package models;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class inquire_Dao {
	@Autowired
	DataSource ds;
	@Autowired
	SqlSessionTemplate template;
	
	public boolean addOnd(Map map) {
		int r=template.insert("inquire.add",map);
		return r==1;
	}
	
	public List<Map> readAll(String ownernumber)  {
		return template.selectList("inquire.list" ,ownernumber);
	}
	public boolean del(String num) {
		int d=template.insert("inquire.del" ,num);
		return d==1;
	}
	public int all(String ownernumber) {
		return template.selectOne("inquire.all" , ownernumber);
	}
	public List<Map> allist(Map map) {
		return template.selectList("inquire.allist",map);
	}
	public List<Map> masterlist() {
		return template.selectList("inquire.masterlist");
	}
	public List<Map> masteralllist(Map map) {
		return template.selectList("inquire.masteralllist",map);
	}
	public boolean reply(Map map) {
		int d= template.insert("inquire.reply",map);
		return d==1;
	}
}
