<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

	<div class="">
		<h2>질문 게시판</h2>
		<table class="w3-table-all w3-margin-top" id="nn">
		<tr>
		<th style="width: 60%;">자주 하는 질문</th>
		</tr>
		<c:forEach var="obj" items="${list }" begin="0" end="4">
		<tr>
					<td>
					<button onclick="anser('Demo${obj.NUM}')"
							class="w3-btn w3-block w3-black w3-left-align">${fn:substring(obj.TITLE, 0, 12) }</button>
						<div id="Demo${obj.NUM}" class="w3-container w3-hide">
							<p>${obj.CONTENT }</p>
							<a href="/QnA/del?num=${obj.NUM }"><button type="button">삭제</button></a>
						</div>
						</td>
				</tr>
		</c:forEach>
				</table>
		<input class="w3-input w3-border w3-padding" type="text"
			placeholder="질문 검색.." id="myInput" onkeyup="myFunction()">

		<table class="w3-table-all w3-margin-top" id="myTable">
			<tr>
				<th style="width: 60%;">질문</th>
			</tr>
			<c:forEach var="obj" items="${list }">
				<tr style="display: none">
					<td><button onclick="ansers('Demos${obj.NUM}')"
							class="w3-btn w3-block w3-black w3-left-align">${fn:substring(obj.TITLE, 0, 12) }</button>
						<div id="Demos${obj.NUM}" class="w3-container w3-hide">
							<p>${obj.CONTENT }</p>
							<a href="/QnA/del?num=${obj.NUM }"><button type="button">삭제</button></a>
						</div></td>
				</tr>
			</c:forEach>

		</table>

	</div>

	<script>
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
	</script>
	<a href="/QnA/add"><button type="button">QnA작성</button></a>

