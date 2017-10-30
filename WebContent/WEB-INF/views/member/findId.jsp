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
      <label class="control-label col-sm-2" for="tel">Tel : </label> 
      <div class="col-sm-5">          
        <input type="text" class="form-control" id="tel" name="tel">
      </div>
    </div>
    
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">FIND</button>
        <a href="home"><button type="button" class="btn btn-default">CANCEL</button></a>
      </div>
    </div>
	
</form>