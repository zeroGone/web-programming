<!-- DB에 저장된 학생 정보를 받아오는 JSP -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, Study.jdbc1.*" %>
<%
String s=request.getParameter("select");
int id=(s==null?0:Integer.parseInt(s));
List<Student> list;
if(id==0){list=StudentDAO3.findAll();}//받아온 값이 0이면 전체출력을 위한 조건문
else{list= StudentDAO3.findDepartment(id);}//아니면 학과아이디 출력
 
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
      table.table { width: 700px; }
  </style>
</head>
<body>
<div class="container">
<h1>학생목록</h1>
<form class="form-inline">
	<div class="form-group">
	<label>학과</label>
		<select class="form-control" style="width:200px" name="select">
			<option value="0" <%=id==0?"selected":""%>>전체</option>
			<option value="1" <%=id==1?"selected":""%>>국어국문학</option>
			<option value="2" <%=id==2?"selected":""%>>영어영문학</option>
			<option value="3" <%=id==3?"selected":""%>>불어불문학</option>
		</select>
	</div>
	<button type="submit" class="btn btn-primary">조회</button>
</form>

<table class="table table-bordered table-condensed">
<thead>
	<tr>
		<th>학번</th>
		<th>이름</th>
		<th>학과</th>
		<th>학년</th>
	</tr>
</thead>
<%for(Student student:list) {%><!-- DB에서 받아온와서 학생정보로 가득채워진 Stduent 클래스를 이용하여 출력 -->
	<tr>
		<td><%=student.getStudentNumber() %></td>
		<td><%=student.getName() %></td>
		<td><%=student.getDepartmentName() %></td>
		<td><%=student.getYear() %></td>
	</tr>
<%} %>
</table>
</div>
</body>
</html>