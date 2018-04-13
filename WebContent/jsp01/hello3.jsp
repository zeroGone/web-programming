<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>hello3</title>
</head>
<style>
	table{border-collapse:collapse;}
	td{padding:5px;border:solid 1px gray;}
</style>
<body>
<%
String h="hello world";
String s="JSP!";
%>
<table>
<tr>
	<td><%out.print(h);%></td><td><%=h%></td>
</tr>
<tr>
	<td><%out.print(h.toUpperCase());%></td><td><%=h.toUpperCase()%></td>
</tr>
<tr>
	<td><%out.print(Math.PI);%></td><td><%=Math.PI%></td>
</tr>
<tr>
	<td><%out.print(h+" "+s);%></td><td><%=h+" "+s%></td>
</tr>
</table>
</body>
</html>