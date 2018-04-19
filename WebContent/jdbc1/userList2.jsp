<!-- user 테이블의 정보를 받아오는 와서 그리는 JSP 파일 -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Study.jdbc1.*" %>
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
String name=request.getParameter("inputName");
if(name==null){name="";}
String select=request.getParameter("select");
int id=select==null?0:Integer.parseInt(select);
List<User> list = UserDAO2.find(name,id);
%>
<body>
<div class="container">
	<h1>USER 테이블 이용</h1>
	<form>
		<div class="form-group">
			<label>유저 이름 검색</label>
			<input style="width:200px" "type="text" class="form-control" name="inputName">
		</div>
		<div class="form-group">
			<select style="width:200px" class="from-control" name="select">
				<option value="0" <%=id==0?"selected":"" %>>전체</option>
				<%for(Department d:DepartmentDAO.findAll()){%>
					<option value="<%=d.getId()%>" <%=id==d.getId()?"selected":"" %>><%=d.getName() %></option>
				<%} %>
			</select>
		</div>
		<button class="btn btn-primary">조회</button>
	</form>
	<table class="table table-bordered table-condensed">
		<thead>
			<th>유저이름</th>
			<th>아이디</th>
			<th>학과번호</th>
			<th>직업</th>
			<th>이메일</th>
		</thead>
			<%for(User user:list) {%>
				<tr>
					<td><%=user.getName() %></td>
					<td><%=user.getUserid() %></td>
					<td><%=user.getDepartmentId()%></td>
					<td><%=user.getUserType() %></td>
					<td><%=user.getEmail() %></td>
				</tr>
			<%} %>
	</table>
</div>
</body>
</html>