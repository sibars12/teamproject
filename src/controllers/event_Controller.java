package controllers;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import models.event_Dao;

@Controller
@RequestMapping("/event")
public class event_Controller {
	@Autowired
	ServletContext application;
	@Autowired
	SimpleDateFormat sdf;
	@Autowired
	event_Dao eventDao;

	@RequestMapping("/list")
	public ModelAndView eventListHandle(@RequestParam(name = "page", defaultValue = "1") int page ) throws SQLException {
		int size = eventDao.inall();
		double c = (size / 9.0);
		int cc = size / 9;
		if (c - cc > 0) {
			cc += 1;
		}
		if (page > cc) {
			page = cc;
		}
		if (page <= 1) {
			page = 1;
		}
		Map a = new HashMap();
		a.put("start", (page * 9) - 8);
		a.put("end", page * 9);
		System.out.println(cc);
		List<Map> ila = eventDao.inlist(a);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("list", ila);
		mav.addObject("cnt", size);
		mav.addObject("lSize", (size - 1) / 3);
		mav.addObject("size", cc);
		mav.addObject("section", "event/list");
		return mav;
	}
	

	@RequestMapping("/startlist")
	public ModelAndView starteventListHandle(@RequestParam(name = "page", defaultValue = "1") int page) throws SQLException {
		int size = eventDao.stall();
		double c = (size / 12.0);
		int cc = size / 12;
		if (c - cc > 0) {
			cc += 1;
		}
		if (page > cc) {
			page = cc;
		}
		if (page <= 1) {
			page = 1;
		}
		Map a = new HashMap();
		a.put("start", (page * 9) - 8);
		a.put("end", page * 9);
		System.out.println(cc);
		List<Map> ila = eventDao.stlist(a);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("list", ila);
		mav.addObject("cnt", size);
		mav.addObject("lSize", (size - 1) / 3);
		mav.addObject("size", cc);
		mav.addObject("section", "event/startlist");
		return mav;
	}
	
	@RequestMapping("/endlist")
	public ModelAndView endeventListHandle(@RequestParam(name = "page", defaultValue = "1") int page) throws SQLException {
		int size = eventDao.edall();
		double c = (size / 12.0);
		int cc = size / 12;
		if (c - cc > 0) {
			cc += 1;
		}
		if (page > cc) {
			page = cc;
		}
		if (page <= 1) {
			page = 1;
		}
		Map a = new HashMap();
		a.put("start", (page * 9) - 8);
		a.put("end", page * 9);
		System.out.println(cc);
		List<Map> ila = eventDao.edlist(a);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("list", ila);
		mav.addObject("cnt", size);
		mav.addObject("lSize", (size - 1) / 3);
		mav.addObject("size", cc);
		mav.addObject("section", "event/endlist");
		return mav;
	}

	@ResponseBody
	@RequestMapping("/uploadImage")
	public String uploadHandler(@RequestParam("file") MultipartFile f) throws IllegalStateException, IOException {
		String fileName = null;
		if (!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/event/content");
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			String of = f.getOriginalFilename();
			fileName = sdf.format(System.currentTimeMillis()) + "." + of.substring(of.lastIndexOf(".") + 1);
			File target = new File(dir, fileName);
			f.transferTo(target);
		}
		return "/event/content/" + fileName;
	}
	@RequestMapping("/view")
	public ModelAndView noticeViewHandle(@RequestParam String num, @RequestParam String page,@RequestParam(name="mode" , defaultValue="")String mode) throws SQLException {
		List<Map> list = eventDao.readOne(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("list", list);
		mav.addObject("mode" , mode);
		mav.addObject("page", page);
		mav.addObject("section", "event/view");
		return mav;

	}




	@RequestMapping("/home")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		mav.addObject("section", "event/home");
		return mav;
	}

}