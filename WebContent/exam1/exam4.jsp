<!-- 버튼을 클릭할때마다 숫자가 느는 입력폼 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
input.form-control { width: 200px; }
</style>
<title>exam4</title>
<%
String input = request.getParameter("input");
int number=input==null?0:Integer.parseInt(input);
if(request.getParameter("input")!=null){
	number++;
}
%>
<body>
<div class="container">
	<form>
		<div class="form-group">
			<label>number1:</label>
			<input type="text" class="form-control" name="input" value=<%=number%>>
		</div>
		<button class="btn btn-primary" name="button">확인</button>
	</form>
</div>
</body>
</html>