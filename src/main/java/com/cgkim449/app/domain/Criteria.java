package com.cgkim449.app.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@ToString
@Setter
@Getter
public class Criteria {

  private int pageNum; // 현재 페이지 번호
  private int amount; // 한 페이지당 보여줄 데이터의 개수

  public Criteria() {
    this(1, 10); // 기본값을 1 페이지, 10 amount로 하자
  }

  public Criteria(int pageNum, int amount) {
    this.pageNum = pageNum;
    this.amount = amount;
  }
}
