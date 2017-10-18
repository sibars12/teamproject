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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

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
	
	@RequestMapping("/view")
	public ModelAndView ViewHandler(@RequestParam(defaultValue="10000") int ownernumber) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/view");
		mav.addObject("productInfo", productDao.getProductInfo(ownernumber));
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
	
	@ResponseBody
	@RequestMapping("/uploadImage")
	public String uploadHandler(@RequestParam("file") MultipartFile f) throws IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView("t_expr");
		System.out.println("upload ¿€µø!");
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/product/content");
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
		return "/product/content/"+fileName;
	}
	
	@PostMapping("/addProduct")
	public ModelAndView profilePostHandle(@RequestParam Map param, 
			@RequestParam(name="imag") MultipartFile f, HttpServletRequest request,
			HttpSession session) throws IllegalStateException, IOException {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section","product/addProduct");
		String fileName = null;
		if(!f.isEmpty() && f.getContentType().startsWith("image")) {
			String path = application.getRealPath("/product/image");
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
		System.out.println(param);
		productDao.addProduct(param);
		return mav;
	}
}