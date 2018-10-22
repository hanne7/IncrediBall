package kr.hanne.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
		cri.setPerPageNum(15);
		logger.info(cri.toString());
		
		if(cri.getSearchType()==null && cri.getKeyword()==null) {
			if(cri.getCate() == 0) {
				model.addAttribute("list", service.list(cri));
				// 게시판 전체 글 표시
				PageMaker pm = new PageMaker();
				pm.setCri(cri);
				pm.setTotalCount(service.countPaging(cri));
				
				model.addAttribute("pm", pm);
			} else {
				model.addAttribute("list", service.listCategory(cri));
				// 게시판 카테고리별 분류 표시
				PageMaker pm = new PageMaker();
				pm.setCri(cri);
				pm.setTotalCount(service.countCategoryPaging(cri));
				
				model.addAttribute("pm", pm);
			}
		} else {
			if(cri.getCate() == 0) {
				model.addAttribute("list", service.listSearch(cri));
				// 전체 보기에서 검색
				PageMaker pm = new PageMaker();
				pm.setCri(cri);
				pm.setTotalCount(service.searchCountPaging(cri));
				
				model.addAttribute("pm", pm);
			} else {
				model.addAttribute("list", service.categorySearch(cri));
				// 카테고리별 검색
				PageMaker pm = new PageMaker();
				pm.setCri(cri);
				pm.setTotalCount(service.categorySearchCount(cri));
				
				model.addAttribute("pm", pm);
			}
		}
				
	}
	
	@RequestMapping("/create")
	public void create(Model model, @RequestParam int cate, HttpSession session) throws Exception{
		logger.info("board create called............");
		
		model.addAttribute("userVO", session.getAttribute("login"));
		model.addAttribute("cate", cate);
		
	}
	
	@RequestMapping(value="/create", method = RequestMethod.POST)
	public String create(@ModelAttribute BoardVO vo, RedirectAttributes rttr) throws Exception{
		logger.info("board create success!.....");
		service.create(vo);
		
		rttr.addAttribute("cate", vo.getCategory());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/board/list";
	}
	
	@RequestMapping("/readPage")
	public void readPage(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		logger.info("board readPage called.....");
		logger.info(cri.toString());
		model.addAttribute("boardVO", service.read(bno));
	}
	
	@RequestMapping("/getAttach/{bno}")
	@ResponseBody
	public List<String> getAttach(@PathVariable int bno) throws Exception{
		return service.getAttach(bno);
	}
	
	@RequestMapping("/modify")
	public void modify(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		logger.info("board modify called.....");
		logger.info(cri.toString());
		model.addAttribute("boardVO", service.read(bno));
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(@ModelAttribute BoardVO vo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info(vo.toString());
		logger.info(cri.toString());
		logger.info("board modify success!.....");
		service.modify(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("cate", cri.getCate());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		rttr.addFlashAttribute("msg", "SUCCESS");
		logger.info(rttr.toString());
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(@RequestParam int bno, Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info("board delete success!.....");
		service.delete(bno);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("cate", cri.getCate());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/board/list";
	}
}
