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

import models.QnA_Dao;
import models.event_Dao;
import models.inquire_Dao;
import models.notice_Dao;
import models.return_Dao;

@Controller
@RequestMapping("/master")
public class Master_Controller {
	@Autowired
	notice_Dao noticeDao;
	@Autowired
	ServletContext application;
	@Autowired
	SimpleDateFormat sdf;
	@Autowired
	event_Dao eventDao;
	@Autowired
	inquire_Dao inquireDao;
	@Autowired
	QnA_Dao QnADao;
	@Autowired
	return_Dao returnDao;
	
	@RequestMapping("/noticelist")
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
			mav.addObject("section", "master/noticelist");
		return mav;
	} 
	@GetMapping("/noticeadd")
	public ModelAndView noticeadd() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		mav.addObject("section", "master/noticeadd");
		return mav;
	}

	@PostMapping("/noticeadd")
	public ModelAndView noticeadHandle(@RequestParam Map map) throws SQLException {
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
			mav.addObject("section", "master/noticelist");
		}else {
		mav.addObject("addt", false);
		mav.addObject("section", "master/noticeadd");
		}
		return mav;
	}
	@RequestMapping("/noticeview")
	public ModelAndView masterViewHandle(@RequestParam String num ) throws SQLException {
		List<Map> list=noticeDao.readOne(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		mav.addObject("list", list);
		mav.addObject("section", "master/noticeview");
		return mav;
		
}
	@RequestMapping("/noticedel")
	public ModelAndView noticedelHandle(@RequestParam String num) throws SQLException {
		boolean a=noticeDao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		if(a==true){
			List<Map> li = noticeDao.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());	
		mav.addObject("section", "master/noticelist");
		}else {
		List<Map> list=noticeDao.readOne(num);
		mav.addObject("list", list);
		mav.addObject("addt", false);
		mav.addObject("section", "master/noticeview");
		}
		return mav;
}
	@ResponseBody
	@RequestMapping("/noticecheckdel")
	public String deleteProduct(@RequestParam String dnum) {
		String[] ar = dnum.split(",");
		for(int i=0;i<ar.length;i++) {
			noticeDao.del(ar[i]);
		}
		return "YY";
	}
	@GetMapping("/noticechange")
	public ModelAndView change(@RequestParam String num) {
		List<Map> list=noticeDao.readOne(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_notice");
		mav.addObject("num" , num);
		mav.addObject("title" ,list.get(0).get("TITLE"));
		mav.addObject("content" ,list.get(0).get("CONTENT"));
		mav.addObject("section", "master/noticechange");
		return mav;
	}

	@PostMapping("/noticechange")
	public ModelAndView changepsHandle(@RequestParam Map map) throws SQLException {
		boolean a=noticeDao.change(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/master/noticeview?num="+map.get("num"));
		return mav;
	}
	//====================================notice======================================================================
	
	
	@RequestMapping("/eventlist")
	public ModelAndView masterListHandle(@RequestParam(name = "page", defaultValue = "1") int page)
			throws SQLException {
		System.out.println("??");
		int size = eventDao.all();
		System.out.println(size);
		double c = (size / 10.0);
		int cc = size / 10;
		if (c - cc > 0) {
			cc += 1;
		}
		if (page > cc) {
			page = cc;
			}
		if (page <= 0) {
			page = 1;
		}
		Map a = new HashMap();
		a.put("start", (page * 10) - 9);
		a.put("end", page * 10);
		System.out.println("page="+page);
		System.out.println(cc);
		List<Map> ila = eventDao.allist(a);
		List<Map> li = eventDao.readAll();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("list", ila);
		mav.addObject("cnt", li.size());
		mav.addObject("size", cc);
		mav.addObject("section", "master/eventlist");
		return mav;
	}
	
	@GetMapping("/eventadd")
	public ModelAndView eventadd() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("section", "master/eventadd");
		return mav;
	}

	@PostMapping("/eventadd")
	public ModelAndView noticeaddHandle(@RequestParam Map map, @RequestParam(name = "eventimg") MultipartFile f,
			HttpServletRequest request, HttpSession session) throws SQLException, IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();

		String fileName = null;
		if (!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/event/eventimg");
			System.out.println("위치     " + path);
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			fileName = System.currentTimeMillis() + ".jpg";
			File target = new File(dir, fileName);
			f.transferTo(target);
			System.out.println("파일 이름   " + target.getPath());
			map.put("eventimg", fileName);
		} else {
			map.put("eventimg", null);
		}
		System.out.println(map);
		boolean a = eventDao.addOnd(map);
		mav.setViewName("t_event");
		if (a == true) {
			int size = eventDao.all();
			Map abc = new HashMap();
			abc.put("start", 1);
			abc.put("end", 9);
			double c = (size / 10.0);
			int cc = size / 10;
			if (c - cc > 0) {
				cc += 1;
			}
			System.out.println(cc);
			List<Map> ila = eventDao.allist(abc);
			List<Map> li = eventDao.readAll();
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size", cc);
			mav.addObject("section", "event/masterlist");
		} else {
			mav.addObject("addt", false);
			mav.addObject("section", "master/eventadd");
		}
		return mav;
	}
	@GetMapping("/eventchange")
	public ModelAndView getChangeHandle(@RequestParam String num) {
		List<Map> list = eventDao.readOne(num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("num", list.get(0).get("NUM"));
		mav.addObject("title", list.get(0).get("TITLE"));
		mav.addObject("content", list.get(0).get("CONTENT"));
		mav.addObject("startdate", list.get(0).get("STARTDATE"));
		mav.addObject("enddate", list.get(0).get("ENDDATE"));
		mav.addObject("eventimg", list.get(0).get("EVENTIMG"));
		mav.addObject("section", "master/eventchange");
		return mav;
	}
	@PostMapping("/eventchange")
	public ModelAndView ㅔㄴchangeHandle(@RequestParam Map map, @RequestParam(name = "eventimg") MultipartFile f,
			HttpServletRequest request, HttpSession session) throws SQLException, IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();

		String fileName = null;
		if (!f.isEmpty() && f.getContentType().startsWith("image")) {
			//기존 이미지 파일 삭제
			File file =new File(application.getRealPath("/event/eventimg/"+map.get("defimg")));
			file.delete();
			String path = application.getRealPath("/event/eventimg");
			System.out.println("위치     " + path);
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			fileName = System.currentTimeMillis() + ".jpg";
			File target = new File(dir, fileName);
			f.transferTo(target);
			System.out.println("파일 이름   " + target.getPath());
			map.put("eventimg", fileName);
		} else {
			map.put("eventimg" , map.get("defimg"));
		}
		System.out.println(map);
		boolean a = eventDao.change(map);
		mav.setViewName("t_event");
		if (a == true) {
			int size = eventDao.all();
			Map abc = new HashMap();
			abc.put("start", 1);
			abc.put("end", 9);
			double c = (size / 10.0);
			int cc = size / 10;
			if (c - cc > 0) {
				cc += 1;
			}
			System.out.println(cc);
			List<Map> ila = eventDao.allist(abc);
			List<Map> li = eventDao.readAll();
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size", cc);
			mav.addObject("section", "master/eventlist");
		} else {
			mav.addObject("addt", false);
			mav.addObject("section", "master/eventadd");
		}
		return mav;
	}
	
	@RequestMapping("/eventview")
	public ModelAndView masterViewHandle(@RequestParam String num, @RequestParam String page) throws SQLException {
		List<Map> list = eventDao.readOne(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("section", "master/eventview");
		return mav;

	}

	@RequestMapping("/eventdel")
	public ModelAndView eventdelHandle(@RequestParam String num) throws SQLException {
		List<Map> fle = eventDao.readOne(num);
		String tre = (String) fle.get(0).get("CONTENT");

		int flag = 0;
		while (true) {
			int idx = tre.indexOf("/event/content", flag);
			if(idx == -1)
				break;
			String url = tre.substring(idx, tre.indexOf("\"", idx));
			System.out.println("url=" + url);
			File file =new File(application.getRealPath(url));
			file.delete();
			flag = idx + 10;
		}
		File mainfile =new File(application.getRealPath("/event/eventimg/"+(String) fle.get(0).get("EVENTIMG")));
		mainfile.delete();
		boolean a = eventDao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_event");
		if (a == true) {
			List<Map> li = eventDao.readAll();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());
			mav.addObject("section", "master/eventlist");

		} else {
			List<Map> list = eventDao.readOne(num);
			mav.addObject("list", list);
			mav.addObject("addt", false);
			mav.addObject("section", "master/eventview");
		}
		return mav;
	}

	// list에서 체크한 상품들 삭제 후 결과 반환
	@ResponseBody
	@RequestMapping("/eventcheckdel")
	public String eventProduct(@RequestParam String dnum) {
		String[] ar = dnum.split(",");
		for (int i = 0; i < ar.length; i++) {
			eventDao.del(ar[i]);
		}
		return "YY";
	}
