<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center" style="line-height: 35px">

	<h2>공지 사항 작성</h2>
	
	<div align="left" style="width: 80%;">
	
		
		<form action="/master/noticeadd" method="post">
			<p>
				<b>공지제목</b><br /> <input type="text"  name="title" placeholder="공지제목"
					autocomplete="off" style="width: 100%;" required/>
			</p>
			<p>
				<b>공지내용</b><br />
				<textarea rows="10" name="content" placeholder="공지내용" required 
					style="width: 100%;"></textarea>
			</p>
			<p>
				<button type="submit">글등록</button>
				<button type="reset">재작성</button>
				<a href="/master/noticelist"><button type="button">목록으로</button></a>
			</p>
		</form>
		
	</div>
</div>
