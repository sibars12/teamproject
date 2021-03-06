package models;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class event_Dao {
	@Autowired
	DataSource ds;
	@Autowired
	SqlSessionTemplate template;
	
	public boolean addOnd(Map map) {
		int r=template.insert("event.add",map);
		return r == 1;
	}
	public int all() {
		return template.selectOne("event.all");
	}
	
	public List<Map> readAll()  {
		return template.selectList("event.list");
	}
	public List<Map> readOne(String num) {
		
		return template.selectList("event.read" ,num);
	}
	public boolean del(String num) {
		int d=template.insert("event.del" ,num);
		return d==1;
	}
	public List<Map> allist(Map map) {
		return template.selectList("event.allist",map);
	}
	public boolean change(Map map) {
		int d= template.insert("event.change",map);
		return d==1;
	}
	
	
	
	public int inall() {
		return template.selectOne("event.inall");
	}
	public List<Map> inlist(Map map) {
		return template.selectList("event.inlist",map);
	}
	public int stall() {
		return template.selectOne("event.stall");
	}
	public List<Map> stlist(Map map) {
		return template.selectList("event.stlist",map);
	}
	
	public int edall() {
		return template.selectOne("event.edall");
	}
	public List<Map> edlist(Map map) {
		return template.selectList("event.edlist",map);
	}
}
