<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	/* 상품검색 결과와 정렬 nav */
	#searchNav_D{
		padding-top: 9;
		padding-bottom: 9;
		border: 1px solid rgb(210,210,210);
		font-family: 'Daum_Regular';
		font-size: 12;
	}
	/* 검색결과가 없을 때 뜨는 div */
	#noSearch_D{
		margin: 50 0;
	}
	/* 검색박스 div */
	#searchBox_D{
		margin-top: 50px;
		padding: 15;
		font-family: 'NanumBarunGothic';
		width: 75%;
	}
	/* 검색박스 table */
	#searchBox_T{
		margin-left: 6px;
		font-size: 13;
	}
	/* 검색박스 td */
	.searchBox_Td{
		padding: 3;
	}
	/* 검색박스 input */
	.searchBox_I{
		padding: 3 6;
	}
	/* 검색조건 input */
	.searchBoxName_I{
		width: 180px;
	}
	/* 판매가격대 input */
	.searchBoxPrice_I{
		width: 150px;
	}
	/* 검색박스 button */
	.searchBox_B{
		transform: translate(-10%, -5%);
	}
	/* 검색박스 type select */
	#searchType_S{
		color: black;
		height: 25px;
		width: 200px;
	}
	/* 검색박스 option select */
	#searchOption_S{
		color: black;
		height: 25px;
		width: 120px;
	}
	/* 검색박스 label td */
	.searchBoxLabel{
		color: white;
		font-size: 14;
	}
	/* 검색결과 있는 td */
	.searchO_Td{
		padding: 10;
	}
	/* 검색결과 td안에 글자 a */
	.searchList_A{
		font-family: 'Daum_Regular';
		font-size: 12;
		line-height: 2;
		color: black;
	}
	.searchList_A:hover{
		text-decoration: none;
	}
	/* 검색결과 td안에 이름 a */
	.searchListImage{
		margin-bottom: 10px;
	}
	/* 검색결과 td안에 가격 a */
	.searchListPrice_A{
		color: blue;
	}
</style>
<c:if test="${error ne null}">
	<script>alert(${error});</script>	
</c:if>
<div class="w3-container" align="center">
	<div align="left" class="tabName_D">Search</div>
	<div id="searchNav_D" class="row">
		<div class="col-sm-6" align="left">
			총 ${cnt}개의 상품이 검색되었습니다.
		</div>
		<div class="col-sm-6" align="right">
			<a href="/search?type=${map.type}&option=${map.option}&name=${map.name}&minPrice=${map.minPrice}&MaxPrice=${map.MaxPrice}&Lineup=signup">신상품</a> /
			<a href="/search?type=${map.type}&option=${map.option}&name=${map.name}&minPrice=${map.minPrice}&MaxPrice=${map.MaxPrice}&Lineup=name">상품명</a> /
			<a href="/search?type=${map.type}&option=${map.option}&name=${map.name}&minPrice=${map.minPrice}&MaxPrice=${map.MaxPrice}&Lineup=rowPrice">낮은가격</a> /
			<a href="/search?type=${map.type}&option=${map.option}&name=${map.name}&minPrice=${map.minPrice}&MaxPrice=${map.MaxPrice}&Lineup=highPrice">높은가격</a> /
			<a href="/search?type=${map.type}&option=${map.option}&name=${map.name}&minPrice=${map.minPrice}&MaxPrice=${map.MaxPrice}&Lineup=cnt">후기많은순</a>
		</div>
	</div>
	<div id="searchBox_D" class="w3-panel w3-Blue-Gray" align="left">
		<form action="/search" method="get" style="margin:0!important;" id="searchBox_F">
			<table id="searchBox_T">
				<tr height="40">
					<td width="90" class="searchBox_Td searchBoxLabel">상품분류</td>
					<td class="searchBox_Td">
						<select id="searchType_S" name="type">
							<option value="">상품 분류 선택</option>
							<option value="의류" ${map.type eq '의류' ? 'selected' : ''}>의류</option>
							<option value="사료" ${map.type eq '사료' ? 'selected' : ''}>사료</option>
							<option value="간식" ${map.type eq '간식' ? 'selected' : ''}>간식</option>
							<option value="장난감" ${map.type eq '장난감' ? 'selected' : ''}>장난감</option>
						</select>
					</td>
				</tr>
				<tr height="40">
					<td width="90" class="searchBox_Td searchBoxLabel">검색조건</td>
					<td class="searchBox_Td">
						<select id="searchOption_S" name="option">
							<option value="name" ${map.option eq 'name' ? 'selected' : ''}>제품명</option>
							<option value="comp" ${map.option eq 'comp' ? 'selected' : ''}>제조사</option>
						</select>
						<input type="text" name="name" class="searchBox_I searchBoxName_I" value="${map.name}"><br/>
					</td>
				</tr>
				<tr height="40">
					<td width="90" class="searchBox_Td searchBoxLabel">판매가격대</td>
					<td class="searchBox_Td">
						<input type="text" name="minPrice" class="searchBox_I searchBoxPrice_I" value="${map.minPrice}">
						<font color="white">~</font>
						<input type="text" name="MaxPrice" class="searchBox_I searchBoxPrice_I" value="${map.MaxPrice}">
					</td>
				</tr>
			</table>
			<p style="margin:0!important;" align="right"><button type="submit" class="searchBox_B w3-button w3-Indigo w3-round w3-large">검색하기</button></p>
		</form> 
	</div>
	<div>
		<c:choose>
			<c:when test="${cnt ne 0}">
				<table style="border-collapse: collapse;">
					<c:forEach var="i" begin="0" end="${lSize}">
						<tr height="310">
							<c:forEach var="j" begin="0" end="3">
								<c:choose>
									<c:when test="${list[j+(i*4)] ne null}">
										<td class="searchO_Td" width="270" align="center">
											<a href="#"><img class="searchListImage" width="95%" src="/images/product/${list[j+(i*4)].IMAG}"></a><br/>
											<a href="#" class="searchList_A searchListName_A">${list[j+(i*4)].NAME}</a><br/>
											<a href="#" class="searchList_A searchListPrice_A">${list[j+(i*4)].PRICE}</a>
										</td>
									</c:when>
									<c:otherwise>
										<td width="270"></td>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</tr>
					</c:forEach>
				</table>
			</c:when>
			<c:otherwise>
				<div id="noSearch_D">검색 결과가 없습니다.</div>
			</c:otherwise>
		</c:choose>
	</div>
</div>

<script>
	// 판매가격대에 글자입력 막는 함수
	$(".searchBoxPrice_I").blur(function(){
		if(isNaN($(this).val())){
			$(this).val("");
			alert("판매가격대에 숫자를 입력해 주세요");
		}
	});
</script>