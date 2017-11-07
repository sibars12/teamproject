package controllers;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tiles.request.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.CookieValue;
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
	
	// ��ǰ�󼼺���
	@RequestMapping("/view")
	public ModelAndView ViewHandler(@RequestParam(name="ownernumber" , defaultValue="10000") String ownernumber, HttpSession session, @CookieValue(value="recentView", required=false) Cookie cookie , HttpServletResponse response) {
		ModelAndView mav = new ModelAndView("t_expr");
		List<Map> li = inquireDao.readAll(ownernumber);
		productDao.updateCount(ownernumber);
		String cook="";
		// �ֱٺ���ǰ 5�� ����
		if(cookie!=null){
			String val = cookie.getValue();
			String[] ar = val.split("&");
			ArrayList list = new ArrayList<String>(3);
			for(int i=0; i<ar.length; i++){
				list.add(ar[i]);
			}
			System.out.println("list"+list);
			System.out.println("listSize"+list.size());
			
			// ���� ���� ���� ��� ����� �ǵڿ� �߰�
			if(list.contains(ownernumber)){
				int idx = list.indexOf(ownernumber);
				list.remove(idx);
				list.add(ownernumber);
				
				System.out.println("listSame"+list);
			}else{ // ���� �� ������ ù�� ����� �߰�
				
				if(list.size()>=3){
					list.remove(0);
				}
				list.add(ownernumber);
				
				System.out.println("listAdd"+list);
			}
			for(int i=0; i<list.size(); i++){
				cook += list.get(i)+"&";
			}
			System.out.println("cook"+cook);
			
			cookie = new Cookie("recentView",cook);//��Ű ����
			cookie.setMaxAge(60*60*24); //��Ű ���� 1��
			cookie.setPath("/");
			response.addCookie(cookie);			
		}
		else{
			cookie = new Cookie("recentView",ownernumber+"&");//��Ű ����
			cookie.setMaxAge(60*60*24); //��Ű ���� 1��
			cookie.setPath("/");
			response.addCookie(cookie);
		}
		
		mav.addObject("list", li);
		mav.addObject("cnt", li.size());
		mav.addObject("section", "product/view");
		mav.addObject("ownernumber", ownernumber);
		mav.addObject("productInfo", productDao.getProductInfo(ownernumber));
		
		
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
		//������ ó��
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
	//�ı� �Է�
	@RequestMapping(path="/addReview",produces="applilcation/json;charset=utf-8")
	@ResponseBody
	public String addReviewHandler(@RequestParam Map map, HttpSession session){
		System.out.println(map);
		boolean r = productDao.addReview(map);
		if (r){			
			return "true";
		}else	return "false";
	}
	
	//�ı� ����Ʈ �ҷ�����
	@RequestMapping(path="/reviewList")
	@ResponseBody
	public Map ReviewListHandler(@RequestParam(defaultValue="10000") String ownernumber,@RequestParam(name="page", defaultValue="1")int page ) throws JsonProcessingException{
		Map map = new HashMap(); 
		System.out.println(ownernumber);
		// ����Ʈ ������ ó��
		Map map1 = new HashMap();
		int size = productDao.reviewListCount(ownernumber); // count�� ������ ����Ʈ Ʃ�� ����
		int pageCount=1; // ������ ����
		// ���������� ���̴� ���� ���
		if(size%5==0){
			pageCount = size/5;
		}else{
			pageCount = size/5+1; 
		}
		map1.put("start", (page-1)*5+1);
		map1.put("end", page*5);
		map1.put("ownernumber", ownernumber);
		List list = productDao.getReviewList(map1);
		
		int startPage = (page-1)/5*5+1;
		int endPage = startPage+5-1;
		if(endPage > pageCount){
			endPage = pageCount;
		}	
		
		map.put("list", list);
		map.put("pageCount", pageCount);
		map.put("page", page);
		map.put("startPage",startPage );
		map.put("endPage",endPage );
		
		return map;
	}
	
	
		
		
		
		
		
		
}