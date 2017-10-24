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
	.stockContent_Td{
		font-family: 'IropkeBatangM';
		font-size: 12;
	}
	.stockTitle_Td{
		font-family: 'IropkeBatangM';
		font-size: 14;
		font-weight: bold;
	}
	.stock_Td{
		padding:3;
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
<div class="w3-container" align="center">
	<h2>새 물품 추가</h2>
	<form action="/stock/addStock" method="post">
	<table>
		<tr>
			<td class="stock_Td">상품명</td>
			<td class="stock_Td"><input type="text" name="name" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td class="stock_Td">분류</td>
			<td class="stock_Td"><input type="text" name="type" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td class="stock_Td">제조사</td>
			<td class="stock_Td"><input type="text" name="comp" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td class="stock_Td">사이즈</td>
			<td class="stock_Td"><input type="text" name="scale" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td class="stock_Td">색상</td>
			<td class="stock_Td"><input type="text" name="color" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td class="stock_Td">가격</td>
			<td class="stock_Td"><input type="text" name="price" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td class="stock_Td">수량</td>
			<td class="stock_Td"><input type="text" name="volume" class="stockInfo_I" required></td>
		</tr>
		<tr>
			<td>추가사항</td>
			<td class="stock_Td"><input type="text" name="subname" class="stockInfo_I"></td>
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
			<td width="90" class="stockTitle_Td">상품번호</td>
			<td width="90" class="stockTitle_Td">분류</td>
			<td width="150" class="stockTitle_Td">상품명</td>
			<td width="140" class="stockTitle_Td">제조사</td>
			<td width="80" class="stockTitle_Td">사이즈</td>
			<td width="80" class="stockTitle_Td">색상</td>
			<td width="80" class="stockTitle_Td">가격</td>
			<td width="70" class="stockTitle_Td">수량</td>
			<td width="130" class="stockTitle_Td">추가사항</td>
			<td></td>
		</tr>
		<c:forEach var="obj" items="${list }">
			<tr align="center">
				<td class="stockContent_Td">${obj.OWNERNUMBER}</td>
				<td class="stockContent_Td type_Td">${obj.TYPE}</td>
				<td class="stockContent_Td name_Td">${obj.NAME}</td>
				<td class="stockContent_Td comp_Td">${obj.COMP}</td>
				<td class="stockContent_Td scale_Td">${obj.SCALE}</td>
				<td class="stockContent_Td">${obj.COLOR}</td>
				<td class="stockContent_Td price_Td">${obj.PRICE}</td>
				<td class="stockContent_Td">${obj.VOLUME}</td>
				<td class="stockContent_Td subname_Td">${obj.SUBNAME}</td>
				<td><button class="plusStock_B" value="${obj.OWNERNUMBER}">추가</button> <button class="updateStock_B" value="${obj.NO}">수정</button> <button class="deleteStock_B" value="${obj.NO}">삭제</button></td>
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
	$(document).ready(function(){
		$(".plusStock_B").click(function(){
			var num = $(this).val();
			var html2 = "<form action=\"/stock/plus\" method=\"post\">"+
				"색상" + "<input type=\"text\" name=\"color\">" + "<input type=\"hidden\" name=\"ownernumber\" value=\"" + num + "\">" +
				"수량" + "<input type=\"text\" name=\"volume\">"+ "<input type=\"hidden\" name=\"type\" value=\"" + $(this).parent().siblings(".type_Td").text() + "\">" +
				"<input type=\"hidden\" name=\"name\" value=\"" + $(this).parent().siblings(".name_Td").text() + "\">" +
				"<input type=\"hidden\" name=\"scale\" value=\"" + $(this).parent().siblings(".scale_Td").text() + "\">" +
				"<input type=\"hidden\" name=\"price\" value=\"" + $(this).parent().siblings(".price_Td").text() + "\">" +
				"<input type=\"hidden\" name=\"comp\" value=\"" + $(this).parent().siblings(".comp_Td").text() + "\">" +
				"<input type=\"hidden\" name=\"subname\" value=\"" + $(this).parent().siblings(".subname_Td").text() + "\">" +
				"<button type=\"submit\">추가</button></form>";
			$("#updateStock_D").html(html2);
		});
	});
</script>