<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center" style="line-height: 35px">

	<h2>Q&A 수정</h2>
	
	<div align="left" style="width: 80%;">
	
		
		<form action="/QnA/change" method="post">
			<p>
			<input type="hidden" name="num" value="${num }">
			</p>
			<p>
				<b>질문</b><br /> <input type="text" name="title" value="${title }"
					autocomplete="off" style="width: 100%;" />
			</p>
			<p>
				<b>답변</b><br />
				<input  name="content" value="${content }"
					style="width: 100%;"/>
			</p>
				<button type="submit">Q&A등록</button>
				<button type="reset">재작성</button>
		</form>
		
	</div>
</div>
