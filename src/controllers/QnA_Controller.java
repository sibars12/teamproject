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

import models.QnA_Dao;

@Controller
@RequestMapping("/QnA")
public class QnA_Controller {
	@Autowired
	QnA_Dao QnADao;
	@RequestMapping("/list")
	public ModelAndView noticeListHandle() throws SQLException {
		List<Map> li = QnADao.readAll();
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_QnA");
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
			mav.addObject("section", "QnA/list"); 
		return mav;
	} 
	@GetMapping("/add")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_QnA");
		mav.addObject("section", "QnA/add");
		return mav;
	}

	@PostMapping("/add")
	public ModelAndView noticeaddHandle(@RequestParam Map map) throws SQLException {
		boolean a=QnADao.addOnd(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_QnA");
		if(a==true){
			List<Map> li = QnADao.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
		mav.addObject("section", "QnA/list");
		}else {
		mav.addObject("addt", false);
		mav.addObject("section", "QnA/add");
		}
		return mav;
	}
	@RequestMapping("/del")
	public ModelAndView noticedelHandle(@RequestParam String num) throws SQLException {
		boolean a=QnADao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_QnA");
		if(a==true){
			List<Map> li = QnADao.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
		mav.addObject("section", "QnA/list");
		}else {
			List<Map> li = QnADao.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());
			mav.addObject("fail", "����");
			mav.addObject("section", "QnA/list");
		}
		return mav;
}
}