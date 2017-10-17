package controllers;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import models.ProductDao;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ProductDao pdao;
	
	@RequestMapping("/view")
	public ModelAndView ViewHandler(@RequestParam(defaultValue="10000") int ownernumber) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/view");
		mav.addObject("productInfo", pdao.getProductInfo(ownernumber));
		return mav;
	}
	
}
