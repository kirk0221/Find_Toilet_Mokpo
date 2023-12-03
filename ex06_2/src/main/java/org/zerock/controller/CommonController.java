package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CommonController {

	@Autowired
	private MemberService service;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {

		log.info("access Denied : " + auth);

		model.addAttribute("msg", "Access Denied");
	}

	@GetMapping("/customLogin")
	public void loginInput(String error, String logout, Model model) {

		log.info("error: " + error);
		log.info("logout: " + logout);
		log.info("model:" +model);
		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}

		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}

	}
	@PostMapping("/customLogin")
	public void login(String error, String logout, Model model) {

		log.info("error: " + error);
		log.info("logout: " + logout);
		log.info("model:" +model);
		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}

		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}

	}
	@GetMapping("/customLogout")
	public void logoutGET() {

		log.info("custom logout");
		
	}

	@PostMapping("/customLogout")
	public void logoutPost() {

		log.info("post custom logout");
		
	}

	@GetMapping("/membership")
	public void register() {

	}

	@PostMapping("/membership")
	public String register(MemberVO member, RedirectAttributes rttr) {
		
		log.info("==========================");

		log.info("register: " + member);

		if (service.read(member.getUserid()) != null) {

			rttr.addFlashAttribute("result", false);
			return "redirect:/membership";

		}

		log.info("==========================");
		member.setUserpw(pwencoder.encode(member.getUserpw()));
		service.insert(member);

		rttr.addFlashAttribute("result", true);

		return "redirect:/customLogin";
	}
	
}
