<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- 관리자모드로 로그인했을경우 추가하기--%>

<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">FORPY</a>
		</div>
		<ul class="nav navbar-nav">
			<li class="active"><a href="#">Home</a></li>
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> DOG <span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="#">FOOD</a></li>
					<li><a href="#">JOY</a></li>
				</ul></li>
			<li class="dropdown"><a class="dropdown-toggle"
				data-toggle="dropdown" href="#"> BOARD <span class="caret"></span></a>
			</li>
		</ul>

		<c:choose>
			<c:when test="${!empty auth}">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="/member/myInfo"><span class="glyphicon glyphicon-user">MY INFO</span></a></li>
					<li><a href="/member/logout"><span class="glyphicon glyphicon-log-in"> LOGOUT </span></a></li>
				</ul>
			</c:when>
			
			<c:otherwise>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="/member/join"><span class="glyphicon glyphicon-user">Sign Up</span></a></li>
					<li><a href="/member/login"><span class="glyphicon glyphicon-log-in">Login</span></a></li>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>
</nav>