<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center" style="line-height: 35px">

	<h2>문의</h2>
	
	<div align="left" style="width: 80%;">
	
		
		<form action="/inquire/add" method="post" enctype="multipart/form-data">
			<p>
			<!-- 나중에 히든으로변경 -->
			<input type="text" name="id" >
			</p>	
			<p>
				<b>이름</b> <input type="text" style="width:20%; " name="name" placeholder="이름"
					 required/>
			
			
				<b>비밀번호</b> <input type="password" style="width: 20%;" name="pass" placeholder="비밀번호" maxlength="4"
					 required/>
			</p>
			
			<p>
				<b>문의 내용</b><br/>
			<textarea  id="summernote" name="content"placeholder="문의 내용" required 
					style="width: 100%;"></textarea>
			</p>
			<input type="hidden" name="ownernumber" value="${ownernumber }">
			<p>
				<button type="submit" >문의 등록</button>
				<button type="reset">재작성 </button>
				<a href="/inquire/list?page=1&ownernumber=${ownernumber }"><button type="button">목록으로</button></a>
			</p>
		</form>
		
	</div>
</div>
<script>
//내부 텍스트에리 업로드
$(document).ready(function(){
	$('#summernote').summernote({
		height: 300,
		width: 700,
		callbacks:{
			onImageUpload: function(files, editor, welEditable){
				for(var i=files.length -1; i>=0;i--){
					sendFile(files[i], this);
				}
			}
		},
	});
	$("tr").hover(function(){
		$(this).not(".selected, .thead").css({"background-color":"rgb(230,230,230)","cursor":"pointer"});
	},function(){
		$(this).not(".selected, .thead").css("background-color","white");
	});
	
	$("tr").click(function(){
		var value = "[" + $(this).children("td.productComp").text() + "] " + $(this).children("td.productName").text() + " " + $(this).children("td.productScale").text();
		$("#productTitle_I").val(value);
		$("#productOwnernumber_I").val($(this).children("td.productOwnernumber").text());
		
		$(this).not(".thead").addClass("selected").css("background-color","pink");
		
		$(this).siblings().not(".thead").removeClass("selected").css("background-color","white");
	});
	
});
	

//-내부 파일 업로드
function sendFile(file, el){
	var form_data = new FormData();
	form_data.append('file', file);
	$.ajax({
		data: form_data,
		type: "POST",
		url: '/event/uploadImage',
		cache: false,
		contentType: false,
		enctype: 'multipart/form-data',
		processData: false,
		success: function(url){
			$(el).summernote('editor.insertImage', url);
			$('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
		}
	});
}

</script>
	