<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*,Study.jdbc5.*,lecture1.*" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<%
int currentPage = 1;
int pageSize = 10;

request.setCharacterEncoding("UTF-8");
String pg = request.getParameter("pg");
if (pg != null) currentPage = ParseUtils.parseInt(pg, 1);

String srchText = request.getParameter("srchText");
if (srchText == null) srchText = "";
String srchTextEncoded = URLEncoder.encode(srchText, "UTF-8");

int recordCount = UserDAO.count(srchText);

int lastPage = (recordCount + pageSize - 1) / pageSize;
if (currentPage > lastPage) currentPage = lastPage;

List<User> list = UserDAO.findByName(srchText, currentPage, pageSize);
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
  </style>
</head>
<body>

<div class="container">
<h1>유저목록</h1>

<a id="createButton" class="btn btn-primary pull-right" 
   href="userCreate.jsp?pg=<%=currentPage%>&srchText=<%=srchTextEncoded%>">
  <i class="glyphicon glyphicon-plus"></i> 유저 등록
</a>

<form class="form-inline">
  <div class="form-group">
    <label>이름</label>
    <input type="text" class="form-control" name="srchText" value="<%= srchText %>" 
           placeholder="검색조건" />
  </div>
  <button type="submit" class="btn btn-primary">조회</button>
</form>

		<table class="table table-bordered table-condensed">
			<thead>
				<tr>
					<th>id</th>
					<th>userId</th>
					<th>password</th>
					<th>이름</th>
					<th>email</th>
					<th>학과번호</th>
					<th>enabled</th>
					<th>타입</th>
				</tr>
			</thead>
			<tbody>
				<% for (User user : list) { %>
				<tr
					data-url="userEdit.jsp?id=<%=user.getId()%>&pg=<%=currentPage%>&srchText=<%=srchTextEncoded%>">
					<td><%=user.getId()%></td>
					<td><%=user.getUserid()%></td>
					<td><%=user.getPassword() %>
					<td><%=user.getName() %></td>
					<td><%=user.getEmail() %></td>
					<td><%=user.getDepartmentId() %></td>
					<td><%=user.isEnabled() %></td>
					<td><%=user.getUserType() %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>

		<my:pagination pageSize="<%=pageSize%>" recordCount="<%=recordCount%>" queryStringName="pg" />

</div>
<script>
$("[data-url]").click(function() {
    var url = $(this).attr("data-url");
    location.href = url;
})
</script>
</body>
</html>
