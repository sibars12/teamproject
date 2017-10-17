package controllers;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/product")
public class ProductController {
	@Autowired
	ServletContext application;
	@Autowired
	SimpleDateFormat sdf;
	
	@RequestMapping("/addProduct")
	public ModelAndView addProductHandler() {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/addProduct");
		return mav;
	}
	
	@RequestMapping("/test")
	public ModelAndView testHandler(@RequestParam Object note) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/addProduct");
		System.out.println(note);
		mav.addObject("obj", note);
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
		return "/product/"+fileName;
	}
}
