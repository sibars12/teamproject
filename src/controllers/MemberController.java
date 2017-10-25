package controllers;

import java.sql.SQLException;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;

import models.MemberDao;


@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	JavaMailSender sender;

	@Autowired
	MemberDao memberDao;

	// join 페이지 띄움
	@GetMapping("/join")
	public String getJoinHandle(Map map) {
		map.put("section", "member/join");
		return "t_expr";
	}

	// 입력한 내용 DB에 저장
	@PostMapping("/join")
	public String postJoinHandle(@RequestParam Map map, ModelMap mMap, HttpSession session) {
		try {

			int r = memberDao.addMember(map);
			session.setAttribute("auth", map.get("id"));
			return "redirect:/member/login";
		} catch (Exception e) {
			mMap.addAttribute("temp", map);
			mMap.addAttribute("section", "member/join");
			return "t_expr";
		}
	}

	// 아이디 체크
	@PostMapping(path = "/signup_check/{mode}", produces = "application/json;charset=utf-8")
	@ResponseBody
	public boolean signupCheckHandle(@RequestBody(required = false) String body,
			@PathVariable(name = "mode") String mode) throws SQLException {
		boolean b = true;
		if (mode.equals("id")) {
			b = memberDao.checkId(body);
			System.out.println("id = " + b);
		}
		if (mode.equals("email")) {
			b = memberDao.checkEmail(body);
			System.out.println("email = " + b);
		}
		return b;
	}
	
	// 가입인증 이메일
	@RequestMapping("/join/auth")
	public void joinAuth(@RequestParam(name = "email") String email, HttpSession session) {
		UUID u = UUID.randomUUID();
		session.setAttribute("tre", u.toString());
		SimpleMailMessage msg = new SimpleMailMessage();
		try {
			msg.setSubject("인증번호입니다.");
			msg.setTo(email); // 받을사람 주소
			msg.setFrom("rkqms1@gmail.com"); // 보내는 사람
			String text = "인증번호는" + u.toString() + "입니다.";
			msg.setText(text);
			sender.send(msg); // 발송
		} catch (Exception r) {
			System.out.println(r);
		}
	}

	@RequestMapping("/join/tre")
	@ResponseBody
	public String tretre(@RequestParam(name = "tre") String tre, HttpSession session) {
		String tru = (String) session.getAttribute("tre");
		return "{ \"tre\" : " + tre.equals(tru) + "}";
	}

	// login
	@GetMapping("/login")
	public String getLoginHandle(Map map) {
		map.put("section", "member/login");
		return "t_expr";
	}

	@PostMapping("/session")
	public String postLoginHandle(@RequestParam Map map, HttpSession session, ModelMap mMap) throws SQLException {
		try {
			Map m = memberDao.login(map);
			session.setAttribute("auth", m.get("ID")); // 대문자 ID로 할 것!!
			System.out.println(session.getAttribute("auth") + "님 로그인");
			return "redirect:/member/loginOk";
		} catch (Exception e) {
			mMap.addAttribute("temp", map);
			mMap.addAttribute("section", "member/login");
			e.printStackTrace();
			return "t_expr";
		}
	}

	@GetMapping("/loginOk")
	public String getLoginOkHandle(Map map) {
		map.put("section", "member/loginOk");
		return "t_expr";
	}

	// logout
	@GetMapping("/logout")
	public String getLogoutHandle(HttpSession session) {
		System.out.println(session.getAttribute("auth") + "님 로그아웃");
		session.invalidate();
		return "redirect:/member/login";
	}

	// myInfo
	@GetMapping("/myInfo")
	public String getMyInfoHandle(HttpSession session, ModelMap mMap) {
		String id = (String) session.getAttribute("auth");
		Map map = memberDao.readDetail(id);
		mMap.addAttribute("readDetail", map);
		mMap.addAttribute("section", "member/myInfo");
		return "t_expr";
	}

	@PostMapping("/myInfoEdit")
	public String postMyInfoHandle(HttpSession session, @RequestParam Map map, ModelMap mMap) {
		try {
			int r = memberDao.editDetail(map);
			System.out.println(session.getAttribute("auth") + "님 정보수정");
			return "redirect:/member/myInfo";
		} catch (Exception e) {
			mMap.addAttribute("section", "member/myInfo");
			e.printStackTrace();
			return "t_expr";
		}
	}

}




