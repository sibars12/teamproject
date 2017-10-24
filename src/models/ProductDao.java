package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class ProductDao {
	@Autowired
	SqlSessionTemplate sql;

	public List<Map> getClothList(Map map) {
		return sql.selectList("product.getClothList", map);
	}
	public List<Map> getFeedList(Map map) {
		return sql.selectList("product.getFeedList", map);
	}
	public List<Map> getSnackList(Map map) {
		return sql.selectList("product.getSnackList", map);
	}
	public List<Map> getToyList(Map map) {
		return sql.selectList("product.getToyList", map);
	}
	// 상품정보 view 페이지용
	public List<Map> getProductInfo(String ownernumber){
		return sql.selectList("product.getProductInfo", ownernumber);
	}
	public int getProductPage(Map map) {
		return sql.selectOne("product.getProductPage", map);
	}
	// 상품등록
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
	// 후기 등록
	public boolean addReview(Map map){
		sql.insert("product.addReview", map);
		return true;
	}
	// 후기 리스트 
	public List<Map> getReviewList(Map map){
		return sql.selectList("product.getReviewList", map);
	}
	// 후기 리스트 갯수 카운트(상품 넘버별)
	public int reviewListCount(String ownernumber){
		return sql.selectOne("product.reviewListCount", ownernumber);
	}
	
	public boolean deleteProduct(String dnum) {
		sql.delete("product.deleteProduct", dnum);
		return true;
	}
	
	//관리자용
	// 후기 리스트_관리자용
	public List<Map> reviewList_master(Map map){
		return sql.selectList("product.reviewList_master", map);
	}
	// 후기 리스트 총 갯수
	public int reviewListAllCount(){
		return sql.selectOne("product.reviewListAllCount");
	}
	// 후기 리스트 삭제
	public int deleteReview(String[] ar) {
		return sql.delete("product.deleteReview", ar);
	}
	// 후기 리스트 검색
	public List<Map> searchReview(Map param){
		return sql.selectList("product.searchReview", param);
	}
	//
	public int searchCount(Map param){
		return sql.selectOne("product.searchCount", param);
	}
}
