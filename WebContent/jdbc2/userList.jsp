<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Study.jdbc2.*" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
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
      table.table { width: 700px; }
  </style>
</head>
<%
int currentPage=1;
int pageSize=10;

String pg = request.getParameter("pg");
if(pg!=null) currentPage=Integer.parseInt(pg);

List<User> list = UserDAO.findAll(currentPage, pageSize);

int recordCount=UserDAO.count();

int pageCount=(int)Math.ceil((double)(recordCount/pageSize));
%>
<body>
<div class="container">
<h1>유저목록</h1>

<table class="table table-bordered table-condensed">
    <thead>
        <tr>
            <th>id</th>
            <th>userid</th>
            <th>이름</th>
            <th>이메일</th>
            <th>직업</th>
        </tr>
    </thead>
    <tbody>
        <% for (User user : list) { %>
            <tr>
                <td><%=user.getId() %></td>
                <td><%=user.getUserid() %></td>
                <td><%=user.getName() %></td>
                <td><%=user.getEmail() %></td>
                <td><%=user.getUserType() %></td>
            </tr>
        <% } %>
    </tbody>
</table>

<my:pagination pageSize="<%= pageSize %>" recordCount="<%= recordCount %>" queryStringName="pg" />
</br>

<%if(currentPage>1) {%>
	<a class="btn btn-default" href="userList.jsp?pg=<%=currentPage-1%>">&lt;</a>
<%} %>
<%if(currentPage<=pageCount) {%>
	<a class="btn btn-default" href="userList.jsp?pg=<%=currentPage+1%>">&gt;</a>
<%} %>

</div>
</body>
</html>