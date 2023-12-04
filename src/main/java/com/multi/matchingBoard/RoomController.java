package com.multi.matchingBoard;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.multi.model.RoomVO;
import com.multi.model.UserVO;
import com.multi.service.GameService;
import com.multi.service.RoomService;
import com.multi.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/room")
@Log4j
public class RoomController {

	@Inject
	private RoomService rService;
	@Autowired
	private GameService gameService;
	
	@Inject
	private UserService uService;
	
	@GetMapping(value="/createRoom")
	public String createRoom(Model m) {
		List<String> gameName = gameService.getAllGameNames();
		m.addAttribute("gameName", gameName);
		
		return "matchingRoom/createRoom";
	}
	
	@PostMapping(value="/createRoom")
	public String cRoomResult(Model m, @ModelAttribute RoomVO room) {
			
		String uid=UUID.randomUUID().toString();
		room.setRoomid(uid);
		
		//////
		if(room.getRplace().isEmpty()) room.setRplace("(임시) 모임장소");
		log.info("room=="+room.toString());
		//////
		int n=rService.insertRoom(room);
		String msg="모임방만들기 "; 
		msg+=(n>0)?"성공":"실패";
		String url="/matchingBoard/room/roomView/"+uid;
		String loc=(n>0)? url:"javascript:history.back()";
		//결과 메시지, 이동경로 처리
		m.addAttribute("msg",msg);
		m.addAttribute("loc",loc);
		return "message";
//		return "matchingRoom/roomView";
	}
	
	@GetMapping(value="/roomView/{roomId}")
	public String roomDetail(Model m, @PathVariable("roomId") String roomId, String rplace, HttpSession session) {

		//admin인지 확인
		//현재 사용자가 해당 모임방에 속해있는지 확인 roomPeople TABLE
		
		//log.info("roomId: "+roomId);
		
		//방id로 해당 방 내용 가져오기
		RoomVO vo=this.rService.selectRoomByIdx(roomId);
		
		//test data
		//UserVO u1=new UserVO();
		//u1.setUserid("1111");
		//u1.setNickname("micol");
		//UserVO u2=new UserVO();
		//u2.setUserid("2222");
		//u2.setNickname("cyon");
		UserVO loginUser =(UserVO) session.getAttribute("loginUser");
		if(loginUser==null) {
			return "redirect:/user/login";
		}
		String userid=loginUser.getUserid();
		//해당 방의 인원 내용 가져오기
		// roompeople 테이블에서 roomid에 해당하는 userid 목록 가져오기
		List<String> userIds = rService.selectUserIdsInRoom(roomId);
		boolean userinroom=rService.isUserInRoom(roomId, userid);
		
		if(!userinroom) {
			if(userIds.size()<vo.getRmaxpeople()) {
				 rService.insertIntoRoomPeople(roomId, userid);
				 //유저 아이디 넣기
				 userIds.add(userid);
			}else {
				m.addAttribute("msg","방이 가득 찼습니다.");
				m.addAttribute("loc","javascript:history.back()");
				return "message";
			}
		}
	 
	    // userIds를 이용해 Member 테이블의 정보를 가져와 UserVO에 저장하고, List<UserVO>에 추가
	    List<UserVO> memberArr = new ArrayList<>();
	    for (String userId : userIds) {
	        UserVO user = uService.getUserById(userId);
	        memberArr.add(user);
	    }
		//List<UserVO> memberArr=Arrays.asList(u1, u2);
		//*****수정확인 필요*****
		//List<UserVO> memberArr = this.rService.selectMemberAll(roomId);
		/*
		 * for(UserVO user : memberArr) { String userid = user.getUserid(); String
		 * nickname = user.getNickname(); //System.out.println("userid: " + userid +
		 * ", nickname: " + nickname); }
		 */
		
		m.addAttribute("room", vo);
		session.setAttribute("memberArr",memberArr);
		session.setAttribute("rplace", rplace);
		m.addAttribute("curPnum", memberArr.size());
		//log.info("curPnum : "+ memberArr.size());
		
		return "matchingRoom/roomView";
	}
	
