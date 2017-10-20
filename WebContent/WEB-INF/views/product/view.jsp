<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt"%>

<style>
	th,td{
		padding:3px;
	}
</style>

<div class="container-fluid">
	<div class="row">
		<!-- 내용 -->
		<div class="col-sm-6">
			<%-- 사진 	--%>
			<div>
				<c:choose>
					<c:when test="${!empty productInfo[0].IMAG}">
						<img src="/images/product/${productInfo[0].IMAG}"
							class="img-rounded" alt="상품이미지" width="280" height="200" />
					</c:when>
					<c:otherwise>
						<img src="/images/default.png" class="img-rounded" alt="기본 사진"
							width="280" height="200" />
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
					<td><c:forEach var="m" items="${productInfo}"
							varStatus="status">
								${m.COLOR }<c:if test="${not status.last }">, </c:if>
						</c:forEach></td>
				</tr>
			</table>
			<hr>
			<%-- 색상 선택  --%>
			<c:choose>
				<c:when test="${'none' ne productInfo[0].COLOR}">
					<form id="selectListForm" name="selectListForm"
						action="/shopping/buyNow" method="get">
						<select id="color_Select">
							<option>색상 옵션 선택</option>
							<c:forEach items="${productInfo}" var="m">
								<c:choose>
									<c:when test="${m.VOLUME eq 0 }">
										<option value="${m.NO }_${m.COLOR}" disabled>
											${m.COLOR }-일시품절</option>
									</c:when>
									<c:otherwise>
										<option value="${m.NO }_${m.COLOR}">${m.COLOR }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select> <span id="select_Span">
							<hr>
						</span> <span style="text-align: right" id="total_Span"></span>
						<hr>
						<button type="submit" id="buyNow_B" disabled>즉시구매</button>
						<button type="button" id="cart_B" disabled>장바구니에 담기</button>
					</form>
				</c:when>
				<c:otherwise>
					<form id="selectListForm" name="selectListForm"
						action="/shopping/buyNow" method="get">
						<span id="select_Span"> <label>${productInfo[0].NAME }</label>
							&nbsp;&nbsp; <!-- 수량 -->
							<button type="button" id="minusA_B">-</button> <input
							id="stockCnt" name="stockCnt" type="number" style="width: 40px;"
							value="1" min="1" />
							<button type="button" id="plusA_B">+</button>&nbsp;&nbsp; <span
							id="priceA_Span"><b>${productInfo[0].PRICE }원</b></span> <input
							type="hidden" id="stockNO" name="stockNO"
							value="${productInfo[0].NO }">
						</span>
						<hr>
						<span style="text-align: right" id="total_Span"></span>
						<hr>
						<button type="submit" id="buyNow_B">즉시구매</button>
						<button type="button" id="cart_B">장바구니에 담기</button>
					</form>
				</c:otherwise>
			</c:choose>
		</div>
	</div>
	<div class="row">
		<ul class="nav nav-tabs">
			<li><a data-toggle="tab" href="#detail" id="home">상품설명</a></li>
			<li><a data-toggle="tab" href="#menu2">상품후기</a></li>
			<li><a data-toggle="tab" href="#menu3">문의하기</a></li>
		</ul>
		<div class="tab-content">
			<div id="detail" class="tab-pane fade" align="center">
				<hr>
				<label>상품 상세보기</label>
				<c:choose>
					<c:when test="${!empty productInfo[0].CONTENTS}">
						<div id="productDetail">${productInfo[0].CONTENTS }</div>
					</c:when>
					<c:otherwise>
							상세정보 없음  
						</c:otherwise>
				</c:choose>
				<hr>
			</div>
			<!-- 상품 후기  -->
			<div id="menu2" class="tab-pane fade">
				<label id="review_Label">상품 후기</label><br>
				<div id="reviewList">후기 리스트</div>
				<div>			
					<p>
					<label> 작성자 </label>
					<input type="text" class="form-control" id="reviewWriter_I" name="reviewWriter_I" placeholder="작성자">
					</p>
					<p>
					<label> 별점 : </label>&nbsp;
					<c:forEach var="i" begin="1" end="5">
						<label class="radio-inline">
						<input type="radio" class="scroe_Radio" name="score" value="${i }">
						<c:forEach var="j" begin="1" end="${i }">
							☆
						</c:forEach>
						</label>
					</c:forEach>
					</p>
					<div>
						<textarea class="form-control" id="summernote" name="reviewContent_Ta" placeholder="내용"></textarea>
					</div>
					<div class="col-sm-12 form-group">
							<button class="btn pull-right" type="submit" id="inquiry_Submit">Send</button>
					</div>
				</div>
			</div>
			<!-- 상품 문의 -->
			<div id="menu3" class="tab-pane fade">
				<label id="inquiry_Label">상품 문의</label><br> 
				<p><a href="/inquire/add">
					<button class="btn pull-right" id="inquiryAdd_B" name="ownernumber"	value="${productInfo[0].OWNERNUMBER }">
					문의하기 </button>
				</a></p>
				<div id="inquiryList">문의 리스트</div>
			</div>
		</div>
	</div>
</div>

<script>
var cnt=0;
var total=0;
// 총액 표기
function print() {	
	if(${productInfo[0].COLOR == "none"}){
		var t = ${productInfo[0].PRICE}*parseInt($("#stockCnt").val());
		console.log(t);
		$("#total_Span").html("<b>총 상품금액 <large style=\"color:blue;\">"+t+"원</large></b><input type=\"hidden\" name=\"total\" value=\""+t+"\">");
	}
	else{
		$("#total_Span").html("<b>총 상품금액 <large style=\"color:blue;\">"+total+"원</large></b><input type=\"hidden\" name=\"total\" value=\""+t+"\">");
	}
}
print();

