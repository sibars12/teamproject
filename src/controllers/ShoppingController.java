package controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import models.ShoppingDao;

@Controller
@RequestMapping("/shopping")
public class ShoppingController {
	@Autowired
	ShoppingDao shoppingDao;
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
	public ModelAndView cartHandler(){
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "shopping/cart");
		mav.addObject("list", shoppingDao.getCartList("master")); // 임시
		return mav;
	}
	
	@RequestMapping("/cartDb") // 장바구니 DB저장
	public ModelAndView cartDbHandler(@RequestParam MultiValueMap<String,String> multiMap) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "shopping/cart");
		List<String> stockNo = multiMap.get("stockNo");
		List<String> stockCnt = multiMap.get("stockCnt");
		Map map = new HashMap<>();
		map.put("id", "master"); // 임시
		for(int i=0;i<stockNo.size();i++) {
			map.put("num", stockNo.get(i));
			map.put("volume", stockCnt.get(i));
			if(shoppingDao.checkCart(stockNo.get(i))>0) {
				shoppingDao.addCartVol(map);
			}else {
				shoppingDao.addCart(map);
			}
		}
		mav.addObject("list", shoppingDao.getCartList("master")); // 임시
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/deleteCart")
	public String deleteCartHandler(@RequestParam String dnum) {
		System.out.println(dnum);
		String[] ar = dnum.split(",");
		for(int i=0;i<ar.length;i++) {
			shoppingDao.deleteCart(ar[i]);
		}
		return "YY";
	}
}
