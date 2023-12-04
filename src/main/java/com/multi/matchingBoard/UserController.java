package com.multi.matchingBoard;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.multi.model.UserVO;
import com.multi.service.GameService;
import com.multi.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/user")
@Log4j
public class UserController {
	@Autowired
	private GameService gameService;
	@Autowired
	private UserService userService;
	
	
	@GetMapping(value="/modify")
	public String modify(Model model) {

		List<String> gameName = gameService.getAllGameNames();
			//모델에 gameName 값을 추가하여 뷰로 전달 
		model.addAttribute("gameName", gameName);
		return "user/modify";
	}
	@PostMapping(value="/submitUserInfo")
	@ResponseBody
	public String modifyuser(Model model, HttpSession session,@RequestParam(value="profile_img", required=false) MultipartFile profile_img, 
			@RequestParam("nickname")String nickname,@RequestParam("genres") List<String> genres,@RequestParam("games") List<String> games 
			,@RequestParam("dong_code") String dongCode, @RequestParam("area_text") String area_text) {
		log.info(genres);
		log.info(games);
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
	    String userid = loginUser.getUserid();
	    log.info("User ID from session: " + userid);
		
		boolean isSuccess = userService.modifyUser(userid, profile_img, nickname, genres, games, dongCode, area_text);
        
        String message = isSuccess ? "success" : "fail";
        // String location = isSuccess ? "/matchingBoard": "javascript:history.back()";
        // model.addAttribute("msg",message);
        // model.addAttribute("loc",location);
        
        if (isSuccess) {
            UserVO updatedUser = userService.getUserById(userid); // 가정: getUserById는 업데이트된 UserVO 객체를 반환합니다.
            session.setAttribute("loginUser", updatedUser);
            System.out.println("modifyloginUser: " + updatedUser);
        } else {
        	 log.error("User information update failed for user ID: " + userid);        	    
        	 String errorMessage = "정보 수정을 완료할 수 없습니다. 다시 시도해 주세요.";
        	 model.addAttribute("errorMessage", errorMessage);
        	 return "redirect:/modify";
        }
        return message; 
	}
	
}

