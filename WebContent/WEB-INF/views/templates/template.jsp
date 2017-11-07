<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles"%>

<html>
<head>

<style>
@font-face {
	font-family: "IropkeBatangM";
	src: url('/fonts/IropkeBatangM.eot');
	src: url('/fonts/IropkeBatangM.eot?#iefix') format('embedded-opentype'),
		url('/fonts/IropkeBatangM.woff') format('woff'),
		url('/fonts/NanumGothic.ttf') format('truetype');
	src: local(※), url('/fonts/IropkeBatangM.woff') format('woff');
}

@font-face {
	font-family: "Daum_Regular";
	src: url('/fonts/Daum_Regular.eot');
	src: url('/fonts/Daum_Regular.eot?#iefix') format('embedded-opentype'),
		url('/fonts/Daum_Regular.woff') format('woff'),
		url('/fonts/Daum_Regular.ttf') format('truetype');
	src: local(※), url('/fonts/Daum_Regular.woff') format('woff');
}

@font-face {
	font-family: "Inconsolata-Bold";
	src: url('/fonts/Daum_Regular.eot');
	src: url('/fonts/Inconsolata-Bold.eot?#iefix')
		format('embedded-opentype'), url('/fonts/Inconsolata-Bold.woff')
		format('woff'), url('/fonts/Inconsolata-Bold.ttf') format('truetype');
	src: local(※), url('/fonts/Inconsolata-Bold.woff') format('woff');
}

@font-face {
	font-family: "Inconsolata-Regular";
	src: url('/fonts/Inconsolata-Regular.eot');
	src: url('/fonts/Inconsolata-Regular.eot?#iefix')
		format('embedded-opentype'), url('/fonts/Inconsolata-Regular.woff')
		format('woff'), url('/fonts/Inconsolata-Regular.ttf')
		format('truetype');
	src: local(※), url('/fonts/Inconsolata-Regular.woff') format('woff');
}

@font-face {
	font-family: "Saira-Medium";
	src: url('/fonts/Saira-Medium.eot');
	src: url('/fonts/Saira-Medium.eot?#iefix') format('embedded-opentype'),
		url('/fonts/Saira-Medium.woff') format('woff'),
		url('/fonts/Saira-Medium.ttf') format('truetype');
	src: local(※), url('/fonts/Saira-Medium.woff') format('woff');
}

@font-face {
	font-family: "Saira-Light";
	src: url('/fonts/Saira-Light.eot');
	src: url('/fonts/Saira-Light.eot?#iefix') format('embedded-opentype'),
		url('/fonts/Saira-Light.woff') format('woff'),
		url('/fonts/Saira-Light.ttf') format('truetype');
	src: local(※), url('/fonts/Saira-Light.woff') format('woff');
}
@font-face {
	font-family: "NanumBarunGothic";
	src: url('/fonts/NanumBarunGothic.eot');
	src: url('/fonts/NanumBarunGothic.eot?#iefix') format('embedded-opentype'),
		url('/fonts/NanumBarunGothic.woff') format('woff'),
		url('/fonts/NanumBarunGothic.ttf') format('truetype');
	src: local(※), url('/fonts/NanumBarunGothic.woff') format('woff');
}
.container-fluid {
	padding-right: 0 !important;
	padding-left: 0 !important;
}
</style>
<!-- 이벤트 테그 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">


<title><t:getAsString name="title" /></title>

<!-- Jquery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Summernote -->
<link
	href="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.css"
	rel="stylesheet">
<script
	src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script
	src="http://netdna.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link href="/summernote/dist/summernote.css" rel="stylesheet">
<script src="/summernote/dist/summernote.js"></script>
<script src="/summernote/dist/summernote.min.js"></script>
<script src="/summernote/dist/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

</head>

<body>

	<div class="container-fluid">
		<div class="navbar-fixed-top">
			<header class="container-fluid">
				<t:insertAttribute name="header" />
			</header>
	
			<nav class="container">
				<t:insertAttribute name="nav" />
			</nav>
		</div>
		<div style="min-height: 130;"></div>
		<div class="container-fluid text-center">
			<div class="row container-fluid">
				<div class="col-sm-2 text-left">
				</div>
				<div class="col-sm-8 text-left">
					<t:insertAttribute name="section" />
				</div>
				<div class="col-sm-2 text-left">
					<t:insertAttribute name="remote" />
				</div>
			</div>
		</div>
		<footer>
			<t:insertAttribute name="footer" />
		</footer>
	</div>
</body>
</html>