package controllers;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
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

	// join ������ ���
	@GetMapping("/join")
	public String getJoinHandle(Map map) {
		map.put("section", "member/join");
		return "t_expr";
	}

	// �Է��� ���� DB�� ����
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

	// ���̵� üũ
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

	// �������� �̸���
	@RequestMapping("/join/auth")
	@ResponseBody
	public String joinAuth(@RequestParam(name = "email") String email, HttpSession session) {
		UUID u = UUID.randomUUID();
		session.setAttribute("tre", u.toString());
		SimpleMailMessage msg = new SimpleMailMessage();
		try {
			msg.setSubject("������ȣ�Դϴ�.");
			msg.setTo(email); // ������� �ּ�
			msg.setFrom("rkqms1@gmail.com"); // ������ ���
			String text = "������ȣ��" + u.toString() + "�Դϴ�.";
			msg.setText(text);
			sender.send(msg); // �߼�
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
			session.setAttribute("auth", m.get("ID")); // �빮�� ID�� �� ��!!
			session.setAttribute("cartCnt", shoppingDao.getCartCnt((String)m.get("ID")));
			System.out.println(shoppingDao.getCartCnt((String)m.get("ID")));
			System.out.println(session.getAttribute("auth") + "�� �α���");
			
		// ����Ʈ ������--------
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
			return "t_expr";

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
		System.out.println(session.getAttribute("auth") + "�� �α׾ƿ�");
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
			System.out.println(session.getAttribute("auth") + "�� ��������");
			return "redirect:/member/myInfo";
		} catch (Exception e) {
			mMap.addAttribute("section", "member/myInfo");
			e.printStackTrace();
			return "t_expr";
		}
	}

	
	// ���̵�,��й�ȣ ã�� ���� â
	@GetMapping("/find")
	public String getFindHandle(Map map) {
		map.put("section", "member/find");
		return "t_expr";
	}

	// ���̵� ã�� �Է� â
	@GetMapping("/findId")
	public String getFindIdHandle(Map map) {
		map.put("section", "member/findId");
		return "t_expr";
	}

	// ���̵� ã�� ���
	@PostMapping("/findIdOk")
	public String getFindIdOkHandle(@RequestParam Map pmap, Map map) { // pmap�� �Ķ���ͷ� �޾ƿ��� ��, map�� ���ý�Ű�� ��
		String id = memberDao.findId(pmap); 					// �Ķ���ͷ� ���� ���� id�� ����
		map.put("findId", id); 									// map�� findId�� id�� ���ý�Ŵ
		map.put("section", "member/findIdOk"); 					// section�� /member/findIdOk �ֱ�
		return "t_expr";
	}
	
	// findPw.jsp ��й�ȣ ã�� �Է� â(���̵�, �̸��� �Է�)
	@GetMapping("/findPw")
	public String getFindPwHandle(Map map) {
		map.put("section", "member/findPw");
		return "t_expr";
	}
	
	// findPwRst (���̵�, �̸��� �Է� �� ȸ���̸� ������������ �ѱ�� ȸ���� �ƴϸ� ���������� �����ֱ�)
	@PostMapping("/findPwRst")
	public String postFindPwRstHandle(@RequestParam Map pmap, Map map) {
		String pw = memberDao.findPw(pmap);				//��ġ�ϴ� pw�� ������
		if(pw != null) {								//pw�� ���� �� = ȸ���� ��
			map.put("findPw", pw);
			map.put("section", "member/findRePw");
			return "t_expr";
		} else {										//ȸ���� �ƴ� ��
			map.put("section", "member/findPwReturn");
			return "t_expr";
		}
	}
	
	// findRePw(��й�ȣ �缳��)
	@PostMapping("/findRePw")
	public String postFindRePwHandle(@RequestParam Map map, ModelMap mMap) {
		//map.put("id", session.getAttribute("auth"));
		
		try {
			int r = memberDao.newPw(map);
			return "redirect:/member/findPwOk";
		} catch(Exception e) {
			e.printStackTrace();
			return "recirect:/member/findPw";
		}
	
		
	}	
	
	// findPwOk(��й�ȣ �缳�� �Ϸ�)
	@PostMapping("/findPwOk")
	public String postFindPwOkHandle(Map map) {		
		map.put("section", "member/findPwOk");
		return "t_expr";
	}
	
	//��й�ȣ ����
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
			System.out.println(session.getAttribute("auth") + "�� ��й�ȣ ����");
			System.out.println(session.getAttribute("auth") + "�� �α׾ƿ�");
			session.invalidate();
			return "redirect:/member/login";
		}catch(Exception e) {
			mMap.addAttribute("section","member/changePw");
			e.printStackTrace();
			return "t_expr";
		}
	}
	
	
	// ȸ�� Ż��
	@GetMapping("/drop")
	public String getDropHandle(Map map) {
		map.put("section", "/member/drop");
		return "t_expr";
	}
	
	
	@PostMapping("/dropOk")		// ��й�ȣ�� ������� or ��й�ȣ�� Ʋ����� 
	public String postDropOkHandle(HttpSession session, @RequestParam Map pmap, Map map) {
		pmap.put("id", session.getAttribute("auth") );		//���̵�Ȯ���ؼ� ���̵�� ��й�ȣ�� ������ Ż�𰡴��ϰ� �ϱ����ؼ� �߰�
		try {
			System.out.println(session.getAttribute("auth") + "�� ȸ��Ż��");
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
