<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h1>아이디찾기</h1>
<hr>

<form class="form-horizontal" action="/member/findIdOk" method="post">

	<div class="form-group">
      <label class="control-label col-sm-2" for="name">Name : </label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" id="name" name="name">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="birth">Birth : </label> 
      <div class="col-sm-5">          
        <input type="date" class="form-control" id="birth" name="birth">
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


<script>

// 빈칸 X
$(document).ready(function(){
	$("#submit").click(function(){
		if($("#name").val().length==0){alert("이름을 입력하세요"); $("#name").focus(); return false;}
		if($("#birth").val().length==0){alert("생년월일을 입력하세요"); $("#birth").focus(); return false;}
		if($("#email").val().length==0){alert("이메일을 입력하세요"); $("#email").focus(); return false;}
	})
})


</script>





