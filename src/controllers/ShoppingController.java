package controllers;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import models.ProductDao;
import models.ShoppingDao;
import models.StockDao;

@Controller
@RequestMapping("/shopping")
public class ShoppingController {
	@Autowired
	ShoppingDao shoppingDao;
	@Autowired
	ProductDao productDao;
	@Autowired
	StockDao stockDao;
	@Autowired
	ObjectMapper mapper;
	
	@GetMapping("/buyNow")
	public ModelAndView BuyNowHandler(@RequestParam MultiValueMap<String,String> multiMap, HttpSession session){
		ModelAndView mav = new ModelAndView("t_expr");
		//System.out.println(multiMap);
		
		List<String> stockNo = multiMap.get("stockNo");
		List<String> stockCnt = multiMap.get("stockCnt");
		List<String> stockPrice = multiMap.get("stockPrice");
		List<String> totPrice = multiMap.get("totPrice");
		List<Map> infoList  = new ArrayList();		
		for(String s : stockNo){
			Map stockInfo = stockDao.getStockInfo(s);
			infoList.add(stockInfo);
		}
		String id = (String) session.getAttribute("auth");
		// �������� ��������
		Map memInfo = shoppingDao.getMemInfo(id);
		// ���� ��������
		List<Map> coupons = shoppingDao.getCoupon(id);
		//�ֱ� �ֹ����� ��������
		Map recentPurchase = shoppingDao.getRecentPurchase(id);
	
		mav.addObject("section", "shopping/buyNow");
		mav.addObject("stockNo", stockNo);
		mav.addObject("stockCnt",stockCnt);
		mav.addObject("stockPrice", stockPrice);
		mav.addObject("totPrice", totPrice.get(0));
		mav.addObject("infoList", infoList);
		mav.addObject("memInfo",memInfo );
		mav.addObject("coupons", coupons);
		mav.addObject("recent",recentPurchase );
		
		return mav;
	}
	
