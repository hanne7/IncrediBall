package kr.hanne.controller;

import javax.inject.Inject;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.hanne.domain.BoardVO;
import kr.hanne.domain.Criteria;
import kr.hanne.domain.PageMaker;
import kr.hanne.service.BoardService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Inject
	private BoardService service;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping("/list")
	public void list(Model model, @ModelAttribute Criteria cri) throws Exception{
		logger.info("board list called............");
		logger.info(cri.toString());
		
		model.addAttribute("list", service.list(cri));
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.countPaging(cri));
		
		model.addAttribute("pm", pm);
	}
	
	@RequestMapping("/create")
	public void create(Model model, HttpSession session) throws Exception{
		logger.info("board create called............");
		
		model.addAttribute("userVO", session.getAttribute("login"));
	}
	
	@RequestMapping(value="/create", method = RequestMethod.POST)
	public String create(@ModelAttribute BoardVO vo, RedirectAttributes rttr) throws Exception{
		logger.info("board create success!.....");
		service.create(vo);
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/board/list";
	}
	
	@RequestMapping("/readPage")
	public void readPage(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		logger.info("board readPage called.....");
		model.addAttribute("boardVO", service.read(bno));
	}
	
	@RequestMapping("/modify")
	public void modify(@RequestParam int bno, @ModelAttribute Criteria cri, Model model) throws Exception{
		logger.info("board modify called.....");
		System.out.println(service.read(bno).toString());
		
		model.addAttribute("boardVO", service.read(bno));
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(@ModelAttribute BoardVO vo, Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info("board modify success!.....");
		service.modify(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/board/readPage";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(@RequestParam int bno, Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info("board delete success!.....");
		service.delete(bno);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/board/list";
	}
}
