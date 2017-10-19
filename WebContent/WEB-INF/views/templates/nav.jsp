 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
   <%-- 관리자모드로 로그인했을경우 추가하기--%> 
   
   
<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">FORPY</a>
    </div>
    <ul class="nav navbar-nav">
      <li class="active"><a href="#">Home</a></li>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> DOG <span class="caret"></span></a>
        <ul class="dropdown-menu">
          <li><a href="#">FOOD</a></li>
          <li><a href="#">JOY</a></li>
        </ul>
      </li>
      <li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> BOARD <span class="caret"></span></a>
      </li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
      <li><a href="/member/join.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
      <li><a href="/member/login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
    </ul>
  </div>
</nav>

</body>
</html>
