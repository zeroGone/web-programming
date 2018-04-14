<%--화면에 1부터 16까지 정사각형으로 채워진 표그리기 --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>loop4</title>
</head>
<style>
	table{border-collapse:collapse;}
	td{padding:5px;border:solid 1px gray;}
</style>
<body>
<table>
<%for(int i=1;i<17;i++){ %>
	<%if(i%4==1){%><tr><%} %>
<td><%=i %></td>
	<%if(i%4==0){ %></tr><%} %>
<%} %>
</table>
</body>
</html>