//=============================================EVENT==============================================================
	
	@ResponseBody
	@RequestMapping("/inquirecheckdel")
	public String msdelhandle(@RequestParam String dnum ) throws SQLException {
		String[] ar = dnum.split(",");
		for(int i=0;i<ar.length;i++) {
			inquireDao.del(ar[i]);
		}
		
		return "YY";
}
	@RequestMapping("/inquirelist")
	public ModelAndView masterhandle(@RequestParam(name="page" , defaultValue="1")int page ) throws SQLException {
		ModelAndView mav = new ModelAndView();
		List<Map> li = inquireDao.masterlist();
		int size=li.size();
			mav.setViewName("t_inquire");
			System.out.println("size="+size);
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
			List<Map> lis = inquireDao.masteralllist(a);
			mav.addObject("list", lis);
			mav.addObject("cnt", li.size());
			mav.addObject("size", cc);
			mav.addObject("section", "master/inquirelist");
		return mav;
		
	}
	@RequestMapping("/inquirereply")
	public ModelAndView replyhandle(@RequestParam Map map) throws SQLException {
		ModelAndView mav = new ModelAndView();
		boolean re = inquireDao.reply(map);
		mav.setViewName("redirect:/master/inquirelist");
		
		return mav;
}
	
	//================================================inquire==============================================
	
	
	@RequestMapping("/QnAlist")
	public ModelAndView QnAlist(@RequestParam(name="page" , defaultValue="1")int page) throws SQLException {
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
		ModelAndView mav = new ModelAndView();
			mav.setViewName("t_QnA");
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());	
			mav.addObject("size" , cc);
			mav.addObject("section", "master/QnAlist"); 
		return mav;
	} 
	@GetMapping("/QnAadd")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_QnA");
		mav.addObject("section", "master/QnAadd");
		return mav;
	}

	@PostMapping("/QnAadd")
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
		mav.addObject("section", "master/QnAlist");
		}else {
		mav.addObject("addt", false);
		mav.addObject("section", "master/QnAadd");
		}
		return mav;
	}
	@RequestMapping("/QnAdel")
	public ModelAndView QnAdel(@RequestParam String num) throws SQLException {
		boolean a=QnADao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_QnA");
		if(a==true){
		mav.addObject("section", "/master/QnAlist");
		}else {
			mav.addObject("section", "/master/QnAlist");
		}
		return mav;
}
	@ResponseBody
	@RequestMapping("/QnAcheckdel")
	public String QnAchdel(@RequestParam String dnum) {
		String[] ar = dnum.split(",");
		for(int i=0;i<ar.length;i++) {
			QnADao.del(ar[i]);
		}
		return "YY";
	}
	@GetMapping("/QnAchange")
	public ModelAndView QnAchange(@RequestParam String num) {
		ModelAndView mav = new ModelAndView();
		List<Map> li=QnADao.read(num);
		mav.setViewName("t_QnA");
		mav.addObject("title", li.get(0).get("TITLE"));
				System.out.println("title= "+li.get(0).get("TITLE"));
		mav.addObject("num", li.get(0).get("NUM"));
				System.out.println("NUM= "+li.get(0).get("NUM"));
		mav.addObject("content", li.get(0).get("CONTENT"));
				System.out.println("CONTENT= "+li.get(0).get("CONTENT"));
		mav.addObject("section", "master/QnAchange");
		return mav;
	}
	@PostMapping("/QnAchange")
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
			mav.setViewName("redirect:/master/QnAlist?page=1");
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());	
			mav.addObject("size" , cc);
		return mav;
	}
	
	//========================================================QnA======================================================
	
	
	@RequestMapping("/returnlist")
	public ModelAndView masterListHandle(@RequestParam(name = "page", defaultValue = "1") int page , HttpSession session)
			throws SQLException {
		int size = returnDao.all();
		double c = (size / 10.0);
		int cc = size / 10;
		if (c - cc > 0) {
			cc += 1;
		}
		if (page > cc) {
			page = cc;
			}
		if (page <= 0) {
			page = 1;
		}
		Map a = new HashMap();
		a.put("start", (page * 10) - 9);
		a.put("end", page * 10);
		System.out.println("page="+page);
		System.out.println(cc);
		List<Map> ila = returnDao.allist(a);
		List<Map> li = returnDao.list();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_return");
		mav.addObject("list", ila);
		mav.addObject("cnt", li.size());
		mav.addObject("size", cc);
		mav.addObject("section", "master/returnlist");
		return mav;
	}
	
	
	@RequestMapping("/returnview")
	public ModelAndView returnViewHandle(@RequestParam String num, @RequestParam String page) throws SQLException {
		List<Map> list = returnDao.read(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_return");
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("section", "master/returnview");
		return mav;

	}
	
	@ResponseBody
	@RequestMapping("/returncheckdel")
	public String returncheckdel(@RequestParam String dnum) {
		String[] ar = dnum.split(",");
		for (int i = 0; i < ar.length; i++) {
			returnDao.del(ar[i]);
		}
		return "YY";
	}
	@RequestMapping("/returncoment")
	public ModelAndView comenthandle(@RequestParam Map map) {
		ModelAndView mav = new ModelAndView("");
		returnDao.coment(map);
		mav.setViewName("redirect:/master/returnview?num="+map.get("num")+"&page="+map.get("page"));
		
		return mav;
		
	}


	//======================================================retrun=============================================
}