package kr.hanne.controller;

import java.util.List;

import javax.inject.Inject;

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

import kr.hanne.domain.Criteria;
import kr.hanne.domain.PageMaker;
import kr.hanne.domain.ProductVO;
import kr.hanne.service.ShopService;

@Controller
@RequestMapping("/shop/*")
public class ShopController {

	@Inject
	private ShopService service;
	
	private static final Logger logger = LoggerFactory.getLogger(ShopController.class);
	
	@RequestMapping("/")
	public String shopMain(Model model, @ModelAttribute Criteria cri) throws Exception{
				
		model.addAttribute("productList", service.list(cri));
		// 게시판 전체 글 표시
		PageMaker pm = new PageMaker();
		pm.setCri(cri);
		pm.setTotalCount(service.countPaging(cri));
		
		model.addAttribute("pm", pm);
		
		return "/shop/shop";
	}
	
	@RequestMapping("/cart")
	public void cart() throws Exception{
		
	}
	
	@RequestMapping("/order")
	public void order() throws Exception{
		
	}
	
	@RequestMapping("/create")
	public void create(Model model, @RequestParam int cate) throws Exception{
		logger.info("product create called............");

		model.addAttribute("cate", cate);
	}
	
	@RequestMapping(value="/create", method=RequestMethod.POST)
	public String create(@ModelAttribute ProductVO vo, RedirectAttributes rttr) throws Exception{
		logger.info(vo.toString());
		logger.info("product create success!");
		
		service.create(vo);
		
		rttr.addAttribute("cate", vo.getProductCategory());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/shop/";
	}
	
	@RequestMapping("/readProduct")
	public void readProduct(@RequestParam("idx") int idx, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		logger.info("readProduct called.....");
		logger.info(cri.toString());
		
		model.addAttribute("productVO", service.read(idx));
	}
	
	@RequestMapping("/modify")
	public void modify(@RequestParam("idx") int idx, @ModelAttribute("cri") Criteria cri, Model model) throws Exception{
		logger.info("product modify called.....");
		logger.info(cri.toString());
		model.addAttribute("productVO", service.read(idx));
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(@ModelAttribute ProductVO vo, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info(vo.toString());
		logger.info(cri.toString());
		logger.info("product modify success!.....");
		service.modify(vo);
		
		rttr.addAttribute("idx", vo.getIdx());
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("cate", cri.getCate());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		rttr.addFlashAttribute("msg", "SUCCESS");
		logger.info(rttr.toString());
		
		return "redirect:/shop/";
	}
	
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public String delete(@RequestParam int idx, Criteria cri, RedirectAttributes rttr) throws Exception{
		logger.info("product delete success!.....");
		service.delete(idx);
		
		rttr.addAttribute("page", cri.getPage());
		rttr.addAttribute("perPageNum", cri.getPerPageNum());
		rttr.addAttribute("cate", cri.getCate());
		rttr.addAttribute("searchType", cri.getSearchType());
		rttr.addAttribute("keyword", cri.getKeyword());
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/shop/";
	}
	
	@RequestMapping("/getAttach/{idx}")
	@ResponseBody
	public List<String> getAttach(@PathVariable int idx) throws Exception{
		return service.getAttach(idx);
	}
}
