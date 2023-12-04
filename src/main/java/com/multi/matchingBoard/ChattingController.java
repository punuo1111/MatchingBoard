package com.multi.matchingBoard;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/chatting")
public class ChattingController {

//	@GetMapping("/chatting")
	@GetMapping("/room/{id}")
	public String ChattingTestView(Model m, @PathVariable("id") String id) {
		
//		User user = (User) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		m.addAttribute("userid", user.getUsername());
//		
//		log.info("==================================");
//		log.info("@ChatController, GET Chat / Username : " + user.getUsername());
		
		m.addAttribute("userid", "테스트유저1");
		m.addAttribute("roomId", id);
		
		return "/matchingRoom/chattingTest";
	}
	
//	@GetMapping("/chat")
	@GetMapping("/chat/{id}")
	public String TestChat(Model m, @PathVariable("id") String id) {

		m.addAttribute("roomId", id);
		
		return "/matchingRoom/chat";
	}
	
}
