package com.multi.model;

import java.util.Arrays;

import lombok.Data;

/**
 * 
 * @author ponuo
 */
@Data
public class PagingVO {

	private int pageNum; // 현재 페이지
	private int amount; // 한 페이지 당 보여질 게시물 갯수

	private String keyword; // 검색 키워드
	private String type; // 검색 타입
	private String[] typeArr; // 검색 타입 배열

//파라미터 없이 pagingvo클래스 호출 시 기본값
	public PagingVO() {
		this(1, 9);
	}

	public PagingVO(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}

	@Override
	public String toString() {
		return "PagingVO [pageNum=" + pageNum + ", amount=" + amount + ", keyword=" + keyword + ", type=" + type
				+ ", typeArr=" + Arrays.toString(typeArr) + "]";
	}

	public void setType(String type) {
		this.type = type;
		this.typeArr = type.split("");
	}

}
