package com.multi.service;

import java.util.List;

import com.multi.model.RoomPeopleVO;
import com.multi.model.RoomVO;
import com.multi.model.UserVO;

public interface RoomService {

	int insertRoom(RoomVO vo);
	RoomVO selectRoomByIdx(String roomid);
	int updateRoom(RoomVO vo);
	//*****수정확인 필요*****
	List<UserVO> selectMemberAll(String roomid);
	int deleteRoom(String roomid);
	int insertIntoRoomPeople(String roomid,String userid);
	int removeFromRoomPeople(String roomid,String userid);
	boolean isUserInRoom(String roomId, String userId);
	List<String> selectUserIdsInRoom(String roomId);
}
