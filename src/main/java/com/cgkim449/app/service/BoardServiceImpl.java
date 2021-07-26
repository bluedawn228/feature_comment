package com.cgkim449.app.service;

import java.util.List;
import org.springframework.stereotype.Service;
import com.cgkim449.app.domain.BoardVO;
import com.cgkim449.app.domain.Criteria;
import com.cgkim449.app.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

  private BoardMapper mapper;

  @Override
  public void register(BoardVO board) {
    mapper.insertSelectKey(board);
  }


  @Override
  public boolean modify(BoardVO board) {
    return mapper.update(board) == 1;
  }

  @Override
  public boolean remove(Long bno) {
    return mapper.delete(bno) == 1;
  }

  @Override
  public BoardVO get(Long bno) {
    return mapper.read(bno);
  }

  //  @Override
  //  public List<BoardVO> getList() {
  //    return mapper.getList();
  //  }


  @Override
  public List<BoardVO> getList(Criteria cri) {
    log.info("get List with criteria: " + cri);
    return mapper.getListWithPaging(cri);
  }
}
