package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class ShoppingDao {
	@Autowired
	SqlSessionTemplate sql;
	// 장바구니
	public boolean addCart(Map map) {
		sql.insert("shopping.addCart", map);
		return true;
	}
	public List getCartList(String id) {
		return sql.selectList("shopping.getCartList", id);
	}
	public boolean deleteCart(Map cart) {
		sql.delete("shopping.deleteCart", cart);
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
	
	//구매
	public int addPurchase(Map param){
		return sql.insert("shopping.addPurchase", param);
	}
	public int addOrderInfo(Map param){
		return sql.insert("shopping.addOrderInfo", param);
	}
	public int addPayment(Map param){
		return sql.insert("shopping.addPayment", param);
	}
	public Map getMemInfo(String id){
		return sql.selectOne("shopping.getMemInfo", id);
	}
	public List<Map> getCoupon(String id){
		return sql.selectList("shopping.getCoupon", id);
	}
	public int updatePoint(Map map){
		return sql.update("shopping.updatePoint", map);
	}
	public int deletePayCoupon(Map coupon){
		return sql.delete("shopping.deletePayCoupon", coupon);
	}
	public Map getRecentPurchase(String id){
		return sql.selectOne("shopping.getRecentPurchase", id);
	}
	public int addPointLog(Map map) {
		return sql.insert("shopping.addPointLog", map);		
	}
	public int delPointLog(String paymentNo){
		return sql.delete("shopping.delPointLog", paymentNo);
	}
	public int editPointLog(String id){
		return sql.update("shopping.editPointLog", id);
	}
	public List<Map> selectAfter10Log(String id){
		return sql.selectList("shopping.selectAfter10Log", id);
	}
 
}
