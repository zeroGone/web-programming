<!-- 현재 시간을 출력하고 현재 시간에 따라 간단한 인사문 출력 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>if1<title>
</head>
<body>
	<%
		Date now = new Date();
		Calendar calendar = GregorianCalendar.getInstance();
		calendar.setTime(now);
		int hour = calendar.get(Calendar.HOUR_OF_DAY);
		
		SimpleDateFormat f = new SimpleDateFormat("지금은 YYYY년  MM월 DD일 HH시 MM분 SS초 입니다.");
		String toDay = f.format(now);
	%>
	<%
		if (hour < 12) {
	%>
	Good Morning!
	<%
		} else if (hour < 18) {
	%>
	Good Afternoon!
	<%
		} else {
	%>
	Good Evening!
	<%
		}
	%>
	<br />
	<%=toDay%>
</body>
</html>