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
	// ��ǰ���� view ��������
	public List<Map> getProductInfo(String ownernumber){
		return sql.selectList("product.getProductInfo", ownernumber);
	}
	public int getProductPage(Map map) {
		return sql.selectOne("product.getProductPage", map);
	}
	// ��ǰ���
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
	// �ı� ���
	public boolean addReview(Map map){
		sql.insert("product.addReview", map);
		return true;
	}
	// �ı� ����Ʈ 
	public List<Map> getReviewList(Map map){
		return sql.selectList("product.getReviewList", map);
	}
	// �ı� ����Ʈ ���� ī��Ʈ(��ǰ �ѹ���)
	public int reviewListCount(String ownernumber){
		return sql.selectOne("product.reviewListCount", ownernumber);
	}
	// ��ǰ ����
	public boolean deleteProduct(String dnum) {
		sql.delete("product.deleteProduct", dnum);
		return true;
	}
	public boolean editRegist(String dnum){
		sql.update("product.editRegist", dnum);
		return true;
	}
	
	//�����ڿ�
	// �ı� ����Ʈ_�����ڿ�
	public List<Map> reviewList_master(Map map){
		return sql.selectList("product.reviewList_master", map);
	}
	// �ı� ����Ʈ �� ����
	public int reviewListAllCount(){
		return sql.selectOne("product.reviewListAllCount");
	}
	// �ı� ����Ʈ ����
	public int deleteReview(String[] ar) {
		return sql.delete("product.deleteReview", ar);
	}
	// �ı� ����Ʈ �˻�
	public List<Map> searchReview(Map param){
		return sql.selectList("product.searchReview", param);
	}
	// �˻� ����Ʈ ����
	public int searchCount(Map param){
		return sql.selectOne("product.searchCount", param);
	}
	
	// ��ǰ ����Ʈ ����
	public int updateProduct(Map param){
		return sql.update("product.updateProduct", param);
	}
	// ��ǰ ���� ��������
	public Map loadPInfo(String ownernumber){
		return sql.selectOne("product.loadPInfo",ownernumber);
	}
}
