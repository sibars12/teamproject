<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
			<div>
	
		
			<c:forEach var="obj" items="${list }">
				<h3>${obj.TITLE }</h3>
				<p style="padding-left: 10px;">
					<small>작성자 : ${obj.WRITER } | 작성일 : <fmt:formatDate
							pattern="MM.dd.yyyy HH:mm:ss" value="${obj.WRITEDATE }" /> 
					</small>
				</p>
				<p>${obj.CONTENT }</p>
				
				
				<form action="/return/coment" method="post">
				<p><input type="hidden" name="num"  value="${obj.NUM}"></p>
				<p>답글 : <input type="text" name="coment"></p><button type="submit">답글 달기</button></form>
				<b>관리자 답글</b>  작성일 :<fmt:formatDate	pattern="yyyy.MM.dd HH:mm:ss" value="${obj.WRITEDATE }" /><br/>
				<p> ${obj.COMENT }</p>
				</c:forEach>
				
				<a href="/return/masterlist?page=${param.page }"><button type="button">목록으로</button></a>
			</div>
