<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.rkqms {
	border-bottom: 1px solid;
	text-align: left;
}
th, td {
	padding: 10px;
}
</style>


<div class="container-fluid">
	<div class="row">
		<!-- 내용 -->
		<div class="col-sm-6">
			<%-- 사진 	--%>
			<div align="center">
				<c:choose>
					<c:when test="${!empty productInfo[0].IMAG}">
						<img src="/images/product/${productInfo[0].IMAG}"
							class="img-rounded" alt="상품이미지" width="70%"/>
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
					<td>4만원 이상 구매시 무료배송</td>
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
										<option id="${m.COLOR}" value="${m.NO }" data="${m.COLOR}" title="${m.VOLUME }" disabled>
											${m.COLOR }-일시품절</option>
									</c:when>
									<c:otherwise>
										<option id="${m.COLOR}" value="${m.NO }" data="${m.COLOR}" title="${m.VOLUME }" >${m.COLOR }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select> <span id="select_Span">
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
							&nbsp;&nbsp; 
							<!-- 수량 -->
							<button type="button" id="minusA_B">-</button>
							<input id="stockCnt" name="stockCnt" type="number" style="width: 40px;"	value="1" min="1" />
							<button type="button" id="plusA_B">+</button>&nbsp;&nbsp; 
							<span id="priceA_Span"><b>${productInfo[0].PRICE }원</b></span>
							<input type="hidden" id="stockNo" name="stockNo" value="${productInfo[0].NO }">
							<input type="hidden" id="stockPrice" name="stockPrice" value="0">
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
				<div>
					<c:if test="${!empty auth }">			
					<p>
					
					<label for="reviewWriter_I"> 작성자 </label>
					<input type="text" class="form-control" id="reviewWriter_I" name="reviewWriter_I" placeholder="작성자" >
					<input type="hidden" id="pname" value="${productInfo[0].NAME }">
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
						<textarea class="form-control" id="reviewContent_Ta" name="reviewContent_Ta" placeholder="내용"></textarea>
					</div>
					<div class="col-sm-12 form-group">
						<button class="btn pull-right" type="submit" id="review_Submit">Send</button>
					</div>
					</c:if>
				</div>
				<div id="reviewList">
					
				</div>
			</div>
			<!-- 상품 문의 -->
			<div id="menu3" class="tab-pane fade">
				<label id="inquiry_Label">상품 문의</label><br> 
				<p><a href="/inquire/add?ownernumber=${productInfo[0].OWNERNUMBER }">
					<button class="btn pull-right" id="inquiryAdd_B" name="ownernumber"	value="${productInfo[0].OWNERNUMBER }">
					문의하기 </button>
				</a></p>
				<div id="inquiryList" align="center" style="line-height: 35px">
					<p align="right" style="margin-right: 30px;">
						총 <b>${cnt }</b> 개의 문의가 등록되어 있습니다.
					</p>
					<div class="w3-container">
						<table class="w3-table-all w3-margin-top" id="nn">
							<tr class="rkqms">
								<th style="width: 20%;">이름</th>
								<th style="width: 40%;">문의 내용</th>
								<th style="width: 20%;">문의한 날자</th>
							</tr>
						<c:forEach var="obj" items="${list }" begin="0" end="4">
							<tr>
								<td>
									<p>${obj.NAME }</p>
								</td>
								<td>
									<button onclick="inquire('memo${obj.NUM}')"	class="w3-btn w3-block w3-Gray w3-left-align">
										${obj.CONTENT }</button>
									<div id="memo${obj.NUM}" class="w3-container w3-hide">
										<p>${obj.TITLE }</p>
										<input type="hidden" id="truepass${obj.NUM }" value="${obj.PASS }" />
										<input type="password" id="${obj.NUM }" onkeyup="passcheck(${obj.NUM });"maxlength="4" /> 
										<a href="/inquire/del?num=${obj.NUM }&ownernumber=${obj.OWNERNUMBER}">
											<button id="del${obj.NUM }" disabled="disabled"	type="button">삭제</button>
										</a>
									</div>
								</td>
								<td>
									<p><fmt:formatDate pattern="yyyy.MM.dd " value="${obj.INDATE }" /></p>
								</td>
							</tr>
						</c:forEach>
					</table>
					<a href="/inquire/list?page=1&ownernumber=${ownernumber }"><button type="button">문의 내용 더보기</button></a>
					</div>
				</div><!-- 문의 리스트 닫음 -->
			</div><!-- 문의하기 tap 닫음 -->
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
		$("#total_Span").html("<b>총 상품금액 <large style=\"color:blue;\">"+t+"원</large></b><input type=\"hidden\" name=\"totPrice\" value=\""+t+"\">");
	}
	else{
		$("#total_Span").html("<b>총 상품금액 <large style=\"color:blue;\">"+total+"원</large></b><input type=\"hidden\" name=\"totPrice\" value=\""+total+"\">");
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
		$("#stockPrice").val(price);
		print();
	}
});
// 수량 plus
$("#plusA_B").click(function(){		
	if($("#stockCnt").val()>=${productInfo[0].VOLUME}){
		window.alert("최대수량입니다.");
		$("#stockCnt").val(${productInfo[0].VOLUME});		
	}else{		
	$("#stockCnt").val(parseInt($("#stockCnt").val())+1);
	}
	var n = $("#stockCnt").val();
	var price = ${productInfo[0].PRICE }*n;
	$("#priceA_Span").html("<b>"+price+"원</b>");
	$("#stockPrice").val(price)
	print();
});
 
