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

import models.notice_Dao;

@Controller
@RequestMapping("/notice")
public class notice_Controller {
	@Autowired
	notice_Dao ndo;
	@RequestMapping("/list")
	public ModelAndView noticeListHandle() throws SQLException {
		System.out.println("??");
		List<Map> li = ndo.readAll();
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_notice");
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
			mav.addObject("section", "list"); 
		return mav;
	} 
	@GetMapping("/add")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		mav.addObject("section", "add");
		return mav;
	}

	@PostMapping("/add")
	public ModelAndView noticeaddHandle(@RequestParam Map map) throws SQLException {
		boolean a=ndo.addOnd(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		if(a==true){
			List<Map> li = ndo.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
		mav.addObject("section", "list");
		}else {
		mav.addObject("addt", false);
		mav.addObject("section", "add");
		}
		return mav;
	}
	@RequestMapping("/view")
	public ModelAndView noticeViewHandle(@RequestParam String num) throws SQLException {
		List<Map> list=ndo.readOne(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		mav.addObject("list", list);
		mav.addObject("section", "view");
		return mav;
		
}
	@RequestMapping("/del")
	public ModelAndView noticedelHandle(@RequestParam String num) throws SQLException {
		boolean a=ndo.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		if(a==true){
			List<Map> li = ndo.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
		mav.addObject("section", "list");
		}else {
		List<Map> list=ndo.readOne(num);
		mav.addObject("list", list);
		mav.addObject("addt", false);
		mav.addObject("section", "view");
		}
		return mav;
}
}