<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, java.net.*, login1.*, lecture1.* "%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<%@ include file="/WEB-INF/include/checkAdmin.jsp" %>
<%  
int currentPage = 1;
int pageSize = 10;

request.setCharacterEncoding("UTF-8");
String pg = request.getParameter("pg");
if (pg != null) currentPage = ParseUtils.parseInt(pg, 1);

String ss = request.getParameter("ss");
String st = request.getParameter("st");
if (ss == null) ss = "0";
if (st == null) st = "";
String stEncoded = URLEncoder.encode(st, "UTF-8");

int recordCount = UserDAO.count(ss, st);

int lastPage = Math.max(1, (recordCount + pageSize - 1) / pageSize);
if (currentPage > lastPage) currentPage = lastPage;

String od = request.getParameter("od");
if (od == null) od = "0";
List<User> list = UserDAO.findAll(currentPage, pageSize, ss, st, od);
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
      thead th { background-color: #eee; }
      tr:hover td { background-color: #ffe; cursor: pointer; }
      table.table { margin-top: 5px; }
      select[name=od] { margin-right: 20px; }
  </style>
</head>
<body>
<%@ include file="/WEB-INF/include/menu.jsp" %>

<div class="container">
<h1>사용자 목록</h1>

<form class="form-inline">
  <div class="form-group">
    <label>정렬</label>
    <select name="od" class="form-control">
      <option value="0" <%= "0".equals(od) ? "selected" : "" %>>등록순서</option>
      <option value="1" <%= "1".equals(od) ? "selected" : "" %>>로그인ID</option>
      <option value="2" <%= "2".equals(od) ? "selected" : "" %>>이름</option>
      <option value="3" <%= "3".equals(od) ? "selected" : "" %>>학과명</option>
    </select>
    <select name="ss" class="form-control">
      <option value="0" <%= "0".equals(ss) ? "selected" : "" %>>전체</option>
      <option value="1" <%= "1".equals(ss) ? "selected" : "" %>>이름</option>
      <option value="2" <%= "2".equals(ss) ? "selected" : "" %>>로그인ID</option>
      <option value="3" <%= "3".equals(ss) ? "selected" : "" %>>사용자유형</option>
      <option value="4" <%= "4".equals(ss) ? "selected" : "" %>>학과명</option>
    </select>
    <input type="text" class="form-control" name="st" value="<%= st %>" />
  </div>
  <button type="submit" class="btn btn-primary">조회</button>
</form>

<table class="table table-bordered table-condensed">
  <thead>
    <tr>
      <th>ID</th>
      <th>로그인ID</th>
      <th>이름</th>
      <th>이메일</th>
      <th>학과</th>
      <th>enabled</th>
      <th>사용자 유형</th>
    </tr>
  </thead>
  <tbody>
    <% for (User user : list) { %>
      <tr data-url="userEdit1.jsp?id=<%=user.getId()%>&pg=<%=currentPage%>&ss=<%=ss%>&st=<%=stEncoded%>&od=<%=od%>">
        <td><%=user.getId() %></td>
        <td><%=user.getLoginId() %></td>
        <td><%=user.getName() %></td>
        <td><%=user.getEmail() %></td>
        <td><%=user.getDepartmentName() %></td>
        <td><%=user.isEnabled()  %></td>
        <td><%=user.getUserType() %></td>
      </tr>
    <% } %>
  </tbody>
</table>

<my:pagination pageSize="<%= pageSize %>" recordCount="<%= recordCount %>" queryStringName="pg" />

</div>
<script>
$("[data-url]").click(function() {
    var url = $(this).attr("data-url");
    location.href = url;
})
</script>

<%@ include file="/WEB-INF/include/footer.jsp" %>
</body>
</html>
