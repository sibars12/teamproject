package controllers;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/shopping")
public class ShoppingController {
	
	@Autowired
	ObjectMapper mapper;
	
	@GetMapping("/buyNow")
	public ModelAndView BuyNowHandler(@RequestParam MultiValueMap<String,String> multiMap){
		ModelAndView mav = new ModelAndView("t_expr");
		List<String> stockNo = multiMap.get("stockNo");
		List<String> stockCnt = multiMap.get("stockCnt");
		
		System.out.println(stockNo.get(0));
		System.out.println(stockCnt.get(0));
		
		System.out.println(stockNo);
		System.out.println(stockCnt);
		mav.addObject("section", "shopping/buyNow");
		return mav;
	}
	
	@GetMapping("/cart")
	public ModelAndView cartHandler(@RequestParam MultiValueMap<String,String> multiMap){
		ModelAndView mav = new ModelAndView("t_expr");
		List<String> stockNo = multiMap.get("stockNo");
		System.out.println(stockNo);
		//System.out.println(stockNo.get(0));
		mav.addObject("section", "/shopping/cart");
		return mav;
	}
	
}
