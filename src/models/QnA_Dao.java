package models;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class QnA_Dao {
	@Autowired
	DataSource ds;
	@Autowired
	SqlSessionTemplate template;
	
	public boolean addOnd(Map map) {
		int r=template.insert("QnA.add",map);
		return r == 1;
	}
	
	public List<Map> readAll()  {
		return template.selectList("QnA.list");
	}
	public List<Map> readOne(String num) {
		
		return template.selectList("QnA.read" ,num);
	}
	public boolean del(String num) {
		int d=template.insert("QnA.del" ,num);
		return d==1;
	}
}
