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
		<table class="w3-table-all w3-margin-top" >
		<tr>
		<th style="width: 10%">체크<br/><input id="inquireallcb" type="checkbox" ></th>
		<th style="width: 10%;">아이디</th>
		<th style="width: 10%;">이름</th>
		<th style="width: 30%;">문의 내용</th>
		<th style="width: 20%;">문의한 날자</th>
		<th style="width: 10%;">상품번호</th>
		</tr>
		<c:forEach var="obj" items="${list }" >
		<tr>
			<td>
			<input class="inquirecb" type="checkbox" value="${obj.NUM }"/>
			</td>
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
							<form action="/inquire/reply" method="post">
							<input type="hidden" name="num" value="${obj.NUM }">
							<input type="text" name="reply" placeholder="답글" required/>
							<button type="submit">답글 달기</button>
							</form>
						</div>
						</td>
						<td><p><fmt:formatDate
							pattern="yyyy.MM.dd " value="${obj.INDATE }" /></p>
							</td>
							<td>${obj.OWNERNUMBER }</td>
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
	function reply(id){
		var x = document.getElementById(id).value;
		
	}
	</script>
</div>
	<button id="inmsbt" class="plist_B">체크된 목록 삭제</button>

<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.page gt 1 }"><a  class="w3-button" href="/inquire/master?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/inquire/master?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page lt size }"><a class="w3-button" href="/inquire/master?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>
<script>
$(document).ready(function(){
	// 문의글  버튼클릭 -> 삭제
	$("#inmsbt").click(function(){
		var dnum = "";
		$('.inmscb:checked').each(function(idx) { 
	    	if(idx!=0)
	    		dnum+=",";
	    	dnum+=$(this).val();
		});
		if(confirm("정말 삭제하시겠습니까??")){
			console.log(dnum);
			$.get("/inquire/msdel",{"dnum":dnum},function(data){
				if(data=="YY"){
					alert("삭제되었습니다");
					location.href="/inquire/master?page=1";
				}
			});
		}
	});
	
});
//전체선택 /취소
$("#inquireallcb").change(function(){
	$(".inquirecb").prop("checked", $("#inquireallcb").prop("checked") );
});
//체크박스 전부선택시 전체선택 온/아닐시 오프
$(".inquirecb").change(function(){
		var ab=$(".inquirecb").length;
		var ac=$(".inquirecb:checked").length;
	if(ab==ac){
		$("#inquireallcb").prop("checked", true);
	}else{
			$("#inquireallcb").prop("checked", false);
		 }
});
</script>

