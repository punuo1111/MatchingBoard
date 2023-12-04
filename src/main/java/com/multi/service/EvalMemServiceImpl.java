package com.multi.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.multi.mapper.EvalMemMapper;
import com.multi.model.MemberEvalVO;
import com.multi.model.UserVO;

import lombok.extern.log4j.Log4j;

@Service("evalMemService")
@Log4j
public class EvalMemServiceImpl implements EvalMemService {
    private final EvalMemMapper evalMemMapper;

    @Inject
    public EvalMemServiceImpl(EvalMemMapper evalMemMapper) {
        this.evalMemMapper = evalMemMapper;
    }

    @Override
    public List<UserVO> listUser() {
        return evalMemMapper.listUser();
    }

    @Override
    public int insertManners(MemberEvalVO memberEval) {
        return evalMemMapper.insertManners(memberEval);
    }

    @Override
    public MemberEvalVO memManners(UserVO userVO) {
        return evalMemMapper.memManners(userVO);
    }
    
    @Override
    public float updateUserManner(String userid) {
        return 0.0f;
    }
}
