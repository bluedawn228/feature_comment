package com.cgkim449.app.domain;

import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
  private int replyCnt;
  private List<ReplyVO> list;
}
