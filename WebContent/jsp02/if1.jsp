<!-- 화면에 현재 시간에 따라 출력이 다른 문구 하나와 현재 시간 출력 -->
<%@ page import="java.text.SimpleDateFormat,java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>if1</title>
</head>
<%
Date today = new Date();
SimpleDateFormat f = new SimpleDateFormat("지금은 yyyy년 m월 dd일 hh시 mm분 ss초 입니다.");
int search;
String day = f.format(today);
%>
<body>

</body>
</html>