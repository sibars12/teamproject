<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles"%>
<html>
<head>
<title><t:getAsString name="title" /></title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.8/summernote-bs4.js"></script>
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
				<div class="col-sm-2 sidenav">
					<p>
						<a href="#">Link</a>
					</p>
				</div>
				<div class="col-sm-8 text-left">
					<h1>Welcome</h1>
					<h3>MAIN</h3>
					</br> </br> </br>
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
			<t:insertAttribute name="footer" />
		</footer>
	</div>
</body>
</html>