package com.multi.service;

import java.util.List;

import com.multi.model.GameVO;

public interface GameService {
	List<String> getAllGameNames();
	
	List<GameVO> getAllGame();
	
	List<GameVO> getFindGameTitle(String keyword);
	List<GameVO> getFindGamePlaytime(int keyword);
	List<GameVO> getFindGameNum(int keyword);
	List<GameVO> getFindGameAge(int keyword);
	
	List<GameVO> getGameListByGenre(String genre);
	
}
