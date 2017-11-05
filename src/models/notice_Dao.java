package models;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class notice_Dao {
	@Autowired
	DataSource ds;
	@Autowired
	SqlSessionTemplate template;
	
	public boolean addOnd(Map map) {
		int r=template.insert("notice.add",map);
		return r == 1;
	}
	public int all() {
		return template.selectOne("notice.all");
	}
	
	public List<Map> readAll()  {
		return template.selectList("notice.list");
	}
	public List<Map> readOne(String num) {
		
		return template.selectList("notice.read" ,num);
	}
	public boolean del(String num) {
		int d=template.insert("notice.del" ,num);
		return d==1;
	}
	public List<Map> allist(Map map) {
		return template.selectList("notice.allist",map);
	}
	public boolean change(Map map) {
		int d= template.insert("notice.change",map);
		return d==1;
	}
}