	@PostMapping("/exitRoom/{roomId}")
    public String exitRoom(@PathVariable("roomId") String roomId, HttpSession session, Model m) {
    
        // 로그인한 사용자 정보 가져오기
        UserVO loginUser = (UserVO) session.getAttribute("loginUser");
    
        // 로그인한 사용자가 없으면 처리하지 않음.
        if (loginUser == null) {
            m.addAttribute("msg", "로그인한 사용자가 아닙니다.");
            m.addAttribute("loc", "javascript:history.back()");
            return "message";
        }
    
        // 로그인한 사용자의 userId 가져오기
        String userId = loginUser.getUserid();
    
        // roompeople 테이블에서 해당 사용자 삭제
        try {
            rService.removeFromRoomPeople(roomId, userId);
            m.addAttribute("msg", "모임방 나가기 성공");
            m.addAttribute("loc", "/matchingBoard/room/roomList");
            return "message";
        } catch (Exception e) {
            m.addAttribute("msg", "모임방 나가기 실패");
            m.addAttribute("loc", "javascript:history.back()");
            return "message";
        }
    }
	
	
	@GetMapping(value ="/popupCalendar")
	public String popupCalendar(Model m, String rdatetime, String rplace) {
		
		m.addAttribute("rstart", rdatetime);
		m.addAttribute("rplace", rplace);
		log.info("rstart : " + rdatetime);
		log.info("rplace : " + rplace);
		return "matchingRoom/calendarPopup";
	}
	
	@PostMapping(value="/editRoom")
	public String showeditRoomFrom(Model m, @RequestParam String roomId) { //, @ModelAttribute RoomVO room, int memberNum) {
		log.info("roomId: "+roomId);
		List<String> gameName = gameService.getAllGameNames();
		m.addAttribute("gameName", gameName);
		
		//////////////////
		//방에 참여하고 있는 인원수 가져오기
		//List<UserVO> memberArr=Arrays.asList(u1, u2); //this.rService.selectMemberAll(roomId);
		//m.addAttribute("curPnum", memberArr.size());

		m.addAttribute("curPnum", 2);
		
		//방id로 해당 방 내용 가져오기
		RoomVO vo=this.rService.selectRoomByIdx(roomId);
		if(vo==null) {
			String msg="해당 글은 없어요";
			String loc="javascript:history.back()";
			m.addAttribute("msg",msg);
			m.addAttribute("loc",loc);
			return "message";
		}
		
		m.addAttribute("room", vo);
		
		return "matchingRoom/editRoomForm";
	}
	
	@PostMapping(value="/roomEditDone")
	public String editRoomResult(Model m, @ModelAttribute RoomVO room) {//, @PathVariable("roomId") String roomId) {
		
		//room.setRoomid(roomId);
		
		log.info("room=="+room.toString());
		
		int n=rService.updateRoom(room);
		String msg="모임방 편집하기 "; 
		msg+=(n>0)?"성공":"실패";
		String url="/matchingBoard/room/roomView/"+room.getRoomid();
		String loc=(n>0)? url:"javascript:history.back()";
		//결과 메시지, 이동경로 처리
		m.addAttribute("msg",msg);
		m.addAttribute("loc",loc);
		return "message";
//		return "matchingRoom/roomView";
	}
	
	@PostMapping(value="/delete")
	public String deleteRoom(Model m,  @RequestParam(defaultValue="0") String roomId) {
		
		int n=rService.deleteRoom(roomId);
		
		String msg=(n>0)?"삭제 성공":"삭제 실패";
		String loc=(n>0)?"roomList":"javascript:history.back()";
		m.addAttribute("msg",msg);
		m.addAttribute("loc",loc);
		return "message";
	}
	
}
