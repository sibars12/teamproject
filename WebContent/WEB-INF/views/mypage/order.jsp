<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	/* 주문내역 table */
	#orderTable_T{
		font-family: 'Daum_Regular';
	}
	/* 주문내역 table thead */
	#orderTableHead_Tr{
		background-color: rgb(230,230,230);
		font-size: 13px;
	}
	/* 주문내역 table td */
	.orderTable_Td{
		padding: 10px;
		text-align: center;
		border-bottom: 1px solid rgb(200,200,200);
		border-top: 1px solid rgb(180,180,180);
	}
	.orderBox_D{
		font-family: 'NanumBarunGothic';
		font-size: 13;
	}
	.orderBox_B{
		padding: 7 11!important;
	}
	.orderTable_D{
		margin-top: 50;
	}
	.orderTitle_D{
		margin-bottom: 30;
		padding: 20;
		font-family: 'Inconsolata';
		font-size: 20;
	}
	.orderBox_I{
		width: 140px;
		height: 27px;
		font-size: 13; 
	}
</style>
<div class="orderBox_D container">
	 <div class="orderTitle_D">Order</div>
	
	 <div class="w3-bar w3-Blue-Gray">
	   <button class="w3-bar-item w3-button tablink w3-red" onclick="openTab(event,'order')">주문내역조회</button>
	   <button class="w3-bar-item w3-button tablink" onclick="openTab(event,'cancel')">반품내역조회</button>
	 </div>
	 
	 <div id="order" class="w3-container w3-border tab" style="padding: 25 20!important">
	 	<table><tr height="60"><td>
	 	<button class="orderBox_B w3-button w3-black w3-hover-red w3-tiny">오늘</button>
	 	<button class="orderBox_B w3-button w3-black w3-hover-red w3-tiny">1주일</button>
	 	<button class="orderBox_B w3-button w3-black w3-hover-red w3-tiny">1개월</button>
	 	<button class="orderBox_B w3-button w3-black w3-hover-red w3-tiny">3개월</button></td>
	 	<td style="padding-left: 10px;"><form action="/mypage/order" method="post" style="margin:0px;">
	 		<input type="date" class="orderBox_I startDate" name="startdate"> ~ 
	 		<input type="date" class="orderBox_I endDate">
	 		<input type="hidden" class="endDateVal" name="enddate"> <!-- 원활한 sql검색을 위해 표시된 endDate날보다 하루+1 되어있는 input -->
	 		<input type="hidden" name="type" value="order">
	 		<button class="orderBox_B w3-button w3-Indigo" style="font-size:14px!important;">조회</button>
	 	</form></td>
	 	</tr>
	 	</table>
	 </div>
	
	 <div id="cancel" class="w3-container w3-border tab" style="display:none; padding: 25 20!important;">
	   <table><tr height="60"><td>
	 	<button class="orderBox_B w3-button w3-black w3-hover-red w3-tiny">오늘</button>
	 	<button class="orderBox_B w3-button w3-black w3-hover-red w3-tiny">1주일</button>
	 	<button class="orderBox_B w3-button w3-black w3-hover-red w3-tiny">1개월</button>
	 	<button class="orderBox_B w3-button w3-black w3-hover-red w3-tiny">3개월</button></td>
	 	<td style="padding-left: 10px;"><form action="/mypage/order" method="post" style="margin:0px;">
	 		<input type="date" class="orderBox_I startDate" name="sdate"> ~ 
	 		<input type="date" class="orderBox_I endDate" name="edate">
	 		<input type="hidden" name="type" value="reorder">
	 		<button class="w3-button w3-Indigo" style="font-size:14px!important;">조회</button>
	 	</form></td>
	 	</tr>
	 	</table>
	 </div>
</div>
<div class="orderTable_D container" align="center">
	<table id="orderTable_T">
		<tr id="orderTableHead_Tr">
			<td class="orderTable_Td" width="120">주문번호</td>
			<td class="orderTable_Td" width="100">주문일자</td>
			<td class="orderTable_Td" width="90">이미지</td>
			<td class="orderTable_Td" width="300">상품정보</td>
			<td class="orderTable_Td" width="100">수량</td>
			<td class="orderTable_Td" width="100">상품구매금액</td>
			<td class="orderTable_Td" width="120">반품</td>
		</tr>
		<tbody style="font-size: 12px;">
			<c:choose>
				<c:when test="${list ne null}">	
					<c:forEach var="obj" items="${list}">
						<tr>
							<td class="orderTable_Td">${obj.NUM}</td>
							<td class="orderTable_Td">${obj.ORDERDATE}</td>
							<td class="orderTable_Td"><img width="80" src="/images/product/${obj.IMAG}"></td>
							<td class="orderTable_Td">${obj.NAME}</td>
							<td class="orderTable_Td">${obj.CNT}</td>
							<td class="orderTable_Td">${obj.PRICE}</td>
							<td class="orderTable_Td"><a href="/return/list?page=1"><button>반품</button></a></td>
						</tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr>
						<td colspan="8" align="center" class="orderTable_Td" style="padding: 30 0;">주문내역이 없습니다</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</tbody>
	</table>
</div>
<script>
	// orderbox div변경하는 function
	function openTab(evt, tabName) {
	  var i, x, tablinks;
	  x = document.getElementsByClassName("tab");
	  for (i = 0; i < x.length; i++) {
	      x[i].style.display = "none";
	  }
	  tablinks = document.getElementsByClassName("tablink");
	  for (i = 0; i < x.length; i++) {
	      tablinks[i].className = tablinks[i].className.replace(" w3-red", "");
	  }
	  document.getElementById(tabName).style.display = "block";
	  evt.currentTarget.className += " w3-red";
	}
	
	$(document).ready(function(){
		// 페이지 로딩시 enddate 오늘로 세팅
		var today = new Date();
		$(".endDate").val(changeDate(today));
		endDateSet();
		
		// 날짜버튼 클릭했을 때 startdate 세팅
		$(".orderBox_B").click(function(){
			var date = new Date();
			var text = $(this).text();
			if(text=="1주일"){
				date.setDate(date.getDate()-7);
				$(".startDate").val(changeDate(date));
			}else if(text=="1개월"){
				date.setMonth(date.getMonth()-1);
				$(".startDate").val(changeDate(date));
			}else if(text=="3개월"){
				date.setMonth(date.getMonth()-3);
				$(".startDate").val(changeDate(date));
			}else if(text=="오늘"){
				$(".startDate").val(changeDate(date));
			}
		});
		
		// enddate 수동으로 세팅시 hidden input 변경
		$(".endDate").change(function(){
			endDateSet();
		});
	});
	
	// hidden input 변경하는 function
	function endDateSet(){
		var date = $(".endDate").val();
		var dar = date.split("-");
		dar[1]=dar[1]*1-1;
		var newDate = new Date(dar[0], dar[1], dar[2]);
		newDate.setDate(newDate.getDate()+1);
		$(".endDateVal").val(changeDate(newDate));
	}
	
	// date형식을 string형식으로 바꾸는 function
	function changeDate(date){
		var year = date.getFullYear();
		var month = date.getMonth()+1;
		if(month<10){
			month = "0" + month;
		}
		var day = date.getDate();
		if(day<10){
			day = "0" + day;
		}
		ndate = year + "-" + month + "-" + day;
		return ndate;
	}
</script>
