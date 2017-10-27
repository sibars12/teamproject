<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>아이디 찾기 결과</h1>
<hr>

<form action="/member/login" method="post">
	
	회원님의 ID는 ${findId.ID}입니다.

	<div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">LOGIN</button>
        <a href="/member/findPw"><button type="button" class="btn btn-default">FIND PW</button></a>
      </div>
    </div>
	
</form>