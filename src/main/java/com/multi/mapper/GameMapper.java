package com.multi.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.multi.model.GameVO;

@Repository
public interface GameMapper {
	
	List<String> getAllGameNames();
	List<GameVO> getAllGame();
	
	List<GameVO> getFindGameTitle(String keyword);
	List<GameVO> getFindGamePlaytime(int keyword);
	List<GameVO> getFindGameNum(int keyword);
	List<GameVO> getFindGameAge(int keyword);
	
	List<GameVO> getGameListByGenre(String genre);
	
}
