package org.zerock.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.BoardAttachVO;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.Favorite;
import org.zerock.domain.InfoVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.BoardAttachMapper;
import org.zerock.mapper.BoardMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;

	@Setter(onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;

	@Transactional
	@Override
	public void register(BoardVO board) {

		log.info("register......" + board);

		mapper.insertSelectKey(board);
		Double total = (double) mapper.getTotalCountByInfoid(board.getInfoid());
		Double totalscore = (double) mapper.getTotalScoreByInfoid(board.getInfoid());
		Double infoscore = (Double) (totalscore/total);
		mapper.updateInfoscore(infoscore, board.getInfoid());
		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
			return;
		}

		board.getAttachList().forEach(attach -> {

			attach.setBno(board.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {

		log.info("get......" + bno);

		return mapper.read(bno);

	}

	@Transactional
	@Override
	public boolean modify(BoardVO board) {

		log.info("modify......" + board);

		attachMapper.deleteAll(board.getBno());

		boolean modifyResult = mapper.update(board) == 1;
		
		if (modifyResult && board.getAttachList() != null) {

			board.getAttachList().forEach(attach -> {

				attach.setBno(board.getBno());
				attachMapper.insert(attach);
			});
		}
		Double total = (double) mapper.getTotalCountByInfoid(board.getInfoid());
		Double totalscore = (double) mapper.getTotalScoreByInfoid(board.getInfoid());
		Double infoscore = (Double) (totalscore/total);
		mapper.updateInfoscore(infoscore, board.getInfoid());
		return modifyResult;
	}

	// @Override
	// public boolean modify(BoardVO board) {
	//
	// log.info("modify......" + board);
	//
	// return mapper.update(board) == 1;
	// }

	// @Override
	// public boolean remove(Long bno) {
	//
	// log.info("remove...." + bno);
	//
	// return mapper.delete(bno) == 1;
	// }

	@Transactional
	@Override
	public boolean remove(Long bno) {

		log.info("remove...." + bno);
		BoardVO board = mapper.read(bno);
		attachMapper.deleteAll(bno);
		boolean result = mapper.delete(bno) == 1;
		Double total = (double) mapper.getTotalCountByInfoid(board.getInfoid());
		Double infoscore = 0.0;
		if(total > 0) {
			total = (double) mapper.getTotalCountByInfoid(board.getInfoid());
			Double totalscore = (double) mapper.getTotalScoreByInfoid(board.getInfoid());
			infoscore = (Double) (totalscore/total);
			mapper.updateInfoscore(infoscore, board.getInfoid());
			return result;
		}
		mapper.updateInfoscore(infoscore, board.getInfoid());
		return result;
	}

	// @Override
	// public List<BoardVO> getList() {
	//
	// log.info("getList..........");
	//
	// return mapper.getList();
	// }

	@Override
	public List<BoardVO> getList(Criteria cri) {

		log.info("get List with criteria: " + cri);

		return mapper.getListWithPaging(cri);
	}

	@Override
	public List<BoardVO> getListByInfoid(Long infoid) {

		log.info("get List with infoid: " + infoid);

		return mapper.getBoardById(infoid);
	}
	
	@Override
	public int getTotal(Criteria cri) {

		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	@Override
	public int getTotalByInfoid(Long infoid) {

		log.info("get total count by infoid");
		return mapper.getTotalCountByInfoid(infoid);
	}

	@Override
	public int getTotalScoreByInfoid(Long infoid) {

		log.info("get total count by infoid");
		return mapper.getTotalScoreByInfoid(infoid);
	}

	
	@Override
	public List<BoardAttachVO> getAttachList(Long bno) {

		log.info("get Attach list by bno" + bno);

		return attachMapper.findByBno(bno);
	}

	@Override
	public void removeAttach(Long bno) {

		log.info("remove all attach files");

		attachMapper.deleteAll(bno);
	}
	
	public List<InfoVO> getAllInfo(){
		log.info("get info");
		
		return mapper.getAllInfo();
	}
	
	public InfoVO getInfoById(Long id) {
		log.info("get info by id :" + id);
		
		return mapper.getInfoById(id);
	}
	
	public InfoVO getInfoByTitle(String title) {
		log.info("get info by title :" + title);
		
		return mapper.getInfoByTitle(title);
	}
	
	public MemberVO getMemberById(String userid) {
		log.info("get userid by user :" + userid);
		
		return mapper.getMemberById(userid);
	}
	
	@Transactional
	@Override
	public void favorite_in(Long infoid, String userid) {

		log.info("favoritein......" + infoid + userid);
		mapper.favorite_in(infoid, userid);
	}
	
	@Transactional
	@Override
	public void favorite_out(Long infoid, String userid) {

		log.info("favoritein......" + infoid + userid);
		mapper.favorite_out(infoid, userid);
	}
	
	public Favorite getFavoriteByIdUserid(Long infoid, String userid) {
		log.info("get info by id :" + infoid);
		
		return mapper.getfavoriteByIdUserid(infoid, userid);
	}
	
	public void addInfo(String title, Double lat, Double lng, String address) {
		log.info(title+lat+lng+address);
		Long id = (long) ((mapper.getAllInfo().size()) + 1);
		mapper.addInfo(id, title, lat, lng, address);
	}
	
	public void deleteInfo(Long id) {
		log.info("delete id");
		mapper.infodelete(id);
	}
	
	public void modifyInfo(InfoVO info) {

		log.info("modify......" + info);

		mapper.infoupdate(info);
	}
	
}
