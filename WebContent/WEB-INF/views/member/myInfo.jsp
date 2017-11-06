<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<div>
	<h2>MY INFO</h2>
	<hr>
	*은 필수입력항목입니다.
	<form class="form-horizontal" action="/member/myInfoEdit" method="post">

		<div class="form-group">
			<label class="control-label col-sm-2" for="id">ID : </label> <label
				class="control-label col-sm-2" for="id">${readDetail.ID}</label>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="name">*Name : </label>
			<div class="col-sm-5">
				<input type="text" class="form-control" id="name" value="${readDetail.NAME}" name="name">
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="birth">Birth : </label>
			<div class="col-sm-5">
				<input type="date" class="form-control" id="birth" value="${readDetail.BIRTH}" name="birth">
			</div>
		</div>


		<div class="form-group">
			<label class="control-label col-sm-2" for="tel">*Tel : </label>
			<div class="col-sm-7">
				<input type="text" class="form-control" id="tel" value="${readDetail.TEL}" name="tel">
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="point">Point : </label>
			<label class="control-label col-sm-2" for="point">${readDetail.POINT}</label>
		</div>			

		<div class="form-group">
			<label class="control-label col-sm-2" for="address">*Address : </label>
			<div class="col-sm-9">
				<input type="text" id="postcode" name="postcode" placeholder="우편번호" value="${readDetail.POSTCODE}">
				<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
				<input type="text" id="addr1" name="addr1" placeholder="주소" style="width:400px;" value="${readDetail.ADDR1}">
				<input type="text" id="addr2" name="addr2" placeholder="상세주소" style="width:300px;" value="${readDetail.ADDR2}">
			</div>
		</div>

		<div class="form-group">
			<label class="control-label col-sm-2" for="joindate"> 가입일 : </label>
			<label class="control-label col-sm-2" for="joindate"> <fmt:formatDate value="${readJoinDate.JOINDATE}" pattern="yyyy-MM-dd"/> </label>
		</div>

		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="submit" id="submit" class="btn btn-default">MODIFY</button>
				<button type="reset" class="btn btn-default">RESET</button>
				<a href="/member/changePw"><button type="button" class="btn btn-default">비밀번호 변경</button></a>
				<a href="/member/drop"><button type="button" class="btn btn-default">탈퇴하기</button></a>
			</div>
		</div>

	</form>
</div>


<script>

// 빈칸 X
$(document).ready(function(){
	$("#submit").click(function(){
		if($("#name").val().length==0){alert("이름을 입력하세요"); $("#name").focus(); return false;}
		if($("#tel").val().length==0){alert("전화번호를 입력하세요"); $("#tel").focus(); return false;}
		if($("#postcode").val().length==0){alert("우편번호를 입력하세요"); $("#postcode").focus(); return false;}
		if($("#addr1").val().length==0){alert("주소를 입력하세요"); $("#addr1").focus(); return false;}
		if($("#addr2").val().length==0){alert("상세주소를 입력하세요"); $("#addr2").focus(); return false;}
	})
})


function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

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
