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
		margin: 0;
	}
	#addBt_D{
		width: 1070;
		padding: 20;
	}
	.deleteCheck_D{
		width: 240;
		height: 30;
	}
	.content_S{
	}
	.plist_B{
		margin: 3;
	}
	.pPage_P{
		margin-top: 10;
	}
	.pList_A{
		font-family: 'Daum_Regular';
		font-size: 12;
		line-height: 2;
		color: black;
	}
	.pType_A{
		font-family: 'Inconsolata-Regular';
		font-size: 14;
		color: black;
	}
	.pType_A:hover{
		text-decoration: none;
	}
	.pPage_A{
		font-family: 'Daum_Regular';
		font-size: 14;
		color: black;
		margin: 2;
	}
	#productNav_P{
		padding-top: 9;
		padding-bottom: 9;
		padding-left: 20;
		border: 1px solid rgb(230,230,230);
		font-family: 'Daum_Regular';
		font-size: 12;
	}
	#tabName_D{
		font-family: 'Inconsolata-Bold';
		font-size: 19;
		margin: 8;
	}
	#lineUp_D{
		height: 30;
		font-family: 'Daum_Regular';
		font-size: 12;
		color: rgb(100,100,100);
		margin-right: 50;
		margin-bottom: 15;
	}
	.lineUp_A{
		color: rgb(100,100,100);
		text-decoration: none;
	}
	.pList_A:hover{
		text-decoration: none;
	}
	.pPage_A:hover{
		text-decoration: none;
	}
	#provPage_A:hover{
		text-decoration: none;
	}
	#nextPage_A:hover{
		text-decoration: none;
	}
</style>
<div class="w3-container" align="center">
	<!-- Product Nav -->
	<br/><div align="left" id="tabName_D">${type}</div>
	<p id="productNav_P" align="left">
		<a class="pType_A" href="/product/list?type=cloth">cloth</a> | <a class="pType_A" href="/product/list?type=feed">feed</a> | 
		<a class="pType_A" href="/product/list?type=snack">snack</a> | <a class="pType_A" href="/product/list?type=toy">toy</a>
	</p>
	<br/>
	
	<!-- 정렬 -->
	<div id="lineUp_D" align="right">
		<a class="pList_A" href="/product/list?option=signup&type=${type}" class="lineUp_A">신상품</a> · <a class="pList_A" href="/product/list?option=name&type=${type}" class="lineUp_A">상품명</a> · 
		<a class="pList_A" href="/product/list?option=priceLow&type=${type}" class="lineUp_A">낮은가격</a> · <a class="pList_A" href="/product/list?option=priceHigh&type=${type}" class="lineUp_A">높은가격</a> · 후기많은순
	</div>
	
	<!-- 상품List 테이블 -->
	<table id="productList_T">
		<c:forEach var="i" begin="0" end="${lSize}">
			<tr>
				<c:forEach var="j" begin="0" end="3">
					<c:choose>
						<c:when test="${list[j+(i*4)]!=null}">
							<td width="270" align="center" class="productList_Td" style="border-bottom: none;">
								<div align="left" class="deleteCheck_D"><input class="deleteCkbox_I" type="checkbox" value="${list[j+(i*4)].OWNERNUMBER }"></div>
								<a class="pList_A" href="/product/view?ownernumber=${list[j+(i*4)].OWNERNUMBER }"><img width="220" height="220" src="/images/product/${list[j+(i*4)].IMAG}"></a>
							</td>
						</c:when>
						<c:otherwise>
							<td width="270" align="center" style="border-bottom: none; border-right: none;">
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
							<td width="270" class="productList_Td" align="center" style="padding-top: 5px; padding-bottom: 20px; border-top: none;">
								<a class="pList_A" href="/product/view?ownernumber=${list[j+(i*4)].OWNERNUMBER }">

								${list[j+(i*4)].NAME}<br/>
								<font color="blue">${list[j+(i*4)].PRICE}</font></a>
							</td>
						</c:when>
						<c:otherwise>
							<td width="270" style="padding: 25;"></td>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
	<!-- 페이지 -->
	<p class="pPage_P">
		<a href="/product/list?page=${tPage-1}&option=${option}&type=${type}" id="provPage_A" class="pPage_A">◀</a>
		<c:forEach var="idx" begin="1" end="${page }">
			<a class="pPage_A" href="/product/list?page=${idx }&option=${option}&type=${type}">${idx }</a>
		</c:forEach>
		<a href="/product/list?page=${tPage+1}&option=${option}&type=${type}" id="nextPage_A" class="pPage_A">▶</a>
	</p>
	<!-- 상품 추가,삭제버튼 -->
	<div id="addBt_D" align="right">
		<button id="addProduct_B" class="plist_B">추가</button>
		<button id="deleteProduct_B" class="plist_B">삭제</button>
	</div>
</div>

<script>
	$(document).ready(function(){
		// 상품추가 버튼클릭 -> 이동
		$("#addProduct_B").click(function(){
			location.href="/product/addProduct";
		});
		
		// 상품삭제 버튼클릭 -> 삭제
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
		
			CheckPage(${tPage});
		//페이지 이동 막기
		
	});
	
	var CheckPage = function(page){
		var MaxPage = ${page};
		console.log("page: " + page + "MaxPage: " + MaxPage);
		if(page == 1){
			$("#provPage_A").attr("href", "#");
		}else if(page == MaxPage){
			$("#nextPage_A").attr("href", "#");
		}
	}
</script>