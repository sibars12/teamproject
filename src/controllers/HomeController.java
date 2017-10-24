package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.*;

import models.ProductDao;

@Controller
public class HomeController {
	@Autowired
	ProductDao productDao;
	@Autowired
	ObjectMapper mapper;
	
	@RequestMapping({"/","/index"})
	public ModelAndView HomeHandler() {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "home");
		Map map = new HashMap();
		map.put("type", "cloth");
		mav.addObject("newList", productDao.getNewProductList(map));
		mav.addObject("bestList", productDao.getNewProductList(map));
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(path="/getNewTypeList", produces="application/json;charset=utf-8")
	public String NewTypeHandler(@RequestParam String type) throws JsonProcessingException {
		type = type.toLowerCase();
		Map map = new HashMap();
		map.put("type", type);
		List list = productDao.getNewProductList(map);
		return mapper.writeValueAsString(list);
	}
	
	@ResponseBody
	@RequestMapping(path="/getBestTypeList", produces="application/json;charset=utf-8")
	public String BestTypeHandler(@RequestParam String type) throws JsonProcessingException {
		type = type.toLowerCase();
		Map map = new HashMap();
		map.put("type", type);
		List list = productDao.getBestProductList(map);
		return mapper.writeValueAsString(list);
	}
}
