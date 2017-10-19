<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	input{
		margin: 10;
		padding: 5;
	}
	a{
		cursor: pointer;
		margin:3;
	}
	.mar{
		margin: 20;
	}
	.seleted{
	}
	.thead{
		background-color: rgb(181,222,244);
		font-weight: bold;
	}
	#stock_D{
		min-height: 300;
	}
	h2{
		margin: 20;
	}
	#schStock_I{
		margin: 3;
		padding: 3;
	}
</style>
<c:if test="${addResult!=null }">
	<c:choose>
		<c:when test="${addResult }">
			<script>
				if(confirm("등록되었습니다.\n확인하시겠습니까?")){
					location.href="/product/list";
				}
			</script>
		</c:when>
		<c:otherwise>
			<script>alert("오류가 발생했습니다");</script>
		</c:otherwise>
	</c:choose>
</c:if>
<div align="center">
	<h2>상품 등록</h2>
	<div id="stock_D">
		<select id="schOption_S">
			<option value="ownernumber">상품번호</option>
			<option value="type">분류</option>
			<option value="name" selected>상품명</option>
			<option value="comp">제조사</option>
			<option value="subname">추가사항</option>
		</select>
		<input type="text" id="schName_I" onkeypress="javascript : if (event.keyCode == 13) schKey();">
		<input type="hidden" id="schValueSave_I">
		<input type="hidden" id="schOptionSave_I">
		<table id="stock_T" style="border-collapse: collapse;">
			<thead>
			<tr height="40" align="center" class="thead">
				<td width="110">상품번호</td>
				<td width="110">분류</td>
				<td width="140">상품명</td>
				<td width="150">제조사</td>
				<td width="110">사이즈</td>
				<td width="110">색상</td>
				<td width="110">가격</td>
				<td width="100">수량</td>
				<td width="110">추가사항</td>
			</tr>
			</thead>
			<tbody>
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
			</tbody>
		</table>
	</div>
	<p id="stockPage_P">
		<c:forEach var="idx" begin="1" end="${page/10+1}">
			<a class="page_A">${idx}</a>
		</c:forEach>
	</p>
	<form action="/product/addProduct" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ownernumber" id="productOwnernumber_I">
		<input type="text" placeholder="제목" class="mar" id="productTitle_I" name="name"><br/>
		<img src="/images/basic.jpg" id="pre" alt="기본이미지" style="width:200; height:200"/><br/>
		<input type="file" name="imag" id="profile" class="mar"><br/>
		<div align="left" style="width: 700;" class="mar">
			<textarea  id="summernote" name="content"></textarea>
		</div>
		<button type="submit" class="mar">작성</button>
	</form>
</div>

<script>
	document.getElementById("profile").onchange = function(){ // 메인이미지 세팅 및 미리보기
		var reader = new FileReader();
		reader.onload = function(e){
			document.getElementById("pre").src = e.target.result;
		}
		reader.readAsDataURL(this.files[0]);
	}
	
	$(document).ready(function(){
		$('#summernote').summernote({ // 노트
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
		
		$(".page_A").click(function(){ // 페이지 이동할 때 테이블 세팅하는 함수
			var pageNum = $(this).text();
			$.get("/product/getPageList", {"page":pageNum}, function(data){
				makeTableHtml(data);
			});
		});
		select_F();
	});
	
	function sendFile(file, el){ // note안에서 이미지 넣을 때 파일 보내는 함수
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
	
	var select_F = function(){ //선택,제목바꾸는 함수 지정
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
	}
	
	var schKey = function(){ // 검색했을 때 테이블 세팅하는 함수
		var schValue = $("#schName_I").val();
		var schOption = $("#schOption_S").val();
		$("#schValueSave_I").val(schValue);
		$("#schOptionSave_I").val(schOption);
		$.get("/product/getSchList", {"option":schOption,"value":schValue}, function(data){
			makeTableHtml(data);
		});
		$.get("/product/getSchPage",{"option":schOption, "value":schValue},function(data){
			var html="";
			for(var i=1;i<=data;i++){
				html+="<a class=\"schPage_A\">"+i+"</a>";
			}
			$("#stockPage_P").html(html);

			$(".schPage_A").click(function(){ // 검색한 후 페이지 이동했을 때 테이블 세팅하는 함수
				var schPage = $(this).text().trim();
				var schValue = $("#schValueSave_I").val();
				var schOption = $("#schOptionSave_I").val();
				$.get("/product/getSchList",{"option":schOption, "value":schValue, "page":schPage},function(data){
					makeTableHtml(data);
				});
			});
		});
	}
	
	
	var makeTableHtml = function(data){ // 테이블 세팅 함수
		var html = "";
		for(idx in data){
			html += "<tr align=\"center\"><td class=\"productOwnernumber\">"+data[idx].OWNERNUMBER+"</td>"
					+ "<td>"+data[idx].TYPE+"</td>"
					+ "<td class=\"productName\">"+data[idx].NAME+"</td>"
					+ "<td class=\"productComp\">"+data[idx].COMP+"</td>"
					+ "<td class=\"productScale\">"+data[idx].SCALE+"</td>"
					+ "<td>"+data[idx].COLOR+"</td>"
					+ "<td>"+data[idx].PRICE+"</td>"
					+ "<td>"+data[idx].VOLUME+"</td>"
					+ "<td>"+(data[idx].SUBNAME==null ? '' : data[idx].SUBNAME)+"</td></tr>";
		}
		$("tbody").html(html);
		select_F();
	}
</script>