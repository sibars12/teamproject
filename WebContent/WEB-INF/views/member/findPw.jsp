<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div>

	<h1>비밀번호 찾기</h1>
	<hr>

	<form class="form-horizontal" action="/member/findPwRst" method="post">

		<div class="form-group">
			<label class="control-label col-sm-2" for="id">ID : </label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="id" placeholder="Enter ID" name="id">
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="email">Email : </label>
			<div class="col-sm-7">
				<input type="email" class="form-control" id="email" placeholder="Enter Email" name="email">
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="submit" class="btn btn-default">FIND</button>
				 <a href="/member/login"><button type="button" class="btn btn-default">CANCEL</button></a>
			</div>
		</div>

	</form>

</div>



<script>

// 빈칸 X
$(document).ready(function(){
	$("#submit").click(function(){
		if($("#id").val().length==0){alert("ID를 입력하세요"); $("#id").focus(); return false;}
		if($("#email").val().length==0){alert("Email을 입력하세요"); $("#email").focus(); return false;}
	})
})


</script>
