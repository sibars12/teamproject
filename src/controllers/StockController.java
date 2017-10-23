package controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.*;
import models.StockDao;

@Controller
@RequestMapping("/stock")
public class StockController {
	@Autowired
	StockDao sdao;
	@Autowired
	ObjectMapper mapper;
	
	@PostMapping("/addStock")
	public ModelAndView PostAddStockHandler(@RequestParam Map map) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "stock/addStock");
		if(sdao.checkAdd(map)) {
			List<Map> list;
			if(map.get("subname").equals("")) 
				list=sdao.getOwnernumbersubN(map);
			else
				list=sdao.getOwnernumber(map);
			boolean rst = addStock(map, list);
			mav.addObject("result", rst);
		}else {
			mav.addObject("result", false);
		}
		mav.addObject("list", sdao.getStockList("1"));
		mav.addObject("page", (sdao.getStockPage()-1)/10+1);
		return mav;
	}
	
	@GetMapping("/addStock")
	public ModelAndView addStockHandler(@RequestParam(defaultValue="1") String page, @RequestParam(required=false) String sch) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "stock/addStock");
		if(sch==null) {
			mav.addObject("list", sdao.getStockList(page));
			mav.addObject("page", sdao.getStockPage()/10+1);
		}else {
			int schpage = sdao.getSearchStockPage(sch)/10+1;
			mav.addObject("page", schpage);
			Map map = new HashMap();
			map.put("page", schpage);
			map.put("name", sch);
			mav.addObject("list", sdao.searchStockList(map));
			mav.addObject("sch", sch);
		}
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/search")
	public String SearchHandler(@RequestBody String name) throws JsonProcessingException {
		name = name.trim();
		List list = sdao.searchName(name);
		return mapper.writeValueAsString(list);
	}
	
	@ResponseBody
	@RequestMapping("/delete")
	public String deleteHandler(@RequestBody String dNo) {
		boolean rst = sdao.deleteStock(dNo);
		if(rst)
			return "YYY";
		return "NNN";
	}
	
	@PostMapping("/update")
	public ModelAndView updateHandler(@RequestParam Map map, @RequestParam(defaultValue="1") String page) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "stock/addStock");
		boolean rst = sdao.updateStock(map);
		mav.addObject("result", rst);
		mav.addObject("list", sdao.getStockList(page));
		mav.addObject("page", (sdao.getStockPage()-1)/10+1);
		return mav;
	}
	
	public boolean addStock(Map addmap, List<Map> schlist) {
		boolean rst = false;
		if(schlist.size()==0) {
			rst = sdao.addNewStock(addmap);
		}else {
			addmap.put("ownernumber", schlist.get(0).get("OWNERNUMBER"));
			rst = sdao.addOldStock(addmap);
		}
		return rst;
	}
}
