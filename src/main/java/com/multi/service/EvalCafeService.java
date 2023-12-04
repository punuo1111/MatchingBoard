package com.multi.service;

import com.multi.model.EvaluationVO;
import com.multi.model.ShopVO;

public interface EvalCafeService {
	int insertStars(ShopVO shopVO);
	EvaluationVO cafeStars(ShopVO shopVO);
}
