<!-- 구현 실습2 -->
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
select.form-control { width: 200px; }
body form label { margin-right: 20px; } 
</style>
</head>
<%
	String one="",one_selected="",two="",two_selected="",three="",three_selected="",text= "";
	String select=request.getParameter("select");
	
	if("one".equals(select)){
		text="one";
		one="checked";
		one_selected="selected";
	}
	if("two".equals(select)){
		text="two";
		two="checked";
		two_selected="selected";
	}
	if("three".equals(select)){
		text="three";
		three="checked";
		three_selected="selected";
	}
%>
<body>
<form>
	<div class="form-group">
		<label>select1:</label>
		<select class="form-control" name="select">
			<option value="one" <%=one_selected%>>one</option>
			<option value="two" <%=two_selected%>>two</option>
			<option value="three" <%=three_selected%>>three</option>
		</select>
	</div>
	<div class="radio">
		<label><input type="radio" name="radio" value="two" <%=two %>>two</label>
		<label><input type="radio" name="radio" value="three" <%=three %>>three</label>
	</div>
	<div class="form-group">
		<input type="text" class="form-control" name="text" value=<%=text%>>
	</div>
	<div>
		<input type="submit" class="btn btn-primary" name="cmd" value="확인">
	</div>
</form>
</body>
</html>
