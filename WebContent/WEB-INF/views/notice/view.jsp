	<a href="/return/change?num=${obj.NUM }"><button type="button">수정 하기 </button></a><%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
			<div>
	
		
			<c:forEach var="obj" items="${list }">
				<h3>${obj.TILTE }</h3>
				<p style="padding-left: 10px;">
					<small>작성자 : ${obj.MASTER } | 작성일 : <fmt:formatDate
							pattern="MM.dd.yyyy HH:mm:ss" value="${obj.ADDDATE }" /> 
					</small>
				</p>
				<pre>${obj.CONTENT }</pre>
				
				</c:forEach>
				<a href="/notice/list?page=${param.page }"><button type="button">목록으로</button></a>
			</div>
