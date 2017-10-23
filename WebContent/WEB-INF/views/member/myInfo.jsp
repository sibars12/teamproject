<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>


<div>
  <h2>MY INFO</h2>
  <hr>
  <form class="form-horizontal" action="/member/myInfoOk" method="post">
  
  	<div class="form-group">
      <label class="control-label col-sm-2" for="name">NAME : </label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" id="name" placeholder="${detail.name}" name="name">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="birth">Birth : </label>
      <div class="col-sm-5">          
        <input type="text" class="form-control" id="birth" placeholder="${detail.birth}" name="birth">
      </div>
    </div>
  	
    <div class="form-group">
      <label class="control-label col-sm-2" for="address">Adress : </label>
      <div class="col-sm-9">
        <input type="text" class="form-control" id="address" placeholder="${detail.address}" name="adress">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="tel">Tel : </label>
      <div class="col-sm-7">
        <input type="text" class="form-control" id="tel" placeholder="${detail.tel}" name="tel">
      </div>
    </div>
    
    <div class="form-group">
      <label class="control-label col-sm-2" for="point">Point : </label>
      <div class="col-sm-5">
        <input type="text" class="form-control" id="point" placeholder="${detail.point}" name="point">
      </div>
    </div>
    
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-10">
        <button type="submit" class="btn btn-default">MODIFY</button>
        <a href="/member/home"><button type="reset" class="btn btn-default">CANCEL</button></a>
      </div>
    </div>
  </form>
</div>

</body>
</html>







