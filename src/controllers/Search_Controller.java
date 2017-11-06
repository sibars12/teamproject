package controllers;

import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import models.SearchDao;

@Controller
public class Search_Controller {
	@Autowired
	SearchDao searchDao;
	
	@RequestMapping("/search")
	public ModelAndView SearchHandler(@RequestParam(required=false) String type, @RequestParam(required=false) String name
			, @RequestParam(required=false) String minPrice, @RequestParam(required=false) String MaxPrice
			, @RequestParam(defaultValue="signup") String Lineup, @RequestParam(defaultValue="name") String option) {
		ModelAndView mav = new ModelAndView("t_expr");
		Map map = new HashMap<>();
		// 밑에 4개의 if문은 검색값이 있을때만 map에 넣기 위해서
		if(type!=null && type.length()>0)
			map.put("type", type);
		if(name!=null && name.length()>0)
			map.put("name", name);
		if(minPrice!=null && minPrice.length()>0)
			map.put("minPrice", Integer.parseInt(minPrice));
		if(MaxPrice!=null && MaxPrice.length()>0)
			map.put("MaxPrice", Integer.parseInt(MaxPrice));
		map.put("Lineup", Lineup);
		map.put("option", option);
		List<Map> list = searchDao.searchList(map);
		int lSize = list.size()==0 ? 0 : (list.size()-1)/4;
		if((type!=null && type.length()!=0) || (name!=null && name.length()!=0)
				|| (minPrice!= null && minPrice.length()!=0) || (MaxPrice!=null && MaxPrice.length()!=0)) { // 모든 검색값이 없거나 비어있지 않아야 list반환
			mav.addObject("list", list);
			mav.addObject("lSize", lSize);
			mav.addObject("cnt", searchDao.searchCnt(map));
		}else {
			mav.addObject("cnt", 0);
		}
		mav.addObject("map", map);
		mav.addObject("section", "search");
		return mav;
	}
}
