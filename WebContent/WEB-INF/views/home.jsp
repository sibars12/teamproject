<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#homeNav_D{
		margin:30;
	}
	.pTitle_P{
		font-family: 'Daum_Regular';
		font-size: 20px;
	}
	.newP_Td{
		padding: 5px;
		font-family: 'Daum_Regular';
		font-size: 12px;
	}
	.bestP_Td{
		padding: 5px;
		font-family: 'Daum_Regular';
		font-size: 12px;
	}
	#newProduct_D{
		margin-top: 80px;
		margin-bottom: 40px;
		min-height: 400px;
	}
	.pSubTilte_P{
		font-family: 'Daum_Regular';
		font-size: 16px;
	}
	.pSubTitle_A{
		color: black;
		font-family: 'Daum_Regular';
		font-size: 13px;
		margin-right: 5px;
		margin-left: 5px;
	}
	.pSubTitle_A:hover{
		text-decoration: none;
	}
	#bestProduct_D{
		margin-top: 100px;
		min-height: 400px;
	}
	.bestSubTilte_P{
		font-family: 'Daum_Regular';
		font-size: 16px;
	}
	.bestSubTitle_A{
		color: black;
		font-family: 'Daum_Regular';
		font-size: 13px;
		margin-right: 5px;
		margin-left: 5px;
	}
	.bestSubTitle_A:hover{
		text-decoration: none;
	}
	#slide_D{
	}
	.pName_A{
		color: black;
	}
	.pPrice_A{
		color: blue;
	}
	.pName_A:hover{
		text-decoration: none;
	}
	.pPrice_A:hover{
		text-decoration: none;
	}
	.mySlides {display:none}
	.demo {cursor:pointer}
</style>

<!-- 슬라이드 사진 -->
<div id="slide_D" class="w3-content" style="max-width:1200px">
<a href="/event/view?num=${eventlist[0].NUM }"><img class="mySlides" src="/event/eventimg/${eventlist[0].EVENTIMG}" style="width:100%"></a>
  <a href="/event/view?num=${eventlist[1].NUM }"><img class="mySlides" src="/event/eventimg/${eventlist[1].EVENTIMG}" style="width:100%"></a>
  <a href="/event/view?num=${eventlist[2].NUM }"><img class="mySlides" src="/event/eventimg/${eventlist[2].EVENTIMG}" style="width:100%"></a>
  <a href="/event/view?num=${eventlist[3].NUM }"><img class="mySlides" src="/event/eventimg/${eventlist[3].EVENTIMG}" style="width:100%"></a>
  <div class="w3-row-padding w3-section">
    <div class="w3-col s3">
      <img class="demo w3-opacity w3-hover-opacity-off" src="/event/eventimg/${eventlist[0].EVENTIMG}" style="width:100%" onclick="currentDiv(1)">
    </div>
    <div class="w3-col s3">
      <img class="demo w3-opacity w3-hover-opacity-off" src="/event/eventimg/${eventlist[1].EVENTIMG}" style="width:100%" onclick="currentDiv(2)">
    </div>
    <div class="w3-col s3">
      <img class="demo w3-opacity w3-hover-opacity-off" src="/event/eventimg/${eventlist[2].EVENTIMG}" style="width:100%" onclick="currentDiv(3)">
    </div>
    <div class="w3-col s3">
      <img class="demo w3-opacity w3-hover-opacity-off" src="/event/eventimg/${eventlist[3].EVENTIMG}" style="width:100%" onclick="currentDiv(4)">
    </div>
  </div>
</div>

<!-- 신상품 -->
<div align="center" id="newProduct_D">
	<p class="pTitle_P">New Product</p>
	<p class="pSubTitle_P"><a class="pSubTitle_A">Cloth</a> - <a class="pSubTitle_A">Feed</a>
	 - <a class="pSubTitle_A">Snack</a> - <a class="pSubTitle_A">Toy</a></p>
	<table id="new_T">
		<tr>
			<c:forEach var="idx" begin="0" end="4">
				<td class="newP_Td" width="210"><a href="/product/view?ownernumber=${newList[idx].OWNERNUMBER}"><img src="/images/product/${newList[idx].IMAG}" width="190"></a></td>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="idx" begin="0" end="4">
				<td align="center" class="newP_Td" width="210">
					<a href="/product/view?ownernumber=${newList[idx].OWNERNUMBER}" class="pName_A">${newList[idx].NAME}</a><br/>
					<a href="/product/view?ownernumber=${newList[idx].OWNERNUMBER}" class="pPrice_A">${newList[idx].PRICE}</a>
				</td>
			</c:forEach>
		</tr>
	</table>
