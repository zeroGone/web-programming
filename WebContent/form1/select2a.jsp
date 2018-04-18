<!-- 선택 태그 연습2 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date,java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
  input.form-control { width: 200px; }
  select.form-control { width: 70px; }
  table.table {width:500px;}
  thead tr{background-color:#eee;}
</style>
</head>
<%
int number1=0;
int number2=0;
String num=request.getParameter("number1");
if(num!=null){number1=Integer.parseInt(num);}
num=request.getParameter("number2");
if(num!=null){number2=Integer.parseInt(num);}
int sum=0;
String cmd=request.getParameter("cmd");

if("+".equals(cmd)){
	sum=number1+number2;
}else if("-".equals(cmd)){
	sum=number1-number2;
}else if("*".equals(cmd)){
	sum=number1*number2;
}else if("/".equals(cmd)){
	sum=number1/number2;
}
%>
<body>
<div class ="container">
<h1>select 01</h1>
<form>
	<div class=form-group>
		<label>number1:</label>
		<input type = "text" name="number1" class="form-control" value=<%=number1 %>>
	</div>
	<div class=form-group>
		<label>operator:</label>
		<select name="cmd" class="form-control">
			<option value="+" <%="+".equals(cmd)?"selected":"" %>>+</option><!-- 선택되었을때 selected 문자열 출력 -->
			<option value="-" <%="-".equals(cmd)?"selected":"" %>>-</option>
			<option vlaue="*" <%="*".equals(cmd)?"selected":"" %>>*</option>
			<option vlaue="/" <%="/".equals(cmd)?"selected":"" %>>/</option>
		</select>
	</div>
	<div class=form-group>
		<label>number2:</label>
		<input type = "text" name="number2" class="form-control" value=<%=number2 %>>
	</div>
	<div class=form-group>
		<button type="submit"class="btn btn-primary">확인</button>
	</div>
</form>
</div>
<h1>request Parameter</h1>
<table class="table table-bordered">
	<thead>
		<tr>
			<th>Parameter Name</th>
			<th>Parameter Value</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>number1</td>
			<td><%=number1 %></td>
		</tr>
		<tr>
			<td>number2</td>
			<td><%=number2 %></td>
		</tr>
		<tr>
			<td>cmd</td>
			<td><%=cmd%></td>
		</tr>
		<tr>
			<td>method</td>
			<td><%=request.getMethod()%></td>
		</tr>
		<tr>
			<td>계산결과</td>
			<td><%=sum %></td>
		</tr>
		<tr>
			<td>시각</td>
			<td><%=new SimpleDateFormat("HH:MM:SS").format(new Date()) %></td>
		</tr>
	</tbody>
</table>
</body>
</html>