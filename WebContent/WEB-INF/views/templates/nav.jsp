 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
   <%-- 관리자모드로 로그인했을경우 추가하기--%> 
<<<<<<< HEAD
   
   
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">FORPY</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="/">Home</a></li>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> DOG <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="/product/list">FOOD</a></li>
          <li><a href="#">JOY</a></li>
        </ul>
      </li>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> BOARD <span class="caret"></span></a>
      </li>
      <li class="active"><a href="/QnA/list">QnA</a></li>
      <li class="active"><a href="/notice/list?page=1">Notice</a></li>
      <li class="active"><a href="/stock/addStock">Stock</a></li>
      <li class="active"><a href="/shopping/cart">Cart</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="/member/join.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      <li><a href="/member/login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
    </ul>
  </div>
</nav>
=======
<style>
	#nav_D{
		font-size: 19;
		padding-top: 30;
		padding-bottom: 30;
		height: 90;
	}
	.menu_A{
		margin-right: 35;
		margin_left: 35;
	}
	#menu_D{
		font-family: 'Saira-Medium';
		padding-left: 120;
	}
	#title_D{
		padding-left: 60;
		font-size: 22;
	}
	#title_A:hover{
		text-decoration: none;
		color: black;
	}
</style>
<div id="nav_D" class="row content">
	<div id="title_D" class="col-sm-5 text-left">
		<a href="/" class="title_A">F O R P Y</a>
	</div>
	<div id="menu_D" class="col-sm-7 text-center">
		<a class="menu_A" href="/product/list">PRODUCT</a>
		<a class="menu_A" href="/event/list">EVENT</a>
		<a class="menu_A" href="/QnA/list">QnA</a>
		<a class="menu_A" href="/notice/list">NOTICE</a>
	</div>
</div>
>>>>>>> refs/heads/master

<script>
	
</script>