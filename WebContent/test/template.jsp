<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%-- <title><t:getAsString name="title"/></title>--%>
<!-- JQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- BootStrap -->
   <!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
   <!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
   <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
   <div class="container">
   <header class="container">
	<jsp:include page="/test/header.jsp"></jsp:include>
   </header>
   <nav class = "navbar navbar-inverse">
      <jsp:include page="/test/nav.jsp"></jsp:include>
   </nav>
   <div class="container-fluid text-center">
   <div class="row content">
    <div class="col-sm-2 sidenav">
      <p><a href="#">Link</a></p>
    </div>
    <div class="col-sm-8 text-left"> 
     <jsp:include page="/test/login.jsp"></jsp:include>
    </div>
    <div class="col-sm-2 sidenav">
      <div class="well">
        <p>ADS</p>
      </div>
      <div class="well">
        <p>ADS</p>
      </div>
    </div>
   </div>
   </div>
   <footer>
      <jsp:include page="/test/footer.jsp"></jsp:include>
   </footer>
   </div>
</body>
</html>