 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
	#nav_D {
		font-size: 19;
		padding-top: 30;
		padding-bottom: 30;
		height: 90;
		background-color: white;
	}
	
	.menu_A {
		margin-right: 10;
		margin_left: 10;
	}
	
	#menu_D {
		font-family: 'Saira-Medium';
		padding-left: 140;
	}
	
	#mainTitle_D {
		padding-left: 90;
		font-size: 22;
	}
	
	.title_A:hover {
		text-decoration: none;
		color: black;
	}
	.menu_A:hover{
		text-decoration: none;
		color: black;
	}
</style>
<div id="nav_D" class="row content">
	<div id="mainTitle_D" class="col-sm-5 text-left">
		<a href="/" class="title_A">F O R P Y</a>
	</div>
	<div id="menu_D" class="col-sm-7 text-center">
		<a class="menu_A" href="/product/list">PRODUCT</a>
		<c:if test="${'MASTER' eq auth }">
		<a class="menu_A" href="/master/eventlist">EVENT</a>
		<a class="menu_A" href="/master/QnAlist">QnA</a>
		<a class="menu_A" href="/master/noticelist">NOTICE</a>
		<a class="menu_A" href="/master/inquirelist">INQUIRE</a>
		<a class="menu_A" href="/master/returnlist">RETURN</a>
		</c:if>
		<c:if test="${'MASTER' ne auth}">
		<a class="menu_A" href="/event/list">EVENT</a>
		<a class="menu_A" href="/QnA/list">QnA</a>
		<a class="menu_A" href="/notice/list">NOTICE</a>
		<a class="menu_A" href="/return/list">RETURN</a>
		</c:if>
		<a class="menu_A" href="/stock/addStock">STOCK</a>
	</div>
</div>
