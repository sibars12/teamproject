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

	<h2>이벤트</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${cnt }</b> 개의 이벤트가 진행중입니다.
	</p>
	<table style="width: 95%">
		<thead>
			<tr>
				<th style="width: 10%">삭제 체크<input id="eventallcb" type="checkbox"></th>
				<th style="width: 40%">이벤트 목록</th>
				<th style="width: 20%">시작일</th>
				<th style="width: 20%">마감일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
				<tr>
					<td>
						<a> <input class="eventcb" type="checkbox" value="${obj.NUM}"></a>
					</td>
					<td>
					
						<a href="/master/eventview?num=${obj.NUM}&page=${param.page}"><img width="100" height="100" src="/event/eventimg/${obj.EVENTIMG }"></a>
					</td>
					<td>
						<p><fmt:formatDate
							pattern="yyyy.MM.dd " value="${obj.STARTDATE }" /></p>
					</td>
					<td>
						<p><fmt:formatDate
							pattern="yyyy.MM.dd " value="${obj.ENDDATE }" /></p>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<p align="right" style="margin-right: 30px;">
		<button type="button" id="eventdel">체크 삭제 </button>
		<a href="/master/eventadd"><button type="button">이벤트 작성</button></a>
	</p>
</div>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.page gt 1 }"><a  class="w3-button" href="/master/eventlist?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/master/eventlist?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page lt size }"><a class="w3-button" href="/master/eventlist?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>

<script>
//체크 해서 삭제
$(document).ready(function(){
	$("#eventdel").click(function(){
		if(!($("input:checkbox[class=eventcb]").is(":checked"))){
				
	        alert("체크목록이 없습니다.확인해주세요.");
		}else{
		var dnum = "";
		$('.eventcb:checked').each(function(idx) { 
	    	if(idx!=0)
	    		dnum+=",";
	    	dnum+=$(this).val();
		});
		if(confirm("정말 삭제하시겠습니까??")){
			console.log(dnum);
			$.get("/master/eventcheckdel",{"dnum":dnum},function(data){
				if(data=="YY"){
					alert("삭제되었습니다");
			 location.href="/master/eventlist";
				}
			});
		}
	}
	})
});
//전체선택 /취소
$("#eventallcb").change(function(){
	$(".eventcb").prop("checked", $("#eventallcb").prop("checked") );
});
//체크박스 전부선택시 전체선택 온/아닐시 오프
$(".eventcb").change(function(){
		var ab=$(".eventcb").length;
		var ac=$(".eventcb:checked").length;
	if(ab==ac){
		$("#eventallcb").prop("checked", true);
	}else{
			$("#eventallcb").prop("checked", false);
		 }
});

</script>
