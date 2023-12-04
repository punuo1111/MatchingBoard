package com.multi.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.multi.mapper.EvalCafeMapper;
import com.multi.model.EvaluationVO;
import com.multi.model.ShopVO;

import lombok.extern.log4j.Log4j;

@Service("evalCafeService")
@Log4j
public class EvalCafeServiceImpl implements EvalCafeService {
	private final EvalCafeMapper evalCafeMapper;

	@Inject
	public EvalCafeServiceImpl(EvalCafeMapper evalCafeMapper) {
		this.evalCafeMapper = evalCafeMapper;
	}

	@Override
	public int insertStars(ShopVO shopVO) {
		return evalCafeMapper.insertStars(shopVO);
	}

	@Override
	public EvaluationVO cafeStars(ShopVO shopVO) {
		return evalCafeMapper.cafeStars(shopVO);
	}
}
