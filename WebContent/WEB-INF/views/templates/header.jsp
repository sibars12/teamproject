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
		margin-right: 110;
		margin-left: 10;
	}
	.right_A{
		margin-right: 10;
		margin-left: 10;
	}
	a:hover{
		text-decoration: none;
		color: white;
	}
</style>
<div id="head_D" align="center">
	<div id="subHead_D" class="row content">
		<c:choose>
			<c:when test="${!empty auth}">
				<div id="head1_D" class="col-sm-4 text-right">
					<a href="/member/myInfo" id="login_A">MY INFO</a> <a
						href="/member/logout" id="join_A">LOGOUT</a>
				</div>
			</c:when>
			<c:otherwise>
				<div id="head1_D" class="col-sm-4 text-right">
					<a href="/member/login" id="login_A">LOGIN</a> <a
						href="/member/join" id="join_A">JOIN</a>
				</div>
			</c:otherwise>
		</c:choose>

		<div id="head2_D" class="col-sm-3"></div>
		<div id="head3_D" class="col-sm-5 text-left">
			<a href="#" class="right_A">CS CENTER</a> <a href="#" class="right_A">DELIVERY</a>
			<a href="#" class="right_A">MY PAGE</a> <a href="/shopping/cart"
				class="right_A">CART</a>
		</div>
	</div>
</div>
