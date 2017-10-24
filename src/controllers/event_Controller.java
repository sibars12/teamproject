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
	public ModelAndView eventListHandle(@RequestParam(name="page" , defaultValue="1")int page) throws SQLException {
		System.out.println("??");
		int size=eventDao.all();
		System.out.println(size);
		double c=(size/10.0);
		int cc=size/10;
		if(c-cc>0) {
			cc+=1;
		}
		if(page>cc) {
			page = cc;
		}
		if(page <=1) {
			page = 1;
		}
		Map a=new HashMap();
		a.put("start", (page*10)-9);
		a.put("end", page*10);
		System.out.println(cc);
		List<Map> ila = eventDao.allist(a);
		List<Map> li = eventDao.readAll();
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_event");
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size" , cc);
			mav.addObject("section", "event/list");
		return mav;
	}
	@RequestMapping("/masterlist")
	public ModelAndView masterListHandle(@RequestParam(name="page" , defaultValue="1")int page) throws SQLException {
		System.out.println("??");
		int size=eventDao.all();
		System.out.println(size);
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
		System.out.println(cc);
		List<Map> ila = eventDao.allist(a);
		List<Map> li = eventDao.readAll();
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_event");
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size" , cc);
			mav.addObject("section", "event/masterlist");
		return mav;
	} 
	@GetMapping("/add")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("section", "event/add");
		return mav;
	}
	@ResponseBody
	@RequestMapping("/uploadImage")
	public String uploadHandler(@RequestParam("file") MultipartFile f) throws IllegalStateException, IOException {
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/event/content");
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			String of = f.getOriginalFilename();
			fileName = sdf.format(System.currentTimeMillis())+"."+of.substring(of.lastIndexOf(".")+1);
			File target = new File(dir, fileName);
			f.transferTo(target);
		}
		return "/event/content/"+fileName;
	}

	@PostMapping("/add")
	public ModelAndView noticeaddHandle(@RequestParam Map map, 
			@RequestParam(name="eventimg") MultipartFile f, HttpServletRequest request,
			HttpSession session) throws SQLException, IllegalStateException, IOException {
		System.out.println("맵"+map);
		ModelAndView mav = new ModelAndView();
		
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/event/eventimg");
			System.out.println("위치     "+path);
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			fileName = System.currentTimeMillis()+".jpg";
			File target = new File(dir, fileName);
			f.transferTo(target);
			System.out.println("파일 이름   "+target.getPath());
			map.put("eventimg", fileName);
		}else {
			map.put("eventimg", null);
		}
		System.out.println(map);
		boolean a=eventDao.addOnd(map);
		mav.setViewName("t_event");
		if(a==true){
			int size=eventDao.all();
			Map abc=new HashMap();
			abc.put("start", 1);
			abc.put("end", 9);
			double c=(size/10.0);
			int cc=size/10;
			if(c-cc>0) {
				cc+=1;
			}
			System.out.println(cc);
			List<Map> ila = eventDao.allist(abc);
			List<Map> li = eventDao.readAll();
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size" , cc);
			mav.addObject("section", "event/masterlist");
		}else {
		mav.addObject("addt", false);
		mav.addObject("section", "event/add");
		}
		return mav;
	}
	@RequestMapping("/view")
	public ModelAndView noticeViewHandle(@RequestParam String num , @RequestParam String page) throws SQLException {
		List<Map> list=eventDao.readOne(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("list", list);
		mav.addObject("page" ,page);
		mav.addObject("section", "event/view");
		return mav;
		
}
	@RequestMapping("/del")
	public ModelAndView noticedelHandle(@RequestParam String num) throws SQLException {
		boolean a=eventDao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		if(a==true){
			List<Map> li = eventDao.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
		mav.addObject("section", "event/list");
		}else {
		List<Map> list=eventDao.readOne(num);
		mav.addObject("list", list);
		mav.addObject("addt", false);
		mav.addObject("section", "event/view");
		}
		return mav;
}
	//list에서 체크한 상품들 삭제 후 결과 반환
		@ResponseBody
		@RequestMapping("/checkdel")
		public String deleteProduct(@RequestParam String dnum) {
			String[] ar = dnum.split(",");
			for(int i=0;i<ar.length;i++) {
				eventDao.del(ar[i]);
			}
			return "YY";
		}
		@RequestMapping("/home")
		public ModelAndView home() {
			ModelAndView mav = new ModelAndView();
			mav.addObject("section", "event/home");
			return mav;
		}
	
}