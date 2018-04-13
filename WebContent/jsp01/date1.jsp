<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date, java.text.SimpleDateFormat" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>date1</title>
</head>
<body>
<h1>날짜 출력</h1>
<%
Date date = new Date();
String[] s= new String[3];
SimpleDateFormat f1 = new SimpleDateFormat("yyyy-MM-dd a hh:mm:ss");
s[0] = f1.format(date);
SimpleDateFormat f2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
s[1] = f2.format(date);
SimpleDateFormat f3 = new SimpleDateFormat("yy-M-d a H:m:s");
s[2] = f3.format(date);
%>
<%for(int i=0;i<3;i++){ %>
<div><%=s[i]%></div>
<%}%>
</body>
</html>