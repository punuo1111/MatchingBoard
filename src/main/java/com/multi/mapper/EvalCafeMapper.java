package com.multi.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.multi.model.EvaluationVO;
import com.multi.model.ShopVO;

@Mapper
public interface EvalCafeMapper {
	int insertStars(ShopVO shopVO);
	EvaluationVO cafeStars(ShopVO shopVO);
}
