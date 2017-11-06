package controllers;

import java.util.*;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import models.ProductDao;

@Controller
@RequestMapping("/remote")
public class RemoteController {
	@Autowired
	ProductDao productDao;
	
	@RequestMapping("/recentView")
	@ResponseBody
	public Map recentViewHandler(@CookieValue(value="recentView", required=false)Cookie cookie){
		Map map = new HashMap();
		List<Map> list = new ArrayList<>();
		
		if(cookie!=null){
			String c = cookie.getValue();
			String[] ar = c.split("&");			
			
			for(int i=ar.length-1; i>=0; i--){
				Map ownInfo =productDao.getPro(ar[i]);
				list.add(ownInfo);
			}
		}
		System.out.println("recentViewList"+list);
		map.put("ownInfo", list);
		
		return map;
	}

}
