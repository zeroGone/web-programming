<!-- 텍스트 입력폼 연습3 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
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
table.table { width: 500px; }
thead tr { background-color: #eee; }  
</style>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8"); 
Date date =new Date();
SimpleDateFormat f = new SimpleDateFormat("HH:MM:SS");
String str = f.format(date);
String text1=request.getParameter("text1");
String text2=request.getParameter("text2");
if(text1==null){
	text1="";
}
if(text2==null){
	text2="";
}
%>
<div class="container">
	<form action = "text3a.jsp" method="get">
	<h1>텍스트 입력폼</h1>
	<div class="form-group">
		<label>text1:</label>
		<input type="text" name="text1" class="form-control" value="hello">
	</div>
	<div class="form-group">
		<label>text2:</label>
		<input type="text" name="text2" class="form-control" value="world">
	</div>
	<div class="form-group">
		<label>time:</label>
		<input type="text" name="time" class="form-control" value=<%=str %>>
	</div>
	<div class="form-group">
		<input type="submit" name="cmd" class="btn btn-primary" value="확인">
	</div>
	</form>
	
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>Parameter Name</th>
				<th>Parameter Value</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>text1</td>
				<td><%=text1%></td>
			</tr>
			<tr>
				<td>text2</td>
				<td><%=text2%></td>
			</tr>
			<tr>
				<td>time</td>
				<td><%=request.getParameter("time")%></td>
			</tr>
		</tbody>
	</table>
</div>
</body>
</html>