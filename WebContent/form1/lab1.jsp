<!-- 구현 실습1 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>  
input.form-control { width: 200px; }
select.form-control{width: 70px;}
</style>
</head>
<%
String number=request.getParameter("number");
int num=number==null?0:Integer.parseInt(number);
String cmd =request.getParameter("cmd");
if("++".equals(cmd)){
	num++;
}
if("--".equals(cmd)){
	num--;
}
%>
<body>
<form>
	<div class="form-group">
		<label>number:</label>
		<input type="text" name="number" value=<%=num %> class="form-control">
	</div>
	<div class="button">
		<input type="submit" name="cmd" value="++" class="btn btn-primary">
		<input type="submit" name="cmd" value="--" class="btn btn-primary">
	</div>
</form>
</body>
</html>
