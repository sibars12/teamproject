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
	public ModelAndView ViewHandler(@RequestParam(name="ownernumber" , defaultValue="10000") String ownernumber, HttpSession session) {
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
		if(!f.isEmpty() && f.getContentType().startsWith("image")) { //빈 파일이 아니고 img로 시작한다면
			String path = application.getRealPath("/images/product");
			File dir = new File(path); // 파일경로
			if(!dir.exists()) {
				dir.mkdirs();
			}
			fileName = (String)param.get("ownernumber")+".jpg"; // 파일이름
			File target = new File(dir, fileName);
			f.transferTo(target);
			System.out.println(path);
			param.put("imag", fileName);
		}
		System.out.println("param: "+param);
		productDao.addProduct(param);
		stockDao.updateRegist(param);
		mav.addObject("type", param.get("type"));
		mav.addObject("list", stockDao.getStockList("1"));
		mav.addObject("page", ((stockDao.getStockPage()-1)/10)+1);
		mav.addObject("section","product/addProduct");
		mav.addObject("addResult", true);
		return mav;
	}
	
	//addProduct에서 summernote에 이미지 등록할 때 이미지 파일 생성 후 경로,이름 반환
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
		      System.out.println("내용: "+cont);
			int flag = 0;
		      while (true) {
		         int idx = cont.indexOf("/images/product/content", flag);
		         if(idx == -1)
		            break;
		         String url = cont.substring(idx, cont.indexOf("\"", idx));
		         System.out.println("url=" + url);
		         File file = new File(application.getRealPath(url));
		         file.delete();
		         flag = idx + 10;
		      }
		      //System.out.println("리얼패스: "+application.getRealPath("/images/product/content"+(String)info.get("IMAG")));
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
		List<Map> list = productDao.reviewList_master(map);

		ModelAndView mav = new ModelAndView("t_expr");		
		mav.addObject("list", list);
		mav.addObject("pageCount",pageCount);
		mav.addObject("page",page);
		mav.addObject("section","product/reviewList_Master");
		return mav;
	}
	// 후기 리스트 삭제
	@RequestMapping(path="deleteReview",produces="text/plain;charset=utf-8")
	@ResponseBody
	public String deleteReviewHandler(@RequestParam String arr){
		String[] ar = arr.split(",");
		int r =	productDao.deleteReview(ar);
		System.out.println(r);
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
		map.put("schlist", list);
		map.put("pageCount", pageCount);
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
			System.out.println(param);
			String fileName = null;
			int r=0;
			fileName = (String)param.get("ownernumber")+".jpg"; // 파일 이름
			if(!f.isEmpty() && f.getContentType().startsWith("image")){ // 빈파일이 아니고 이미지파일이면
				File old = new File(application.getRealPath("/images/product")+fileName);
				old.delete();
				String path = application.getRealPath("/images/product");
				File dir = new File(path); // 파일경로
				File target = new File(dir, fileName);
				System.out.println("target: "+target);
				f.transferTo(target);
				System.out.println("path:"+path);
				System.out.println("파일이름 : "+fileName);
				param.put("imag", fileName);
			}else{
				param.put("imag", fileName);
			}
			r = productDao.updateProduct(param);
			if(r==1){return "redirect:/product/addProduct";}
			else{return "redirect:/product/list";}
		}
		
		
		
		
		
		
}