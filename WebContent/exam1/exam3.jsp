<!-- 화면에 텍스트를 입력하면 두 입력폼이 바뀌어서 출력되는  입력폼 -->
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
<title>exam3</title>
<%
String text1=request.getParameter("text1");
String text2=request.getParameter("text2");
if(text1==null&&text2==null){
	text1="hello";
	text2="world";
}else{
	text1=request.getParameter("text2");
	text2=request.getParameter("text1");
}
%>
<body>
<div class="container">
	<form>
		<div class="form-group">
			<label>text1:</label>
			<input class="form-control" type="text" name="text1" value=<%=text1%>>
		</div>
		<div class="form-group">
			<label>text2:</label>
			<input class="form-control" type="text" name="text2" value=<%=text2%>>
		</div>
		<div class="form-group">
			<button class="btn btn-primary">확인</button>
		</div>
	</form>
</div>
</body>
</html>