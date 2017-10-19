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
<div class="container">

  <h2>JOIN</h2>
  <form class="form-inline" action="/login.jsp">
    <div class="form-group">
      <label class="sr-only" for="id">Id :</label>
      <input type="text" class="form-control" id="text" placeholder="Enter ID"  name="text">
    </div>
    <div class="form-group">
      <label class="sr-only" for="pw">Password:</label>
      <input type="password" class="form-control" id="pw" placeholder="Enter password" name="pw">
    </div>
    <div class="form-group">
      <label class="sr-only" for="email">Email:</label>
      <input type="email" class="form-control" id="email" placeholder="Enter email"  name="email">
    </div>
    <div class="form-group">
      <label class="sr-only" for="add">Address :</label>
      <input type="text" class="form-control" id="address" placeholder="Enter address"  name="address">
    </div>
    <button type="submit" class="btn btn-default">Join</button>
  </form>
</div>

</body>
</html>
