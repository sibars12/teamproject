<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>


	<div>
		<h2>MY INFO</h2>
		<hr>
		*은 필수입력항목입니다.
		<form class="form-horizontal" action="/member/myInfoEdit"
			method="post">

			<div class="form-group">
				<label class="control-label col-sm-2" for="id">ID : </label> <label
					class="control-label col-sm-2" for="id">${readDetail.ID}</label>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="name">*Name : </label>
				<div class="col-sm-5">
					<input type="text" class="form-control" id="name"
						value="${readDetail.NAME}" name="name">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="birth">*Birth : </label>
				<div class="col-sm-5">
					<input type="date" class="form-control" id="birth"
						value="${readDetail.BIRTH}" name="birth">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="address">*Address
					: </label>
				<div class="col-sm-9">
					<input type="text" class="form-control" id="address"
						value="${readDetail.ADDRESS}" name="address">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="tel">*Tel : </label>
				<div class="col-sm-7">
					<input type="text" class="form-control" id="tel"
						value="${readDetail.TEL}" name="tel">
				</div>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="point">Point : </label>
			</div>

			<div class="form-group">
				<label class="control-label col-sm-2" for="joindate">가입일 : </label>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-default">MODIFY</button>
					<button type="reset" class="btn btn-default">RESET</button>
					<a href="/member/drop"><button type="button" class="btn btn-default">탈퇴하기</button></a>
				</div>
			</div>

		</form>
	</div>

</body>
</html>


