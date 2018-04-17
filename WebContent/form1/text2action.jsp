<!-- text2.jsp의 request parameter -->
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
  table.table { width: 500px; }
  thead tr { background-color: #eee; }
</style>
</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>
<%
String num=request.getParameter("number1"); 
int number1=Integer.parseInt(num);
num=request.getParameter("number2");
int number2=Integer.parseInt(num);
String cmd =request.getParameter("cmd");
%>
	<div class="container">
		    <h1>request parameter</h1> 
			<table class="table table-borderd">
				<thead>
					<tr>
						<td>Parameter Name</td>
						<td>Parameter Value</td>
					</tr>
				</thead>
					<tr>
						<td>number1</td>
						<td><%=number1%></td>	
					</tr>
					<tr>
						<td>number2</td>
						<td><%=number2%></td>
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
						<td>
							<%if(cmd.equals("+")) {
								out.print(number1+number2);
							}else if(cmd.equals("-")){
								out.print(number1-number2);
							}else if(cmd.equals("*")){
								out.print(number1*number2);
							}else{
								out.print(number1/number2);
							}
							%>
						</td>
					</tr>
			</table>
	</div>
 
</body>
</html>