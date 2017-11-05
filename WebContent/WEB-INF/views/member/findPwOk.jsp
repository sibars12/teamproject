<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div>
	<h1>비밀번호 찾기</h1>
	<hr>
	
	비밀번호 재설정이 정상적으로 완료되었습니다. 로그인해주세요 :)
	
	<form action="/member/login" method="get">
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-default" id="pwLogin" name="pwLogin">LOGIN</button>
			</div>
		</div>
	</form>
	
</div>
