<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#stockEditName_I{
		padding: 5;
		margin: 5;
	}
	#stockEditName_B{
		padding: 4;
		margin: 5;
	}
	.stockInfo_I{
		padding: 3;
	}
	td{
		padding: 3;
	}
</style>
<c:if test="${result!=null }">
	<c:choose>
	 <c:when test="${result}">
	 	<script>window.alert("성공");</script>
	 </c:when>
	 <c:otherwise>
	 	<script>window.alert("실패");</script>
	 </c:otherwise>
	</c:choose>
</c:if>
<div align="center">
	<h2>새 물품 추가</h2>
	<form action="/stock/addStock" method="post">
	<table>
		<tr>
			<td>상품명</td>
			<td><input type="text" name="name" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td>분류</td>
			<td><input type="text" name="type" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td>제조사</td>
			<td><input type="text" name="comp" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td>사이즈</td>
			<td><input type="text" name="scale" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td>색상</td>
			<td><input type="text" name="color" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="text" name="price" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td>수량</td>
			<td><input type="text" name="volume" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td>추가사항</td>
			<td><input type="text" name="subname" class="stockInfo_I"></td>
		</tr>
		<tr align="center">
			<td colspan="2"><button type="submit">추가</button></td>
		</tr>
	</table>
	</form>
	
	<h2>기존 물품 수정</h2>
	<form action="/stock/addStock">
		<input type="text" id="searchStock_I" name="sch" required>
		<button type="submit" id="searchStock_B">검색</button>
	</form>
	
	<table style="border-collapse: collapse;">
		<tr height="40" align="center" style="background-color: rgb(181,222,244);">
			<td width="100">상품번호</td>
			<td width="100">분류</td>
			<td width="110">상품명</td>
			<td width="110">제조사</td>
			<td width="110">사이즈</td>
			<td width="110">색상</td>
			<td width="110">가격</td>
			<td width="110">수량</td>
			<td width="110">추가사항</td>
			<td></td>
		</tr>
		<c:forEach var="obj" items="${list }">
			<tr align="center">
				<td>${obj.OWNERNUMBER}</td>
				<td>${obj.TYPE}</td>
				<td>${obj.NAME}</td>
				<td>${obj.COMP}</td>
				<td>${obj.SCALE}</td>
				<td>${obj.COLOR}</td>
				<td>${obj.PRICE}</td>
				<td>${obj.VOLUME}</td>
				<td>${obj.SUBNAME}</td>
				<td><button class="updateStock_B" value="${obj.NO}">수정</button> <button class="deleteStock_B" value="${obj.NO}">삭제</button></td>
			</tr>
		</c:forEach>
	</table>
	<p>
		<c:forEach var="idx" begin="1" end="${page}">
			<c:choose>
				<c:when test="${sch ne null}">
					<a href="/stock/addStock?sch=${sch}&page=${idx}">${idx }</a>
				</c:when>
				<c:otherwise>
					<a href="/stock/addStock?page=${idx}">${idx}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>
	</p>
</div>
<div align="center" id="updateStock_D">
	
</div>
<script>
	var ar = document.getElementsByClassName("deleteStock_B");
	for(var i=0;i<ar.length;i++){
		ar[i].onclick = function(){
			var dNo = this.value;
			var xhr = new XMLHttpRequest();
			xhr.open("post", "/stock/delete", true);
			xhr.send(dNo);
			xhr.onreadystatechange = function(){
				if(this.readyState ==4){
					var rst = this.responseText;
					if(rst=="YYY"){
						window.alert("삭제되었습니다");
					}else{
						window.alert("오류가 발생했습니다");
					}
				}
			}
		}
	}
	var ar2 = document.getElementsByClassName("updateStock_B");
	for(var i=0;i<ar2.length;i++){
		ar2[i].onclick = function(){
			var num = this.value;
			var html = "<form action=\"/stock/update\" method=\"post\">"+
			"<select name=\"option\">"+
			"<option value=\"price\">가격</option><option value=\"volume\">수량</option></selected>"+
			"<input type=\"text\" name=\"value\"><input type=\"hidden\" name=\"no\" value=\""+num+"\">"+
			"<button type=\"submit\">수정</button></form>";
			document.getElementById("updateStock_D").innerHTML = html;
		}
	}
</script>