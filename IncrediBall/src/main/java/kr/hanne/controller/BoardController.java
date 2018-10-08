package kr.hanne.controller;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.hanne.domain.BoardVO;
import kr.hanne.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	private BoardService service;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping("/create")
	public void create() throws Exception{
		logger.info("boardCreate called............");
	}
	
	@RequestMapping(value="/create", method = RequestMethod.POST)
	public String create(@ModelAttribute BoardVO vo) throws Exception{
		
		vo.setUseridx(1);
		logger.info(vo.toString());
		service.create(vo);
		
		return "redirect:/board/list";
	}
	
	
	@RequestMapping("/list")
	public void list(Model model) throws Exception{
		logger.info("boardList called............");
		
		model.addAttribute("list", service.list());
	}
}
