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
import org.springframework.web.bind.annotation.PathVariable;
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
import models.inquire_Dao;

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
	@Autowired
	inquire_Dao inquireDao;
	
	// 상품상세보기
	@RequestMapping("/view")
	public ModelAndView ViewHandler(@RequestParam(name="ownernumber" , defaultValue="10000") String ownernumber) {
		ModelAndView mav = new ModelAndView("t_expr");
		List<Map> li = inquireDao.readAll(ownernumber);
		productDao.updateCount(ownernumber);
		mav.addObject("list", li);
		mav.addObject("cnt", li.size());
		mav.addObject("section", "product/view");
		mav.addObject("ownernumber", ownernumber);
		mav.addObject("productInfo", productDao.getProductInfo(ownernumber));
		return mav;
	} 
	
	// 상품리스트
	@GetMapping("/list")
	public ModelAndView ListHandler(@RequestParam(defaultValue="1") String page, 
			@RequestParam(defaultValue="signup") String option, @RequestParam(defaultValue="cloth") String type) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "product/list");
		Map map = new HashMap();
		map.put("page",page);
		map.put("option", option);
		map.put("type", type);
		switch(type) { // list와 list의 size를 type별로 함께 뽑음
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
		//페이지 처리
		int MPage = ((productDao.getProductPage(map)-1)/16)+1;
		int pPage = Integer.parseInt(page);
		mav.addObject("tPage", page);
		int startPage = pPage-(pPage%5)+1;
		mav.addObject("startPage", startPage);
		if((startPage+4)>MPage)
			mav.addObject("endPage", MPage);
		else
			mav.addObject("endPage", startPage+4);
		mav.addObject("MaxPage", MPage);
		mav.addObject("option", option);
		mav.addObject("type", type);
		return mav;
	}
	//후기 입력
	@RequestMapping(path="/addReview",produces="applilcation/json;charset=utf-8")
	@ResponseBody
	public String addReviewHandler(@RequestParam Map map){
		System.out.println(map);
		boolean r = productDao.addReview(map);
		if (r){			
			return "true";
		}else	return "false";
	}
	
	//후기 리스트 불러오기
	@RequestMapping(path="/reviewList")
	@ResponseBody
	public Map ReviewListHandler(@RequestParam(defaultValue="10000") String ownernumber,@RequestParam(name="page", defaultValue="1")int page ) throws JsonProcessingException{
		Map map = new HashMap(); 
		System.out.println(ownernumber);
		// 리스트 페이지 처리
		Map map1 = new HashMap();
		int size = productDao.reviewListCount(ownernumber); // count는 가져온 리스트 튜플 갯수
		int pageCount=1; // 페이지 갯수
		// 한페이지에 보이는 갯수 계산
		if(size%5==0){
			pageCount = size/5;
		}else{
			pageCount = size/5+1; 
		}
		map1.put("start", (page-1)*5+1);
		map1.put("end", page*4);
		map1.put("ownernumber", ownernumber);
		List list = productDao.getReviewList(map1);
		
		map.put("list", list);
		map.put("pageCount", pageCount);
		map.put("page", page);
		return map;
	}
	
	
		
		
		
		
		
		
}