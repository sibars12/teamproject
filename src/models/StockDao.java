package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class StockDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public List getStockList(String page) {
		return sql.selectList("stock.getStockList", page);
	}
	public int getStockPage() {
		return sql.selectOne("stock.getStockPage");
	}
	public List searchStockList(Map map) {
		return sql.selectList("stock.searchStockList", map);
	}
	public int getSearchStockPage(String name) {
		return sql.selectOne("stock.getSearchStockPage", name);
	}
	public List searchName(String name) {
		return sql.selectList("stock.searchName", name);
	}
	public boolean addNewStock(Map map) {
		sql.insert("stock.addNewStock", map);
		return true;
	}
	public boolean addOldStock(Map map) {
		sql.insert("stock.addOldStock", map);
		return true;
	}
	public boolean checkAdd(Map map) {
		int n = sql.selectOne("stock.checkAdd", map);
		if(n==0)
			return true;
		return false;
	}
	public boolean deleteStock(String no) {
		sql.delete("stock.deleteStock", no);
		return true;
	}
	public boolean updateStock(Map map) {
		sql.update("stock.updateStock", map);
		return true;
	}
	public boolean updateRegist(Map param){
		sql.update("stock.updateRegist", param);
		return true;
	}
	public List getOwnernumber(Map map) {
		return sql.selectList("stock.getOwnernumber", map);
	}
	public List getOwnernumbersubN(Map map) {
		return sql.selectList("stock.getOwnernumbersubN", map);
	}
	public List getOptionSchStockList(Map map) {
		return sql.selectList("stock.getOptionSchStockList", map);
	}
	public int getOptionSchStockPage(Map map) {
		return sql.selectOne("getOptionSchStockPage", map);
	}
}
