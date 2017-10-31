package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class ShoppingDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public boolean addCart(Map map) {
		sql.insert("shopping.addCart", map);
		return true;
	}
	public List getCartList(String id) {
		return sql.selectList("shopping.getCartList", id);
	}
	public boolean deleteCart(String dnum) {
		sql.delete("shopping.deleteCart", dnum);
		return true;
	}
	public int checkCart(Map map) {
		return sql.selectOne("shopping.checkCart", map);
	}
	public boolean addCartVol(Map map) {
		sql.update("shopping.addCartVol",map);
		return true;
	}
	public int getCartCnt(String id) {
		return sql.selectOne("shopping.getCartCnt", id);
	}
}
