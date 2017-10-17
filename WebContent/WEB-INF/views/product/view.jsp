<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
	th,td{
		padding:5px;
	}
</style>

<div class="container-fluid">
	<div class="row">
		<div class="col-sm-11">
			<!-- 내용 -->
			<div class="row">
				<div class="col-sm-6">
					<%-- 사진 	--%>				
					<div class="container">
					<c:choose>
						<c:when test="${!empty productInfo[0].IMAG}">
							<img src="/images/product/${productInfo[0].IMAG}" class="img-rounded"
								alt="상품이미지" width="304" height="236" />
						</c:when>
						<c:otherwise>
							<img src="/images/default.png" class="img-rounded"
								alt="Cinque Terre" width="304" height="236" />
						</c:otherwise>
					</c:choose>
					
					</div>
			
				</div>
				<div class="col-sm-6">
					<!-- 상품정보 -->
					<h3>${productInfo[0].NAME }</h3>
					<hr>
					<table>
						<tr>
							<th>소비자 가격</th>
							<td>${productInfo[0].PRICE }</td>
						</tr>
						<tr>
							<th>배송비</th>
							<td>3만원 이상 구매시 무료배송</td>
						</tr>
						<tr>
							<th>제조사/판매원</th>
							<td>${productInfo[0].COMP }</td>
						</tr>
						<tr>
							<th>사이즈</th>
							<td>${productInfo[0].SCALE }</td>
						</tr>
						<tr>
							<th>색상</th>
							<td>
							<c:forEach var="m" items="${productInfo}" varStatus="status">
								${m.COLOR }<c:if test="${not status.last }">, </c:if>
							</c:forEach>
							</td>
						</tr>
					</table>
					<hr>
					<div id="selecter_Div">
						<%-- 색상 선택  --%>
						<c:choose>
							<c:when test="${porductInfo[0].COLOR != 'none'}">
							<select id="color_Select">
								<option>색상 옵션 선택</option>
								<c:forEach items="${productInfo}" var="m">
									<option>${m.COLOR }</option>
								</c:forEach>
							</select>
							</c:when>
							<c:otherwise>
								<!-- 수량 -->
								<button id="minusA_B">-</button>
								<input id="number_I" type="number" style="width: 40px;" value="1"	min="1" />
								<button class="plusA_B">+</button>
							</c:otherwise>							
						</c:choose>						
					</div>
					<div>
					<hr>
					<span id="select_s"></span>
					<hr>
					<button id="">장바구니에 담기</button>
					<button id="buyNow_B">즉시구매</button>
					</div>
				</div>
					
				<div>
					<label id="">상품 상세보기</label>
					<pre>
						아마도 여기서
						제품의 상세설명이 있을 꺼야
						없을 수 도 있고
					</pre>
				</div>
				
				<div>
					<label id="inquiry_Label">상품 문의</label><br>
					<sapn id="inquiry_Span">문의 리스트</sapn>
					<div class="row">
				        <div class="col-sm-6 form-group">
				          <input class="form-control" id="inquiryWriter_I" name="inquiryWriter_I" placeholder="작성자" type="text" required>
				        </div>
				        <div class="col-sm-6 form-group">
				          <input class="form-control" id="inquiryPw_I" name="inquiryPw_I" placeholder="비밀번호" type="password" required>
				        </div>
				      </div>
				      <textarea class="form-control" id="inquiryComments" name="inquiryComments" placeholder="문의내용" rows="3"></textarea>
				      <br>
				      <div class="row">
				        <div class="col-md-12 form-group">
				          <button class="btn pull-right" type="submit" id="inquiry_Submit">Send</button>
				        </div>
				      </div>
				</div>
				<div>
					<label id="review_Label">상품 후기</label><br>
					<span id="review_Span">후기 리스트</span>
					<div class="form-group">
						<label for="reviewWriter_I">작성자</label>
						<input type="text" class="form-control" id="reviewWriter_I" name="reviewWriter_I" placeholder="작성자">&nbsp;
						<textarea class="form-control" id="reviewComment_Ta" name="reviewComment_Ta" placeholder="내용"></textarea><br>
				        <div class="col-md-12 form-group">
				          <button class="btn pull-right" type="submit" id="inquiry_Submit">Send</button>
				        </div>
					</div>
				</div>
			</div>
	</div>
		<div class="col-sm-1" style="background-color: lavender;">최근본거 요기에 따라다니지용</div>
	</div>
</div>	

<script>
// 수량 minusA
$(".minus_B").click(function(){
	if(parseInt($(this).next().val()) > 1){
		$("#number_I").val($("#number_I").val()-1);
	}
});
// 수량 plusA
$(".plus_B").click(function(){	
	$("#number_I").val($("#number_I").val()+1);
});

// 옵션 선택시
$("#color_Select").change(function(){
	console.log($(this).val());
	if($(this).val()!="색상 옵션 선택"){
	var selectOption="<p>";
		selectOption += $(this).val();
		selectOption += "&nbsp;&nbsp;<button class=\"minus_B\">-</button>";
		selectOption += "<input type=\"number\" style=\"width: 40px;\" value=\"1\" min=\"1\" />";
		selectOption += "<button class=\"plus_B\">+</button>";
		selectOption += "&nbsp;<button class=\"remove_B\">X</button><p>";
		//selectOption += "&nbsp;&nbsp;"+${productInfo[0].PRICE}*+"</p>";
		$("#select_s").append(selectOption);
		
		//수량 minus
		$(".minus_B").click(function(){
			if(parseInt($(this).next().val()) > 1){
				$(this).next().val(parseInt($(this).next().val())-1);
			}
		});
		// 수량 plus
		$(".plus_B").click(function(){	
			$(this).prev().val(parseInt($(this).prev().val())+1);
			//var n = parseInt($(this).prev().val())+1;
			console.log($(this).prev().val());	
		});
		// 삭제
		$(".remove_B").click(function(){
			console.log($(this).parent());
			$(this).parent().remove();
		})
	}
})
</script>
