package com.multi.mapper;

import java.util.List;

import com.multi.model.UserVO;

public interface UserMapper {
	void insertUser(String userid);
	
	void modifyUser(UserVO user);
	
	UserVO getUserById(String userid);
	
	List<String> getUserSocialConnections(String userid);

	List<String> getUsersRoomIds(String userid);
}	
