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
}
