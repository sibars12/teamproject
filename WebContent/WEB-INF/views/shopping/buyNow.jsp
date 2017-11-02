<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<style>
	.tabName_D{
		font-family: 'Inconsolata-Bold';
		font-size: 19;
		margin: 8;
	}
	td{ margin: 5px;}
</style>
<div class="w3-container" align="center">
	<div align="left" class="tabName_D">ORDER</div>
	<div id="StockList">
		<table class="table">
			<tr>
				<td>상품명</td>
				<td>상품번호</td>
				<td>사이즈</td>
				<td>색상</td>
				<td>수량</td>
				<td>가격</td>
			</tr>
		<c:forEach var="i" begin="0" end="${stockNo.size()-1}">
			<tr>
				<td>${infoList[i].NAME }</td>
				<td>${infoList[i].OWNERNUMBER }</td>
				<td>${infoList[i].SIZE }</td>
				<td>${infoList[i].COLOR }</td>
				<td>${stockCnt[i] }</td>
				<td>${stockPrice[i] }</td>			
			</tr>
		</c:forEach>
		</table>
	</div>
	<hr>
	<form action="/shopping/buyNow" method="post">
		<div id="buyerInfo">
			<div align="left" class="tabName_D">구매자 정보</div>
			<table class="table">
				<tr>
					<th>받으실분 성함</th>
	    			<td><input type="text" class="form-control" id="name" name="name" placeholder="받는분 성함">	</td>
	    		</tr>
    			<tr>
	    			<th>우편번호</th>
	    			<td><input type="text" class="form-control" id="postcode" name="postcode" placeholder="우편번호">
	    				<button type="button" onclick="execDaumPostcode()">우편번호 찾기</button>
	    			</td>
	    		</tr>
	    		<tr>	    		
	    			<th>주소</th>
	    			<td><input type="text" class="form-control" id="addr1" name="addr1" placeholder="주소"></td>
	    			<td><input type="text" class="form-control" id="addr2" name="addr2" placeholder="상세주소"></td>
	    		</tr>
	    		<tr>
	    			<th>전화번호</th>
	    			<td><input type="text" class="form-control" name="tel" id="tel" placeholder="전화번호"></td>
	    		</tr>
			</table>
		</div>
		<hr>
		<div id="paymentInfo">
			<div align="left" class="tabName_D">결제할 금액</div>
			<table class="table">
				<tr>
					<th>주문 금액</th>
					<td><input type="hidden" name="totPrice" value="${totPrice }">${totPrice }</td>
				</tr>
				<tr>
					<th>배송료</th>
					<c:choose>
					<c:when test="${totPrice ge 30000}">
						<td><input type="hidden" name="delivery" id="delivery" value="0">무료 배송</td>
					</c:when>
					<c:otherwise>					
						<td><input type="hidden" name="delivery" id="delivery" value="2500">2500</td>
					</c:otherwise>
					</c:choose>
				</tr>
				<tr>
					<th colspan="2">포인트 사용</th>
				</tr>
				<tr>
					<td>보유포인트 : ${memInfo.POINT }</td>
					<td><input type="text" id="payPoint" name="payPoint" placeholder="사용할 포인트">
						
					</td>
				</tr>
				<tr>
					<th colspan="2">쿠폰 사용</th>
				</tr>
				<tr>
					<td>
						<select id="coupon">
						<option>쿠폰선택</option>
						<c:forEach var="i" items="${coupons}">	
							<option value="${i.DISCOUNT }" data="${i.NO }">${i.NAME }</option>
							
						</c:forEach>
						</select>
					</td>
					<td id="checkCoupon"></td>
				</tr>
				<tr>
					<td>최종 결제 금액</td>
					<td id="lastPay"></td>
				</tr>
				<tr>
					<th>적립 포인트  :<p id="point"></p> </th>
					<input type="hidden" id="addPoint" name="addPoint" value="0">
				</tr>							
			</table>		
		</div>
		<hr>
		<div id="paymentType">
			<div align="left" class="tabName_D">결제 방법</div>
			<table class="table">
				<tr><th colspan="2">결제 수단</th></tr>
				<tr>
					<td><input type="radio" class="type_Radio" name="type" value="계좌이체">실시간 계좌이체</td>
					<td><input type="radio" class="type_Radio" name="type" value="신용카드">신용카드</td>
				</tr>
				<tr id="banking" style="display:none" >
					<td colspan="2">
						<select id="bank">
							<option>----</option>
							<option>국민은행</option>
							<option>농협</option>
							<option>신한은행</option>
							<option>우리은행</option>
							<option>우체국</option>
							<option>하나은행</option>
						</select>
					</td>
				</tr>
				<tr id="credit" style="display:none">
					<td>
						<label>카드선택</label> : 
						<select id="card">
							<option>----</option>
							<option>국민카드</option>
							<option>농협카드</option>
							<option>롯데카드</option>
							<option>신한카드</option>
							<option>삼성카드</option>
							<option>우리카드</option>
							<option>하나카드</option>
							<option>현대카드</option>
							<option>BC카드</option>
						</select>
					</td>
					<td id="install" style="display:none">
						<label>할부 선택</label> :
						<select id="insta_Select">
							<option>일시불</option>
							<option>2개월</option>
							<option>3개월</option>
							<option>4개월</option>
							<option>5개월</option>
							<option>6개월</option>
						</select>
					</td>
				</tr>
			</table>		
		</div>
		<div id="hiddens">
					<input type="hidden" name="id" value="${auth }">
					<input type="hidden" name="stockNo" value="${stockNo }">
					<input type="hidden" name="StockCnt" value="${stockCnt }">
					<input type="hidden" name="infoList" value="${infoList }">
					<input type="hidden" id="kind" name="kind" value="">
					<input type="hidden" id="installment" name="installment" value="일시불">
					<input type="hidden" id="couponNo" name="couponNo" value="0" >
					<input type="hidden" id="couponDiscount" name="couponDiscount"  value="0">
					<input type="hidden" id="payment" name="payment" value="0">
		</div>
		<button type="submit" name="buy">구매하기</button>
	</form>
	
</div>
<script>
// 결제 타입 선택
$(".type_Radio").change(function(){
	var type = $(this).val();
	console.log(type);
	if(type=="계좌이체"){
		$("#credit").hide();
		$("#banking").show();
	}
	if(type=="신용카드"){
		$("#banking").hide();
		if($("#payment").val()>=50000){
			$("#install").show();
		}
		$("#credit").show();
	}
});
// 은행 선택시
$("#bank").change(function(){
	console.log($(this).val());
	if($(this).val()!="----"){
		$("#kind").val($(this).val());
	}
});
//카드 선택시
$("#card").change(function(){
	console.log($(this).val());
	if($(this).val()!="----"){
		$("#kind").val($(this).val())
		// 할부 선택
		$("#install_Select").change(function(){
			console.log($(this).val());
			$("#installment").val($(this).val());
		});
	}
});

//


//최종 결제 금액

</script>

<%--우편번호 찾기 --%> 
<script>
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) { // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = ''; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                fullAddr = data.roadAddress;

            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                fullAddr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
            if(data.userSelectedType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('postcode').value = data.zonecode; //5자리 새우편번호 사용
            document.getElementById('addr1').value = fullAddr;

            // 커서를 상세주소 필드로 이동한다.
            document.getElementById('addr2').focus();
        }
    }).open();
}

</script>