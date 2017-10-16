<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center" style="line-height: 35px">

	<h2>Q&A 작성</h2>
	
	<div align="left" style="width: 80%;">
	
		
		<form action="/QnA/add" method="post">
			<p>
			<b>작성자</b>
				<input type="text" placeholder="master" name="writer" />
			</p>
			<p>
				<b>질문</b><br /> <input type="text" name="QnA" placeholder="QnA"
					autocomplete="off" style="width: 100%;" />
			</p>
			<p>
				<b>답변</b><br />
				<textarea rows="10" name="anser" placeholder="답변"
					style="width: 100%;"></textarea>
			</p>
			<p>
				<button type="submit">Q&A등록</button>
				<button type="reset">재작성</button>
			</p>
		</form>
		
	</div>
</div>
