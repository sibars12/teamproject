package controllers;

import java.io.File;
import java.io.IOException;
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
	ProductDao productDao;
	@Autowired
	StockDao stockDao;
	@Autowired
	ObjectMapper mapper;
	
	@RequestMapping("/view")
	public ModelAndView ViewHandler(@RequestParam(defaultValue="10000") int ownernumber) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/view");
		mav.addObject("productInfo", productDao.getProductInfo(ownernumber));
		return mav;
	}
	
	@GetMapping("/list")
	public ModelAndView ListHandler(@RequestParam(defaultValue="1") String page) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/list");
		mav.addObject("list", productDao.getProductList(page));
		return mav;
	}
	
	@GetMapping("/addProduct")
	public ModelAndView addProductHandler(@RequestParam(defaultValue="1") String page) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/addProduct");
		mav.addObject("list", stockDao.getStockList(page));
		mav.addObject("page", stockDao.getStockPage());
		return mav;
	}
	
	@PostMapping("/addProduct")
	public ModelAndView profilePostHandle(@RequestParam Map param, 
			@RequestParam(name="imag") MultipartFile f) throws IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section","product/addProduct");
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/images/product");
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			fileName = (String)param.get("ownernumber")+".jpg";
			File target = new File(dir, fileName);
			f.transferTo(target);
			System.out.println(fileName);
			param.put("imag", fileName);
		}
		System.out.println("param: "+param);
		productDao.addProduct(param);
		mav.addObject("list", stockDao.getStockList("1"));
		mav.addObject("page", stockDao.getStockPage());
		mav.addObject("addResult", true);
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/uploadImage")
	public String uploadHandler(@RequestParam("file") MultipartFile f) throws IllegalStateException, IOException {
		System.out.println("upload ¿€µø!");
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/images/product/content");
			File dir = new File(path);
			if(!dir.exists()) {
				dir.mkdirs();
			}
			String of = f.getOriginalFilename();
			
			System.out.println("of: " + of);
			System.out.println("path: " + path);
			
			fileName = sdf.format(System.currentTimeMillis())+"."+of.substring(of.lastIndexOf(".")+1);
			File target = new File(dir, fileName);
			f.transferTo(target);
			System.out.println(fileName);
		}
		return "/images/product/content/"+fileName;
	}
	
	@ResponseBody
	@RequestMapping(path="/getPageList", produces="application/json;charset=utf-8")
	public String getPageListHandler(@RequestParam String page) throws JsonProcessingException {
		List list = stockDao.getStockList(page);
		return mapper.writeValueAsString(list);
	}
	
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
	
	@ResponseBody
	@RequestMapping("/getSchPage")
	public String getSchPageHandler(@RequestParam Map map) {
		return stockDao.getOptionSchStockPage(map);
	}
	
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