// 옵션 선택시
$("#color_Select").change(function(){
	console.log($(this).val());
	var optionValue=$(this).val();
	var maxVolume=0;
	var data = $("#color_Select option:selected").attr("data");
	console.log("data:"+data);
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
		$("#color_Select option:selected").prop("disabled",true);
		// 선택된 옵션 표기
		console.log(optionValue);
		var selectOption="<p>";
		selectOption += "<label >"+data+"</label>";
		selectOption += "&nbsp;&nbsp;<button type=\"button\" class=\"minus_B\">-</button>";
		selectOption += "<input type=\"number\" name=\"stockCnt\" style=\"width: 40px;\" value=\"1\" min=\"1\" />";
		selectOption += "<button type=\"button\" class=\"plus_B\">+</button>";
		selectOption += "&nbsp;<button type=\"button\" class=\"remove_B\">X</button>";
		selectOption += "&nbsp;&nbsp;<span class=\"price_Span\">"+${productInfo[0].PRICE }+"</span>";
		selectOption += "<input type=\"hidden\" name=\"stockNo\" value=\""+optionValue+"\">";
		selectOption += "<input type=\"hidden\" name=\"stockPrice\" value=\""+${productInfo[0].PRICE }+"\"></p>";
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
				var price = ${productInfo[0].PRICE }*n;
				$(this).next().next().next().next().html(price);
				$(this).next().next().next().next().next().next().val(price);
				total-=${productInfo[0].PRICE };
				print();
			}
		}); 
		// 수량 plus
		$(".plus_B").click(function(){	
			var optionName = $(this).prev().prev().prev().text();
			console.log(optionName);
			maxVolume = $("#"+optionName).attr("title");
			console.log("max"+maxVolume);
			if(parseInt($(this).prev().val())>= parseInt(maxVolume))	{
				window.alert("최대수량입니다.");
				$(this).prev().val(maxVolume);
				var n = parseInt($(this).prev().val());
				var price = ${productInfo[0].PRICE }*n;
				$(this).next().next().html(price);
				$(this).next().next().next().next().val(price);
			}
			else{
			$(this).prev().val(parseInt($(this).prev().val())+1);
				console.log($(this).prev().val());	
				var n = parseInt($(this).prev().val());
				var price = ${productInfo[0].PRICE }*n;
				$(this).next().next().html(price);
				$(this).next().next().next().next().val(price);
				total+=${productInfo[0].PRICE };
			}
				print();
			
		});
		// 삭제
		$(".remove_B").click(function(){
			var reflash = $(this).prev().prev().prev().prev().text();
			console.log("reflash:"+reflash);
			$("#"+reflash).attr("disabled",false);
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
	$("#selectListForm").attr("action","/shopping/cartDb");
	$("#selectListForm").submit();	
});

