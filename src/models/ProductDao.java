package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class ProductDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public List getList() {
		return sql.selectList("product.getList");
	}
	
	public List<Map> getProductInfo(int ownernumber){
		return sql.selectList("product.getProductInfo", ownernumber);
	}
}
