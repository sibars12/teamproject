<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
th {
	border-bottom: 1px solid;
	text-align: left;
}
th, td {
	padding: 10px;
}
</style>
<div align="center" style="line-height: 35px">

	<h2>이벤트</h2>
	<p align="right" style="margin-right: 30px;">
		총 <b>${cnt }</b> 개의 이벤트가 진행중입니다.
	</p>
	<table id="productList_T">
				<c:forEach var="obj" items="${list }" >
			<tr>
			<c:when test="${list!=null }">
								<td width="270" align="center" class="productList_Td" style="border-bottom: none;">
								<a class="pList_A" href="/event/view?num=${obj.NUM}&page=${param.page}"><img width="220" height="220" src="/event/eventimg/${obj.EVENTIMG }"></a>
ㄴ							</td>
				</c:when>
						<c:otherwise>
							<td width="270" align="center" style="border-bottom: none; border-right: none;">
								<div align="left" class="deleteCheck_D"></div>
							</td>
						</c:otherwise>
			</tr>
			<tr class="productList_Tr">
					<c:choose>
							<td width="270" class="productList_Td" align="center" style="padding-top: 5px; padding-bottom: 20px; border-top: none;">
								<a class="pList_A" href="/event/view?num=${obj.NUM}&page=${param.page}">
								<font color="blue">시작일:<fmt:formatDate pattern="yyyy.MM.dd " value="${obj.STARTDATE }" /></font><br/>
								<font color="blue">종료일<fmt:formatDate	pattern="yyyy.MM.dd " value="${obj.ENDDATE }" />
								</font></a>
							</td>
						<c:otherwise>
							<td width="270" style="padding: 25;"></td>
						</c:otherwise>
					</c:choose>
			</tr>
				</c:forEach>
	</table>
	<table style="width: 95%">
		<thead>
			<tr>
				<th style="width: 40%">이벤트 목록</th>
				<th style="width: 20%">시작일</th>
				<th style="width: 20%">마감일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="obj" items="${list }">
				<tr>
					<td>
					
						<a href="/event/view?num=${obj.NUM}&page=${param.page}"><img width="100" height="100" src="/event/eventimg/${obj.EVENTIMG }"></a>
					</td>
					<td>
						<p><fmt:formatDate
							pattern="yyyy.MM.dd " value="${obj.STARTDATE }" /></p>
					</td>
					<td>
						<p><fmt:formatDate
							pattern="yyyy.MM.dd " value="${obj.ENDDATE }" /></p>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<p align="right" style="margin-right: 30px;">
	</p>
</div>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<div class="w3-container">
<div class="w3-bar">
 <c:if test="${param.page ne 1 }"><a  class="w3-button" href="/event/list?page=${param.page-1 }">&laquo;</a></c:if>
  <c:forEach var="i" begin="1" end="${size}" varStatus="vs">
			<c:choose>
				<c:when test="${i eq param.page }">
					<a class="w3-button" class="active">${i }</a>
				</c:when>
				<c:otherwise>
					<a href="/event/list?page=${i }" class="w3-button"
						><b style="color: #9c9892;">${i }</b></a>	
				</c:otherwise>
			</c:choose>
			
		</c:forEach>
  <c:if test="${param.page ne size }"><a class="w3-button" href="/event/list?page=${param.page+1 }">&raquo;</a></c:if>
</div>

</div>

<script>

</script>
