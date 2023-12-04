package com.multi.mapper;

import com.multi.model.UserVO;

public interface AdminMapper {

	UserVO getAdminByIdx(String userid);
	
}