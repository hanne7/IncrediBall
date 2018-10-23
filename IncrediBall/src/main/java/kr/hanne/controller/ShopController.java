package kr.hanne.controller;

import java.util.ArrayList;
import java.util.Arrays;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
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
	
	@RequestMapping("/shopMain")
	public void shopMain(Model model, @ModelAttribute Criteria cri) throws Exception{
		logger.info("shop main called............");
		cri.setPerPageNum(21);
		logger.info(cri.toString());
				
		if(cri.getSearchType()==null && cri.getKeyword()==null) {
			if(cri.getCate() == 0) {
				model.addAttribute("list", service.list(cri));
				logger.info(service.list(cri).toString());
				// 상품 전체리스트 표시
				PageMaker pm = new PageMaker();
				pm.setCri(cri);
				pm.setTotalCount(service.countPaging(cri));
				
				model.addAttribute("pm", pm);
			} else {
				model.addAttribute("list", service.listCategory(cri));
				logger.info(service.listCategory(cri).toString());
				// 상품 카테고리별 분류 표시
				PageMaker pm = new PageMaker();
				pm.setCri(cri);
				pm.setTotalCount(service.countCategoryPaging(cri));
				
				model.addAttribute("pm", pm);
			}
		} else {
			if(cri.getCate() == 0) {
				model.addAttribute("list", service.listSearch(cri));
				logger.info(service.listSearch(cri).toString());
				// 전체 보기에서 검색
				PageMaker pm = new PageMaker();
				pm.setCri(cri);
				pm.setTotalCount(service.searchCountPaging(cri));
				
				model.addAttribute("pm", pm);
			} else {
				model.addAttribute("list", service.categorySearch(cri));
				logger.info(service.categorySearch(cri).toString());
				// 카테고리별 검색
				PageMaker pm = new PageMaker();
				pm.setCri(cri);
				pm.setTotalCount(service.categorySearchCount(cri));
				
				model.addAttribute("pm", pm);
			}
		}
		
	}
	
	@RequestMapping("/cart")
	public void cart(Model model, HttpSession session) throws Exception{
		@SuppressWarnings("unchecked")
		List<ProductVO> carts = (List<ProductVO>) session.getAttribute("carts");
		
		model.addAttribute("carts", carts);
	}
	
	@RequestMapping(value="/addCart", method=RequestMethod.POST)
	public String addCart(@ModelAttribute ProductVO vo, HttpSession session) throws Exception{
		vo = service.read(vo.getIdx());
		logger.info(vo.toString());

		@SuppressWarnings("unchecked")
		List<ProductVO> carts = (List<ProductVO>) session.getAttribute("carts");
		
		if(carts == null) {
			carts = new ArrayList<>();
		}		
		carts.add(vo);
		
		for(ProductVO p : carts) {
			System.out.println(p.toString());
		}
		session.setAttribute("carts", carts);
		
		return "redirect:/shop/cart";
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
		
		return "redirect:/shop/shopMain";
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
		
		return "redirect:/shop/shopMain";
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
		
		return "redirect:/shop/shopMain";
	}
	
	@RequestMapping("/getAttach/{idx}")
	@ResponseBody
	public List<String> getAttach(@PathVariable int idx) throws Exception{
		return service.getAttach(idx);
	}
}
