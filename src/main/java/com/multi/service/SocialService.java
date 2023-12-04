package com.multi.service;

import com.multi.model.SnsLoginVO;

public interface SocialService {
	  void saveSnsLogin(String uuid, String type, String identifier, String refreshToken);
	  
	  SnsLoginVO findSnsLoginByidentifier(String identifier);
}
