package musign.classes;

import java.io.PrintWriter;
import java.net.URI;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class Interceptor extends HandlerInterceptorAdapter{

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws ServletException {
		response.setContentType("text/html; charset=UTF-8");
		
		try 
		{
			HttpSession session = request.getSession();
			if(session.getAttribute("login_idx") != null)
			{
		        return true;
		    }
			else
			{
				ModelAndView mv = new ModelAndView("redirect:/main");
	            throw new ModelAndViewDefiningException(mv);
			}
		} catch (Exception e) {
			ModelAndView mv = new ModelAndView("redirect:/main");
            throw new ModelAndViewDefiningException(mv);
			
		}

	}
}