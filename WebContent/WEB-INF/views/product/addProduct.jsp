<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div align="center">
	<h2>상품 등록</h2>
	<form action="/product/test" method="post">
		<textarea  id="summernote" name="note"></textarea>
		<button type="submit">작성</button>
	</form>
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