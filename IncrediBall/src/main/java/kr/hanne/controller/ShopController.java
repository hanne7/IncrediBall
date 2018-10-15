package kr.hanne.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/shop/*")
public class ShopController {

	@RequestMapping("/")
	public String shopMain() throws Exception{
		return "/shop/shop";
	}
	
	@RequestMapping("/cart")
	public void cart() throws Exception{
		
	}
	
	@RequestMapping("/order")
	public void order() throws Exception{
		
	}
}