</div>
<div align="center">
<a href="#"><img src="/images/home/5.jpg" class="w3-opacity-min"></a>
</div>
<!-- 베스트 상품 -->
<div align="center" id="bestProduct_D">
	<p class="pTitle_P">Best Product</p>
	<p class="bestSubTitle_P"><a class="bestSubTitle_A">Cloth</a> - <a class="bestSubTitle_A">Feed</a>
	 - <a class="bestSubTitle_A">Snack</a> - <a class="bestSubTitle_A">Toy</a></p>
	<table id="best_T">
		<tr>
			<c:forEach var="idx" begin="0" end="4">
				<td class="bestP_Td" width="210"><a href="/product/view?ownernumber=${bestList[idx].OWNERNUMBER}"><img src="/images/product/${bestList[idx].IMAG}" width="190"></a></td>
			</c:forEach>
		</tr>
		<tr>
			<c:forEach var="idx" begin="0" end="4">
				<td align="center" class="bestP_Td" width="210">
					<a href="/product/view?ownernumber=${bestList[idx].OWNERNUMBER}" class="pName_A">${bestList[idx].NAME}</a><br/>
					<a href="/product/view?ownernumber=${bestList[idx].OWNERNUMBER}" class="pPrice_A">${bestList[idx].PRICE}</a>
				</td>
			</c:forEach>
		</tr>
	</table>
</div>


<script>
	var slideIndex = 1;
	showDivs(slideIndex);
	
	function plusDivs(n) {
	  showDivs(slideIndex += n);
	}
	
	function currentDiv(n) {
	  showDivs(slideIndex = n);
	}
	
	function showDivs(n) {
	  var i;
	  var x = document.getElementsByClassName("mySlides");
	  var dots = document.getElementsByClassName("demo");
	  if (n > x.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = x.length}
	  for (i = 0; i < x.length; i++) {
	     x[i].style.display = "none";
	  }
	  for (i = 0; i < dots.length; i++) {
	     dots[i].className = dots[i].className.replace(" w3-opacity-off", "");
	  }
	  x[slideIndex-1].style.display = "block";
	  dots[slideIndex-1].className += " w3-opacity-off";
	}

	$(document).ready(function(){
		// 신상품 nav
		$(".pSubTitle_A").hover(function(){
			$(this).css("cursor","pointer");
		});
		$(".pSubTitle_A").click(function(){
			var type = $(this).text();
			$.get("/getNewTypeList",{"type":type},function(data){
				var html="<tr>";
				for(idx in data){
					html += "<td class=\"newP_Td\" width=\"210\"><a href=\"/product/view?ownernumber="+ data[idx].OWNERNUMBER +"\">"
							+"<img src=\"/images/product/"+ data[idx].IMAG +"\" width=\"190\"></a></td>"
				}
				html += "</tr><tr>";
				for(idx in data){
					html += "<td align=\"center\" class=\"newP_Td\" width=\"210\">"
							+"<a href=\"/product/view?ownernumber="+data[idx].OWNERNUMBER+"\" class=\"pName_A\">"+data[idx].NAME+"</a><br/>"
							+"<a href=\"/product/view?ownernumber="+data[idx].OWNERNUMBER+"\" class=\"pPrice_A\">"+data[idx].PRICE+"</a></td>";
				}
				html += "</tr>";
				$("#new_T").html(html);
			});
		});
		
		// 베스트 nav
		$(".bestSubTitle_A").hover(function(){
			$(this).css("cursor","pointer");
		});
		$(".bestSubTitle_A").click(function(){
			var type = $(this).text();
			$.get("/getBestTypeList",{"type":type},function(data){
				var html="<tr>";
				for(idx in data){
					html += "<td class=\"bestP_Td\" width=\"210\"><a href=\"/product/view?ownernumber="+ data[idx].OWNERNUMBER +"\">"
							+"<img src=\"/images/product/"+ data[idx].IMAG +"\" width=\"190\"></a></td>"
				}
				html += "</tr><tr>";
				for(idx in data){
					html += "<td align=\"center\" class=\"bestP_Td\" width=\"210\">"
							+"<a href=\"/product/view?ownernumber="+data[idx].OWNERNUMBER+"\" class=\"pName_A\">"+data[idx].NAME+"</a><br/>"
							+"<a href=\"/product/view?ownernumber="+data[idx].OWNERNUMBER+"\" class=\"pPrice_A\">"+data[idx].PRICE+"</a></td>";
				}
				html += "</tr>";
				$("#best_T").html(html);
			});
		});
	});
</script>