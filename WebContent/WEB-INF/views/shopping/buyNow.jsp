<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
	#tabName_D{
		font-family: 'Inconsolata-Bold';
		font-size: 19;
		margin: 8;
	}
</style>
<div class="w3-container" align="center">
	<div align="left" id="tabName_D">ORDER</div>
	<div id="StockList">
		<table>
			<tr>
				<th>상품명</th>
				<th>상품번호</th>
				<th>사이즈</th>
				<th>색상</th>
				<th>수량</th>
				<th>가격</th>
			</tr>
		<c:forEach var="i" begin="0" end="${stockNo.length }-1">
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
	<form>
		<div id="buyerInfo">
			<table>
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
	    		<p>
					<input type="hidden" name="id" value="${auth }">
					<input type="hidden" name="stockNo" value="${stockNo }">
					<input type="hidden" name="StockCnt" value="${stockCnt }">
					<input type="hidden" name="infoList" value="${infoList }">
				</p>
		</div>
		<div id="paymentInfo">
			<table>
				<tr>
					<th>주문 금액</th>
					<td><input type="hidden" name="totPrice" value="${totPrice }">${totPrice }</td>
				</tr>
				<tr>
					<th>배송료</th>
					<c:choose>
					<c:when test="${totPrice le 30000}">
						<td><input type="hidden" name="delivery" id="delivery" valeu="0">무료 배송</td>
					</c:when>
					<c:otherwise>					
						<td><input type="hidden" name="delivery" id="delivery" valeu="2500">2500</td>
					</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<th>보유포인트 ${memInfo[0].POINT }</th>
					<td><input type="text" id="payPoint" name="payPoint" placeholder="사용할 포인트"></td>
				</tr>							
			</table>		
		</div>
		<div id="paymentType">
			<div>
				<label>결제 수단</label><br>
				<input type="radio" class="type_Radio" name="type" value="실시간 계좌이체">실시간 계좌이체<br>
				<input type="radio" class="type_Radio" name="type" value="신용카드">신용카드
			</div>
			<div id="kind">	
			</div>			
		</div>
		<button type="submit" name="buy">구매하기</button>
	</form>
	
</div>