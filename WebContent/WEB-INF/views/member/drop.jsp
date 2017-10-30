<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div>
	<h1>회원탈퇴</h1>
	<hr>
	탈퇴를 위해 다시 한 번 비밀번호를 입력해주세요<br/>
	
	<form class="form-horizontal" action="/member/dropOk" method="post">
	
		<div class="form-group">
			<label class="control-label col-sm-2" for="pw">Password:</label>
			<div class="col-sm-5">
				<input type="password" class="form-control" id="pw" placeholder="Enter Password" name="pw">
			</div>
		</div>
		
		<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<span id="drop"><button type="submit" class="btn btn-default">탈퇴하기</button>
					</span>
				</div>
			</div>

	</form>
</div>