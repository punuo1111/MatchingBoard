package com.multi.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.multi.mapper.GameMapper;
import com.multi.model.GameVO;

@Service
public class GameServiceImpl implements GameService {
	
	private GameMapper gameMapper;
	
	@Autowired
	public GameServiceImpl(GameMapper gameMapper) {
        this.gameMapper = gameMapper;
    }
	
	@Override
	public List<String> getAllGameNames() {
		// TODO Auto-generated method stub
		return gameMapper.getAllGameNames();
	}

	@Override
	public List<GameVO> getAllGame() {

		return gameMapper.getAllGame();
	}

	@Override
	public List<GameVO> getGameListByGenre(String genre) {
		
		return gameMapper.getGameListByGenre(genre);
	}

	@Override
	public List<GameVO> getFindGameTitle(String keyword) {
		
		return gameMapper.getFindGameTitle(keyword);
	}

	@Override
	public List<GameVO> getFindGamePlaytime(int keyword) {

		return gameMapper.getFindGamePlaytime(keyword);
	}

	@Override
	public List<GameVO> getFindGameNum(int keyword) {

		return gameMapper.getFindGameNum(keyword);
	}

	@Override
	public List<GameVO> getFindGameAge(int keyword) {

		return gameMapper.getFindGameAge(keyword);
	}

}
