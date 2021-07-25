package com.cgkim449.app.mapper;

import java.util.List;
import com.cgkim449.app.domain.BoardVO;
import com.cgkim449.app.domain.Criteria;

public interface BoardMapper {

  public List<BoardVO> getList();

  public void insert(BoardVO board);
  public void insertSelectKey(BoardVO board);

  public BoardVO read(Long bno);
  public int delete(Long bno);
  public int update(BoardVO board);

  public List<BoardVO> getListWithPaging(Criteria cri);

  public int getTotalCount(Criteria cri);
}
