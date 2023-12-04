package com.multi.matchingBoard;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.multi.model.PagingVO;
import com.multi.service.ClickRoomService;

@Controller
@RequestMapping("/room")
public class ClickRoomController {
	
	@Inject	
	private ClickRoomService cservice;
	
	@GetMapping(value="/clickRoom")
	public String clickRoom(String roomid, Model model, PagingVO pagingvo) {
		model.addAttribute("room", cservice.clickRoom(roomid));
		
		//조회 - > 목록
		model.addAttribute("pagingvo", pagingvo);
		return "search/clickRoom";
	}
	


}
