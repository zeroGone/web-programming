<!-- 학과 정보를 받아와서 출력하는 jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Study.jdbc1.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<title>departmentList</title>
<%
List<Department> list = DepartmentDAO.findAll();
%>
<body>
<h1>학과정보</h1>
<table class="table table-bordered table-condensed">
	<thead>
		<tr>
			<th>학과번호</th>
			<th>학과이름</th>
		</tr>
	</thead>
	<tbody>
		<%for(Department department:list){%>
			<tr>
				<td><%=department.getId()%></td>
				<td><%=department.getName()%></td>
			</tr>
		<%} %>
	</tbody>
</table>
</body>
</html>