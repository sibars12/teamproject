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
import models.ShoppingDao;
import models.inquire_Dao;
import models.return_Dao;

@Controller
@RequestMapping("/mypage")
public class MypageController {
	@Autowired
	CouponDao couponDao;
	@Autowired
	inquire_Dao inquireDao;
	@Autowired
	return_Dao returnDao;
	@Autowired
	ShoppingDao shoppingDao;
	
	
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
	@RequestMapping("/board")
	public ModelAndView boardhandler(HttpSession session, @RequestParam(name="inpage" , defaultValue="1")int inpage ,@RequestParam(name="repage" , defaultValue="1") int repage) {
		List<Map> li = inquireDao.uesrin((String)session.getAttribute("auth"));
		int size=inquireDao.insize((String)session.getAttribute("auth"));
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_expr");
			double c=(size/3.0);
			int cc=size/3;
			if(c-cc>0) {
				cc+=1; 
			}
			if(inpage>cc)
				inpage = cc;
			if(inpage <=0) 
				inpage = 1;
			Map map=new HashMap();
			map.put("auth", session.getAttribute("auth"));
			map.put("start", (inpage*3)-2);
			map.put("end", inpage*3);
			List<Map> ila = inquireDao.uesrlist(map);
		mav.addObject("inlist", ila);
		mav.addObject("incnt", li.size());
		mav.addObject("insize", cc);
		
		List<Map> reli = returnDao.uesrre((String)session.getAttribute("auth"));
		int resize=returnDao.resize((String)session.getAttribute("auth"));
			double rec=(resize/3.0);
			int recc=resize/3;
			if(rec-recc>0) {
				recc+=1; 
			}
			if(repage>recc)
				repage = recc;
			if(repage <=0) 
				repage = 1;
			Map remap=new HashMap();
			remap.put("auth", session.getAttribute("auth"));
			remap.put("start", (repage*3)-2);
			remap.put("end", repage*3);
			List<Map> reila = returnDao.uesrlist(remap);
		mav.addObject("relist", reila);
		mav.addObject("recnt", reli.size());
		mav.addObject("resize", recc);
		mav.addObject("section", "mypage/board");
		return mav;
	}
	

	
	
}