// 페이지 로드시 상세보기 클릭한 효과 강제 적용
$("#home").trigger("click");

// 상품 후기 ajax
//후기 리스트
function reviewList(p){
	$.ajax({
		"type":"post", // default = get
		"async":false, // default = true;
		"url":"/product/reviewList",
		"data":{
			"ownernumber":${productInfo[0].OWNERNUMBER},
			"page":p,
		}
	}).done(function(obj){	
		var list = "<table class=\"table table-hover\"><tr><th>작성자</th><th>별점</th><th>후기</th><tr>";
		for(i in obj.list){
			var star ="";  
			for(var j=0; j<obj.list[i].SCORE; j++){
				star += "☆";
			}
			list += "<tr><td>"+obj.list[i].WRITER+"</td>";
			list += "<td>"+star+"</td>";
			list += "<td>"+obj.list[i].CONTENT+"</td></tr>";
		}
		list += "</table><div id=\"paging\">";
		
		if((obj.startPage-1)!=0){
			list += "<a class=\"w3-button\" href=\"javascript:reviewList("+(obj.startPage-1)+")\">&laquo;</a>"
		}
		for(var i=obj.startPage; i<=obj.endPage; i++){
			if(i != obj.page){
				list += "&nbsp;<a href=\"javascript:reviewList("+i+")\"><b>"+i+"</b></a>";
			}else{
				list += "&nbsp;<b style=\"color:red\">"+i+"</b>";
			}
		}
		if(obj.endPage%5==0 && obj.pageCount>obj.endPage){
			list += "<a class=\"w3-button\" href=\"javascript:reviewList("+(obj.endPage+1)+")\">&raquo;</a>"
		}
		list += "</div>"
		$("#reviewList").html(list);
	});
} 
reviewList(1);
//후기 작성
$("#review_Submit").click(function () {
	
	var writer = $("#reviewWriter_I").val();
	var score = $(":input[name=score]:radio:checked").val();
	var scoreSelected = $(":input[name=score]:radio:checked").length;
	var con = $("#reviewContent_Ta").val();
	var pname=$("#pname").val();
	var id = "${auth}";
	console.log(pname);
	if(writer=="" || scoreSelected==0 || con==""){
		window.alert("항목을 모두 기입해주세요");
		return;
	}
	$.ajax({
		"type":"get", // default = get
		"async":false, // default = true;
		"url":"/product/addReview",
		"data":{
			"ownernumber":${productInfo[0].OWNERNUMBER},
			"pname": pname,
			"id":id, 
			"writer":writer,
			"score": score,
			"content":con,
		}
	}).done(function(r){
		var obj = JSON.parse(r);
		$("#reviewWriter_I").val("");
		$(":input[name=score]:radio:checked").attr("chaeckd",false);
		//$("#color_Select").attr("chaeckd",false);
		$("#reviewContent_Ta").val("");
		reviewList(1);
	});
});

// 상품 문의
// 클릭시 내용나오게
	function inquire(id) {
		var x = document.getElementById(id);
		if (x.className.indexOf("w3-show") == -1) {
			x.className += " w3-show";
		} else {
			x.className = x.className.replace(" w3-show", "");
		}
	}
//비밀번호 맞으면 버튼 on
	function passcheck(z){
		var x = document.getElementById(z).value;
		var y = document.getElementById("truepass"+z).value;
		if(x==y){
			$("#del"+z).removeAttr("disabled");
		}else{
			$("#del"+z).attr("disabled",true); 
		}
	}
	
</script>
