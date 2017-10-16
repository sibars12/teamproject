package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class StockDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public List getList() {
		return sql.selectList("product.getList");
	}
	public List getStockList(String page) {
		return sql.selectList("product.getStockList", page);
	}
	public int getStockPage() {
		return sql.selectOne("product.getStockPage");
	}
	public List searchStockList(Map map) {
		return sql.selectList("product.searchStockList", map);
	}
	public int getSearchStockPage(String name) {
		return sql.selectOne("product.getSearchStockPage", name);
	}
	public List searchName(String name) {
		return sql.selectList("product.searchName", name);
	}
	public boolean addNewStock(Map map) {
		sql.insert("product.addNewStock", map);
		return true;
	}
	public boolean addOldStock(Map map) {
		sql.insert("product.addOldStock", map);
		return true;
	}
	public boolean checkAdd(Map map) {
		int n = sql.selectOne("product.checkAdd", map);
		if(n==0)
			return true;
		return false;
	}
	public boolean deleteStock(String no) {
		sql.delete("product.deleteStock", no);
		return true;
	}
	public boolean updateStock(Map map) {
		sql.update("product.updateStock", map);
		return true;
	}
	public List getOwnernumber(Map map) {
		return sql.selectList("product.getOwnernumber", map);
	}
	public List getOwnernumbersubN(Map map) {
		return sql.selectList("product.getOwnernumbersubN", map);
	}
}
