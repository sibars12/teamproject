<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.myPageSection_D{
		height: 100;
		border: 1px solid rgb(200,200,200);
		padding: 3 12;
		margin-bottom: 20px;
	}
	.myPageIndex_D{
		width : 850;
		margin-top: 25!important;
	}
	.myPageSecT_D{
		font-family: 'Saira-Medium';
		font-size: 15;
		border-bottom: 1px dotted black;
		padding-bottom: 3!important;
		padding-top: 3!important;
	}
	.myPageSecV_D{
		font-family: 'Saira-Light';
		font-size: 12;
		padding-bottom: 3!important;
		padding-top: 3!important;
	}
	.myPage_A{
		color: black;
	}
	.myPage_A:hover{
		text-decoration: none;
		color: black;
	}
	.myPageTitle_D{
		margin-left: 70;
		margin-bottom: 30;
		padding: 20;
		font-family: 'Inconsolata';
		font-size: 20;
	}
</style>
<div align="center">
	<div align="left" class="myPageTitle_D">My Page</div>
	<div align="left" class="myPageIndex_D row content">
		<div class="col-sm-4">
			<div class="myPageSection_D">
				<div class="myPageSecT_D" style="margin-bottom:2;"><a href="/mypage/order" class="myPage_A">Order</a></div>
				<div class="myPageSecV_D"><a href="/mypage/order" class="myPage_A">고객님께서 주문하신 상품의<br/>주문내역을 확인하실 수 있습니다</a></div>
			</div>
			<div class="myPageSection_D">
				<div class="myPageSecT_D" style="margin-bottom:2;"><a href="/mypage/board" class="myPage_A">Board</a></div>
				<div class="myPageSecV_D"><a href="/mypage/board" class="myPage_A">고객님께서 작성하신 상품의<br/>글들을 확인하실 수 있습니다</a></div>
			</div>
		</div>
		<div class="col-sm-4">
			<div class="myPageSection_D">
				<div class="myPageSecT_D" style="margin-bottom:2;"><a href="/member/myInfo" class="myPage_A">Profile</a></div>
				<div class="myPageSecV_D"><a href="/member/myInfo" class="myPage_A">고객님의 정보를<br/>관리 하실 수 있습니다</a></div>
			</div>
		</div>
		<div class="col-sm-4">
			<div class="myPageSection_D">
				<div class="myPageSecT_D" style="margin-bottom:2;"><a href="/mypage/coupon" class="myPage_A">Coupon</a></div>
				<div class="myPageSecV_D"><a href="/mypage/coupon" class="myPage_A">쿠폰을 등록하거나<br/>등록하신 쿠폰 목록을<br/>확인하실 수 있습니다</a></div>
			</div>
		</div>
	</div>
</div>
<script>
	
</script>