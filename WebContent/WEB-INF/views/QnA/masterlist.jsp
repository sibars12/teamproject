<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

		<h2>질문 게시판-master</h2>
		
		
		<table class="w3-table-all w3-margin-top" id="myTable">
			<tr>
				<th style="width: 10%">삭제 체크<input id="QnAallcb" type="checkbox"></th>
				<th style="width: 60%;">질문</th>
			</tr>
			<c:forEach var="obj" items="${list }">
				<tr >
				<td>
						<a> <input class="QnAcb" type="checkbox" value="${obj.NUM}"></a>
					</td>
					<td><button onclick="ansers('Demos${obj.NUM}')"
							class="w3-btn w3-block w3-blue w3-left-align">${fn:substring(obj.TITLE, 0, 12) }</button>
						<div id="Demos${obj.NUM}" class="w3-container w3-hide">
							<p>${obj.CONTENT }</p>
							<a href="/QnA/change?num=${obj.NUM }"><button type="button">수정</button></a>
						</div></td>
				</tr>
			</c:forEach>

		</table>
<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.page ne 1 }"><a  class="w3-button" href="/QnA/masterlist?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/QnA/masterlist?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page ne size }"><a class="w3-button" href="/QnA/masterlist?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>

	<script>
	//체크 해서 삭제
	$(document).ready(function(){
		$("#QnAdel").click(function(){
			if(!($("input:checkbox[class=QnAcb]").is(":checked"))){
					
		        alert("체크목록이 없습니다.확인해주세요.");
			}else{
			var dnum = "";
			$('.QnAcb:checked').each(function(idx) { 
		    	if(idx!=0)
		    		dnum+=",";
		    	dnum+=$(this).val();
			});
			if(confirm("정말 삭제하시겠습니까??")){
				console.log(dnum);
				$.get("/QnA/checkdel",{"dnum":dnum},function(data){
					if(data=="YY"){
						alert("삭제되었습니다");
					}
				});
				location.href="/QnA/masterlist";
			}
		}
		})
	});
	
	
		function myFunction() {
			var input, filter, table, tr, td, i;
			input = document.getElementById("myInput");
			filter = input.value.toUpperCase();
			table = document.getElementById("myTable");
			tr = table.getElementsByTagName("tr");
			for (i = 0; i < tr.length; i++) {
				td = tr[i].getElementsByTagName("td")[0];
				if (td) {
					if (td.innerHTML.toUpperCase().indexOf(filter) > 0) {
						tr[i].style.display = "";
					} else {
						tr[i].style.display = "none";
					}
				}
			}
		}
		function anser(id) {
			var x = document.getElementById(id);
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}
		function ansers(id) {
			var x = document.getElementById(id);
			if (x.className.indexOf("w3-show") == -1) {
				x.className += " w3-show";
			} else {
				x.className = x.className.replace(" w3-show", "");
			}
		}
		//전체선택 /취소
		$("#QnAallcb").change(function(){
			$(".QnAcb").prop("checked", $("#QnAallcb").prop("checked") );
		});
		//체크박스 전부선택시 전체선택 온/아닐시 오프
		$(".QnAcb").change(function(){
				var ab=$(".QnAcb").length;
				var ac=$(".QnAcb:checked").length;
			if(ab==ac){
				$("#QnAallcb").prop("checked", true);
			}else{
					$("#QnAallcb").prop("checked", false);
				 }
		});

	</script>
	<button type="button" id="QnAdel">체크 삭제 </button>
	<a href="/QnA/add"><button type="button">QnA작성</button></a>

