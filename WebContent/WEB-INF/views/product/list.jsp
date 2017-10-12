<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#productList_T{
		border-collapse: collapse;
		border: solid;
		border-color: rgb(230,230,230);
	}
	#productListImg_Td{
		border-bottom: none;
	}
</style>
<div align="center">
	<table id="productList_T">
		<c:forEach var="i" begin="0" end="${(list.size-1)/4}">
			<tr id="productListImg_Tr">
				<c:forEach var="j" begin="0" end="3">
					<td align="center" id="productListImg_Td">
						<c:if test="${list[j+(i*4)]!=null}">
							<img src="img/${list[j+(i*4)].IMAG}">
						</c:if>
					</td>
				</c:forEach>
			</tr>
			<tr>
				<c:forEach var="j" begin="0" end="3">
					<td>
						<c:if test="${list[j+(i*4)]!=null}">
							${list[j+(i*4)].TYPE}<br/>
							${list[j+(i*4)].NAME}<br/>
							${list[j+(i*4)].PRICE}
						</c:if>
					</td>
				</c:forEach>
			</tr>
		</c:forEach>
	</table>
</div>