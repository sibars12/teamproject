<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div align="center" style="line-height: 35px">

	<h2>문의 한목록</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${incnt }</b> 개의 문의가 등록되어 있습니다.
	</p>
	<div class="w3-container">
		<table class="w3-table-all w3-margin-top" >
		<tr>
		<th style="width: 20%;">아이디</th>
		<th style="width: 20%;">이름</th>
		<th style="width: 40%;">문의 내용</th>
		<th style="width: 20%;">문의한 날자</th>
		</tr>
		<c:forEach var="obj" items="${inlist }" >
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
							${obj.CONTENT }
							</button>
						<div id="memo${obj.NUM}" class="w3-container w3-hide">
							<p>${obj.TITLE }</p>
							<input type="hidden" id="truepass${obj.NUM }" value="${obj.PASS }"/>
							<input type="password" placeholder="비밀번호"
							 id="${obj.NUM }" onkeyup="passcheck(${obj.NUM })"
							 maxlength="4"/>
							<a href="/inquire/del?num=${obj.NUM }&ownernumber=${obj.OWNERNUMBER}">
							<button id="del${obj.NUM }" disabled="disabled" type="button">삭제</button></a>
						</div>
						</td>
						<td><p><fmt:formatDate
							pattern="yyyy.MM.dd " value="${obj.INDATE }" /></p></td>
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
</div>


<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.inpage gt 1 }"><a  class="w3-button" href="/mypage/board?inpage=${param.inpage-1 }&repage=${param.repage}&auth=${auth}">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${insize}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.inpage }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/mypage/board?inpage=${i}&repage=${param.repage}&auth=${auth}" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.inpage lt insize }"><a class="w3-button" href="/mypage/board?inpage=${param.inpage+1 }&repage=${param.repage}&auth=${auth}">&raquo;</a></c:if>
  </div>

</div>
<!--  =================== -->
<div align="center" style="line-height: 35px">
<div class="w3-container">
	<h2>반품 신청 한 목록 </h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${recnt }</b> 개의 반품 신청이  등록되어있습니다.
	</p>
	<table style="width: 95%">
		<thead>
			<tr>
				
				<th style="width: 40%">글제목</th>
				<th style="width: 20%">작성자</th>
				<th style="width: 20%">작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${relist }">
				<tr>
					<td>
						<a href="/return/view?num=${obj.NUM}">${fn:substring(obj.TITLE, 0, 12) } </a>
					</td>
					<td>${obj.WRITER }</td>
					<td>${obj.WRITEDATE }
					</td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</div>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.repage gt 1 }"><a  class="w3-button" href="/mypage/board?inpage=${param.inpage }&repage=${param.repage-1}&auth=${auth}">&laquo;</a></c:if>
  <c:forEach var="ii" begin="1" end="${resize}" varStatus="vs">
			<c:choose>
				<c:when test="${ii eq param.repage }">
					<a class="w3-button" class="active">${ii }</a>
				</c:when>
				<c:otherwise>
					<a href="/mypage/board?inpage=${param.inpage }&repage=${ii}&auth=${auth}" class="w3-button"
						><b style="color: #9c9892;">${ii }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.repage lt resize }"><a class="w3-button" href="/mypage/board?inpage=${param.inpage }&repage=${param.repage+1}&auth=${auth}">&raquo;</a></c:if>
</div>

</div>