<!-- 구구단을 2줄로 출력하는 표를 만들어라 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
	table{border-collapse:collapse;}
	td{padding:5px;border:solid 1px gray;}
</style>
<body>
<table>
<tr>
<%for(int i=2; i<10; i++){
	if(i==6){
		out.print("</tr><tr>");
	}
	out.println("<td>");
	for(int j=1; j<10; j++){
		out.println(i+"x"+j+"="+i*j+"</br>");
	}
	out.println("</td>");
}
%>
</tr>
</table>
</body>
</html>