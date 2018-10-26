package kr.hanne.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Date;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import kr.hanne.domain.UserVO;
import kr.hanne.dto.LoginDTO;
import kr.hanne.service.UserService;
import kr.hanne.util.MediaUtils;

@Controller
@RequestMapping("/user/*")
public class UserController {

	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	private String uploadPath = "D://development//upload//user//";

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
			
			// 자동로그인위한 쿠키 처리
			if(dto.isUseCookie()) {
				int amount = 60*60*24*7;
				
				Date sessionLimit = new Date(System.currentTimeMillis()+(1000*amount));
				
				service.keepLogin(vo.getUserid(), session.getId(), sessionLimit);
			}
		}
		
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest req,
			HttpServletResponse res, HttpSession session) throws Exception{
		
		logger.info("logout!!.........................");
		
		Object obj = session.getAttribute("login");
		
		if (obj != null) {
			UserVO vo = (UserVO) obj;
			session.removeAttribute("login");
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(req, "loginCookie");
			if(loginCookie != null) {
				loginCookie.setPath("/");
				loginCookie.setMaxAge(0);
				res.addCookie(loginCookie);
				service.keepLogin(vo.getUserid(), session.getId(), new Date());
			}
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
	
	@RequestMapping("/delete")
	public String delete(int idx, HttpSession session, RedirectAttributes rttr) throws Exception{
		service.deleteUser(idx);
		session.invalidate();
		rttr.addFlashAttribute("msg", "SUCCESS");
		return "redirect:/";		
	}
	
	@RequestMapping("/addImg")
	public String addImg(UserVO vo) throws Exception{
		logger.info(vo.toString());
		MultipartFile imgFile = vo.getImgFile();
		String imgName = imgFile.getOriginalFilename();
		if(imgFile.isEmpty() == false) {
			byte[] bytes = imgFile.getBytes();
			Path path = Paths.get(uploadPath + imgFile.getOriginalFilename());
			Files.write(path, bytes);
		}
		vo.setImgName(imgName);
		logger.info(vo.toString());
		
		service.updateImg(vo);
		
		return "redirect:/user/myPage/";		
	}
	
	
	@ResponseBody
	@RequestMapping("/displayImg")
	public ResponseEntity<byte[]> displayImg(String imgName) throws Exception{
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		logger.info("imgName: " + imgName);
		try {
			String formatName = imgName.substring(imgName.lastIndexOf(".")+1);
			
			MediaType mType = MediaUtils.getMediaType(formatName);
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(uploadPath + imgName);
			
			headers.setContentType(mType);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
		}catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
		
		
		return entity;
	}
}
