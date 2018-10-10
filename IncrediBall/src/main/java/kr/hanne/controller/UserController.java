package kr.hanne.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.hanne.domain.UserVO;
import kr.hanne.dto.LoginDTO;
import kr.hanne.service.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);

	@Inject
	private UserService service;
	
	@RequestMapping(value="/loginPage", method=RequestMethod.GET)
	public void loginPage(Model model) throws Exception{
		logger.info("loginPage called.....");		
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public void login(@ModelAttribute LoginDTO dto, Model model, HttpSession session) throws Exception{
	
		System.out.println("===============================");
		System.out.println("UserController: userid : "+ dto.getUserid());
		System.out.println("UserController: password : "+ dto.getPassword());
		System.out.println("===============================");
		
		UserVO vo = service.login(dto);
		
		if(vo == null) {
			logger.info("login failed.....");
		} else {
			logger.info("vo : " + vo.toString());
			model.addAttribute("userVO", vo);
		}
		
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest req,
			HttpServletResponse res, HttpSession session) throws Exception{
		
		logger.info("logout!!.........................");
		
		Object obj = session.getAttribute("login");
		
		if (obj != null) {
			session.removeAttribute("login");
			session.invalidate();
		}
		
		return "user/loginPage";
	}
	
	@RequestMapping("/join")
	public void join() throws Exception {
		logger.info("join called...........");
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(@ModelAttribute UserVO vo, RedirectAttributes rttr) throws Exception {
		logger.info("join success!.....");
		service.insertUser(vo);
		rttr.addFlashAttribute("msg", "SUCCESS");
		
		return "redirect:/";
	}
	
	@RequestMapping("/myPage")
	public void myPage(Model model, HttpSession session) throws Exception{
		logger.info("myPage called.....");
		UserVO vo = (UserVO) session.getAttribute("login");
		
		model.addAttribute("userVO", vo);
	}
	
	@RequestMapping("/modifyPage")
	public void modify(Model model, HttpSession session) throws Exception{
		logger.info("user modifyPage called.....");
		UserVO vo = (UserVO) session.getAttribute("login");
		
		model.addAttribute("userVO", vo);
	}
	
	@RequestMapping(value="/modify", method=RequestMethod.POST)
	public String modify(@ModelAttribute UserVO vo, Model model, HttpSession session, RedirectAttributes rttr) throws Exception{	
		logger.info("user modify success!.....");
		service.updateUser(vo);
				
		LoginDTO dto = new LoginDTO();
		
		dto.setUserid(vo.getUserid());
		dto.setPassword(vo.getPassword());
		
		vo = service.login(dto);
		
		logger.info("vo : " + vo.toString());
		
		session.setAttribute("login", vo);
		rttr.addFlashAttribute("msg", "SUCCESS");		
		
		return "redirect:/user/myPage";
	}
}
