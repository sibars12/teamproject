<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.makeCoupon_Td{
		padding: 5px;
		font-family: 'NanumBarunGothic';
		font-size: 14;
	}
	.makeCoupon_I{
		padding: 3px;
		width: 150px;
	}
	#makeCoupon_D{
		margin-top: 100px;
		margin-bottom: 100px;
	}
	.makeCoupon_B{
		padding: 10!important 6!important;
		margin-top: 10px;
		font-size: 13;
	}
</style>
<c:if test="${result ne null}">
	<c:choose>
		<c:when test="${result}">
			<script>alert("등록되었습니다");</script>
		</c:when>
		<c:otherwise>
			<script>alert("등록 실패");</script>
		</c:otherwise>
	</c:choose>
</c:if>
<div align="center">
	<div id="makeCoupon_D">
		<form action="/mypage/makecoupon" method="post">
			<table class="makeCoupon_T">
				<tr>
					<td class="makeCoupon_Td"><font color="red">*</font>이름</td><td class="makeCoupon_Td"><input type="text" name="name" class="makeCoupon_I" required></td>
				</tr>
				<tr>
					<td class="makeCoupon_Td"><font color="red">*</font>할인액</td><td class="makeCoupon_Td"><input type="text" name="discount" class="makeCoupon_I" required></td>
				</tr>
				<tr>
					<td class="makeCoupon_Td">아이디</td><td class="makeCoupon_Td"><input type="text" name="id" class="makeCoupon_I"></td>
				</tr>
				<tr>
					<td class="makeCoupon_Td">마감일</td><td class="makeCoupon_Td"><input type="date" name="enddate" class="makeCoupon_I"></td>
				</tr>
			</table>
			<button class="makeCoupon_B w3-btn w3-blue-grey" type="submit">등록</button>
		</form>
		<h6><font color="red">*</font>는 필수</h6>
	</div>
</div>