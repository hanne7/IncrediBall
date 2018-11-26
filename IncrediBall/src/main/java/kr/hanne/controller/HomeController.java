package kr.hanne.controller;

import java.util.Locale;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import kr.hanne.domain.Criteria;
import kr.hanne.service.BoardService;


/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	private BoardService service;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, Criteria cri) throws Exception {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		cri.setCate(1);
		cri.setPerPageNum(5);		
		model.addAttribute("noticeList", service.listCategory(cri));
		
		cri.setCate(3);
//		cri.setPerPageNum(7);
		model.addAttribute("listFree", service.listPopular(cri));
		
		cri.setCate(2);
		model.addAttribute("listFootball", service.listPopular(cri));
		
		return "home";
	}
	
	@RequestMapping(value="/voiceControl", method=RequestMethod.POST, produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> voiceControl(@RequestBody String power, HttpSession session) {
		logger.info("power: " + power);
		
		try{
			session.removeAttribute("power");
		
			if(power.equals("0")) {
				power = "1";
			} else if(power.equals("1")) {
				power = "0";
				session.removeAttribute("mode");
				session.setAttribute("mode", "0");
			}
			
			session.setAttribute("power", power);
			logger.info("after power: " + power);
			return new ResponseEntity<>(power, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@RequestMapping(value="/modeControl", method=RequestMethod.POST)
	public ResponseEntity<String> modeControl(@RequestBody String mode, HttpSession session){
		logger.info("mode: " + mode);
		
		try {
			session.removeAttribute("mode");
			if(mode.equals("1")) {
				mode = "0";
			} else if(mode.equals("0")) {
				mode = "1";
			}
			session.setAttribute("mode", mode);
			logger.info("after mode: " + mode);
			return new ResponseEntity<>(mode, HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
	}
	
	@RequestMapping("/header")
	public void header(HttpSession session, Model model) throws Exception{
		
		Object power =  session.getAttribute("power");
		Object mode = session.getAttribute("mode");
		
		if(power!=null) {
			model.addAttribute("power", power);
		} else {
			power = "0";
			model.addAttribute("power", power);
			session.setAttribute("power", power);
		}
		
		if(mode!=null) {
			model.addAttribute("mode", mode);
		} else {
			mode = "0";
			model.addAttribute("mode", mode);
			session.setAttribute("mode", mode);
		}
		
	}
	
	@RequestMapping("/footer")
	public void footer() throws Exception{}
}
