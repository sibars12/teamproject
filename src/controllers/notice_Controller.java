package controllers;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import models.notice_Dao;

@Controller
@RequestMapping("/notice")
public class notice_Controller {
	@Autowired
	notice_Dao noticeDao;
	@RequestMapping("/list")
	public ModelAndView noticeListHandle(@RequestParam(name="page" , defaultValue="1")int page) throws SQLException {
		System.out.println("??");
		int size=noticeDao.all();
		System.out.println(size);
		double c=(size/5.0);
		int cc=size/10;
		if(c-cc>0) {
			cc+=1;
		}
		if(page>cc)
			page = cc;
		if(page <=0) 
			page = 1;
		Map a=new HashMap();
		a.put("start", (page*10)-9);
		a.put("end", page*10);
		System.out.println(cc);
		List<Map> ila = noticeDao.allist(a);
		List<Map> li = noticeDao.readAll();
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_notice");
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size" , cc);
			mav.addObject("section", "notice/list");
		return mav;
	}
	@RequestMapping("/masterlist")
	public ModelAndView noticemsListHandle(@RequestParam(name="page" , defaultValue="1")int page) throws SQLException {
		System.out.println("??");
		int size=noticeDao.all();
		System.out.println(size);
		Map a=new HashMap();
		a.put("start", (page*10)-9);
		a.put("end", page*10);
		double c=(size/5.0);
		int cc=size/10;
		if(c-cc>0) {
			cc+=1;
		}
		if(page>cc)
			page = cc;
		if(page <=0) 
			page = 1;
		System.out.println(cc);
		List<Map> ila = noticeDao.allist(a);
		List<Map> li = noticeDao.readAll();
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_notice");
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size" , cc);
			mav.addObject("section", "notice/masterlist");
		return mav;
	} 
	@GetMapping("/add")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		mav.addObject("section", "notice/add");
		return mav;
	}

	@PostMapping("/add")
	public ModelAndView noticeaddHandle(@RequestParam Map map) throws SQLException {
		boolean a=noticeDao.addOnd(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		if(a==true){
			int size=noticeDao.all();
			Map abc=new HashMap();
			abc.put("start", 1);
			abc.put("end", 9);
			double c=(size/5.0);
			int cc=size/10;
			if(c-cc>0) {
				cc+=1;
			}
			System.out.println(cc);
			List<Map> ila = noticeDao.allist(abc);
			List<Map> li = noticeDao.readAll();
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size" , cc);
			mav.addObject("section", "notice/masterlist");
		}else {
		mav.addObject("addt", false);
		mav.addObject("section", "notice/add");
		}
		return mav;
	}
	@RequestMapping("/view")
	public ModelAndView noticeViewHandle(@RequestParam String num) throws SQLException {
		List<Map> list=noticeDao.readOne(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		mav.addObject("list", list);
		mav.addObject("section", "notice/view");
		return mav;
		
}
	@RequestMapping("/masterview")
	public ModelAndView masterViewHandle(@RequestParam String num ) throws SQLException {
		List<Map> list=noticeDao.readOne(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		mav.addObject("list", list);
		mav.addObject("section", "notice/masterview");
		return mav;
		
}
	@RequestMapping("/del")
	public ModelAndView noticedelHandle(@RequestParam String num) throws SQLException {
		boolean a=noticeDao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		if(a==true){
			List<Map> li = noticeDao.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
		mav.addObject("section", "notice/list");
		}else {
		List<Map> list=noticeDao.readOne(num);
		mav.addObject("list", list);
		mav.addObject("addt", false);
		mav.addObject("section", "notice/view");
		}
		return mav;
}
	@ResponseBody
	@RequestMapping("/checkdel")
	public String deleteProduct(@RequestParam String dnum) {
		String[] ar = dnum.split(",");
		for(int i=0;i<ar.length;i++) {
			noticeDao.del(ar[i]);
		}
		return "YY";
	}
}