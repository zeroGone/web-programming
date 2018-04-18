<!-- 선택 태그 연습 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
  input.form-control { width: 200px; }
  select.form-control { width: 70px; }
</style>
</head>
<body>
<div class ="container">
<h1>select 01</h1>
<form action="text2action.jsp"><!-- text2action.jsp을 호출한다 -->
	<div class=form-group>
		<label>number1:</label>
		<input type = "text" name="number1" class="form-control">
	</div>
	<div class=form-group>
		<label>operator:</label>
		<select name="cmd" class="form-control">
			<option vlaue="+">+</option>
			<option vlaue="-">-</option>
			<option vlaue="*">*</option>
			<option vlaue="/">/</option>
		</select>
	</div>
	<div class=form-group>
		<label>number2:</label>
		<input type = "text" name="number2" class="form-control">
	</div>
	<div class=form-group>
		<button type="submit"class="btn btn-primary">확인</button>
	</div>
</form>
</div>
</body>
</html>