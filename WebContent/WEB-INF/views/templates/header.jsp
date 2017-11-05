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
	.headerSearch_I{
		height: 27;
		width: 100;
		margin-top: 7px;
		margin-right: 3px;
	}
</style>
<div id="head_D" align="center">
	<div id="subHead_D" class="row container">
		<c:choose>
			<c:when test="${!empty auth}">
				<div id="head1_D" class="col-sm-4 text-left">
					<a href="/member/myInfo" id="login_A" class="header_A">MY INFO</a>
					<a href="/member/logout" id="join_A" class="header_A">LOGOUT</a>
				</div>
			</c:when>
			<c:otherwise>
				<div id="head1_D" class="col-sm-4 text-left">
					<a href="/member/login" id="login_A" class="header_A">LOGIN</a>
					<a class="header_A" href="/member/join" id="join_A">JOIN</a>
				</div>
			</c:otherwise>
		</c:choose>

		<div id="head2_D" class="col-sm-4" align="right">
			<table><tr><td>
				<form style="margin:0;" action="/search" method="get">
					<input type="text" class="headerSearch_I">
					<button style="transform: translate(0%, -5%);" class="btn btn-primary" type="submit"><span class="glyphicon glyphicon-search"></span></button>
				</form>
			</td></tr></table>
		</div>
		<div id="head3_D" class="col-sm-4" align="right">
			<a href="#" class="right_A header_A">CS CENTER</a>
			<a href="https://www.doortodoor.co.kr/parcel/pa_004.jsp" class="right_A header_A">DELIVERY</a>
			<c:if test="${auth ne null}"><a href="/mypage/index" class="right_A header_A">MY PAGE</a>
			<a href="/shopping/cart" class="right_A header_A">CART</a>
			<span class="cartN_Sp w3-badge w3-white">${cartCnt}</span></c:if>
		</div>
	</div>
</div>
