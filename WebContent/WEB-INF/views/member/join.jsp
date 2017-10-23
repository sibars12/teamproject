<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>


<div>
  <h2>JOIN</h2>
  <hr>
  <form class="form-horizontal" action="/member/login" method="post">
  
  	<div class="form-group">
      <label class="control-label col-sm-2" for="id">ID : </label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" id="id" placeholder="Enter ID" name="id">
          <span id="checkId"></span>
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="pw">Password : </label>
      <div class="col-sm-5">          
        <input type="password" class="form-control" id="pw" placeholder="Enter Password" name="pw">
        <input type="password" class="form-control" id="pw2" placeholder="Enter Password" name="pw2">
          <span id="checkPass"></span>
      </div>
    </div>
  	
    <div class="form-group">
      <label class="control-label col-sm-2" for="email">Email : </label>
      <div class="col-sm-7">
        <input type="email" class="form-control" id="email" placeholder="Enter Email" name="email">
          <span id="checkEmail"></span>
      </div>
    </div>
    
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">JOIN</button>
      </div>
    </div>
  </form>
</div>

</body>
</html>

<script>
	//ID 중복확인
	document.getElementById("id").onblur = function() {
		if(this.value.length != 0) {
			var xhr = new XMLHttpRequest();
			var ids = document.getElementById("id").value;
			console.log(ids);
			xhr.open("post", "/member/signup_check/id", true);
			xhr.send(ids);
			
			xhr.onreadystatechange = function() {
				if(this.readyState == 4) {
					if(this.responseText.trim() =="false") {
						document.getElementById("checkId").innerHTML = "<b style=\"color:green\">사용가능 ID</b>"
					} else {
						document.getElementById("checkId").innerHTML = "<b style=\"color:red\">사용불가능 ID</b>"
					}
				}
			}
		}
	}
	//이메일 사용가능 확인
	document.getElementById("email").onblur = function() {
		if(this.value.length != 0) {
			var email = document.getElementById("email").value;
			var xhr = new XMLHttpRequest();
			console.log(email);
			xhr.open("post", "/member/signup_check/email", true);
			xhr.send(email);
			xhr.onreadystatechange = function() {
				if(this.readyState == 4) {
					if(this.responseText.trim() == "false") {
						document.getElementById("checkEmail").innerHTML = "<b style=\"color:green\">사용가능 Email</b>"
						document.getElementById("sbt").disabled = false;
					}else {
						document.getElementById("checkEmail").innerHTML = "<b style=\"color:red\">사용불가능 Email</b>"
					}
				}
			}
		}
	}
	
	//비밀번호 확인
	document.getElementById("pw2").onblur = function() {
		var pass = document.getElementById("pw").value;
		var pass2 = document.getElementById("pw2").value;
		console.log(pw);
		console.log(pw2);
		if(this.value == pass) {
			document.getElementById("checkPass").innerHTML = "<b style=\"color:blue\">일치</b>"
		} else {
			document.getElementById("checkPass").innerHTML = "<b style=\"color:red\">불일치</b>"
		}
	}
</script>







