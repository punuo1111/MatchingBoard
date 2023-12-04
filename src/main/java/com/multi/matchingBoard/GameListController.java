package com.multi.matchingBoard;

import java.util.List;

import javax.inject.Inject;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.multi.model.GameVO;
import com.multi.service.GameService;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class GameListController {

	@Inject
	private GameService gService;
	
	@GetMapping("/gameList")
	public ModelAndView gameListForm() {
		ModelAndView mv=new ModelAndView();
		mv.addObject("msg", "게임 정보");//데이터
		mv.setViewName("gameList");//뷰네임
		return mv;
	}
	
	@GetMapping(value="/games", produces="application/json")
	public List<GameVO> gameAll(Model m, @RequestParam(defaultValue="") String keyword, 
			@RequestParam(defaultValue="") String searchType){
		log.info("keyword=="+keyword);
		log.info("searchType=="+searchType);
		m.addAttribute("findType", searchType);
		
		List<GameVO> arr=null;
		if(keyword.isEmpty()) {
			arr=gService.getAllGame();
		}else {
			//검색한 도서정보 가져오기
			if(searchType.equals("T")) arr=gService.getFindGameTitle(keyword);
			if(searchType.equals("P")) arr=gService.getFindGamePlaytime(Integer.parseInt(keyword));
			if(searchType.equals("N")) arr=gService.getFindGameNum(Integer.parseInt(keyword));
			if(searchType.equals("A")) arr=gService.getFindGameAge(Integer.parseInt(keyword));
		}
		
		return arr;
	}
	
	@GetMapping(value="/genreSearch", produces="application/json")
	public List<GameVO> getTitleList(@RequestParam("genre") String genre){
		
		return gService.getGameListByGenre(genre);
	}

}
