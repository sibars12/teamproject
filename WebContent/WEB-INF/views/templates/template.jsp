<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<html>
<head>
<title> <t:getAsString name="title"/> </title>
</head>
<body>
<header>
	<t:insertAttribute name="header"/>
</header>
<nav>
	<t:insertAttribute name="nav"/>
</nav>
<section>
	<t:insertAttribute name="section"/>
</section>
<footer>
	<t:insertAttribute name="footer"/>
</footer>
</body>
</html>