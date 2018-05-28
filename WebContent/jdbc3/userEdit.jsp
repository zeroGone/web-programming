<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Study.jdbc3.*, java.util.*" %>
<%
	request.setCharacterEncoding("UTF-8");

String 에러메시지 = null;
String s1 = request.getParameter("id");
int id = Integer.parseInt(s1);
User user = null;

	if (request.getMethod().equals("GET")) {
		user = UserDAO.findOne(id);
	} else {
		user = new User();
		user.setId(id);
		user.setUserid(request.getParameter("userId"));
		user.setPassword(request.getParameter("userPassword"));
		user.setName(request.getParameter("userName"));
		user.setEmail(request.getParameter("userEmail"));
		String s2 = request.getParameter("departmentId");
	    user.setDepartmentId(Integer.parseInt(s2));
	    String s3=request.getParameter("userEnabled");
	  	if(s3.equals("true")) user.setEnabled(true);
	  	else if(s3.equals("false")) user.setEnabled(false);
		user.setUserType(request.getParameter("userType"));

		if (s1 == null || s1.length() == 0)
			에러메시지 = "ID를 입력하세요";
		else if (user.getUserid()== null || user.getUserid().length() == 0)
			에러메시지 = "유저아이디를 입력하세요";
		else if(user.getPassword()==null||user.getPassword().length()==0)
			에러메시지 = "패스워드를 입력하세요";
		else if (user.getName() == null || user.getName().length() == 0)
			에러메시지 = "이름을 입력하세요";
		else if (user.getEmail() == null || user.getEmail().length() == 0)
			에러메시지 = "이메일을 입력하세요";
		else if (user.getDepartmentId()<1)
			에러메시지 = "학과를 체크하세요";
		else if (user.getUserType() == null || user.getUserType().length() == 0)
			에러메시지 = "사용자유형을 입력하세요";
		else {
			UserDAO.update(user);
			response.sendRedirect("userList.jsp?pg=" + (id + 10) / 10);
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
  </style>
</head>
<body>

<div class="container">

<h1>학생 등록</h1>
<hr />

<form method="post">
  <div class="form-group">
    <label>유저아이디</label>
    <input type="text" class="form-control" name="userId" 
           value="<%= user.getUserid() %>" />
  </div>
    <div class="form-group">
    <label>비밀번호</label>
    <input type="text" class="form-control" name="userPassword" value="<%= user.getPassword() %>" />
  </div>
  <div class="form-group">
    <label>이름</label>
    <input type="text" class="form-control" name="userName" value="<%= user.getName() %>" />
  </div>
   <div class="form-group">
    <label>이메일</label>
    <input type="text" class="form-control" name="userEmail" value="<%= user.getEmail() %>" />
  </div>
			<div class="form-group">
				<label>학과</label>
				<div class="radio">
					<%
						for (Department d : DepartmentDAO.findAll()) {
							String checked = user.getDepartmentId() == d.getId() ? "checked" : "";
					%>
					<label>
						<input type="radio"  name="departmentId" value="<%=d.getId()%>" <%=checked%>>
							<%=d.getDepartmentName()%>
					</label>
					<%
						}
					%>
				</div>
			</div>
			<div class="form-group">
				<label>enabled</label>
				<div class="radio">
					<%
						String enable1 = "";
						String enable2 = "";
						if (user.isEnabled()) {
							enable1 = "checked";
						} else {
							enable2 = "checked";
						}
					%>
					<label> <input type="radio" name="userEnabled" value="true" <%=enable1 %>>true</label>
					<label> <input type="radio" name="userEnabled" value="false" <%=enable2 %>>false</label>
				</div>
			</div>
			<div class="form-group">
    <label>사용자유형</label>
    <input type="text" class="form-control" name="userType" value="<%= user.getUserType() %>" />
  </div>
  <button type="submit" class="btn btn-primary">
    <i class="glyphicon glyphicon-ok"></i> 저장
  </button>
</form>

<hr />
<% if (에러메시지 != null) { %>
  <div class="alert alert-danger">
    유저등록 실패: <%= 에러메시지 %>
  </div>
<% } %>
</div>
</body>
</html>
