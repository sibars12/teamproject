package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class SearchDao {
	@Autowired
	SqlSessionTemplate sql;
	
	// �˻� ��� ����Ʈ
	public List<Map> searchList(Map map){
		return sql.selectList("search.searchList", map);
	}
	
	// �˻� ��� ����
	public int searchCnt(Map map) {
		return sql.selectOne("search.searchCnt", map);
	}
}
