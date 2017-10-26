<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div >
  <h2>LOGIN</h2>
  <hr>
  <form class="form-horizontal" action="/member/session" method="post">
    <div class="form-group" >
      <label class="control-label col-sm-2" for="id">ID:</label>
      <div class="col-sm-5">
        <input type="text" class="form-control" id="id" placeholder="Enter ID" name="id">
      </div>
    </div>
    <div class="form-group">
      <label class="control-label col-sm-2" for="pw">Password:</label>
      <div class="col-sm-5">
        <input type="password" class="form-control" id="pw" placeholder="Enter password" name="pw">
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <div class="checkbox">
          <label><input type="checkbox" name="keep" value="keep" id="keep" onchange="javascript:keeps()"> Remember me</label>
        </div>
      </div>
    </div>
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">Login</button>
      </div>
    </div>
  </form>
</div>


<!-- 로그인 유지 -->
<script>
	function keeps() {
		var k = document.getElementById("keep")
		var check=false;
		if(k.checked == true) {
			if(window.confirm("로그인을 유지하시겠습니까?")) {
				document.getElementById("keep").checked==true;
				check=true;
			}
			
		}
	}
</script>








