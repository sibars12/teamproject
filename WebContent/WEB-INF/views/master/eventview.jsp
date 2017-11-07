<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
			<div>
	
		
			<c:forEach var="obj" items="${list }">
				<h3>${obj.TITLE }</h3>
				<p style="padding-left: 10px;">
					<small>작성자 : 관리자 | 시작일 : <fmt:formatDate
							pattern="MM.dd.yyyy HH:mm:ss" value="${obj.STARTDATE }" /> |
							 종료일 :  <fmt:formatDate	pattern="MM.dd.yyyy HH:mm:ss" value="${obj.ENDDATE }" />
					</small>
				</p>
				<pre>${obj.CONTENT }</pre>
				
				<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
				
				<a href="/master/eventdel?num=${obj.NUM }"><button type="button">이벤트 삭제</button></a>
				<a href="/master/eventchange?num=${obj.NUM }"><button type="button">이벤트 수정</button></a>
				</c:forEach>
				
				<a href="/master/eventlist?page=${page }"><button type="button">목록으로</button></a>
			</div>
