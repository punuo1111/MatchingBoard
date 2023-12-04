package com.multi.mapper;

import com.multi.model.MemberEvalVO;
import com.multi.model.UserVO;

import java.util.List;

public interface EvalMemMapper {
	List<UserVO> listUser();
    int insertManners(MemberEvalVO memberEval);
    MemberEvalVO memManners(UserVO userVO);
}
