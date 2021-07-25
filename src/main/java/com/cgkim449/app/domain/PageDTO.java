package com.cgkim449.app.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
  private int startPage;
  private int endPage;
  private boolean prev;
  private boolean next;

  private int total; // 전체 데이터 수
  private Criteria cri; // 현재 페이지 번호와 한페이지당 보여줄 데이터 수

  public PageDTO(Criteria cri, int total) {
    this.cri = cri;
    this.total = total;

    // 맨 뒤에 10 : 화면에 보일 '페이지 번호'의 개수
    // endPage : 현재 페이지 번호가 1이상 10이하면 10, 11이상 20이하면 20
    this.endPage = (int) (Math.ceil(cri.getPageNum() / 10.0)) * 10; 
    this.startPage = this.endPage - 9;

    int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));

    if(realEnd < this.endPage) {
      this.endPage = realEnd;
    }

    this.prev = this.startPage > 1;
    this.next = this.endPage < realEnd;
  }
}
