package kr.hanne.interceptor;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import kr.hanne.domain.UserVO;
import kr.hanne.service.UserService;

public class CookieInterceptor extends HandlerInterceptorAdapter {

	private static final Logger logger = LoggerFactory.getLogger(CookieInterceptor.class);
	
	@Inject
	private UserService service;
	
	@Override
	public boolean preHandle(HttpServletRequest req,
			HttpServletResponse res, Object handler) throws Exception{
		
		HttpSession session = req.getSession();
		
		Cookie loginCookie = WebUtils.getCookie(req, "loginCookie");
		if(loginCookie != null) {
			UserVO vo = service.checkUserWithSessionKey(loginCookie.getValue());
			
			logger.info("UserVO : " + vo);
			if(vo != null) {
				session.setAttribute("login", vo);
				return true;
			}
		}
		
		return true;
	}
	
}
