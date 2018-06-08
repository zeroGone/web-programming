<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="login1.*, java.net.*, java.util.*, lecture1.*" %>
<%@ include file="/WEB-INF/include/checkAdmin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");

String 에러메시지 = null;
String s1 = request.getParameter("id");
int id = ParseUtils.parseInt(s1, 0);

String pg = request.getParameter("pg");
String ss = request.getParameter("ss");
String st = request.getParameter("st");
if (ss == null) ss = "0";
if (st == null) st = "";
String stEncoded = URLEncoder.encode(st, "UTF-8");

String od = request.getParameter("od");
User user = null;

if (request.getMethod().equals("GET")) {
    user = UserDAO.findOne(id);
}
else {
    user = UserService.createUser(request);
    에러메시지 = UserService.validate(user);
    if (에러메시지 == null) {
        UserDAO.update(user);
        response.sendRedirect("userList1.jsp?pg=" + pg + "&ss=" + ss + "&st=" + stEncoded + "&od=" + od);
        return;
    }
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
      input.form-control, select.form-control { width: 200px; }
      div.radios > label { font-size: 1em; font-weight: normal; margin-right: 20px; }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/include/menu.jsp" %>

<div class="container">

<h1>사용자 정보</h1>
<hr />

<form method="post">
  <div class="form-group">
    <label>사용자ID</label>
    <input type="text" class="form-control" name="loginId" value="<%= user.getLoginId() %>" />
  </div>
  <div class="form-group">
    <label>이름</label>
    <input type="text" class="form-control" name="name" value="<%= user.getName() %>" />
  </div>
  <div class="form-group">
    <label>이메일</label>
    <input type="text" class="form-control" name="email" value="<%= user.getEmail() %>" />
  </div>
  <div class="form-group">
    <label>학과</label>
    <select class="form-control" name="departmentId">
        <option value="0">없음</option>
      <% for (Department d : DepartmentDAO.findAll()) { %>
        <% Integer departmentId = user.getDepartmentId(); %>
        <% String selected = departmentId != null && departmentId == d.getId() ? "selected" : ""; %>
        <option value="<%= d.getId() %>" <%= selected %>>
           <%= d.getDepartmentName() %>
        </option>
      <% } %>
    </select>
  </div>
  <div class="form-group">
    <label>Enabled:
        <input type="checkbox" name="enabled" <%= user.isEnabled() ? "checked" : "" %> />
    </label>
  </div>
  <div class="form-group">
    <label>사용자 유형</label>
    <div class="radios">
       <% String userType = user.getUserType(); %>
       <label>
         <input type="radio" name="userType" value="관리자" <%= "관리자".equals(userType) ? "checked" : "" %> />
         관리자
       </label>
       <label>
         <input type="radio" name="userType" value="교수" <%= "교수".equals(userType) ? "checked" : "" %> /> 
         교수
       </label>
       <label>
         <input type="radio" name="userType" value="학생" <%= "학생".equals(userType) ? "checked" : "" %> /> 
         학생
       </label>
    </div>
  </div>
  <button type="submit" class="btn btn-primary">
    <i class="glyphicon glyphicon-ok"></i> 저장
  </button>
  <a href="userList1.jsp?pg=<%= pg %>&ss=<%= ss %>&st=<%=stEncoded%>&od=<%=od%>" 
     class="btn btn-default">
    <i class="glyphicon glyphicon-list"></i> 목록으로
  </a>
</form>

<hr />
<% if (에러메시지 != null) { %>
  <div class="alert alert-danger">
    사용자 저장 실패: <%= 에러메시지 %>
  </div>
<% } %>
</div>

<%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
