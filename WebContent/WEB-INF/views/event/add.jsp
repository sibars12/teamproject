<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center" style="line-height: 35px">

	<h2>이벤트</h2>
	
	<div align="left" style="width: 80%;">
	
		
		<form action="/event/add" method="post">
			<p>
				<b>이벤트 제목</b><br /> <input type="text"  name="title" placeholder="이벤트 제목"
					autocomplete="off" style="width: 100%;" required/>
			</p>
			<p>
				<b>이벤트 내용</b><br />
				<textarea rows="10" name="content" placeholder="이벤트 내용" required 
					style="width: 100%;"></textarea>
			</p>
			<p>
			<b>마감일</b><br/>
			  <input type="date" name="enddate" />
			</p>
			<p>
				<button type="submit">이벤트 등록</button>
				<button type="reset">재작성 </button>
				<a href="/event/list"><button type="button">목록으로</button></a>
			</p>
		</form>
		
	</div>
</div>
