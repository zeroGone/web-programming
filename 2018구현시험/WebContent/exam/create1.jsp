<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="exam.*, java.net.*, java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String 에러메시지 = null;

	String pg = request.getParameter("pg");
	String ss = request.getParameter("ss");
	String st = request.getParameter("st");
	if (ss == null)
		ss = "0";
	if (st == null)
		st = "";
	String stEncoded = URLEncoder.encode(st, "UTF-8");

	String od = request.getParameter("od");
	
	Article article = new Article();
	
	String s1 = request.getParameter("no");
	article.setNo(ParseUtils.parseInt(s1,0));
	
	article.setTitle(request.getParameter("title")==null?"":request.getParameter("title"));
	article.setBody(request.getParameter("body")==null?"":request.getParameter("body"));
	String s2 = request.getParameter("userId");
	article.setUserId(ParseUtils.parseInt(s2, 1));
	String s3 = request.getParameter("notice") == null ? "" : "true";

	String s4 = request.getParameter("boardId");
	article.setBoardId(ParseUtils.parseInt(s4, 0));
	
	if (s3.equals("true"))
		article.setNotice(true);
	else
		article.setNotice(false);

	if (request.getMethod().equals("GET")) {
	}
	else {
		if (article.getTitle() == null || article.getTitle().length() == 0)
			에러메시지 = "제목을 입력하세요";
		else if (article.getBody() == null || article.getBody().length() == 0)
			에러메시지 = "본문을 입력하세요";
		else if (article.getNo() == 0)
			에러메시지 = "no을 입력하세요";
		else {
			ArticleDAO.insert(article);
			response.sendRedirect("list1.jsp?pg=" + pg + "&ss=" + ss + "&st=" + stEncoded + "&od=" + od);
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
  </style>
</head>
<body>

<div class="container">

<h1>게시글 등록</h1>
<hr />

<form method="post">
	<div class="form-group">
    <label>no</label>
    <input type="text" class="form-control" name="no" 
           value="<%= article.getNo() %>" />
  </div>
  <div class="form-group">
    <label>제목</label>
    <input type="text" class="form-control" name="title" 
           value="<%= article.getTitle() %>" />
  </div>
  <div class="form-group">
    <label>본문</label>
    <textarea class="form-control" name="body" rows="20"><%=article.getBody() %></textarea>
  </div>
  <div class="form-group">
    <label>작성자</label>
    <select class="form-control" name="userId">
      <% for (User u : UserDAO.findAll()) { %>
          <% String selected = article.getUserId()==u.getId() ? "selected" : ""; %>
          <option value="<%= u.getId() %>" <%= selected %>>
            <%= u.getName() %>
          </option>
      <% } %>
    </select>
  </div>
  <div class="form-group">
    <label>게시판</label>
    <select class="form-control" name="boardId">
      <% for (Board b : BoardDAO.findAll()) { %>
          <% String selected = article.getBoardId()==b.getId() ? "selected" : ""; %>
          <option value="<%= b.getId() %>" <%= selected %>>
            <%= b.getBoardName() %>
          </option>
      <% } %>
    </select>
  </div>
  <%
  String checked="";
	if(article.isNotice()){
	checked="checked";
}%>
  <div class="form-inline">
    <label>공지</label>
    <input type="checkbox" class="form-control" name="notice" value="true" <%=checked%>/>
  </div>
  <button type="submit" class="btn btn-primary">
    <i class="glyphicon glyphicon-ok"></i> 저장
  </button>
  <a href="list1.jsp?pg=<%= pg %>&ss=<%= ss %>&st=<%=stEncoded%>&od=<%=od%>" 
     class="btn btn-default">
    <i class="glyphicon glyphicon-list"></i> 목록으로
  </a>
</form>

<hr />
<% if (에러메시지 != null) { %>
  <div class="alert alert-danger">
    게시글 등록 실패: <%= 에러메시지 %>
  </div>
<% } %>
</div>
</body>
</html>
