<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center" style="line-height: 35px">

	<h2>이벤트</h2>
	
	<div align="left" style="width: 80%;">
	
		
		<form action="/master/eventadd" method="post" enctype="multipart/form-data">
			<p>
				<b>이벤트 제목</b><br /> <input type="text"  name="title" placeholder="이벤트 제목"
					autocomplete="off" style="width: 100%;" required/>
			</p>
			<p>
				<b>이벤트 내용</b><br/>
			<textarea  id="summernote" name="content"placeholder="이벤트 내용" required 
					style="width: 100%;"></textarea>
			</p>
			<p>
			<b>시작일</b><br/>
			  <input type="date" name="startdate" id="startdate" class="eventtime" required />
			</p>
			<p>
			<b>마감일</b><br/>
			  <input type="date" name="enddate" id="enddate" class="eventtime" required/>
			</p>
			<p>
			<b>대표이미지</b><br/>
			<input type="file" name="eventimg" id="profile" required/>
			<img  id="pre" alt="기본이미지" style="width:200; height:200"/><br/>
			</p>
			<div align="left" style="width: 700;" class="mar">
		
		</div>
			<p>
			<span id="eventaddcheck"></span>
				<button type="submit" id="eventaddbt">이벤트 등록</button>
				<button type="reset">재작성 </button>
				<a href="/master/eventlist?page=1"><button type="button">목록으로</button></a>
			</p>
		</form>
		
	</div>
</div>
<script>
//메인 파일 업로드
document.getElementById("profile").onchange = function(){
	
	var reader = new FileReader();
	reader.onload = function(e){
		document.getElementById("pre").src = e.target.result;
	}
	reader.readAsDataURL(this.files[0]);
}
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
	

//내부 파일 업로드
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

//시작일 마감일 체크
$(".eventtime").change(function(){
	if($('#startdate').val() <= $('#enddate').val()){
		$("#eventaddbt").removeAttr("disabled");

	}else{
		
		$("#eventaddbt").attr("disabled",true); 
	}
});
</script>
	