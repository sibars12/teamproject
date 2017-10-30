<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>아이디 찾기 결과</h1>
<hr>

<form action="/member/login" method="get">
	
	<!-- findId.id라고 적지 않은 이유는 mapper에서 보면 findId에서 뽑아오는값이 string으로 id이기때문에 map으로 전체를 뽑아와서 거기서 id만 추출하는게 아니어서 그냥 findId만 쓰는것! -->
	회원님의 ID는 ${findId}입니다.		

	<div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">LOGIN</button>
        <a href="/member/findPw"><button type="button" class="btn btn-default">FIND PW</button></a>
      </div>
    </div>
	
</form>