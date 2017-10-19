package controllers;

import java.sql.SQLException;
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
	public ModelAndView noticeListHandle(@RequestParam(name="ownernumber" , defaultValue="10000") String ownernumber) throws SQLException {
		System.out.println("??");
		List<Map> li = inquireDao.readAll(ownernumber);
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_inquire");
			mav.addObject("list", li);
		mav.addObject("cnt", li.size());	
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
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
		mav.addObject("section", "inquire/list");
		}else {
		mav.addObject("addt", false);
		mav.addObject("section", "inquire/add");
		}
		return mav;
	}
	@RequestMapping("/del")
	public ModelAndView noticedelHandle(@RequestParam String num) throws SQLException {
		boolean a=inquireDao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_inquire");
		return mav;
}
}