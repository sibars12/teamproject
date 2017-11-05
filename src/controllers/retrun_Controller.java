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

import models.return_Dao;
import models.return_Dao;

@Controller
@RequestMapping("/return")
public class retrun_Controller {
	@Autowired
	ServletContext application;
	@Autowired
	SimpleDateFormat sdf;
	@Autowired
	return_Dao returnDao;
	@RequestMapping("/list")
	public ModelAndView returnListHandle(@RequestParam(name = "page", defaultValue = "1") int page) throws SQLException {
		int size = returnDao.all();
		double c = (size / 10.0);
		int cc = size / 10;
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
		a.put("start", (page * 10) - 9);
		a.put("end", page * 10);
		System.out.println(cc);
		List<Map> ila = returnDao.allist(a);
		List<Map> li = returnDao.list();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_return");
		mav.addObject("list", ila);
		mav.addObject("cnt", li.size());
		mav.addObject("size", cc);
		mav.addObject("section", "return/list");
		return mav;
	}
	

	


	@ResponseBody
	@RequestMapping("/uploadImage")
	public String uploadHandler(@RequestParam("file") MultipartFile f) throws IllegalStateException, IOException {
		String fileName = null;
		if (!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/return/returnimg");
			File dir = new File(path);
			if (!dir.exists()) {
				dir.mkdirs();
			}
			String of = f.getOriginalFilename();
			fileName = sdf.format(System.currentTimeMillis()) + "." + of.substring(of.lastIndexOf(".") + 1);
			File target = new File(dir, fileName);
			f.transferTo(target);
		}
		return "/return/returnimg/" + fileName;
	}
	@GetMapping("/add")
	public ModelAndView add() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_return");
		mav.addObject("section", "return/add");
		return mav;
	}

	@PostMapping("/add")
	public ModelAndView noticeaddHandle(@RequestParam Map map, 	HttpServletRequest request, HttpSession session) throws SQLException, IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();
		boolean a = returnDao.add(map);
		mav.setViewName("t_return");
		if (a == true) {
			int size = returnDao.all();
			Map abc = new HashMap();
			abc.put("start", 1);
			abc.put("end", 9);
			double c = (size / 10.0);
			int cc = size / 10;
			if (c - cc > 0) {
				cc += 1;
			}
		
			System.out.println(cc);
			List<Map> ila = returnDao.allist(abc);
			List<Map> li = returnDao.list();
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size", cc);
			mav.addObject("section", "return/list");
		} else {
			mav.addObject("addt", false);
			mav.addObject("section", "return/add");
		}
		return mav;
	}
	@GetMapping("/change")
	public ModelAndView getChangeHandle(@RequestParam String num) {
		List<Map> list = returnDao.read(num);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_return");
		mav.addObject("num", list.get(0).get("NUM"));
		mav.addObject("title", list.get(0).get("TITLE"));
		mav.addObject("content", list.get(0).get("CONTENT"));
		mav.addObject("section", "return/change");
		return mav;
	}
	@PostMapping("/change")
	public ModelAndView changeHandle(@RequestParam Map map) throws SQLException, IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView();

		
		boolean a = returnDao.change(map);
		mav.setViewName("t_return");
		if (a == true) {
			int size = returnDao.all();
			Map abc = new HashMap();
			abc.put("start", 1);
			abc.put("end", 9);
			double c = (size / 10.0);
			int cc = size / 10;
			if (c - cc > 0) {
				cc += 1;
			}
			System.out.println(cc);
			List<Map> ila = returnDao.allist(abc);
			List<Map> li = returnDao.list();
			mav.addObject("list", ila);
			mav.addObject("cnt", li.size());
			mav.addObject("size", cc);
			mav.addObject("section", "return/list");
		} else {
			mav.addObject("addt", false);
			mav.addObject("section", "return/list");
		}
		return mav;
	}
	@RequestMapping("/view")
	public ModelAndView noticeViewHandle(@RequestParam String num, @RequestParam(name = "page", defaultValue = "1") int page) throws SQLException {
		List<Map> list = returnDao.read(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_return");
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("section", "return/view");
		return mav;

	}

	@RequestMapping("/masterview")
	public ModelAndView masterViewHandle(@RequestParam String num, @RequestParam(name = "page", defaultValue = "1") int page) throws SQLException {
		List<Map> list = returnDao.read(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_return");
		mav.addObject("list", list);
		mav.addObject("page", page);
		mav.addObject("section", "return/masterview");
		return mav;

	}

	@RequestMapping("/del")
	public ModelAndView noticedelHandle(@RequestParam String num) throws SQLException {
		List<Map> fle = returnDao.read(num);
		String tre = (String) fle.get(0).get("CONTENT");

		int flag = 0;
		while (true) {
			int idx = tre.indexOf("/return/returnimg", flag);
			if(idx == -1)
				break;
			String url = tre.substring(idx, tre.indexOf("\"", idx));
			File file =new File(application.getRealPath(url));
			file.delete();
			flag = idx + 10;
		}
		File mainfile =new File(application.getRealPath("/return/returnimg/"+(String) fle.get(0).get("returnIMG")));
		mainfile.delete();
		boolean a = returnDao.del(num);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("t_return");
		if (a == true) {
			List<Map> li = returnDao.list();
			mav.addObject("list", li);
			mav.addObject("cnt", li.size());
			mav.addObject("section", "return/masterlist");

		} else {
			List<Map> list = returnDao.read(num);
			mav.addObject("list", list);
			mav.addObject("section", "return/view");
		}
		return mav;
	}

	// list에서 체크한 상품들 삭제 후 결과 반환


}