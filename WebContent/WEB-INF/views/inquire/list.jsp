<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
th {
	border-bottom: 1px solid;
	text-align: left;
}
th, td {
	padding: 10px;
}
</style>
<div align="center" style="line-height: 35px">

	<h2>문의</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${cnt }</b> 개의 문의가 등록되어 있습니다.
	</p>
	<div class="w3-container">
		<table class="w3-table-all w3-margin-top" id="nn">
		<tr>
		<th style="width: 20%;">아이디</th>
		<th style="width: 20%;">이름</th>
		<th style="width: 60%;">문의 제목</th>
		</tr>
		<c:forEach var="obj" items="${list }" begin="0" end="4">
		<tr>
					<td>
					<p>${obj.ID }</p>
					</td>
					<td>
					<p>${obj.NAME }</p>
					</td>
					<td>
					<button onclick="inquire('memo${obj.NUM}')"
							class="w3-btn w3-block w3-black w3-left-align">
							
							${fn:substring(obj.TITLE, 0, 12) }
							
							</button>
						<div id="memo${obj.NUM}" class="w3-container w3-hide">
							<p>${obj.CONTENT }</p>
							<input type="hidden" id="truepass${obj.NUM }" value="${obj.PASS }"/>
							<input type="password" id="${obj.NUM }" onkeyup="passcheck(${obj.NUM });" maxlength="4"/>
							<a href="/inquire/del?num=${obj.NUM }&ownernumber=${obj.OWNERNUMBER}">
							<button id="del${obj.NUM }" disabled="disabled" type="button">삭제</button></a>
						</div>
						</td>
				</tr>
		</c:forEach>
				</table>
	</div>

	<script>
	//클릭시 내용나오게
		function inquire(id) {
			var x = document.getElementById(id);
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}
	//비밀번호 맞으면 버튼 on
		function passcheck(z){
			var x = document.getElementById(z).value;
			var y = document.getElementById("truepass"+z).value;
			if(x==y){
				$("#del"+z).removeAttr("disabled");
			}else{
				$("#del"+z).attr("disabled",true); 
			}
		}
	</script>
	<p align="right" style="margin-right: 30px;">
	
		<a href="/inquire/add"><button type="button">문의글 작성</button></a>
	</p>
</div>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.page ne 1 }"><a  class="w3-button" href="/inquire/list?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/inquire/list?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page ne size }"><a class="w3-button" href="/inquire/list?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>
