package com.multi.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.mapper.AdminMapper;
import com.multi.model.NotUserException;
import com.multi.model.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	private AdminMapper adMapper;
	
	@Override
	public UserVO selectAdminByIdx(String userid) throws NotUserException {
		
//		System.out.println("\n\n\n-------------AdminService Impl-------------\n\n\n");
		UserVO dbuser=adMapper.getAdminByIdx(userid);
		if(dbuser==null) throw new NotUserException("존재하지 않는 아이디입니다");
		return dbuser;
	}

}
