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

import models.QnA_Dao;

@Controller
@RequestMapping("/QnA")
public class QnA_Controller {
	@Autowired
	QnA_Dao QnADao;
	@RequestMapping("/list")
	public ModelAndView noticeListHandle() throws SQLException {
		System.out.println("??");
		List<Map> li = QnADao.readAll();
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_QnA");
			mav.addObject("list", li);
		mav.addObject("cnt", li.size());	
			mav.addObject("section", "QnA/list"); 
		return mav;
	} 
	@RequestMapping("/masterlist")
	public ModelAndView masterListHandle(@RequestParam(name="page" , defaultValue="1")int page) throws SQLException {
		int size=QnADao.all();
		if(page>size)
			page = size;
		if(page <=0) 
			page = 1;
		Map a=new HashMap();
		a.put("start", (page*10)-9);
		a.put("end", page*10);
		double c=(size/10.0);
		int cc=size/10;
		if(c-cc>0) {
			cc+=1;
		}
		List<Map> ila = QnADao.allist(a);
		List<Map> li = QnADao.readAll();
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_QnA");
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());	
			mav.addObject("size" , cc);
			mav.addObject("section", "QnA/masterlist"); 
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
		boolean as=QnADao.addOnd(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_QnA");
		if(as==true){
			int page=1;
			int size=QnADao.all();
			if(page>size)
				page = size;
			if(page <=0) 
				page = 1;
			Map a=new HashMap();
			a.put("start", (page*10)-9);
			a.put("end", page*10);
			double c=(size/10.0);
			int cc=size/10;
			if(c-cc>0) {
				cc+=1;
			}
			List<Map> ila = QnADao.allist(a);
			List<Map> li = QnADao.readAll();
				mav.setViewName("t_QnA");
				mav.addObject("list", ila);
				mav.addObject("cnt", li.size());	
				mav.addObject("size" , cc);	
		mav.addObject("section", "QnA/masterlist");
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
		mav.addObject("section", "/QnA/masterlist");
		}else {
			mav.addObject("section", "/QnA/masterlist");
		}
		return mav;
}
	@ResponseBody
	@RequestMapping("/checkdel")
	public String deleteProduct(@RequestParam String dnum) {
		String[] ar = dnum.split(",");
		for(int i=0;i<ar.length;i++) {
			QnADao.del(ar[i]);
		}
		return "YY";
	}
	@GetMapping("/change")
	public ModelAndView change(@RequestParam String num) {
		ModelAndView mav = new ModelAndView();
		List<Map> li=QnADao.read(num);
		mav.setViewName("t_QnA");
		mav.addObject("title", li.get(0).get("TITLE"));
				System.out.println("title= "+li.get(0).get("TITLE"));
		mav.addObject("num", li.get(0).get("NUM"));
				System.out.println("NUM= "+li.get(0).get("NUM"));
		mav.addObject("content", li.get(0).get("CONTENT"));
				System.out.println("CONTENT= "+li.get(0).get("CONTENT"));
		mav.addObject("section", "QnA/change");
		return mav;
	}
	@PostMapping("/change")
	public ModelAndView changehandle(@RequestParam Map map) throws SQLException {
		System.out.println(map);
		boolean as=QnADao.change(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_QnA");
		int page=1;
		int size=QnADao.all();
		double c=(size/10.0);
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
		List<Map> ila = QnADao.allist(a);
		List<Map> li = QnADao.readAll();
			mav.setViewName("redirect:/QnA/masterlist?page=1");
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());	
			mav.addObject("size" , cc);
		return mav;
	}
}