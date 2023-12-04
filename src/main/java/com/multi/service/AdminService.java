package com.multi.service;

import com.multi.model.NotUserException;
import com.multi.model.UserVO;

public interface AdminService {
	
	UserVO selectAdminByIdx(String userid) throws NotUserException;
}
