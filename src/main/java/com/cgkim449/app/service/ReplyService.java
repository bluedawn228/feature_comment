package com.cgkim449.app.service;

import java.util.List;
import com.cgkim449.app.domain.Criteria;
import com.cgkim449.app.domain.ReplyVO;

public interface ReplyService {
  int register(ReplyVO vo);
  ReplyVO get(Long rno);
  int modify(ReplyVO vo);
  int remove(Long rno);
  List<ReplyVO> getList(Criteria cri, Long bno);
}
