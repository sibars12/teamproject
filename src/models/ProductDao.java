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
	// ��ǰ���� view ��������
	public List<Map> getProductInfo(String ownernumber){
		return sql.selectList("product.getProductInfo", ownernumber);
	}
	//��ǰ ������
	public int getProductPage() {
		return sql.selectOne("product.getProductPage");
	}
	//��ǰ���
	public boolean addProduct(Map map) {
		sql.insert("product.addProduct", map);
		return true;
	}
	// ��ǰ ��ȸ��
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
