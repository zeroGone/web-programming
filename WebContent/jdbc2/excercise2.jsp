<!-- 데이터 페이지 단위 조회와 체크박스를 접목 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, Study.jdbc2.*" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
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
<title>excercise2</title>
</head>
<%
int currentPage=1;
int pageSize=10;
String pg =request.getParameter("pg");
if(pg!=null) currentPage=Integer.parseInt(pg);
String radio = request.getParameter("radio")==null?"":request.getParameter("radio");
String name =request.getParameter("name")==null?"":request.getParameter("name");

List<Student> list=Excercise2.find(currentPage,pageSize,radio,name);
String A_checked = "국어".equals(radio) ? "checked" : "";
String B_checked = "영어".equals(radio) ? "checked" : "";
String AB_checked = "불어".equals(radio) ? "checked" : "";
int recordCount=Excercise2.count(radio,name);
int pageCount = (int)Math.ceil((double)(recordCount/pageSize));

String department="pg=";

if("국어".equals(radio)){
	department="radio=%EA%B5%AD%EC%96%B4&"+"pg=";
}else if("영어".equals(radio)){
	department="radio=%EC%98%81%EC%96%B4&"+"pg=";
}else if("불어".equals(radio)){
	department="radio=%EC%98%81%EC%96%B4&"+"pg=";
}
String name2=name.equals("")?"":"name="+request.getParameter(name)+"&";
%>
<body>
	<div class="container">
		<h1>학생목록</h1>
		<h2>무슨 과?</h2>
		<form>
			<div class="form-group">
				<label>학생이름</label>
				<input type="text" class="form-control" style="width:200px" name="name" value=<%=name %>>
			</div>
			<div class="radio">
				<label><input type="radio" name="radio" value="국어" <%=A_checked %> /> 국어국문학과 </label> 
				<label><input type="radio" name="radio" value="영어" <%=B_checked %> /> 영어영문학과 </label> 
				<label><input type="radio" name="radio" value="불어" <%=AB_checked %>/> 불어불문학과 </label> 
				<button class="btn btn-primary">확인</button>
			</div>
		</form>
		<table class="table table-bordered table-condensed">
			<thead>
				<tr>
					<th>id</th>
					<th>학번</th>
					<th>이름</th>
					<th>학과</th>
					<th>학년</th>
				</tr>
			</thead>
			<tbody>
				<% for (Student student : list) { %>
				<tr>
					<td><%= student.getId() %></td>
					<td><%= student.getStudentNumber() %></td>
					<td><%= student.getName() %></td>
					<td><%= student.getDepartmentName() %></td>
					<td><%= student.getYear() %></td>
				</tr>
				<% } %>
			</tbody>
		</table>
		<div class="form-inline">
			<my:pagination pageSize="<%=pageSize%>" recordCount="<%=recordCount%>" queryStringName="pg" />
			<%if (currentPage > 1) {%>
			<a class="btn btn-default" href="excercise2.jsp?<%=name2%><%=department%><%=currentPage - 1%>"> &lt; </a>
			<%}%>
			<%if (currentPage <= pageCount) {%>
			<a class="btn btn-default" href="excercise2.jsp?<%=name2%><%=department%><%=currentPage + 1%>"> &gt; </a>
			<% } %>
		</div>
	</div>
</body>
</html>