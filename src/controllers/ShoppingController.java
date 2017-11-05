package controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import javax.servlet.http.HttpSession;

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

import models.ProductDao;
import models.ShoppingDao;
import models.StockDao;

@Controller
@RequestMapping("/shopping")
public class ShoppingController {
	@Autowired
	ShoppingDao shoppingDao;
	@Autowired
	ProductDao productDao;
	@Autowired
	StockDao stockDao;
	@Autowired
	ObjectMapper mapper;
	
	@GetMapping("/buyNow")
	public ModelAndView BuyNowHandler(@RequestParam MultiValueMap<String,String> multiMap, HttpSession session){
		ModelAndView mav = new ModelAndView("t_expr");
		//System.out.println(multiMap);
		
		List<String> stockNo = multiMap.get("stockNo");
		List<String> stockCnt = multiMap.get("stockCnt");
		List<String> stockPrice = multiMap.get("stockPrice");
		List<String> totPrice = multiMap.get("totPrice");
		List<Map> infoList  = new ArrayList();		
		for(String s : stockNo){
			Map stockInfo = stockDao.getStockInfo(s);
			infoList.add(stockInfo);
		}
		String id = (String) session.getAttribute("auth");
		Map memInfo = shoppingDao.getMemInfo(id);
		List<Map> coupons = shoppingDao.getCoupon(id);
	
		mav.addObject("section", "shopping/buyNow");
		mav.addObject("stockNo", stockNo);
		mav.addObject("stockCnt",stockCnt);
		mav.addObject("stockPrice", stockPrice);
		mav.addObject("totPrice", totPrice.get(0));
		mav.addObject("infoList", infoList);
		mav.addObject("memInfo",memInfo );
		mav.addObject("coupons", coupons);
		
		// 현재시간 가져오기
		String purchaseNo = id+"_"+System.currentTimeMillis();
		return mav;
	}
	
	@GetMapping("/cart")
	public ModelAndView cartHandler(HttpSession session){
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "shopping/cart");
		mav.addObject("list", shoppingDao.getCartList((String)session.getAttribute("auth")));
		return mav;
	}
	
	@RequestMapping("/cartDb") // 장바구니 DB저장
	public ModelAndView cartDbHandler(@RequestParam MultiValueMap<String,String> multiMap, HttpSession session) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "shopping/cart");
		List<String> stockNo = multiMap.get("stockNo");
		List<String> stockCnt = multiMap.get("stockCnt");
		Map map = new HashMap<>();
		map.put("id", (String)session.getAttribute("auth"));
		for(int i=0;i<stockNo.size();i++) {
			map.put("num", stockNo.get(i));
			map.put("volume", stockCnt.get(i));
			if(shoppingDao.checkCart(map)>0) {
				shoppingDao.addCartVol(map);
			}else {
				shoppingDao.addCart(map);
				int n = (int)session.getAttribute("cartCnt");
				session.setAttribute("cartCnt", n+1);
			}
		}
		mav.addObject("list", shoppingDao.getCartList((String)session.getAttribute("auth"))); // 임시
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/deleteCart")
	public String deleteCartHandler(@RequestParam String dnum, HttpSession session) {
		System.out.println(dnum);
		String[] ar = dnum.split(",");
		for(int i=0;i<ar.length;i++) {
			Map map = new HashMap<>();
			map.put("num", ar[i]);
			map.put("id", session.getAttribute("auth"));
			shoppingDao.deleteCart(map);
		}
		session.setAttribute("cartCnt", shoppingDao.getCartCnt((String)session.getAttribute("auth")));
		return "YY";
	}
}
