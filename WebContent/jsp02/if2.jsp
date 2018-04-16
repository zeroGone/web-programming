<!-- 1~9까지 채워진 표에 녹색과 노란색을 번갈아 가면 채운다 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>if2</title>
</head>
<style>
	table{border-collapse:collapse;}
	td{padding:5px;border:solid 1px gray;}
</style>
<body>
<table>
<tr>
<%for(int i=0; i<10; i++){ 
	if(i%2==0){
		out.print("<td style=\"background-color:#ccffcc\">"+i+"</td>");
	}else{
		out.print("<td style=\"background-color:#ffffcc\">"+i+"</td>");
	}
}%>
</tr>
</table>
</body>
</html>