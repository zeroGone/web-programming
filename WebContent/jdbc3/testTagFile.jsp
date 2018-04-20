<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>testTag</title>
</head>
<body>
<div class="container">
<h1>JSP 태그 파일 테스트</h1>
<p>
  <my:dateTime format="yyyy-MM-dd" />
</p>  

<p>
  <my:dateTime format="yyyy-MM-dd HH:mm" />
</p>  

<p>
  <my:dateTime format="yyyy-MM-dd HH:mm:ss" date="<%= new Date() %>" />
</p>  

</div>
</body>
</html>