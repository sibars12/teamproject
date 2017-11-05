<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="container">
	<h3>후기 관리</h3>
	<div id="search_Div">
		<select id="schMode">
			<option value="pname">상품명</option>
			<option value="ownernumber">상품번호</option>
			<option value="id">아이디</option>
		</select>
		<input type="text" id="schKey">
		<button id="sch_B">검색</button>
	</div>
	<br>
	<div id="table_Div">
		<table class="table table-hover">
			<tr>
				<th><input type="checkbox" id="allcheck"></th>
				<th>올린날짜</th>
				<th>상품번호</th>
				<th>상품명</th>
				<th>id</th>
				<th>score</th>
				<th>content</th>
			</tr>
				<c:forEach var="i" items="${list }">
					<tr>
						<td><input type="checkbox" class="checks" value="${i.NO }"></td>
						<td><fmt:formatDate value="${i.ADDDATE }" pattern="yyyy-MM-dd"/></td>
						<td>${i.OWNERNUMBER }</td> 
						<td>${i.PNAME }</td>
						<td>${i.ID }</td>
						<td>${i.SCORE }</td>
						<td>${i.CONTENT }</td>
					</tr>
				</c:forEach>
		</table>
	</div>
	<div align="right">
		<button type="button" id="delete_B">삭제</button>
		<a href="/master/reviewList_Master"><button type="button">목록으로</button></a>
	</div>
	<div align="center" id="paging">
	<c:if test="${startPage-1!=0}"><a  class="w3-button" href="/master/reviewList_Master?page=${startPage-1 }">&laquo;</a></c:if>
	<c:set var="idx" value="${empty param.page ?1: param.page}"/>
		<c:forEach var="n" begin="${startPage }" end="${endPage }" varStatus="vs">
			<c:choose>
				<c:when test="${n ne idx }">
					<a href="/master/reviewList_Master?page=${n }"> <b>${n }</b>
					</a>
				</c:when>
				<c:otherwise>
					<b style="color: red">${n }</b>
				</c:otherwise>
			</c:choose>
		</c:forEach>		
		<c:if test="${endPage%5==0 && pageCount>endPage }"><a class="w3-button" href="/master/reviewList_Master?page=${endPage+1 }">&raquo;</a></c:if>
		<c:if test="${endPage%5!=0 && endPage==pageCount }"></c:if>
	</div>
</div>

<script>
// 전체 선택
$("#allcheck").change(function(){
	if($("#allcheck:checked")){
		$(".checks").prop("checked",true);
	}else{
		$(".checks").prop("checked",false);
	}
});
// 체크박스 선택
$(".checks").change(function(){
	if($("#allcheck").prop("checked")){
		if($(this).prop("checked",false)){
			$("#allcheck").prop("checked",false);	
		}
	}
	else{
		if($(".checks:checked").length==5){
			$("#allcheck").prop("checked",true);
		}
	}
});

// 선택 삭제
$("#delete_B").click(function(){
	var arr ="";
	$(".checks:checked").each(function(i){
		if(i!=0) arr += ",";
		arr += $(this).val();
	});
	if(confirm("삭제 하시겠습니까?")){
		console.log(arr);
		$.ajax({
			"type":"post",
			"url":"/master/deleteReview",
			"data":{
				"arr":arr,
			}
		}).done(function(rst){
			window.alert(rst);
			location.href="/master/reviewList_Master";
		});		
	}	
});

// 검색용 함수
function search(p){
	if($("#schKey").val().length==0){
		window.alert("검색어를 입력해주세요");
		return;
	}
	$.ajax({
		"type":"get",
		"url":"/master/searchReview",
		"data":{
			"mode":$("#schMode").val(),
			"key":$("#schKey").val(),
			"page":p,
			"startPage":1,
		}		
	}).done(function(obj){
		var schList="<table class=\"table table-hover\"><tr><th><input type=\"checkbox\" id=\"allcheck\"></th><th>올린날짜</th>	<th>상품번호</th>";
		schList += "<th>상품명</th><th>id</th><th>score</th><th>content</th></tr>";
		for(i in obj.schlist){
			schList += "<tr><td><input type=\"checkbox\" class=\"checks\" value=\""+obj.schlist[i].NO+"\"></td>";
			schList += "<td>"+obj.schlist[i].ADDDATE +"</td>";
			schList += "<td>"+obj.schlist[i].OWNERNUMBER +"</td><td>"+obj.schlist[i].PNAME+"</td>"
			schList +=	"<td>"+obj.schlist[i].ID +"</td>";
			schList += "<td>"+obj.schlist[i].SCORE +"</td><td>"+obj.schlist[i].CONTENT +"</td></tr>";
		}
		schList += "</table>"
		 $("#table_Div").html(schList);
		
		//페이지 번호 처리
		var pages = "";
		if((obj.startPage-1)!=0){
			pages += "<a class=\"w3-button\" href=\"javascript:search("+(obj.startPage-1)+")\">&laquo;</a>"
		}
		for(var i=obj.startPage; i<=obj.endPage; i++){
			if(i != obj.page){
				pages += "&nbsp;<a href=\"javascript:search("+i+")\"><b>"+i+"</b></a>";
			}else{
				pages += "&nbsp;<b style=\"color:red\">"+i+"</b>";
			}
		}
		if(obj.endPage%5==0 && obj.pageCount>obj.endPage){
			pages += "<a class=\"w3-button\" href=\"javascript:search("+(obj.endPage+1)+")\">&raquo;</a>"
		}
		$("#paging").html(pages);
		
		// 체크박스 선택
		$("#allcheck").change(function(){
			if($("#allcheck:checked")){
				$(".checks").prop("checked",true);
			}else{
				$(".checks").prop("checked",false);
			}
		});
		// 체크박스 선택
		$(".checks").change(function(){
			if($("#allcheck").prop("checked")){
				if($(this).prop("checked",false)){
					$("#allcheck").prop("checked",false);	
				}
			}
			else{
				if($(".checks:checked").length==5){
					$("#allcheck").prop("checked",true);
				}
			}
		});
	});	
}

//검색버튼 누름
$("#sch_B").click(function(){
	console.log($("#schMode").val());
	search(1);	
	
});

</script>