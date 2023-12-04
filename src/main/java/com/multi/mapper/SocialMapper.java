package com.multi.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;

import com.multi.model.SnsLoginVO;

public interface SocialMapper {
	
    void insertSnsLogin(@Param("userid") String userid, @Param("type") String type, @Param("identifier") String identifier, @Param("refreshToken") String refreshToken);
	
    SnsLoginVO findSnsLoginByidentifier(String identifier);
}
