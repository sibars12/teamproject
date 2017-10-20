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
import org.springframework.web.servlet.ModelAndView;

import models.inquire_Dao;

@Controller
@RequestMapping("/inquire")
public class inquire_Controller {
	@Autowired
	inquire_Dao inquireDao;
	@RequestMapping("/list")
	public ModelAndView noticeListHandle(@RequestParam(name="page" , defaultValue="1")int page ,@RequestParam(name="ownernumber" , defaultValue="10000") String ownernumber) throws SQLException {
		System.out.println("??");
		List<Map> li = inquireDao.readAll(ownernumber);
		int size=inquireDao.all(ownernumber);
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_inquire");
			System.out.println("size="+size);
			if(page>size)
				page = size;
			if(page <=0) 
				page = 1;
			Map a=new HashMap();
			a.put("ownernumber", ownernumber);
			a.put("start", (page*5)-4);
			a.put("end", page*5);
			double c=(size/5.0);
			int cc=size/5;
			if(c-cc>0) {
				cc+=1;
			}
			System.out.println("size cc=" +cc);
			List<Map> ila = inquireDao.allist(a);
			mav.addObject("list", ila);
		mav.addObject("cnt", li.size());
		mav.addObject("size", cc);
			mav.addObject("section", "inquire/list"); 
		return mav;
	} 
	@GetMapping("/add")
	public ModelAndView add(@RequestParam(name="ownernumber" , defaultValue="10000") String ownernumber) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_inquire");
		mav.addObject("ownernumber", ownernumber);
		mav.addObject("section", "inquire/add");
		return mav;
	}

	@PostMapping("/add")
	public ModelAndView noticeaddHandle(@RequestParam Map map) throws SQLException {
		boolean a=inquireDao.addOnd(map);
		System.out.println(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_inquire");
		if(a==true){
			List<Map> li = inquireDao.readAll((String)map.get("ownernumber"));
			int size=inquireDao.all((String)map.get("ownernumber"));
				mav.setViewName("t_inquire");
				int page=1;
				System.out.println(size);
				if(page>size)
					page = size;
				if(page <=0) 
					page = 1;
				Map ma=new HashMap();
				ma.put("ownernumber", (String)map.get("ownernumber"));
				ma.put("start", (page*5)-4);
				ma.put("end", page*5);
				double c=(size/5.0);
				int cc=size/5;
				if(c-cc>0) {
					cc+=1;
				}
				List<Map> ila = inquireDao.allist(ma);
				mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size", cc);
		}else {
		mav.addObject("addt", false);
		mav.addObject("section", "inquire/add");
		}
		return mav;
	}
	@RequestMapping("/del")
	public ModelAndView noticedelHandle(@RequestParam String num ,@RequestParam String ownernumber) throws SQLException {
		boolean a=inquireDao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/inquire/list?ownernumber="+ownernumber);
		
		return mav;
}
}