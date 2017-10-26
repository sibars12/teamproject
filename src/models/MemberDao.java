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
	
	// 개인정보 수정
	public int editDetail(Map map) {
		int r = template.update("member.editDetail", map);
		return r;
	}

}
