<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
			<div>
	
		
			<c:forEach var="obj" items="${list }">
				<h3>${obj.TILTE }</h3>
				<p style="padding-left: 10px;">
					<small>작성자 : ${obj.MASTER } | 시작일 : <fmt:formatDate
							pattern="MM.dd.yyyy HH:mm:ss" value="${obj.ADDDATE }" /> |
							 종료일 :  <fmt:formatDate	pattern="MM.dd.yyyy HH:mm:ss" value="${obj.ENDDATE }" />
					</small>
				</p>
				<pre>${obj.CONTENT }</pre>
				
				<a href="/event/del?num=${obj.NUM }"><button type="button">이벤트 삭제</button></a>
				</c:forEach>
				<a href="/event/list?page=${page }"><button type="button">목록으로</button></a>
			</div>
