package models;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {

	@Autowired
	SqlSessionTemplate template;
	
	// 회원가입
	public int addMember(Map map) {
		int r = 0;
		r += template.insert("member.addMember",map);
		r += template.insert("member.addDetail",map);
		return r;
	}
	
	// id 체크
	public boolean checkId(String id) {
		String result = template.selectOne("member.checkId",id);
		return id.equals(result);
	}
	
	// email 체크
	public boolean checkEmail(String email) {
		String result = template.selectOne("member.checkEmail", email);
		return email.equals(result);
	}
	
	// login
	public Map login(Map map) {
		return template.selectOne("member.login",map);
	}
	
	// 개인정보 읽어오기
	public Map readDetail(String id) {
		return template.selectOne("member.readDetail", id);
	}
	
	// 가입일 읽어오기
	public Map readJoinDate(String id) {
		return template.selectOne("member.readJoinDate", id);
	}
	
	// point 출력
	public Map readPoint(String id) {
		return template.selectOne("member.readPoint", id);
	}
	
	// 개인정보 수정
	public int editDetail(Map map) {
		int r = template.update("member.editDetail", map);
		return r;
	}
	
	// 아이디 찾기
	public String findId(Map map) {
		return template.selectOne("member.findId", map);
	}
	
	// 비밀번호 찾기
	public String findPw(Map map) {
		return template.selectOne("member.findPw", map);
	}
	
	// 비밀번호 찾기 시 새 비밀번호 설정
	public int newPw(Map map) {
		int r = template.update("member.newPw", map);
		return r;
	}
	
	// 비밀번호 변경
	public int changePw(Map map) {
		int r = template.update("member.changePw", map);
		return r;
	}

	// 회원 탈퇴
	public int drop(Map map) {
		int r = 0;
		r += template.delete("member.dropMember", map);
		r += template.delete("member.dropDetail", map);
		return r;
	}
	
}
