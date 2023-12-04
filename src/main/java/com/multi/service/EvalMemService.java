package com.multi.service;

import com.multi.model.MemberEvalVO;
import com.multi.model.UserVO;

import java.util.List;

public interface EvalMemService {
    List<UserVO> listUser();
    int insertManners(MemberEvalVO memberEval);
    //MemberEvalVO memManners(UserVO userVO);
    MemberEvalVO memManners(UserVO userVO);
	float updateUserManner(String userid);

}
