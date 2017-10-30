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
			// session.setAttribute("auth", map.get("id"));
			return "redirect:/member/login";
		} catch (Exception e) {
			e.printStackTrace();
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
	@ResponseBody
	public String joinAuth(@RequestParam(name = "email") String email, HttpSession session) {
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
			return "Y";
		} catch (Exception r) {
			System.out.println(r);
			return "N";
		}
	}

	@RequestMapping("/join/tre")
	@ResponseBody
	public String tretre(@RequestParam(name = "tre") String tre, HttpSession session) {
		String tru = (String) session.getAttribute("tre");
		//System.out.println("String" + tru);
		//System.out.println(tre);
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
			return "home";
		} catch (Exception e) {
			mMap.addAttribute("temp", map);
			mMap.addAttribute("section", "member/login");
			e.printStackTrace();
			return "t_expr";
		}
	}

	// logout
	@GetMapping("/logout")
	public String getLogoutHandle(HttpSession session) {
		System.out.println(session.getAttribute("auth") + "님 로그아웃");
		session.invalidate();
		return "redirect:/member/logoutOk";
	}

	@GetMapping("/logoutOk")
	public String getLogoutOkHandle(Map map) {
		map.put("section", "member/logoutOk");
		return "t_expr";
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

	// 아이디,비밀번호 찾기 메인 창
	@GetMapping("/find")
	public String getFindHandle(Map map) {
		map.put("section", "member/find");
		return "t_expr";
	}

	// 아이디 찾기 입력 창
	@GetMapping("/findId")
	public String getFindIdHandle(Map map) {
		map.put("section", "member/findId");
		return "t_expr";
	}

	// 아이디 찾기 결과
	@PostMapping("/findIdOk")
	public String getFindIdOkHandle(@RequestParam Map pmap, Map map) { // pmap는 파라미터로 받아오는 맵, map은 셋팅시키는 맵
		String id = memberDao.findId(pmap); // 파라미터로 받은 값을 id에 저장
		System.out.println(id);
		map.put("findId", id); // map의 findId에 id를 세팅시킴
		map.put("section", "member/findIdOk"); // section에 /member/findIdOk 넣기
		return "t_expr";
	}
	
	// findPw.jsp 비밀번호 찾기 입력 창(아이디, 이름, 생년월일, 이메일 입력받기)
	@GetMapping("/findPw")
	public String getFindPwHandle(Map map) {
		map.put("section", "member/findPw");
		return "t_expr";
	}
	
	
	// findRePw.jsp 비밀번호 재설정 창(새로운 비밀번호 입력받아서 update)
	

	// 회원 탈퇴
	@GetMapping("/drop")
	public String getDropHandle(Map map) {
		map.put("section", "/member/drop");
		return "t_expr";
	}

	
	@PostMapping("/dropOk")		// 비밀번호가 맞을경우 or 비밀번호가 틀릴경우 
	public String postDropOkHandle(HttpSession session, @RequestParam Map pmap, Map map) {
		pmap.put("id", session.getAttribute("auth") );		//아이디확인해서 아이디랑 비밀번호가 맞을때 탈퇴가능하게 하기위해서 추가
		try {
			System.out.println(session.getAttribute("auth") + "님 회원탈퇴");
			int r = memberDao.drop(pmap);
			session.invalidate();
			return "redirect:/member/dropOk";
		} catch (Exception e) {
			map.put("section", "member/drop");
			e.printStackTrace();
			return "t_expr";
		}
	}

	@GetMapping("/dropOk")
	public String getDropOkHandle(Map map) {
		map.put("section", "/member/dropOk");
		return "t_expr";
	}
	
	
}
