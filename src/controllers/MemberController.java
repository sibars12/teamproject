package controllers;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;


import javax.servlet.http.Cookie;

import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
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
import models.ShoppingDao;
import models.event_Dao;

@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	JavaMailSender sender;

	@Autowired
	MemberDao memberDao;
	
	@Autowired
	ShoppingDao shoppingDao;
	@Autowired
	event_Dao eventDao;

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
	public String postLoginHandle(@RequestParam Map map, HttpSession session, ModelMap mMap ,HttpServletResponse response) throws SQLException {
		try {
			
			Map m = memberDao.login(map);
			if(map.get("keep")!=null) {
					Cookie c = new Cookie("keep", (String) map.get("id"));
					c.setPath("/");
					c.setMaxAge(60*60*24*7);
					response.addCookie(c);
			}
			session.setAttribute("auth", m.get("ID")); // 대문자 ID로 할 것!!
			session.setAttribute("cartCnt", shoppingDao.getCartCnt((String)m.get("ID")));
			System.out.println(shoppingDao.getCartCnt((String)m.get("ID")));
			System.out.println(session.getAttribute("auth") + "님 로그인");
			
		// 포인트 적립함--------
			List<Map> logList = shoppingDao.selectAfter10Log((String)m.get("ID"));
			Map mem = memberDao.readDetail((String)m.get("ID"));
			
			int adds=0;
			for(int i=0; i<logList.size(); i++ ){
				System.out.println(logList.get(i).get("ADDPOINT"));
				int a = ((BigDecimal) logList.get(i).get("ADDPOINT")).intValue();
				adds += a;
				System.out.println("addp"+adds);
			}
			
			System.out.println("addPoint"+adds);
			int mp = ((BigDecimal)mem.get("POINT")).intValue();
			System.out.println("mp"+mp);
			int result = mp+adds;
			System.out.println("resultPoint"+result);
			
			Map pointMap = new HashMap();
			pointMap.put("id",(String)m.get("ID")); 
			pointMap.put("resultPoint", result);
			shoppingDao.updatePoint(pointMap);			
			shoppingDao.editPointLog((String)m.get("ID"));
			
		//------------------
			Map eventmap=new HashMap<>();
			eventmap.put("start", "1");
			eventmap.put("end", "4");
			List<Map> eventlist=eventDao.inlist(eventmap);
			mMap.addAttribute("eventlist" , eventlist);
			mMap.addAttribute("section", "home");
			return "redirect:/index";

		} catch (Exception e) {
			mMap.addAttribute("temp", map);
			mMap.addAttribute("section", "member/login");
			e.printStackTrace();
			return "t_expr";
		}
	}

	// logout
	@GetMapping("/logout")
	public String getLogoutHandle(HttpSession session ,HttpServletResponse response) {
		Cookie c = new Cookie("keep", "");
		c.setPath("/");
		c.setMaxAge(0);
		response.addCookie(c);
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
		Map joindate = memberDao.readJoinDate(id);	
		mMap.addAttribute("readDetail", map);
		mMap.addAttribute("readJoinDate", joindate);
		mMap.addAttribute("section", "member/myInfo");
		return "t_expr";
	}

	@PostMapping("/myInfoEdit")
	public String postMyInfoHandle(HttpSession session, @RequestParam Map map, ModelMap mMap) {
		try {
			map.put("id", session.getAttribute("auth") );
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
		String id = memberDao.findId(pmap); 					// 파라미터로 받은 값을 id에 저장
		map.put("findId", id); 									// map의 findId에 id를 세팅시킴
		map.put("section", "member/findIdOk"); 					// section에 /member/findIdOk 넣기
		return "t_expr";
	}
	
	// findPw.jsp 비밀번호 찾기 입력 창(아이디, 이메일 입력)
	@GetMapping("/findPw")
	public String getFindPwHandle(Map map) {
		map.put("section", "member/findPw");
		return "t_expr";
	}
	
	// findPwRst (아이디, 이메일 입력 후 회원이면 다음페이지로 넘기고 회원이 아니면 에러페이지 보여주기)
	@PostMapping("/findPwRst")
	public ModelAndView postFindPwRstHandle(@RequestParam Map pmap, Map map) {
		ModelAndView mav = new ModelAndView("t_expr");
		String pw = memberDao.findPw(pmap);				//일치하는 pw값 가져옴
		if(pw != null) {								//pw가 있을 때 = 회원일 떄
			mav.addObject("findPw", pw);
			mav.addObject("section", "member/findRePw");
			mav.addObject("id", pmap.get("id"));
			return mav;
		} else {										//회원이 아닐 때
			mav.addObject("section", "member/findPwReturn");
			return mav;
		}
	}
	
	// findRePw(비밀번호 재설정)
	@PostMapping("/findRePw")
	public ModelAndView postFindRePwHandle(@RequestParam Map pmap, Map map) {
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "member/findRePw");
		mav.addObject("id", pmap.get("id"));
		return mav;
	}
	
	// findPwOk(비밀번호 재설정 완료)
	@PostMapping("/findPwOk")
	public String postFindPwOkHandle(@RequestParam Map pmap, Map map) {
		int pw = memberDao.newPw(pmap);
		try {
			map.put("newPw", pmap.get("pw2"));
			map.put("section", "member/findPwOk");
		return "t_expr";
		} catch(Exception e) {
			e.printStackTrace();
			return "redirect:/member/findPw";
		}
	}	
	
	//비밀번호 변경
	@GetMapping("/changePw")
	public String getRePwHandle(Map map) {
		map.put("section", "/member/changePw");
		return "t_expr";
	}
	
	@PostMapping("/changePwOk")
	public String postRePwOkHandle(HttpSession session, @RequestParam Map map, ModelMap mMap) {
		map.put("id", session.getAttribute("auth"));
		try {			
			int r = memberDao.changePw(map);
			System.out.println(session.getAttribute("auth") + "님 비밀번호 변경");
			System.out.println(session.getAttribute("auth") + "님 로그아웃");
			session.invalidate();
			return "redirect:/member/login";
		}catch(Exception e) {
			mMap.addAttribute("section","member/changePw");
			e.printStackTrace();
			return "t_expr";
		}
	}
	
	
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
