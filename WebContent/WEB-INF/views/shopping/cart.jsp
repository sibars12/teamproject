<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.cart_Td{ /* 장바구니 모든 td */
	padding:10;
	font-family: 'Daum_Regular';
	font-size: 12;
	border-top: 1px solid rgb(210,210,210);
	border-bottom: 1px solid rgb(210,210,210);
}
.cartBt_Td{ /* 장바구니 버튼있는 td */
	padding:12;
	font-family: 'Daum_Regular';
	font-size: 12;
}
.cartTP_Td{ /* 장바구니 총금액 td */
	font-size: 14;
	padding: 14;
	padding-right: 30;
}
.cart_Th{ /* 장바구니 테이블 thead */
	background-color: rgb(240,240,240);
}
.vol_Td{ /* 장바구니 테이블 수량 조절하는 td */
	padding:5;
	font-family: 'Daum_Regular';
	font-size: 12;
}
.cartVol_I{ /* 수량조절하는 버튼 */
	width: 40px;
	height: 21px;
	text-align: right;
	margin: 3;
	padding: 3;
}
.cartBt_B{ /* 장바구니 삭제,구매 버튼 */
	margin: 3;
}
.Title_D{ /* 타이틀 글자 */
	margin-left: 70;
	margin-bottom: 30;
	padding: 20;
	font-family: 'Inconsolata';
	font-size: 20;
}
#cart_T{ /* 장바구니 테이블 */
	border-collapse: collapse;
}
#cartInfo_D{
	font-family: 'NanumBarunGothic';
	font-size: 13;
	text-align: left;
	width: 800;
	border: 1px solid rgb(210,210,210);
	margin-top: 50;
}
#cartInfoHead_D{
	background-color: rgb(240,240,240);
	padding: 8 11;
}
#cartInfoval_D{
	padding: 11;
}
.cartInfoval_Li{
	font-size: 12;
}
.cartInfoTitle_Sp{
	font-size: 13;
	margin-bottom: 3;
}
</style>
<div class="w3-container" align="center">
	<div align="left" class="Title_D">Shopping Cart</div>
	<div align="center">
		<form action="/shopping/buyNow">
			<table id="cart_T">
				<thead class="cart_Th" align="center">
					<tr>
						<td class="cart_Td"></td>
						<td class="cart_Td" width="70">번호</td>
						<td class="cart_Td">사진</td>
						<td class="cart_Td" width="500">제품명</td>
						<td class="cart_Td" width="80">판매가</td>
						<td class="cart_Td" width="150">수량</td>
						<td class="cart_Td" width="80">합계</td>
					</tr>
				</thead>
				<c:choose>
					<c:when test="${list.size()!=0}">
						<tbody align="center">
							<c:forEach var="idx" begin="0" end="${list.size()-1 }">
								<tr>
									<td class="cart_Td"><input type="checkbox" class="delete_I" value="${list[idx].NUM }"></td>
									<td class="cart_Td">${idx+1 }</td>
									<td class="cart_Td"><img width="70" height="70" src="/images/product/${list[idx].IMAG }"></td>
									<td class="cart_Td">[${list[idx].COMP}] ${list[idx].NAME}${list[idx].SCALE} ${list[idx].COLOR}</td>
									<td class="price_Td cart_Td">${list[idx].PRICE}</td>
									<td class="vol_Td cart_Td">
										<button type="button" class="volminus_B w3-button w3-black w3-hover-black w3-padding-small w3-tiny">-</button>
										<input type="text" name="stockCnt" class="cartVol_I" value="${list[idx].VOLUME }">
										<button type="button" class="volplus_B w3-button w3-black w3-hover-black w3-padding-small w3-tiny">+</button>
										<input type="hidden" name="stockNo" value="${list[idx].NUM }">
									</td>
									<td class="sPrice_Td cart_Td">
										<span id="sPrice_S"></span>
										<input type="hidden" name="stockPrice" value="">
									</td>
								</tr>
							</c:forEach>
							</tbody>
							<tfoot align="right">
								<tr>
									<td class="cart_Td cartTP_Td" colspan="7">
										총 구매금액: <span id="totalPrice_S"></span>
										<input type="hidden" name="totPrice" id="totalPrice_I">
									</td>
								</tr>
								<tr>
									<td class="cartBt_Td" colspan="6" align="right">
										<button id="deleteCart_B" class="cartBt_B w3-button w3-white w3-border w3-border-black w3-hover-black" type="button">삭제</button>
										<button class="cartBt_B w3-button w3-white w3-border w3-border-black w3-hover-black" type="submit">구매</button>
									</td>
								</tr>
							</tfoot>
						</c:when>
						<c:otherwise>
							<tbody align="center">
								<tr height="100">
									<td class="cart_Td" colspan="7">장바구니에 상품이 없습니다</td>
								</tr>
							</tbody>
						</c:otherwise>
					</c:choose>
				
			</table>
		</form>
		
		<div id="cartInfo_D" align="center">
			<div id="cartInfoHead_D">이용안내</div>
			<div id="cartInfoval_D">
				<span class="cartInfoTitle_Sp">장바구니 이용안내</span>
				<ul>
					<li class="cartInfoval_Li">해외배송 상품과 국내배송 상품은 함께 결제하실 수 없으니 장바구니 별로 따로 결제해 주시기 바랍니다.</li>
					<li class="cartInfoval_Li">해외배송 가능 상품의 경우 국내배송 장바구니에 담았다가 해외배송 장바구니로 이동하여 결제하실 수 있습니다.</li>
					<li class="cartInfoval_Li">선택하신 상품의 수량을 변경하시려면 수량변경 후 [변경] 버튼을 누르시면 됩니다.</li>
					<li class="cartInfoval_Li">[쇼핑계속하기] 버튼을 누르시면 쇼핑을 계속 하실 수 있습니다.</li>
					<li class="cartInfoval_Li">장바구니와 관심상품을 이용하여 원하시는 상품만 주문하거나 관심상품으로 등록하실 수 있습니다.</li>
					<li class="cartInfoval_Li">파일첨부 옵션은 동일상품을 장바구니에 추가할 경우 마지막에 업로드 한 파일로 교체됩니다.</li>
				</ul>
				<span class="cartInfoTitle_Sp">무이자할부 이용안내</span>
				<ul>
					<li class="cartInfoval_Li">상품별 무이자할부 혜택을 받으시려면 무이자할부 상품만 선택하여 [주문하기] 버튼을 눌러 주문/결제 하시면 됩니다.</li>
					<li class="cartInfoval_Li">[전체 상품 주문] 버튼을 누르시면 장바구니의 구분없이 선택된 모든 상품에 대한 주문/결제가 이루어집니다.</li>
					<li class="cartInfoval_Li">단, 전체 상품을 주문/결제하실 경우, 상품별 무이자할부 혜택을 받으실 수 없습니다.</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function(){
		$(".volplus_B").click(function(){
			var num = $(this).prev().val();
			num++;
			$(this).prev().val(num);
			totalPrice();
		});
		$(".volminus_B").click(function(){
			var num = $(this).next().val();
			if(num!=0)
				num--;
			$(this).next().val(num);
			totalPrice();
		});
		totalPrice();
	});
	
	$("#deleteCart_B").click(function(){
		var dnum = "";
		$('.delete_I:checked').each(function(idx) { 
	    	if(idx!=0)
	    		dnum+=",";
	    	dnum+=$(this).val();
		});
		if(confirm("정말 삭제하시겠습니까??")){
			console.log(dnum);
			$.get("/shopping/deleteCart",{"dnum":dnum},function(data){
				if(data=="YY"){
					location.href="/shopping/cart";
				}
			});
		}
	});
	
	var totalPrice = function(){
		var tPrice = 0;
		var sPrice = 0;
		$(".price_Td").each(function(){
			sPrice = parseInt($(this).text()) * parseInt($(this).next().children("input.cartVol_I").val());
			tPrice += parseInt($(this).text()) * parseInt($(this).next().children("input.cartVol_I").val());
			$(this).siblings(".sPrice_Td").children("#sPrice_S").text(sPrice);
			$(this).siblings(".sPrice_Td").children("input").val(sPrice);
		});
		$("#totalPrice_S").text(tPrice);
		$("#totalPrice_I").val(tPrice);
	}
</script>