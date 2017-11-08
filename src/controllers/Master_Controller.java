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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import models.ProductDao;
import models.QnA_Dao;
import models.ShoppingDao;
import models.StockDao;
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
	@Autowired
	ProductDao productDao;
	@Autowired
	StockDao stockDao;
	@Autowired
	ObjectMapper mapper;
	@Autowired
	ShoppingDao shoppingDao;
	
	@RequestMapping("/noticelist")
	public ModelAndView noticemsListHandle(@RequestParam(name="page" , defaultValue="1")int page) throws SQLException {
		int size=noticeDao.all();
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
	public String deletenotice(@RequestParam String dnum) {
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
		int size = eventDao.all();
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
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			fileName = System.currentTimeMillis() + ".jpg";
			File target = new File(dir, fileName);
			f.transferTo(target);
			map.put("eventimg", fileName);
		} else {
			map.put("eventimg", null);
		}
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
	public ModelAndView eventchangeHandle(@RequestParam Map map, @RequestParam(name = "eventimg") MultipartFile f,
			HttpServletRequest request, HttpSession session) throws SQLException, IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();

		String fileName = null;
		if (!f.isEmpty() && f.getContentType().startsWith("image")) {
			//기존 이미지 파일 삭제
			File file =new File(application.getRealPath("/event/eventimg/"+map.get("defimg")));
			file.delete();
			String path = application.getRealPath("/event/eventimg");
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			fileName = System.currentTimeMillis() + ".jpg";
			File target = new File(dir, fileName);
			f.transferTo(target);
			map.put("eventimg", fileName);
		} else {
			map.put("eventimg" , map.get("defimg"));
		}
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
			if(idx == -1) {
				break;
		}
			String url = tre.substring(idx, tre.indexOf("\"", idx));
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
			List<Map> fle = eventDao.readOne(ar[i]);
			String tre = (String) fle.get(0).get("CONTENT");

			int flag = 0;
			while (true) {
				int idx = tre.indexOf("/event/content", flag);
				if(idx == -1) {
					break;
			}
				String url = tre.substring(idx, tre.indexOf("\"", idx));
				File file =new File(application.getRealPath(url));
				file.delete();
				flag = idx + 5;
			}
			File mainfile =new File(application.getRealPath("/event/eventimg/"+(String) fle.get(0).get("EVENTIMG")));
			mainfile.delete();
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
		mav.addObject("num", li.get(0).get("NUM"));
		mav.addObject("content", li.get(0).get("CONTENT"));
		mav.addObject("section", "master/QnAchange");
		return mav;
	}
	@PostMapping("/QnAchange")
	public ModelAndView changehandle(@RequestParam Map map) throws SQLException {
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
	
	
	@GetMapping("/addProduct")
	public ModelAndView addProductHandler(@RequestParam(defaultValue="1") String page) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "master/addProduct");
		mav.addObject("list", stockDao.getStockList(page));
		mav.addObject("page", ((stockDao.getStockPage()-1)/10)+1);
		return mav;
	}
	
	@PostMapping("/addProduct")
	public ModelAndView profilePostHandle(@RequestParam Map param, 
			@RequestParam(name="imag") MultipartFile f) throws IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView("t_expr");
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) { //빈 파일이 아니고 img로 시작한다면
			String path = application.getRealPath("/images/product");
			File dir = new File(path); // 파일경로
			if(!dir.exists()) {
				dir.mkdirs();
			}
			fileName = (String)param.get("ownernumber")+".jpg"; // 파일이름
			File target = new File(dir, fileName);
			f.transferTo(target);
			param.put("imag", fileName);
		}
		productDao.addProduct(param);
		stockDao.updateRegist(param);
		mav.addObject("type", param.get("type"));
		mav.addObject("list", stockDao.getStockList("1"));
		mav.addObject("page", ((stockDao.getStockPage()-1)/10)+1);
		mav.addObject("section","master/addProduct");
		mav.addObject("addResult", true);
		return mav;
	}
	
	//addProduct에서 summernote에 이미지 등록할 때 이미지 파일 생성 후 경로,이름 반환
	@ResponseBody
	@RequestMapping("/productuploadImage")
	public String uploadHandler(@RequestParam("file") MultipartFile f) throws IllegalStateException, IOException {
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/images/product/content");
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			String of = f.getOriginalFilename();
			fileName = sdf.format(System.currentTimeMillis())+"."+of.substring(of.lastIndexOf(".")+1);
			File target = new File(dir, fileName);
			f.transferTo(target);
		}
		return "/images/product/content/"+fileName;
	}
	
	//addProduct페이지에서 상품목록 반환
	@ResponseBody
	@RequestMapping(path="/getPageList", produces="application/json;charset=utf-8")
	public String getPageListHandler(@RequestParam String page) throws JsonProcessingException {
		List list = stockDao.getStockList(page);
		return mapper.writeValueAsString(list);
	}
	
	//addProduct페이지에서 검색한상품목록 반환
	@ResponseBody
	@RequestMapping(path="/getSchList", produces="application/json;charset=utf-8")
	public String getSchListHandler(@RequestParam Map map) throws JsonProcessingException {
		List list;
		if(map.containsKey("page")) {
			list = stockDao.getOptionSchStockList(map);
		}else {
			map.put("page", 1);
			list = stockDao.getOptionSchStockList(map);
		}
		return mapper.writeValueAsString(list);
	}
	
	//addProduct페이지에서 검색한 상품목록결과 수 반환
	@ResponseBody
	@RequestMapping("/getSchPage")
	public String getSchPageHandler(@RequestParam Map map) {
		int cnt = stockDao.getOptionSchStockPage(map);
		int page = (cnt-1)/10+1;
		return Integer.toString(page);
	}
	
	//list에서 체크한 상품들 삭제 후 결과 반환
	@ResponseBody
	@RequestMapping("/deleteProduct")
	public String deleteProduct(@RequestParam String dnum) {
		String[] ar = dnum.split(",");
		
		for(int i=0;i<ar.length;i++) {
			// 이미지 파일들 지우기
			Map info = productDao.loadPInfo(ar[i]);
		      String cont = (String) info.get("CONTENTS");
			int flag = 0;
		      while (true) {
		         int idx = cont.indexOf("/images/product/content", flag);
		         if(idx == -1)
		            break;
		         String url = cont.substring(idx, cont.indexOf("\"", idx));
		         File file = new File(application.getRealPath(url));
		         file.delete();
		         flag = idx + 10;
		      }
		      File mainfile = new File(application.getRealPath("/images/product/"+(String)info.get("IMAG")));
		      mainfile.delete();			
			
		    // DB에서 삭제 
			boolean r = productDao.deleteProduct(ar[i]);
			boolean rr = productDao.editRegist(ar[i]);			
		}		
		return "YY";
	}	
	
	// 관리자용
	// 후기 리스트 관리자용
	@GetMapping("/reviewList_Master")
	public ModelAndView reviewList_masterHandler(@RequestParam(name="page", defaultValue="1") int page){
		Map map = new HashMap();
		int size = productDao.reviewListAllCount(); 
		int pageCount=1; // 페이지 갯수
		// 한페이지에 보이는 갯수 계산
		if(size%5==0){
			pageCount = size/5;
		}else{
			pageCount = size/5+1; 
		}
		map.put("start", (page-1)*5+1);
		map.put("end", page*5);
		
		
		//------------------------------------------------
		int allBlock=0;//전체 페이지 블럭
		//int nowBlock=0; //현재 페이지 블럭
		int startPage = (page-1)/5*5+1;
		int endPage = startPage+5-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}		
		//----------------------------------------------
		
		List<Map> list = productDao.reviewList_master(map);

		ModelAndView mav = new ModelAndView("t_expr");		
		mav.addObject("list", list);
		mav.addObject("pageCount",pageCount);
		mav.addObject("page",page);
		mav.addObject("section","master/reviewList_Master");
		mav.addObject("allBlock",allBlock);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		return mav;
	}
	// 후기 리스트 삭제
	@RequestMapping(path="deleteReview",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String deleteReviewHandler(@RequestParam String arr){
		String[] ar = arr.split(",");
		int r =	productDao.deleteReview(ar);
		String rst="";
		if(ar.length==r){ rst="모두 삭제되었습니다.";}
		else{			
			rst = r+"개 삭제됨/"+(ar.length-r)+"개  미삭제";
		}
		return rst;
	}
	
	// 후기 리스트 검색
	@RequestMapping(path="searchReview",produces="application/json;charset=utf-8")
	@ResponseBody
	public Map searchReviewHandler(@RequestParam Map param,@RequestParam(name="page", defaultValue="1")int page){
		Map map = new HashMap();
		String word ="%";
		word +=(String)param.get("key")+"%";		
		param.put("word", word);
		int size = productDao.searchCount(param);
		int pageCount=1; // 페이지 갯수
		// 한페이지에 보이는 갯수 계산
		if(size%5==0){
			pageCount = size/5;
		}else{
			pageCount = size/5+1; 
		}
		param.put("start", (page-1)*5+1);
		param.put("end", page*5);
		List<Map> list = productDao.searchReview(param);
		
		int allBlock=0;//전체 페이지 블럭
		int startPage = (page-1)/5*5+1;
		int endPage = startPage+5-1;
		if(endPage > pageCount){	endPage = pageCount;	}	
		
		map.put("schlist", list);
		map.put("pageCount", pageCount);
		map.put("startPage",startPage );
		map.put("endPage",endPage );
		map.put("page", page);
		return map;
	}
	
	// addProduct 상품내용 불러오기
		@RequestMapping(path="/loadPInfo",produces="application/json;charset=utf-8")
		@ResponseBody
		public Map loadPInfoHandler(@RequestParam Map param){
			String ownernumber = (String)param.get("ownernumber"); 
			Map map = productDao.loadPInfo(ownernumber);
			//map.put("info", productDao.loadPInfo(param));
			return map;
		}
	
	// 상품 내용 수정
		@RequestMapping("/updateProduct")
		public String updateProductHandler(@RequestParam Map param,@RequestParam(name="imag") MultipartFile f) throws IllegalStateException, IOException{
			String fileName = null;
			int r=0;
			fileName = (String)param.get("ownernumber")+".jpg"; // 파일 이름
			if(!f.isEmpty() && f.getContentType().startsWith("image")){ // 빈파일이 아니고 이미지파일이면
				File old = new File(application.getRealPath("/images/product")+fileName);
				old.delete();
				String path = application.getRealPath("/images/product");
				File dir = new File(path); // 파일경로
				File target = new File(dir, fileName);
				f.transferTo(target);
				param.put("imag", fileName);
			}else{
				param.put("imag", fileName);
			}
			r = productDao.updateProduct(param);
			if(r==1){return "redirect:/master/addProduct";}
			else{return "redirect:/product/list";}
		}
		@RequestMapping("/tradelist")
		public ModelAndView tradeHandler(@RequestParam(name="page" , defaultValue="1")int page) {
			int size=shoppingDao.tradeall();
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
			ModelAndView mav = new ModelAndView("t_expr");
			List<Map> list=shoppingDao.tradelist(a);
			mav.addObject("cnt", size);
			mav.addObject("size" , cc);
			mav.addObject("list" , list);
			mav.addObject("section","master/tradelist");
			return mav;
				

		}
		@RequestMapping("/returnY")
		public ModelAndView returnYHandler(@RequestParam String no) {
			ModelAndView mav = new ModelAndView("t_expr");
			
			return mav;
			
		}
}