//수량 minus
$("#minusA_B").click(function(){
	if(parseInt($("#stockCnt").val()) > 1){
		$("#stockCnt").val(parseInt($("#stockCnt").val())-1); 
		var n = $("#stockCnt").val();
		var price = ${productInfo[0].PRICE }*n;
		$("#priceA_Span").html("<b>"+price+"원</b>");
		print();
	}
});
// 수량 plus
$("#plusA_B").click(function(){	
	$("#stockCnt").val(parseInt($("#stockCnt").val())+1);
	var n = $("#stockCnt").val();
	var price = ${productInfo[0].PRICE }*n;
	$("#priceA_Span").html("<b>"+price+"원</b>");
	print();
});
 
// 옵션 선택시
$("#color_Select").change(function(){
	console.log($(this).val());
	if($(this).val()!="색상 옵션 선택"){
		cnt++; // script 전역 변수 -> 옵션 선택 갯수 제한
		if(cnt>0){
			$("#buyNow_B").prop("disabled",false);
			$("#cart_B").prop("disabled",false);
		}
		if(cnt> ${productInfo.size()}){
			var length = ${productInfo.size()};
			//console.log(length);
			cnt=length;
			$("#color_Select").val("색상 옵션 선택");
			return;
		}
		// 선택된 옵션 표기
		var optionValue=$(this).val();
		var	arr = optionValue.split("_");
		var sno = arr[0];
		var selectOption="<p>";
		selectOption += "<label>"+$(this).val()+"</label>";
		selectOption += "&nbsp;&nbsp;<button type=\"button\" class=\"minus_B\">-</button>";
		selectOption += "<input type=\"number\" name=\"stockCnt\" style=\"width: 40px;\" value=\"1\" min=\"1\" />";
		selectOption += "<button type=\"button\" class=\"plus_B\">+</button>";
		selectOption += "&nbsp;<button type=\"button\" class=\"remove_B\">X</button>";
		selectOption += "&nbsp;&nbsp;<span class=\"price_Span\">"+${productInfo[0].PRICE }+"</span>";
		selectOption += "<input type=\"hidden\" name=\"stockNo\" value=\""+sno+"\"><p>";
		$("#select_Span").append(selectOption);
		$("#color_Select").val("색상 옵션 선택");
		total+=${productInfo[0].PRICE };
		print();
		
		//먼저 걸려있던 이벤트 해제
		$(".minus_B").off("click"); 
		$(".plus_B").off("click");
		$(".remove_B").off("click");
		
		//수량 minus
		$(".minus_B").click(function(){
			if(parseInt($(this).next().val()) > 1){
				$(this).next().val(parseInt($(this).next().val())-1);
				var n = parseInt($(this).next().val());
				$(this).next().next().next().next().html(${productInfo[0].PRICE }*n);
				total-=${productInfo[0].PRICE };
				print();
			}
		}); 
		// 수량 plus
		$(".plus_B").click(function(){	
			$(this).prev().val(parseInt($(this).prev().val())+1);
			console.log($(this).prev().val());	
			var n = parseInt($(this).prev().val());
			$(this).next().next().html(${productInfo[0].PRICE }*n);
			total+=${productInfo[0].PRICE };
			print();
		});
		// 삭제
		$(".remove_B").click(function(){
			console.log($(this).next().html());
			total -= parseInt($(this).next().html());
			$(this).parent().remove();
			cnt--;
			console.log(cnt);
			print();
		});
	}
});

// 장바구니 버튼
$("#cart_B").click(function(){
	$("#selectListForm").attr("action","/shopping/cart");
	$("#selectListForm").submit();	
});

// summernote
$(document).ready(function(){
	$("#summernote").summernote({ // summernote 형태 추가
	    height: 200,
	    width: 600,
	    callbacks:{
	       onImageUpload: function(files, editor, welEditable){
	          for(var i=files.length -1; i>=0;i--){
	             sendFile(files[i], this);
	          }
	       }
	    }, 
	 });
});

function sendFile(file, el){
	var form_data = new FormData();
	form_data.append('file', file);
	$.ajax({
		data: form_data,
		type: "POST",
		url: '/product/uploadImage', // 이부분은 수정 필요 경로 변경
		cache: false,
		contentType: false,
		enctype: 'multipart/form-data',
		processData: false,
		success: function(url){
			$(el).summernote('editor.insertImage', url);
			$('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
		}
	});
}
// 페이지 로드시 상세보기 클릭한 효과 강제 적용
$("#home").trigger("click");

// 상품 후기 ajax
//후기 작성
$("#inquiry_Submit").click(function () {
	$.ajax({
		"type":"post", // default = get
		"async":false, // default = true;
		"url":"/product/addReview",
		"data":{
			"ownernumber":${productInfo[0].OWNERNUMBER},
			"id":'TEST',
			"writer":$("#reviewWriter_I").val(),
			"score":$("#score_Radio").val(),
			"contnet":$("#reviewContent_Ta").val(),
		},
	}).done(function(r){
		//console.log(r+"/"+typeof r);
		var obj = JSON.parse(r);
		window.alert(obj);
	});
	
})

</script>
