package com.multi.model;

import lombok.Data;

@Data
public class PageMakerVO {

	private int startPage; // 시작페이지
	private int endPage; // 끝 페이지
	private int total; // 전체 게시물 수
	private boolean prev, next; // 이전페이지, 다음페이지 존재유무
	private PagingVO pagingvo; // 현재 페이지, 페이지당 게시물 표시 정보

	public PageMakerVO(PagingVO pagingvo, int total) {

		this.pagingvo = pagingvo;
		this.total = total;

		// 마지막 페이지
		this.endPage = (int) (Math.ceil(pagingvo.getPageNum() / 10.0)) * 10;
		// 시작 페이지
		this.startPage = this.endPage - 9;
		// 전체 마지막 페이지
		int realEnd = (int) (Math.ceil(total * 1.0 / pagingvo.getAmount()));
		// 전체 마지막 페이지 realEnd가 화면에 보이는 마지막페이지보다 작은경우, 보이는 페이지 값 조정
		if (realEnd < this.endPage) {
			this.endPage = realEnd;
		}
		// 시작 페이지(startPage) 값이 1보다 큰 경우 true
		this.prev = this.startPage > 1;
		// 마지막 페이지(endPage)값이 1보다 큰 경우 true
		this.next = this.endPage < realEnd;
	}

	@Override
	public String toString() {
		return "PageMakerVO [startPage=" + startPage + ", endPage=" + endPage + ", total=" + total + ", prev=" + prev
				+ ", next=" + next + ", pagingvo=" + pagingvo + "]";
	}

}
