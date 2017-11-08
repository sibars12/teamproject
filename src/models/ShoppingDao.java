package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.util.MultiValueMap;

import java.util.*;

import javax.servlet.http.HttpSession;

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
	
	//Order페이지
	public List getOrderNoDateList(Map map) {
		return sql.selectList("shopping.getOrderNoDateList", map);
	}
	public List getOrderDateList(Map map) {
		return sql.selectList("shopping.getOrderDateList", map);
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
	
	public boolean purchaseAll(Map param){
		List<String> stockNo = (List<String>) param.get("stockNo");
		List<String> stockCnt = (List<String>) param.get("stockCnt");
		List<String> stockPrice = (List<String>) param.get("stockPrice");
		List<String> ownernumber = (List<String>) param.get("ownernumber");
		String id = (String) param.get("id");
		int r=0;
		
		r+=sql.insert("shopping.addPurchase",param.get("pur"));

		for (int i = 0; i < stockNo.size(); i++) {
			Map or = new HashMap();
			or.put("purchaseNo", param.get("purchaseNo")); // 주문번호;
			or.put("ownernumber", (String) ownernumber.get(i));// 상품번호
			or.put("stockNo", (String) stockNo.get(i));// 재고번호
			or.put("stockCnt", (String) stockCnt.get(i));// 구매수량
			or.put("stockPrice", (String) stockPrice.get(i));// 수량*가격
			sql.insert("shopping.addOrderInfo", or);
		}
		
		r+=sql.insert("shopping.addPayment",param.get("pay"));
		r+=sql.insert("shopping.addPointLog", param.get("pay"));	
		r+=sql.update("shopping.updatePoint", param.get("po"));
		r+=sql.delete("shopping.deletePayCoupon", param.get("coupon"));
		
		for (int i = 0; i < stockNo.size(); i++) {
			Map or = new HashMap();
			or.put("stockNo", (String) stockNo.get(i));// 재고번호
			or.put("stockCnt", (String) stockCnt.get(i));// 구매수량
			sql.update("shopping.subStockVolum",or);
		}
		
		for (int i = 0; i < stockNo.size(); i++) {
			Map cart = new HashMap();
			cart.put("id", id);
			cart.put("num", stockNo.get(i));
			
			sql.delete("shopping.deleteCart", cart);
		}
				
		return true;
	}
	public List<Map> tradelist(Map map){
		return sql.selectList("shopping.tradeList", map);
	}
	public int tradeall() {
		return sql.selectOne("shopping.tradeall");
	}
 
}
