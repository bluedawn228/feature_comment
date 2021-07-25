package com.cgkim449.app.service;

import java.util.List;
import com.cgkim449.app.domain.BoardVO;

public interface BoardService {
  public void register(BoardVO board);
  public boolean modify(BoardVO board);
  public boolean remove(Long bno);

  public BoardVO get(Long bno);
  public List<BoardVO> getList();

}
