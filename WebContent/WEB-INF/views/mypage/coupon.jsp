<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.CouponTitle_D{
		margin-left: 70;
		margin-bottom: 30;
		padding: 20;
		font-family: 'Inconsolata';
		font-size: 20;
	}
	#addCoupon_D{
		width: 800px;
		margin-top: 50px;
		padding: 15;
		font-family: 'NanumBarunGothic';
	}
	.addCoupon_I{
		width: 200px;
		text-align: center;
		padding: 5px;
		margin-right: 10px;
		color: black;
	}
	.addCoupon_B{
		padding: 7 16;
		 transform: translate(0%, 4%);
	}
	.coupon_Th{ /* 쿠폰 테이블 thead */
		background-color: rgb(240,240,240);
	}
	.coupon_Td{ /* 쿠폰 모든 td */
		padding:10;
		font-family: 'Daum_Regular';
		font-size: 12;
		border-top: 1px solid rgb(210,210,210);
		border-bottom: 1px solid rgb(210,210,210);
	}
	#CouponTable_D{
		margin-top: 60px;
		margin-bottom: 100px;
	}
</style>
<div align="center">
	<div align="left" class="CouponTitle_D">My Coupon</div>
	<div id="addCoupon_D" class="w3-panel w3-Blue-Gray">
		<p>등록하실 쿠폰의 번호를 입력해 주세요 (10~35자 일련번호 "-" 제외)</p>
		<form action="/mypage/coupon" method="post">
			<input type="hidden" name="id" value="${auth}">
			<input type="text" class="addCoupon_I" name="no">
			<button type="submit" class="addCoupon_B w3-button w3-black">인증</button>
		</form>
	</div>
	<div id="CouponTable_D">
		<table>
			<thead class="Coupon_Th" align="center">
				<tr>
					<td class="coupon_Td" width="70">번호</td>
					<td class="coupon_Td" width="400">쿠폰명</td>
					<td class="coupon_Td" width="150">할인액</td>
					<td class="coupon_Td" width="150">마감일</td>
				</tr>
			</thead>
			<tbody align="center">
				<c:choose>
					<c:when test="${list ne null}">
						<c:forEach var="obj" items="${list}">
							<tr>
								<td class="coupon_Td">${obj.NO}</td>
								<td class="coupon_Td">${obj.NAME}</td>
								<td class="coupon_Td">${obj.DISCOUNT}</td>
								<td class="coupon_Td">${obj.ENDDATE}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr height="100">
							<td class="coupon_Td" colspan="5">사용 가능한 쿠폰이 없습니다</td>
						</tr>
					</c:otherwise>
				</c:choose>
			</tbody>
			<tfoot>
				
			</tfoot>
		</table>
	</div>
</div>