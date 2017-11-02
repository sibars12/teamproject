package models;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {

	@Autowired
	SqlSessionTemplate template;
	
	// ȸ������
	public int addMember(Map map) {
		int r = 0;
		r += template.insert("member.addMember",map);
		r += template.insert("member.addDetail",map);
		return r;
	}
	
	// id üũ
	public boolean checkId(String id) {
		String result = template.selectOne("member.checkId",id);
		return id.equals(result);
	}
	
	// email üũ
	public boolean checkEmail(String email) {
		String result = template.selectOne("member.checkEmail", email);
		return email.equals(result);
	}
	
	// login
	public Map login(Map map) {
		return template.selectOne("member.login",map);
	}
	
	// �������� �о����
	public Map readDetail(String id) {
		return template.selectOne("member.readDetail", id);
	}
	
	// ������ �о����
	public Map readJoinDate(String id) {
		return template.selectOne("member.readJoinDate", id);
	}
	
	// point ���
	public Map readPoint(String id) {
		return template.selectOne("member.readPoint", id);
	}
	
	// �������� ����
	public int editDetail(Map map) {
		int r = template.update("member.editDetail", map);
		return r;
	}
	
	// ���̵� ã��
	public String findId(Map map) {
		return template.selectOne("member.findId", map);
	}
	
	// ��й�ȣ ã��
	public String findPw(Map map) {
		return template.selectOne("member.findPw", map);
	}
	
	// ��й�ȣ ã�� �� �� ��й�ȣ ����
	public int newPw(Map map) {
		int r = template.update("member.newPw", map);
		return r;
	}
	
	// ��й�ȣ ����
	public int changePw(Map map) {
		int r = template.update("member.changePw", map);
		return r;
	}

	// ȸ�� Ż��
	public int drop(Map map) {
		int r = 0;
		r += template.delete("member.dropMember", map);
		r += template.delete("member.dropDetail", map);
		return r;
	}
	
}
