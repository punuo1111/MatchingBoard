package com.multi.matchingBoard;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.multi.model.PageMakerVO;
import com.multi.model.PagingVO;

import com.multi.model.PageMakerVO;
import com.multi.model.PagingVO;
import com.multi.model.RoomVO;
import com.multi.model.UserVO;
import com.multi.service.BoardSearchService;

import lombok.extern.log4j.Log4j;


@Controller
@RequestMapping("/room")
@Log4j
public class SearchController {
	
	@Inject
	private BoardSearchService bservice;
	
	@GetMapping(value="/roomList")
	public String boardSearch(Model model, HttpSession session, PagingVO pagingvo) {
		
//		List<RoomVO> roomlist = bservice.getListPaging(pagingvo);
		model.addAttribute("list", bservice.getListPaging(pagingvo));
//		log.info("roomlist : "+ roomlist.toString());
		
		int total = bservice.getTotal(pagingvo);
		PageMakerVO pageMake = new PageMakerVO(pagingvo, total);
		model.addAttribute("pageMaker", pageMake);
		
		UserVO user = (UserVO)session.getAttribute("loginUser");
		if(user!=null) {
			List<String> likeRoomIds = bservice.getUserWishList(user.getUserid());
			model.addAttribute("likeRoomIds", likeRoomIds);
		}
		return "search/boardSearch";
	}

	@PutMapping(value="/like/{roomid}", produces="application/json")
	@ResponseBody
	public ModelMap wishlist(@PathVariable("roomid")String roomid, HttpSession session) {
		log.info("roomid:" + roomid);
		UserVO user = (UserVO)session.getAttribute("loginUser");
		if(user==null) {
			ModelMap map = new ModelMap();
			map.put("result", "-2");
			map.put("msg", "로그인을 해야 해요");
			return map;
		}
		String str="";
		String uuid="";
		if(user!=null) {
			uuid=user.getUserid();
			System.out.println(uuid);
		}else {
			str="Fail-Login required";
		}
		int n = this.bservice.updateLike(uuid, roomid);
		 str=(n>0)?"ok":"Fail";
		
		ModelMap map = new ModelMap("result", str);
		return map;
				
	}

}
