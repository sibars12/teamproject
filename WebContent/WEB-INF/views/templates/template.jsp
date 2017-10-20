<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles"%>
<html>
<head>
	<title><t:getAsString name="title" /></title>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<!-- include libraries(jQuery, bootstrap) -->
	<link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
		<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script> 
		<script src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script> 
	
	<link href="/summernote/dist/summernote.css" rel="stylesheet">
		<script src="/summernote/dist/summernote.js"></script>
		<script src="/summernote/dist/summernote.min.js"></script>
		<script src="/summernote/dist/lang/summernote-ko-KR.js"></script>
</head>
<body>
	<div class="container">
		<header class="container">
			<t:insertAttribute name="header" />
		</header>
		<nav class="navbar navbar-inverse">
			<t:insertAttribute name="nav" />
		</nav>
		<div class="container-fluid text-center">
			<div class="row content">
				<!-- <div class="col-sm-1 sidenav"></div>-->
				<div class="col-sm-12 text-center">
					<t:insertAttribute name="section" />
					<br/> <br/>
				</div>
				
			<!-- 	<div class="col-sm-1 sidenav">
					<div class="well">
						<p>ADS</p>
					</div>
					<div class="well">
						<p>ADS</p>
					</div>
				</div> -->
			</div>
		</div>
		<footer>
			<t:insertAttribute name="footer" />
		</footer>
	</div>
</body>
</html>