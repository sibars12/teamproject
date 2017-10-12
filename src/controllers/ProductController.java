package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import models.ProductDao;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ProductDao pdao;
	
	@RequestMapping("/list")
	public ModelAndView ListHandler() {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/list");
		mav.addObject("list", pdao.getList());
		return mav;
	}
}