	@PostMapping("/buyNow")
	public String PostBuyNowHandler(@RequestParam MultiValueMap param, HttpSession session){
		try{
			// ������ ���� ����
			List<String> stockNo = (List<String>) param.get("stockNo");
			List<String> stockCnt = (List<String>) param.get("stockCnt");
			List<String> stockPrice = (List<String>) param.get("stockPrice");
			List<String> ownernumber = (List<String>) param.get("ownernumber");
			String id = (String) ((List) param.get("id")).get(0);
			Map forDao = new HashMap<>();

				// �ֹ���ȣ �����
				String purchaseNo = ((List) param.get("id")).get(0) + "_" + System.currentTimeMillis();
				System.out.println(purchaseNo);
				// purchase�� �����͵�
				Map pur = new HashMap();
				pur.put("purchaseNo", purchaseNo);
				pur.put("id", id);
				pur.put("name", ((List) param.get("name")).get(0));
				pur.put("postcode", ((List) param.get("postcode")).get(0));
				pur.put("addr1", ((List) param.get("addr1")).get(0));
				pur.put("addr2", ((List) param.get("addr2")).get(0));
				pur.put("tel", ((List) param.get("tel")).get(0));
				//int purchase_r = shoppingDao.addPurchase(pur);

				// orderInfo�� �����͵�
				int order_r = 0;
				for (int i = 0; i < stockNo.size(); i++) {
					Map or = new HashMap();
					or.put("purchaseNo", purchaseNo); // �ֹ���ȣ;
					or.put("ownernumber", (String) ownernumber.get(i));// ��ǰ��ȣ
					or.put("stockNo", (String) stockNo.get(i));// ����ȣ
					or.put("stockCnt", (String) stockCnt.get(i));// ���ż���
					or.put("stockPrice", (String) stockPrice.get(i));// ����*����
					//order_r += shoppingDao.addOrderInfo(or);
				}

				// ���� ���̺� �ֱ�
				Map pay = new HashMap();
				pay.put("purchaseNo", purchaseNo);
				pay.put("id", id);
				pay.put("type", ((List) param.get("type")).get(0));
				pay.put("kind", ((List) param.get("kind")).get(0));
				pay.put("installment", ((List) param.get("installment")).get(0));
				pay.put("totPrice", ((List) param.get("totPrice")).get(0));
				pay.put("delivery", ((List) param.get("delivery")).get(0));
				pay.put("payPoint", ((List) param.get("payPoint")).get(0));
				pay.put("addPoint", ((List) param.get("addPoint")).get(0));
				pay.put("coupon", ((List) param.get("couponDiscount")).get(0));
				pay.put("payment", ((List) param.get("payment")).get(0));
				//int pay_r = shoppingDao.addPayment(pay);

				// ����Ʈ �α� �����
				//int addpo = shoppingDao.addPointLog(pay);

				// ����Ʈ ����( ����Ʈ-����)
				String ownPoint = (String) ((List) param.get("point")).get(0);
				String payPoint = (String) ((List) param.get("payPoint")).get(0);
				String addPoint = (String) ((List) param.get("addPoint")).get(0);
				int resultPoint = Integer.parseInt(ownPoint) - Integer.parseInt(payPoint);
				System.out.println(resultPoint);
				Map po = new HashMap();
				po.put("resultPoint", resultPoint);
				po.put("id", id);
				//int point_r = shoppingDao.updatePoint(po);

				// ���� ���� ���� ����
				Map coupon = new HashMap();
				coupon.put("couponNo", ((List) param.get("couponNo")).get(0));
				coupon.put("id", id);
				//int coupon_r = shoppingDao.deletePayCoupon(coupon);

				// ����� ����
				int stock_r = 0;
				for (int i = 0; i < stockNo.size(); i++) {
					Map or = new HashMap();
					or.put("stockNo", (String) stockNo.get(i));// ����ȣ
					or.put("stockCnt", (String) stockCnt.get(i));// ���ż���
					//stock_r += shoppingDao.subStockVolum(or);
				}

				// �ֹ��� ��ǰ īƮ���� ����
				boolean cart_r;
				for (int i = 0; i < stockNo.size(); i++) {
					Map cart = new HashMap();
					cart.put("id", id);
					cart.put("num", stockNo.get(i));
					//cart_r = shoppingDao.deleteCart(cart);
				}
				forDao.put("id", id);
				forDao.put("purchaseNo", purchaseNo);
				forDao.put("stockNo",stockNo);
				forDao.put("stockCnt",stockCnt);
				forDao.put("stockPrice",stockPrice);
				forDao.put("ownernumber",ownernumber );
				forDao.put("pur",pur);
				forDao.put("pay",pay);
				forDao.put("po",po);
				forDao.put("coupon",coupon);
				
				shoppingDao.purchaseAll(forDao);
				session.setAttribute("cartCnt", shoppingDao.getCartCnt((String)session.getAttribute("auth")));
				
			
		}catch(Exception e){	
			e.printStackTrace();
			return "redirect:/shopping/error";
		}
		return "redirect:/mypage/index";
			
	}
	
	
	@RequestMapping("/error")
	public ModelAndView errorHandler(){
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "shopping/error");
		return mav;
	}
	
//----------------------------------------------------------------------------------------	
// ��ٱ���	
	@GetMapping("/cart")
	public ModelAndView cartHandler(HttpSession session){
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "shopping/cart");
		mav.addObject("list", shoppingDao.getCartList((String)session.getAttribute("auth")));
		return mav;
	}
	
	@RequestMapping("/cartDb") // ��ٱ��� DB����
	public ModelAndView cartDbHandler(@RequestParam MultiValueMap<String,String> multiMap, HttpSession session) {
		System.out.println(multiMap);
		ModelAndView mav = new ModelAndView("t_expr");
		mav.addObject("section", "shopping/cart");
		List<String> stockNo = multiMap.get("stockNo");
		List<String> stockCnt = multiMap.get("stockCnt");
		Map map = new HashMap<>();
		map.put("id", (String)session.getAttribute("auth"));
		for(int i=0;i<stockNo.size();i++) {
			map.put("num", stockNo.get(i));
			map.put("volume", stockCnt.get(i));
			if(shoppingDao.checkCart(map)>0) {
				shoppingDao.addCartVol(map);
			}else {
				shoppingDao.addCart(map);
				int n = (int)session.getAttribute("cartCnt");
				session.setAttribute("cartCnt", n+1);
			}
		}
		mav.addObject("list", shoppingDao.getCartList((String)session.getAttribute("auth"))); // �ӽ�
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("/deleteCart")
	public String deleteCartHandler(@RequestParam String dnum, HttpSession session) {
		System.out.println(dnum);
		String[] ar = dnum.split(",");
		for(int i=0; i<ar.length; i++){
			Map cart = new HashMap();
			cart.put("id", session.getAttribute("auth"));
			cart.put("num", ar[i]);
			shoppingDao.deleteCart(cart);
		}
		
		session.setAttribute("cartCnt", shoppingDao.getCartCnt((String)session.getAttribute("auth")));
		return "YY";
	}
}
