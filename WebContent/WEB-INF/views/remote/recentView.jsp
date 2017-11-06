<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div align="center" style="position:fixed">
	<div align="center" id="cookieView" style="border:1px;"></div>
	<a href="#"><button id="up" type="button">TOP</button></a>
</div>
<script>
function crequest(){
	$.ajax({
		"url":"/remote/recentView",
	}).done(function(obj){
		console.log(obj.ownInfo[0].OWNERNUMBER);
		
		var hm="<table><tr><th align=\"center\">최근 본 상품</th></tr>";
		for(var i in obj.ownInfo){
			hm += "<tr><td>";
			hm += "<a href=\"/product/view?ownernumber="+obj.ownInfo[i].OWNERNUMBER+"\">";
			hm += "<img alt=\"최근 이미지\" src=\"/images/product/"+obj.ownInfo[i].IMAG+"\" class=\"img-rounded\" width=\"60%\"><br>"+obj.ownInfo[i].NAME+"</a>";
			hm += "</td></tr>";
		}
		hm += "</table>";
		console.log(hm);
		$("#cookieView").html(hm);
	});
}
crequest();
window.onscroll = function() { // 스크롤할때마다
    var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
    
};
</script>
