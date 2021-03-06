package com.cgkim449.app.controller;

import java.text.SimpleDateFormat;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.cgkim449.app.domain.BoardVO;
import com.cgkim449.app.domain.Criteria;
import com.cgkim449.app.domain.PageDTO;
import com.cgkim449.app.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

  @InitBinder
  public void initBinder(WebDataBinder binder) {
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    binder.registerCustomEditor(java.util.Date.class, new CustomDateEditor(dateFormat, false));
  }

  private BoardService service;

  @GetMapping("/list")
  public void list(Criteria cri, Model model) {
    log.info("list: " + cri);
    int total = service.getTotal(cri);
    model.addAttribute("list", service.getList(cri));
    model.addAttribute("pageMaker", new PageDTO(cri, total));
  }

  // 로그인 성공한 사용자 만이 게시물 작성할 수 있도록
  @GetMapping("/register")
  @PreAuthorize("isAuthenticated()")
  public void register() {

  }

  @GetMapping({"/get", "/modify"})
  public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
    model.addAttribute("board", service.get(bno));
  }

  // 목록 화면으로 redirect할때 등록된 게시물 번호를 전달하기 위해 RedirectAttributes 이용
  @PostMapping("/register")
  @PreAuthorize("isAuthenticated()")
  public String register(BoardVO board, RedirectAttributes rttr) {

    service.register(board);

    rttr.addFlashAttribute("result", board.getBno());
    return "redirect:/board/list";
  }


  @PreAuthorize("principal.username == #board.writer")
  @PostMapping("/modify")
  public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
    if(service.modify(board)) {
      rttr.addFlashAttribute("result", "success");
    }
    //    rttr.addAttribute("pageNum", cri.getPageNum());
    //    rttr.addAttribute("amount", cri.getAmount());
    //    rttr.addAttribute("type", cri.getType());
    //    rttr.addAttribute("keyword", cri.getKeyword());
    return "redirect:/board/list"+cri.getListLink();
  }

  @PreAuthorize("principal.username == #writer")
  @PostMapping("/remove")
  public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, 
      RedirectAttributes rttr, String writer) {
    if(service.remove(bno)) {
      rttr.addFlashAttribute("result", "success");
    }
    //    rttr.addAttribute("pageNum", cri.getPageNum());
    //    rttr.addAttribute("amount", cri.getAmount());
    //    rttr.addAttribute("type", cri.getType());
    //    rttr.addAttribute("keyword", cri.getKeyword());
    return "redirect:/board/list" + cri.getListLink();
  }
}
