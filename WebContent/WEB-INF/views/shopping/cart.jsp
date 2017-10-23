<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
thead{
	
}
td{
	padding:5;
}
.vol_B{
	width: 40px;
	text-align: right;
	margin: 3;
}
</style>
<div align="center">
	<form action="/product/buy">
		<table>
			<thead align="center">
				<tr>
					<td></td>
					<td width="70">번호</td>
					<td>사진</td>
					<td width="300">제품명</td>
					<td width="150">수량</td>
					<td width="80">가격</td>
				</tr>
			</thead>
			<tbody align="center">
				<c:if test="${list.size()!=0 }">
				<c:forEach var="idx" begin="0" end="${list.size()-1 }">
					<tr>
						<td><input type="checkbox" class="delete_I" value="${list[idx].NUM }"></td>
						<td>${idx+1 }</td>
						<td><img width="80" height="80" src="/images/product/${list[idx].IMAG }"></td>
						<td>[${list[idx].COMP}] ${list[idx].NAME}${list[idx].SCALE} ${list[idx].COLOR}</td>
						<td class="vol_Td"><button type="button" class="volplus_B">+</button><input type="text" class="vol_B" value="${list[idx].VOLUME }"><button type="button" class="volminus_B">-</button></td>
						<td class="price_Td">${list[idx].PRICE }</td>
					</tr>
				</c:forEach>
				</c:if>
			</tbody>
			<tfoot align="right">
				<tr>
					<td colspan="6">총 구매금액: <span id="totalPrice_S"></span></td>
				</tr>
				<tr>
					<td colspan="6" align="right"><button id="deleteCart_B" type="button">삭제</button></td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<script>
	$(document).ready(function(){
		$(".volplus_B").click(function(){
			var num = $(this).next().val();
			num++;
			$(this).next().val(num);
			totalPrice();
		});
		$(".volminus_B").click(function(){
			var num = $(this).prev().val();
			if(num!=0)
				num--;
			$(this).prev().val(num);
			totalPrice();
		});
		totalPrice();
	});
	
	$("#deleteCart_B").click(function(){
		var dnum = "";
		$('.delete_I:checked').each(function(idx) { 
	    	if(idx!=0)
	    		dnum+=",";
	    	dnum+=$(this).val();
		});
		if(confirm("정말 삭제하시겠습니까??")){
			console.log(dnum);
			$.get("/shopping/deleteCart",{"dnum":dnum},function(data){
				if(data=="YY"){
					alert("삭제되었습니다");
				}
			});
			location.href="/shopping/cart";
		}
	});
	
	var totalPrice = function(){
		var tPrice = 0;
		$(".price_Td").each(function(){
			console.log($(this).text());
			console.log($(this).prev().children("input").val());
			tPrice+=parseInt($(this).text()) * parseInt($(this).prev().children("input").val());
		});
		$("#totalPrice_S").text(tPrice);
	}
</script>