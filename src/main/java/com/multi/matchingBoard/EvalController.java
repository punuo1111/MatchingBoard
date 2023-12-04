package com.multi.matchingBoard;


import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.multi.model.EvaluationVO;
import com.multi.model.ShopVO;
import com.multi.service.EvalCafeService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/eval")
@Log4j
public class EvalController {
	@Inject
	private EvalCafeService evalCafeService;

	@GetMapping(value = "/cafeEval")
	public String showCafeEvalForm(Model model) {
		model .addAttribute("shopVO", new ShopVO());
		return "eval/cafeEval";
	}
	
    @PostMapping("/cafeEval")
    public String submitCafeEvalForm(Model model, @ModelAttribute ShopVO shopVO) {
        //System.out.println("shoVO: "+shopVO);

    	int n=evalCafeService.insertStars(shopVO);
    	String msg = "보드게임카페 평가";
    	EvaluationVO star=evalCafeService.cafeStars(shopVO);
    	System.out.println("매장 평점: "+star.getStars());
    	//loc = (n > 0) ? "/matchingBoard/room/roomView" : "javascript:history.back()";
    	String loc = (n > 0) ? "/matchingBoard/room/roomView" : "javascript:history.back()";
    	//System.out.println("매장 평점: "+star.getStars());
        
        msg += (n > 0) ? "성공" : "실패";
        log.info("평가 결과: " + msg);

        model.addAttribute("msg", msg);
        model.addAttribute("loc", loc);
        model.addAttribute("averageRating", shopVO.getStars());

        return "message";
    }
    
}
