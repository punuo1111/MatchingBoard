package com.multi.matchingBoard;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.multi.model.NotUserException;
import com.multi.model.UserVO;
import com.multi.service.AdminService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class AdminController {
	
	@Inject
	private AdminService aService;
	

	@GetMapping(value = "/adminLogin")
	public String adminLogin() {
		
		return "adminLogin";
	}
	
	@PostMapping(value = "/adminLogin")
	public String loginAdminPost(String admin_pw, HttpSession session) throws NotUserException {
		
		log.info("admin_pw : "+admin_pw);
		
		if(admin_pw==null||admin_pw.trim().isEmpty()) {
			log.info("redirected!!!");
			return "redirect:adminLogin";
		}
		
		UserVO loginUser = null;
		
		try {
			loginUser = aService.selectAdminByIdx(admin_pw);
		} catch (Exception e) {
			log.info("redirected!!! after aService!!");
			return "redirect:adminLogin";
		}
		
		log.info("adminVO : "+loginUser.toString());
		
		
		if(loginUser != null) {
			session.setAttribute("loginUser", loginUser);
		}
		
		return "home";
	}
	
	
}
