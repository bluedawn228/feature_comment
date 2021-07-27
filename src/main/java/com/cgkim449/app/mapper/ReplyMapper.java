package com.cgkim449.app.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.cgkim449.app.domain.Criteria;
import com.cgkim449.app.domain.ReplyVO;

public interface ReplyMapper {
  int insert(ReplyVO vo);
  ReplyVO read(Long rno); // 특정 댓글 읽기
  int delete(Long rno);
  int update(ReplyVO reply);

  // Criteria와, 그리고 추가적으로 해당 게시물의 번호가 필요하다
  public List<ReplyVO> getListWithPaging(
      @Param("cri") Criteria cri,
      @Param("bno") Long bno);

  // 페이징 처리를 위해서는 해당 게시물의 전체 댓글의 숫자가 있어야 한다
  public int getCountByBno(Long bno);
}
