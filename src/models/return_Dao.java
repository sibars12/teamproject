package models;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class return_Dao {
	@Autowired
	DataSource ds;
	@Autowired
	SqlSessionTemplate template;
	
	//�ۻ���
	public boolean add(Map map) {
		int r=template.insert("return.add",map);
		return r == 1;
	}
	//��ü�� �����ľ�
	public int all() {
		return template.selectOne("return.all");
	}
	//����ü ����Ʈ
	public List<Map> list()  {
		return template.selectList("return.list");
	}
	//�� ������
	public List<Map> read(String num) {
		
		return template.selectList("return.read" ,num);
	}
	//�ۻ���
	public boolean del(String num) {
		int d=template.insert("return.del" ,num);
		return d==1;
	}
	//?��~??�� ���� �۸���Ʈ 
	public List<Map> allist(Map map) {
		return template.selectList("return.allist",map);
	}
	public boolean change(Map map) {
		int d= template.insert("return.change",map);
		return d==1;
	}
	public boolean coment(Map map) {
		int d= template.insert("return.coment",map);
		return d==1;
	}
	public List<Map> uesrre(String auth) {
		return template.selectList("return.uesrre",auth);
	}
	public int resize(String auth) {
		return template.selectOne("return.resize" , auth);
	}
	public List<Map> uesrlist(Map map) {
		return template.selectList("return.uesrlist" , map);
	}
	public boolean wite(String no) {
		int d= template.insert("return.wite",no);
		return d==1;
	}
	public boolean ret(String no) {
		int d= template.insert("return.ret",no);
		return d==1;
	}
}
