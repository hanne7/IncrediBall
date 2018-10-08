package kr.hanne.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest req,
			HttpServletResponse res, Object handler) throws Exception{
		
		HttpSession session = req.getSession();
		
		if(session.getAttribute(LOGIN) != null) {
			logger.info("clear login data before");
			session.removeAttribute(LOGIN);
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest req, 
			HttpServletResponse res, 
			Object handler, ModelAndView mav) throws Exception{
		
		HttpSession session = req.getSession();
		
		ModelMap modelMap = mav.getModelMap();
		Object userVO = modelMap.get("userVO");
		
		if(userVO != null) {
			logger.info("new login success");
			session.setAttribute(LOGIN, userVO);
			
			Object dest = session.getAttribute("dest");
			res.sendRedirect(dest != null ? (String)dest:"/");
		} else {
			int count = 0;
			session.setAttribute("count", count);
			res.sendRedirect("/user/loginPage");
		}		
//		res.sendRedirect("/");
	}
}
