package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class SearchDao {
	@Autowired
	SqlSessionTemplate sql;
	
	// 검색 결과 리스트
	public List<Map> searchList(Map map){
		return sql.selectList("search.searchList", map);
	}
	
	// 검색 결과 갯수
	public int searchCnt(Map map) {
		return sql.selectOne("search.searchCnt", map);
	}
}
