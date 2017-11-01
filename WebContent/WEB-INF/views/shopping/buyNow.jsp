<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	.tabName_D{
		font-family: 'Inconsolata-Bold';
		font-size: 19;
		margin: 8;
	}
	td{ margin: 5px;}
</style>
<div class="w3-container" align="center">
	<div align="left" class="tabName_D">ORDER</div>
	<div id="StockList">
		<table class="table">
			<tr>
				<td>상품명</td>
				<td>상품번호</td>
				<td>사이즈</td>
				<td>색상</td>
				<td>수량</td>
				<td>가격</td>
			</tr>
		<c:forEach var="i" begin="0" end="${stockNo.size()-1}">
			<tr>
				<td>${infoList[i].NAME }</td>
				<td>${infoList[i].OWNERNUMBER }</td>
				<td>${infoList[i].SIZE }</td>
				<td>${infoList[i].COLOR }</td>
				<td>${stockCnt[i] }</td>
				<td>${stockPrice[i] }</td>			
			</tr>
		</c:forEach>
		</table>
	</div>
	<hr>
	<form>
		<div id="buyerInfo">
			<div align="left" class="tabName_D">구매자 정보</div>
			<table class="table">
				<tr>
					<th>받으실분 성함</th>
	    			<td><input type="text" class="form-control" id="name" name="name" placeholder="받는분 성함">	</td>
	    		</tr>
    			<tr>
	    			<th>우편번호</th>
	    			<td><input type="text" class="form-control" id="postCode" name="postCode" placeholder="우편번호">
	    				<button id="searchPostCode">우편번호 찾기</button>
	    			</td>
	    		</tr>
	    		<tr>	    		
	    			<th>주소</th>
	    			<td><input type="text" class="form-control" id="addr1" name="addr1" placeholder="주소"></td>
	    			<td><input type="text" class="form-control" id="addr2" name="addr2" placeholder="상세주소"></td>
	    		</tr>
	    		<tr>
	    			<th>전화번호</th>
	    			<td><input type="text" class="form-control" name="tel" id="tel" placeholder="전화번호"></td>
	    		</tr>
			</table>
		</div>
		<hr>
		<div id="paymentInfo">
			<div align="left" class="tabName_D">결제할 금액</div>
			<table class="table">
				<tr>
					<th>주문 금액</th>
					<td><input type="hidden" name="totPrice" value="${totPrice }">${totPrice }</td>
				</tr>
				<tr>
					<th>배송료</th>
					<c:choose>
					<c:when test="${totPrice ge 30000}">
						<td><input type="hidden" name="delivery" id="delivery" value="0">무료 배송</td>
					</c:when>
					<c:otherwise>					
						<td><input type="hidden" name="delivery" id="delivery" value="2500">2500</td>
					</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<th colspan="2">포인트 사용</th>
				</tr>
				<tr>
					<td>보유포인트 : ${memInfo[0].POINT }</td>
					<td><input type="text" id="payPoint" name="payPoint" placeholder="사용할 포인트"></td>
				</tr>
				<tr>
					<th colspan="2">쿠폰 사용</th>
				</tr>
				<tr>
					<td>
						<select id="coupon">
						<option>쿠폰선택</option>
						<c:forEach var="i" items="${memInfo}">	
							<option value="${i.DISCOUNT }" data="${i.NO }">${i.NAME }</option>
						</c:forEach>
						</select>
					</td>
					<td id="checkCoupon"></td>
				</tr>
				<tr>
					<td>최종 결제 금액</td>
					<td id="lastPay"></td>
				</tr>							
			</table>		
		</div>
		<hr>
		<div id="paymentType">
			<div align="left" class="tabName_D">결제 방법</div>
			<table class="table">
				<tr><th colspan="2">결제 수단</th></tr>
				<tr>
					<td><input type="radio" class="type_Radio" name="type" value="실시간 계좌이체">실시간 계좌이체</td>
					<td><input type="radio" class="type_Radio" name="type" value="신용카드">신용카드</td>
				</tr>
				<tr id="banking" style="display:none" >
					<td colspan="2" id="bank"> d</td>
				</tr>
				<tr id="credit" style="display:none">
					<td id="card">s</td>
					<td id="installment">d</td>
				</tr>
			</table>		
		</div>
		<div>
					<input type="hidden" name="id" value="${auth }">
					<input type="hidden" name="stockNo" value="${stockNo }">
					<input type="hidden" name="StockCnt" value="${stockCnt }">
					<input type="hidden" name="infoList" value="${infoList }">
					<input type="hidden" id="couponNo" name="couponNo" value="0" >
					<input type="hidden" id="couponDiscount" name="couponDiscount"  value="0">
					<input type="hidden" id="payment" name="payment" value="0">
		</div>
		<button type="submit" name="buy">구매하기</button>
	</form>
	
</div>

<script>

</script>