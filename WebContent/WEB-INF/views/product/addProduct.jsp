<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	input{
		margin: 10;
		padding: 5;
	}
</style>

<div align="center">
	<h2>상품 등록</h2>
	<div align="left" style="width: 700;">
		<form action="/product/test" method="post">
			<input type="text" placeholder="제목">
			<textarea  id="summernote" name="note"></textarea>
			<input type="file" name="profile" id="profile">
			<button type="submit">작성</button>
		</form>
	</div>
</div>
<div>${obj }</div>


<script>
	$(document).ready(function(){
		$('#summernote').summernote({
			height: 300,
			width: 700,
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
			url: '/product/uploadImage',
			cache: false,
			contentType: false,
			enctype: 'multipart/form-data',
			processData: false,
			success: function(url){
				window.alert('aa');
				$(el).summernote('editor.insertImage', url);
				$('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
			}
		});
	}
</script>