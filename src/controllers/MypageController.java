package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	
	@RequestMapping("/index")
	public ModelAndView IndexHandler() {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "mypage/index");
		
		return mav;
	}
}
