<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	input{
		margin: 10;
		padding: 5;
	}
	.mar{
		margin: 20;
	}
	.seleted{
	}
	.thead{
		background-color: rgb(181,222,244);
	}
</style>

<div align="center">
	<h2>상품 등록</h2>
	<table style="border-collapse: collapse;">
		<tr height="40" align="center" class="thead">
			<td width="139">등록된 상품번호</td>
			<td width="110">분류</td>
			<td width="110">상품명</td>
			<td width="110">제조사</td>
			<td width="110">사이즈</td>
			<td width="110">색상</td>
			<td width="110">가격</td>
			<td width="110">수량</td>
			<td width="110">추가사항</td>
		</tr>
		<c:forEach var="obj" items="${list }">
			<tr align="center">
				<td class="productOwnernumber">${obj.OWNERNUMBER}</td>
				<td>${obj.TYPE}</td>
				<td class="productName">${obj.NAME}</td>
				<td class="productComp">${obj.COMP}</td>
				<td class="productScale">${obj.SCALE}</td>
				<td>${obj.COLOR}</td>
				<td>${obj.PRICE}</td>
				<td>${obj.VOLUME}</td>
				<td>${obj.SUBNAME}</td>
			</tr>
		</c:forEach>
	</table>
	<p>
		<c:forEach var="idx" begin="1" end="${page/10+1}">
			<c:choose>
				<c:when test="${sch ne null}">
					<a>${idx }</a>
				</c:when>
				<c:otherwise>
					<a>${idx}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</p>
	<form action="/product/addProduct" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ownernumber" id="productOwnernumber_I">
		<input type="text" placeholder="제목" class="mar" id="productTitle_I" name="name"><br/>
		<img src="/product/basic.jpg" id="pre" alt="기본이미지" style="width:200; height:200"/><br/>
		<input type="file" name="imag" id="profile" class="mar"><br/>
		<div align="left" style="width: 700;" class="mar">
			<textarea  id="summernote" name="content"></textarea>
		</div>
		<button type="submit" class="mar">작성</button>
	</form>
</div>

<script>
	document.getElementById("profile").onchange = function(){
		var reader = new FileReader();
		reader.onload = function(e){
			document.getElementById("pre").src = e.target.result;
		}
		reader.readAsDataURL(this.files[0]);
	}
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
		
		$("a").click(function(){
			
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
	
	function sendFile(file, el){
		var form_data = new FormData();
		form_data.append('file', file);
		$.ajax({
			data: form_data,
			type: "POST",
			url: '/product/uploadImage',
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