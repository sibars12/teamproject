package controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@RequestMapping("/list")
	public ModelAndView ListHandler() {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/list");
		
		return mav;
	}
}
