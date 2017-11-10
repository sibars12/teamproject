package models;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class CouponDao {
	@Autowired
	SqlSessionTemplate sql;
	
	public List getCouponList(String id) { // �ش� ID�� ��������� ��ȯ
		return sql.selectList("coupon.getCouponList", id);
	}
	
	public Set<Integer> getCouponNo() { // ���� ��ϵǾ��ִ� ������ no�� set���� ��ȯ
		List<Integer> list = sql.selectList("coupon.getCouponNo");
		Set<Integer> set = new HashSet<>();
		for(int n : list) {
			set.add(n);
		}
		return set;
	}
	
	public boolean addCoupon(Map map) {
		sql.insert("coupon.addCoupon", map);
		return true;
	}
	
	public int checkNo(String no) {
		return sql.selectOne("coupon.checkNo", no);
	}
	
	public boolean regCoupon(Map map) {
		sql.update("coupon.regCoupon", map);
		return true;
	}
	public boolean newCoupon(Map map) {
		sql.insert("coupon.newCoupon", map);
		return true;
	}
}
