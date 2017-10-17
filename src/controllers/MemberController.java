package controllers;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;

import models.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	ObjectMapper mapper;
	@Autowired
	MemberDao memberDao;

	@GetMapping("/join")
	public String getJoinHandle(Map map) {
		map.put("section", "member/join");
		return "t_member";
	}
	
}
