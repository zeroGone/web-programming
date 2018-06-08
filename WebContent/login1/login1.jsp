<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*, login1.*" %>
<%
String loginId = "";
String password;
boolean autologin = false;
String 에러메시지 = null;
if (request.getMethod().equals("POST")) {
    loginId = request.getParameter("loginId");
    password = request.getParameter("password");
    autologin = (request.getParameter("autologin") != null);
    
    if (loginId == null || loginId.length() == 0) 
        에러메시지 = "사용자 아이디를 입력하세요";
    else if (password == null || password.length() == 0) 
        에러메시지 = "비밀번호를 입력하세요";
    else if (UserService.login(session, loginId, password)) { 
        response.sendRedirect("index.jsp");
        return;
    } else
        에러메시지 = "로그인 정보 불일치";
}
%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
      body { font-family: 굴림체; }
      input.form-control { width: 200px; }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/include/menu.jsp" %>

<div class="container">

<h1>로그인</h1>
<hr />

<form method="post">
  <div class="form-group">
    <label>사용자 아이디</label>
    <input type="text" class="form-control" name="loginId" value="<%= loginId %>" />
  </div>
  <div class="form-group">
    <label>비밀번호</label>
    <input type="password" class="form-control" name="password" />
  </div>
  <div class="checkbox">
    <label>
      <input type="checkbox" name="autologin" <%= autologin ? "checked" : "" %> /> 자동 로그인
    </label>
  </div>
  <button type="submit" class="btn btn-primary">
    <i class="glyphicon glyphicon-ok"></i> 로그인
  </button>
  <a href="#" class="btn btn-default">
    <i class="glyphicon glyphicon-user"></i> 회원가입
  </a>
</form>

<% if (에러메시지 != null) { %>
  <div class="alert alert-danger">
    로그인 실패: <%= 에러메시지 %>
  </div>
<% } %>
</div>

<%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
