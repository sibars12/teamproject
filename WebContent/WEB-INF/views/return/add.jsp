<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center" style="line-height: 35px">

	<h2>반품 신청</h2>
	
	<div align="left" style="width: 80%;">
	
		
		<form action="/return/add" method="post" enctype="multipart/form-data">
			<p>
				<b>제목</b><br /> <input type="text"  name="title" placeholder="반품 신청 제목"
					autocomplete="off" style="width: 100%;" required/>
			</p>
			<p>
				<b>반품 내용</b><br/>
			<textarea title="asd" id="summernote" name="content" 
					style="width: 100%;"></textarea>
			</p>
			<input type="hidden" name="writer" value="${auth}">
			<p>
				<div align="left" style="width: 700;" class="mar">
		
		</div>
			<p>
				<button type="submit" id="eventaddbt">반품 등록</button>
				<button type="reset">재작성 </button>
				<a href="/return/list?page=1"><button type="button">목록으로</button></a>
			</p>
		</form>
		
	</div>
</div>
<script>
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
	

//내부 파일 업로드
function sendFile(file, el){
	var form_data = new FormData();
	form_data.append('file', file);
	$.ajax({
		data: form_data,
		type: "POST",
		url: '/return/uploadImage',
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
	