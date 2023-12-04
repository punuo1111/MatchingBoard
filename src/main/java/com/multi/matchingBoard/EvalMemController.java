package com.multi.matchingBoard;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.multi.model.MemberEvalVO;
import com.multi.model.UserVO;
import com.multi.service.EvalMemService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/eval")
@Log4j
public class EvalMemController {
    private final EvalMemService evalMemService;

    @Inject
    public EvalMemController(EvalMemService evalMemService) {
        this.evalMemService = evalMemService;
    }

    @GetMapping(value="/memberEval")
    public String showMemEvalForm(Model m, HttpSession session) {
        Map<String, String> qMap = new HashMap<>();
        qMap.put("질문1", "해당 모임원이 시간약속은 잘 지켰나요");
        qMap.put("질문2", "해당 모임원의 게임플레이 매너는 어떠했나요");
        qMap.put("질문3", "해당 모임원의 모임참여 매너는 어떠했나요");
        m.addAttribute("question", qMap);
        
        List<UserVO> userList = evalMemService.listUser();
        m.addAttribute("userList", userList);
        
        //중복 평가 방지 -> roomView로 redirect
		/*
		 * if (session.getAttribute("evalDone") != null && (Boolean)
		 * session.getAttribute("evalDone")) { }
		 */
        
        return "eval/memberEval";
    }

    @PostMapping("/memberEval")
    public String submitMemEvalForm(Model model, HttpSession session, @ModelAttribute UserVO userVO,
    		@RequestParam String whoid,
    		 @RequestParam String[] userid,
    		@RequestParam String ranges) {
        
    	//중복 평가 처리
		/* session.setAttribute("evalDone", true); */
        
    	System.out.println("whoid="+whoid+"ranges: "+ranges+"userid"+Arrays.toString(userid));
        List<UserVO> userList = evalMemService.listUser();
        String[] ratings=ranges.split(",");
        int i=0;
        
        for (String user : userid) {
            MemberEvalVO memberEval = new MemberEvalVO();
            memberEval.setWhoid(whoid);
            memberEval.setUserid(user);
            
            String evalValue = ratings[i];
            if (evalValue != null) {
                Float eval = Float.parseFloat(evalValue);
                memberEval.setEval(eval);
                float insertManners = evalMemService.insertManners(memberEval);
                evalMemService.updateUserManner(user);
            }
            i++;
        }
//memberEval에서 member의 manner로 점수 반영시키고
//UserVO연결 후에 작동 시키기
//        String msg = "모임방 참여 인원 평가";
//        MemberEvalVO eval = evalMemService.memManners(userVO);
//        String loc = "javascript:history.back()";
//        
//        System.out.println("맴버 평점: " + eval.getEval());
//        
//        if (eval != null) {
//            System.out.println("맴버 평점: " + eval.getEval());
//            loc = "/matchingBoard/eval/cafeEval";
//            msg += " 성공";
//        } else {
//        	msg += " 실패";
//          System.out.println("맴버 평점 가져오기 실패");
//        }
//        
//        log.info("평가 결과: " + msg);
//        
//        model.addAttribute("msg", msg);
//        model.addAttribute("loc", loc);
//        return "message";
        return "redirect:/eval/cafeEval";
    }
}
