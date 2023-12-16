package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.Favorite;
import org.zerock.domain.InfoVO;
import org.zerock.domain.MemberVO;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

	private BoardService service;
	private MemberService userservice;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {

		log.info("list: " + cri);
		model.addAttribute("list", service.getList(cri));
		// model.addAttribute("pageMaker", new PageDTO(cri, 123));

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

	}
	
	@GetMapping("/map")
	public String map(Model model, Authentication authentication) {
	    List<InfoVO> infoList = service.getAllInfo();
	    model.addAttribute("infoList", infoList);

	    if (authentication != null) {
	        // 현재 사용자의 인증 정보에서 권한을 가져와서 모델에 추가
	        String auth = userservice.readauth(authentication.getName());
	        model.addAttribute("auth", auth);
	    }

	    return "/board/map";
	}


	@GetMapping(value = "/info_board")
	public String info_board(@RequestParam("id") Long id, String userid, Model model) {
		boolean result = false;
		Favorite favorite = service.getFavoriteByIdUserid(id, userid);
		if(favorite == null) {
			model.addAttribute("result", result);
			log.info("id----------------------------" + id);
			log.info("userid-----------------------------"+userid);
		    InfoVO info = service.getInfoById(id); // service 계층을 통해 데이터베이스에서 정보를 조회
	 	    model.addAttribute("info", info);
	 	    return "/board/info_board";
		}
		log.info("========================================================="+favorite);
		
		log.info("result"+(favorite.getInfoid().equals(id) && favorite.getUserid().equals(userid)));
		if(favorite.getInfoid().equals(id) && favorite.getUserid().equals(userid)) {
			result = true;
			model.addAttribute("result", result);
			log.info(result);
		}
		model.addAttribute("result", result);
		log.info("id----------------------------" + id);
		log.info("userid-----------------------------"+userid);
	    InfoVO info = service.getInfoById(id); // service 계층을 통해 데이터베이스에서 정보를 조회
 	    model.addAttribute("info", info);
 	    return "/board/info_board";
	}
	
	@PostMapping(value = "/info_board_in")
	public String boardfavoritein(@RequestParam("infoid") Long infoid, @RequestParam("userid") String userid, Model model) {
		log.info("id" + infoid);
	    model.addAttribute("id", infoid);
	    model.addAttribute("userid", userid);
	    log.info("=============================================info:"+infoid);
	    log.info("=============================================member:"+userid);
	    service.favorite_in(infoid, userid);
	    
	    return "redirect:/board/map";
	}
	
	
	@PostMapping(value = "/info_board_out")
	public String boardfavoriteout(@RequestParam("infoid") Long infoid, @RequestParam("userid") String userid, Model model) {
		log.info("id" + infoid);
	    model.addAttribute("id", infoid);
	    model.addAttribute("userid", userid);
	    log.info("=============================================info:"+infoid);
	    log.info("=============================================member:"+userid);
	    service.favorite_out(infoid, userid);
	    
	    return "redirect:/board/map";
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public void register(Model model) {
		List<InfoVO> infolist = service.getAllInfo();
		model.addAttribute("infoList", infolist);
	}

	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, String infotitle, RedirectAttributes rttr) {

		log.info("==========================");
		board.setInfoid(service.getInfoByTitle(infotitle).getId() );
		log.info("register: " + board);

		if (board.getAttachList() != null) {

			board.getAttachList().forEach(attach -> log.info(attach));

		}
		if(board.getTitle()=="" && board.getContent() == "") {
			rttr.addFlashAttribute("result", board.getBno());
			return "redirect:/board/register";
		}
		log.info("==========================");
		service.register(board);
		log.info("---------------------"+service.getTotalByInfoid(board.getInfoid()));
		log.info("---------------------"+service.getTotalScoreByInfoid(board.getInfoid()));
		
		
		rttr.addFlashAttribute("result", board.getBno());
		return "redirect:/board/list";
	}

	@GetMapping({ "/get", "/modify" })
	public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {

		log.info("/get or modify");
		model.addAttribute("board", service.get(bno));
		model.addAttribute("selectinfo", service.getInfoById(service.get(bno).getInfoid()));
		List<InfoVO> infolist = service.getAllInfo();
		model.addAttribute("infoList", infolist);
	}
	
	@PreAuthorize("principal.username == #board.writer")
	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, String infotitle, RedirectAttributes rttr) {
		log.info("modify:" + board);
		board.setInfoid(service.getInfoByTitle(infotitle).getId());
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/board/list" + cri.getListLink();
	}
	
	@PreAuthorize("principal.username == #writer")
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, String infotitle, RedirectAttributes rttr, String writer) {

		log.info("remove..." + bno);
		List<BoardAttachVO> attachList = service.getAttachList(bno);

		if (service.remove(bno)) {

			// delete Attach Files
			deleteFiles(attachList);

			rttr.addFlashAttribute("result", "success");
		}
		return "redirect:/board/list" + cri.getListLink();
	}

	private void deleteFiles(List<BoardAttachVO> attachList) {

		if (attachList == null || attachList.size() == 0) {
			return;
		}

		log.info("delete attach files...................");
		log.info(attachList);

		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(
						"C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {

					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
							+ attach.getFileName());

					Files.delete(thumbNail);
				}

			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			} // end catch
		});// end foreachd
	}

	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {

		log.info("getAttachList " + bno);

		return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);

	}

}
