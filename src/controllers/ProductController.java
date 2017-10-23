package controllers;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import models.ProductDao;
import models.StockDao;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ServletContext application;
	@Autowired
	SimpleDateFormat sdf;
	@Autowired
	ObjectMapper mapper;
	@Autowired
	ProductDao productDao;
	@Autowired
	StockDao stockDao;
	
	@RequestMapping("/view")
	public ModelAndView ViewHandler(@RequestParam(defaultValue="10000") String onum) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/view");
		mav.addObject("productInfo", productDao.getProductInfo(onum));
		return mav;
	} 
	
	// ��ǰ����Ʈ
	@GetMapping("/list")
	public ModelAndView ListHandler(@RequestParam(defaultValue="1") String page, 
			@RequestParam(defaultValue="signup") String option, @RequestParam(defaultValue="cloth") String type) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/list");
		Map map = new HashMap();
		map.put("page",page);
		map.put("option", option);
		map.put("type", type);
		switch(type) { // list�� list�� size�� type���� �Բ� ����
		case "cloth":
			mav.addObject("list", productDao.getClothList(map));
			mav.addObject("lSize", (productDao.getClothList(map).size()-1)/4);
			break;
		case "feed":
			mav.addObject("list", productDao.getFeedList(map));
			mav.addObject("lSize", (productDao.getFeedList(map).size()-1)/4);
			break;
		case "snack":
			mav.addObject("list", productDao.getSnackList(map));
			mav.addObject("lSize", (productDao.getSnackList(map).size()-1)/4);
			break;
		case "toy":
			mav.addObject("list", productDao.getToyList(map));
			mav.addObject("lSize", (productDao.getToyList(map).size()-1)/4);
			break;
		}
		mav.addObject("page", ((productDao.getProductPage(map)-1)/12)+1);
		mav.addObject("tPage", page);
		mav.addObject("option", option);
		mav.addObject("type", type);
		return mav;
	}
	
	@RequestMapping(path="/addReview",produces="applilcation/json;charset=utf-8")
	@ResponseBody
	public String addReviewHandler(@RequestParam Map param){
		System.out.println(param);
		String s="s";
		return s;
	}
	
	@RequestMapping(path="/ReviewList",produces="applilcation/json;charset=utf-8")
	@ResponseBody
	public List ReviewListHandler(@RequestParam String ownernumber) throws JsonProcessingException{
		List list = new ArrayList();
		//String str = mapper.writeValueAsString(list);
		return list;
	}
	
	
	@GetMapping("/addProduct")
	public ModelAndView addProductHandler(@RequestParam(defaultValue="1") String page) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/addProduct");
		mav.addObject("list", stockDao.getStockList(page));
		mav.addObject("page", ((stockDao.getStockPage()-1)/10)+1);
		return mav;
	}
	
	@PostMapping("/addProduct")
	public ModelAndView profilePostHandle(@RequestParam Map param, 
			@RequestParam(name="imag") MultipartFile f) throws IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView("t_expr");
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) { //�� ������ �ƴϰ� img�� �����Ѵٸ�
			String path = application.getRealPath("/images/product");
			File dir = new File(path); // ���ϰ��
			if(!dir.exists()) {
				dir.mkdirs();
			}
			fileName = (String)param.get("ownernumber")+".jpg"; // �����̸�
			File target = new File(dir, fileName);
			f.transferTo(target);
			System.out.println(path);
			param.put("imag", fileName);
		}
		System.out.println("param: "+param);
		productDao.addProduct(param);
		mav.addObject("type", param.get("type"));
		mav.addObject("list", stockDao.getStockList("1"));
		mav.addObject("page", ((stockDao.getStockPage()-1)/10)+1);
		mav.addObject("section","product/addProduct");
		mav.addObject("addResult", true);
		return mav;
	}
	
	//addProduct���� summernote�� �̹��� ����� �� �̹��� ���� ���� �� ���,�̸� ��ȯ
	@ResponseBody
	@RequestMapping("/uploadImage")
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
			System.out.println(fileName);
		}
		return "/images/product/content/"+fileName;
	}
	
	//addProduct���������� ��ǰ��� ��ȯ
	@ResponseBody
	@RequestMapping(path="/getPageList", produces="application/json;charset=utf-8")
	public String getPageListHandler(@RequestParam String page) throws JsonProcessingException {
		List list = stockDao.getStockList(page);
		return mapper.writeValueAsString(list);
	}
	
	//addProduct���������� �˻��ѻ�ǰ��� ��ȯ
	@ResponseBody
	@RequestMapping(path="/getSchList", produces="application/json;charset=utf-8")
	public String getSchListHandler(@RequestParam Map map) throws JsonProcessingException {
		System.out.println("map: "+map);
		List list;
		if(map.containsKey("page")) {
			list = stockDao.getOptionSchStockList(map);
		}else {
			map.put("page", 1);
			list = stockDao.getOptionSchStockList(map);
		}
		return mapper.writeValueAsString(list);
	}
	
	//addProduct���������� �˻��� ��ǰ��ϰ�� �� ��ȯ
	@ResponseBody
	@RequestMapping("/getSchPage")
	public String getSchPageHandler(@RequestParam Map map) {
		int cnt = stockDao.getOptionSchStockPage(map);
		int page = (cnt-1)/10+1;
		return Integer.toString(page);
	}
	
	//list���� üũ�� ��ǰ�� ���� �� ��� ��ȯ
	@ResponseBody
	@RequestMapping("/deleteProduct")
	public String deleteProduct(@RequestParam String dnum) {
		String[] ar = dnum.split(",");
		for(int i=0;i<ar.length;i++) {
			productDao.deleteProduct(ar[i]);
		}
		return "YY";
	}
	
	
	
}