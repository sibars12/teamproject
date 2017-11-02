<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div>
	
	<h1>비밀번호 변경</h1>
	<hr>
	
	<form action="/member/changePwOk" method="post">
		
		<div class="form-group">
			<label class="control-label col-sm-2" for="pw">Password : </label>
			<div class="col-sm-5">
				<input type="password" class="form-control" id="pw" placeholder="Enter Password" name="pw"> 
				<input type="password" class="form-control" id="pw2" placeholder="Enter Password" name="pw2"> 
				<span id="checkPass"></span>
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" class="btn btn-default" id="changePw" name="changePw">변경</button>
			</div>
		</div>
		
	</form>
	
</div>

<script>

	//비밀번호 일치 여부
	document.getElementById("pw2").onblur = function() {
		var pass = document.getElementById("pw").value;
		var pass2 = document.getElementById("pw2").value;
		console.log(pw);
		console.log(pw2);
		if (this.value == pass) {
			document.getElementById("checkPass").innerHTML = "<b style=\"color:green\">일치</b>"
		} else {
			document.getElementById("checkPass").innerHTML = "<b style=\"color:red\">불일치</b>"
		}
	}

</script>