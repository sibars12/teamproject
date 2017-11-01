package controllers;

import javax.servlet.http.HttpSession;
import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import models.CouponDao;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	CouponDao couponDao;
	
	@RequestMapping("/index")
	public ModelAndView IndexHandler() {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "mypage/index");
		
		return mav;
	}
	
	@GetMapping("/coupon")
	public ModelAndView CouponHandler(HttpSession session) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "mypage/coupon");
		mav.addObject("list", couponDao.getCouponList((String)session.getAttribute("auth")));
		return mav;
	}
	@PostMapping("/coupon")
	public ModelAndView PostCouponHandler(@RequestParam Map map, HttpSession session) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "mypage/coupon");
		if(couponDao.checkNo((String)map.get("no"))==0) {
			mav.addObject("result", false);
			mav.addObject("list", couponDao.getCouponList((String)session.getAttribute("auth")));
			return mav;
		}else {
			System.out.println(map);
			mav.addObject("result", true);
			couponDao.regCoupon(map);
			mav.addObject("list", couponDao.getCouponList((String)session.getAttribute("auth")));
			return mav;
		}
	}
	
	@GetMapping("/makecoupon")
	public ModelAndView MakeHandler() {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "mypage/makeCoupon");
		return mav;
	}
	@PostMapping("/makecoupon")
	public ModelAndView PostMakeHandler(@RequestParam Map map) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "mypage/makeCoupon");
		Set<Integer> set = couponDao.getCouponNo();
		int n = 0;
		while(true){
			n = (int)(Math.random()*900000000)+100000000;
			boolean rst = set.add(n);
			if(rst)
				break;
		}
		map.put("no", n);
		boolean rst = couponDao.addCoupon(map);
		mav.addObject("result", rst);
		return mav;
	}
}
