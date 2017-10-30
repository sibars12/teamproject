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

	<h2>공지사항</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${cnt }</b> 개의 공지사항이 등록되어있습니다.
	</p>
	<table style="width: 95%">
		<thead>
			<tr>
				<th style="width: 10%">삭제 체크<input id="noticeallcb" type="checkbox"></th>
				<th style="width: 40%">글제목</th>
				<th style="width: 20%">작성자</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
				<tr>
					<td>
						<a> <input class="noticecb" type="checkbox" value="${obj.NUM}"></a>
					</td>
					<td>
					
						<a href="/notice/masterview?num=${obj.NUM}&page=${param.page}">${fn:substring(obj.TITLE, 0, 30) } </a>
					</td>
					<td>${obj.MASTER }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<p align="right" style="margin-right: 30px;">
		<button type="button" id="noticealldel">체크 삭제 </button>
		<a href="/notice/add"><button type="button">공지글작성</button></a>
	</p>
</div>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.page ne 1 }"><a  class="w3-button" href="/notice/masterlist?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/notice/masterlist?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page ne size }"><a class="w3-button" href="/notice/masterlist?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>
<script>
//체크 해서 삭제
$(document).ready(function(){
	$("#noticealldel").click(function(){
		if(!($("input:checkbox[class=noticecb]").is(":checked"))){
				
	        alert("체크목록이 없습니다.확인해주세요.");
		}else{
		var dnum = "";
		$('.noticecb:checked').each(function(idx) { 
	    	if(idx!=0)
	    		dnum+=",";
	    	dnum+=$(this).val();
		});
		if(confirm("정말 삭제하시겠습니까??")){
			console.log(dnum);
			$.get("/notice/checkdel",{"dnum":dnum},function(data){
				if(data=="YY"){
					alert("삭제되었습니다");
				}
			});
			location.href="/notice/masterlist";
		}
	}
	})
});
//전체선택 /취소
$("#noticeallcb").change(function(){
	$(".noticecb").prop("checked", $("#noticeallcb").prop("checked") );
});
//체크박스 전부선택시 전체선택 온/아닐시 오프
$(".noticecb").change(function(){
		var ab=$(".noticecb").length;
		var ac=$(".noticecb:checked").length;
	if(ab==ac){
		$("#noticeallcb").prop("checked", true);
	}else{
			$("#noticeallcb").prop("checked", false);
		 }
});
</script>
