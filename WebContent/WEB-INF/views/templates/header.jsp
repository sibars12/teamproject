<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#head_D{
		height: 40;
		background-color: black;
		color: white;
		font-family: 'Saira-Light';
	}
	#subHead_D{
		font-size: 13;
	}
	#head1_D{
		padding-top: 10;
	}
	#head3_D{
		padding-top: 10;
	}
	#login_A{
		margin-right: 10;
		margin-left: 10;
	}
	#join_A{
		margin-right: 80;
		margin-left: 10;
	}
	.right_A{
		margin-right: 10;
		margin-left: 10;
	}
	.header_A:hover{
		text-decoration: none;
		color: white;
	}
	.cartN_Sp{
		font-weight: bold;
	}
</style>
<div id="head_D" align="center">
	<div id="subHead_D" class="row content">
		<c:choose>
			<c:when test="${!empty auth}">
				<div id="head1_D" class="col-sm-4 text-right">
					<a href="/member/myInfo" id="login_A" class="header_A">MY INFO</a>
					<a href="/member/logout" id="join_A" class="header_A">LOGOUT</a>
				</div>
			</c:when>
			
			<c:when test =" ${auth eq 'master'}">
				<div id="head1_D" class="col-sm-4 text-right">
					<a href="" id="login_A" class="header_A">1</a>
					<a href="" id="join_A" class="header_A">2</a>
				</div>
			</c:when>
			
			<c:otherwise>
				<div id="head1_D" class="col-sm-4 text-right">
					<a href="/member/login" id="login_A" class="header_A">LOGIN</a>
					<a class="header_A" href="/member/join" id="join_A">JOIN</a>
				</div>
			</c:otherwise>
		</c:choose>

		<div id="head2_D" class="col-sm-3"></div>
		<div id="head3_D" class="col-sm-5 text-left">
			<a href="#" class="right_A header_A">CS CENTER</a>
			<a href="https://www.doortodoor.co.kr/parcel/pa_004.jsp" class="right_A header_A">DELIVERY</a>
			<a href="/mypage/index" class="right_A header_A">MY PAGE</a>
			<a href="/shopping/cart" class="right_A header_A">CART</a><span class="cartN_Sp w3-badge w3-white">1</span>
		</div>
	</div>
</div>
