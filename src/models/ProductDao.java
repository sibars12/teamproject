package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class ProductDao {
	@Autowired
	SqlSessionTemplate sql;

	public List<Map> getProductList(String page) {
		return sql.selectList("product.getProductList", page);
	}
	// 상품정보 view 페이지용
	public List<Map> getProductInfo(String ownernumber){
		return sql.selectList("product.getProductInfo", ownernumber);
	}
	//상품 페이지
	public int getProductPage() {
		return sql.selectOne("product.getProductPage");
	}
	//상품등록
	public boolean addProduct(Map map) {
		sql.insert("product.addProduct", map);
		return true;
	}
	// 상품 조회수
	public boolean updateCount(String ownernumber){
		int r = sql.update("product.updateCount", ownernumber);
		if(r==1) return true;
		else return false;
	}
	
	public boolean deleteProduct(String dnum) {
		sql.delete("product.deleteProduct", dnum);
		return true;
	}
}
