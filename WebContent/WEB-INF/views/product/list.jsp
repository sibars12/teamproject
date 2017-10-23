<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#productList_T{
		border-collapse: collapse;
	}
	.productList_Tr{
	}
	.productList_Td{
		padding: 5;
		border:  1px solid rgb(220,220,220);
	}
	#addBt_D{
		width: 1070;
		padding: 20;
	}
	.deleteCheck_D{
		width: 240;
		height: 30;
	}
	button{
		margin: 3;
	}
	p{
		margin-top: 10;
	}
</style>
<div align="center">
	<h2>상품 목록</h2><br/>
	<table id="productList_T">
		<c:forEach var="i" begin="0" end="${list.size()/4 }">
			<tr>
				<c:forEach var="j" begin="0" end="3">
					<c:choose>
						<c:when test="${list[j+(i*4)]!=null}">
							<td width="280" align="center" class="productList_Td" style="border-bottom: none;">
								<div align="left" class="deleteCheck_D"><input class="deleteCkbox_I" type="checkbox" value="${list[j+(i*4)].OWNERNUMBER }"></div>
								<a href="/product/view?ownernumber=${list[j+(i*4)].OWNERNUMBER }"><img width="180" height="180" src="/images/product/${list[j+(i*4)].IMAG}"></a>
							</td>
						</c:when>
						<c:otherwise>
							<td width="280" align="center" style="border-bottom: none; border-right: none;">
								<div align="left" class="deleteCheck_D"></div>
							</td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
			<tr class="productList_Tr">
				<c:forEach var="j" begin="0" end="3">
					<c:choose>
						<c:when test="${list[j+(i*4)]!=null}">
							<td width="280" class="productList_Td" style="padding: 25;border-top: none;">
								<a href="/product/view?ownernumber=${list[j+(i*4)].OWNERNUMBER }">	${list[j+(i*4)].TYPE}<br/>
								${list[j+(i*4)].NAME}<br/>
								${list[j+(i*4)].PRICE}</a>
							</td>
						</c:when>
						<c:otherwise>
							<td width="280" style="padding: 25;"></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
	<p>
		<c:forEach var="idx" begin="1" end="${page }">
			<a href="/product/list?page=${idx }">${idx }</a>
		</c:forEach>
	</p>
	<div id="addBt_D" align="right">
		<button id="addProduct_B">추가</button>
		<button id="deleteProduct_B">삭제</button>
	</div>
</div>

<script>
	$(document).ready(function(){
		if($("td").children("div").filter()){
			
		}
		$("#addProduct_B").click(function(){
			location.href="/product/addProduct";
		});
		
		$("#deleteProduct_B").click(function(){
			var dnum = "";
			$('.deleteCkbox_I:checked').each(function(idx) { 
		    	if(idx!=0)
		    		dnum+=",";
		    	dnum+=$(this).val();
			});
			if(confirm("정말 삭제하시겠습니까??")){
				console.log(dnum);
				$.get("/product/deleteProduct",{"dnum":dnum},function(data){
					if(data=="YY"){
						alert("삭제되었습니다");
					}
				});
				location.href="/product/list";
			}
		});
	});
	
	
	
	
	
</script>