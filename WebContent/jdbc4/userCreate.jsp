<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Study.jdbc4.*, java.util.*,lecture1.*" %>
<%
request.setCharacterEncoding("UTF-8");

String 에러메시지 = null;
User user = new User();

if (request.getMethod().equals("GET")) {
	user.setUserid("");
	user.setName("");
	user.setPassword("");
	user.setEmail("");
	user.setEnabled(false);
	user.setUserType("");
} else {
    user.setUserid(request.getParameter("userId"));
    user.setName(request.getParameter("userName"));
    user.setPassword(request.getParameter("userPassword"));
    user.setEmail(request.getParameter("userEmail"));
    user.setUserType(request.getParameter("userType"));
    String s2 = request.getParameter("departmentId");
    user.setDepartmentId(ParseUtils.parseInt(s2, 1));
    String s3=request.getParameter("userEnabled");
  	if(s3.equals("true")) user.setEnabled(true);
  	else if(s3.equals("false")) user.setEnabled(false);
    
    if (user.getUserid()==null || user.getUserid().length() == 0) 
        에러메시지 = "아이디를 입력하세요";
    else if (user.getName() == null || user.getName().length() == 0) 
        에러메시지 = "이름을 입력하세요";
    else if (user.getPassword() == null || user.getPassword().length() == 0) 
        에러메시지 = "비밀번호를 입력하세요";
    else if (user.getEmail() == null || user.getEmail().length() == 0) 
        에러메시지 = "이메일을 입력하세요";
    else if (user.getUserType() == null || user.getUserType().length() == 0) 
        에러메시지 = "타입을 입력하세요";
    else {
        UserDAO.insert(user);
        response.sendRedirect("userList.jsp?pg=99999");
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

<h1>유저 등록</h1>
<hr />

<form method="post">
  <div class="form-group">
    <label>아이디</label>
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
    <label>학과</label>
    <select class="form-control" name="departmentId">
      <% for (Department d : DepartmentDAO.findAll()) { %>
          <% String selected = user.getDepartmentId()==d.getId() ? "selected" : ""; %>
          <option value="<%= d.getId() %>" <%= selected %>>
            <%= d.getDepartmentName() %>
          </option>
      <% } %>
    </select>
  </div>
   <div class="form-group">
    <label>이메일</label>
    <input type="text" class="form-control" name="userEmail" value="<%= user.getEmail() %>" />
  </div>
			<div class="form-group">
				<label>enabled</label>
				<div class="radio">
					<label> 
						<input type="radio" name="userEnabled" value="true">true
					</label> 
					<label> 
					<input type="radio" name="userEnabled" value="false">false
					</label>
				</div>
			</div>
			<div class="form-group">
    <label>타입</label>
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
