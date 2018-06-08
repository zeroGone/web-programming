<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="exam.*, java.net.*, java.util.*" %>
<%
request.setCharacterEncoding("UTF-8");

String 에러메시지 = null;
String s1 = request.getParameter("id");
int id = ParseUtils.parseInt(s1, 0);

String pg = request.getParameter("pg");
String ss = request.getParameter("ss");
String st = request.getParameter("st");
if (ss == null) ss = "0";
if (st == null) st = "";
String stEncoded = URLEncoder.encode(st, "UTF-8");

String od = request.getParameter("od");
Article article =null;

if (request.getMethod().equals("GET")) {
    article = ArticleDAO.findOne(id);
}
else {
    article = new Article();
    article.setId(id);
    article.setTitle(request.getParameter("title"));
    article.setBody(request.getParameter("body"));
    String s2 = request.getParameter("userId");
    article.setUserId(ParseUtils.parseInt(s2, 1));
    String s3 = request.getParameter("notice")==null?"":"true";
	
    if(s3.equals("true")) article.setNotice(true);
    else article.setNotice(false);
    
    if (article.getTitle() == null || article.getTitle().length() == 0) 
        에러메시지 = "제목을 입력하세요";
    else if (article.getBody() == null || article.getBody().length() == 0) 
        에러메시지 = "본문을 입력하세요";
    else {
        ArticleDAO.update(article);
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
  <a href="delete1.jsp?id=<%= id %>&pg=<%= pg %>&ss=<%=ss%>&st=<%=stEncoded%>&od=<%=od%>" 
     class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?')">
    <i class="glyphicon glyphicon-trash"></i> 삭제
  </a>
  <a href="list1.jsp?pg=<%= pg %>&ss=<%= ss %>&st=<%=stEncoded%>&od=<%=od%>" 
     class="btn btn-default">
    <i class="glyphicon glyphicon-list"></i> 목록으로
  </a>
</form>

<hr />
<% if (에러메시지 != null) { %>
  <div class="alert alert-danger">
    게시글등록 실패: <%= 에러메시지 %>
  </div>
<% } %>
</div>
</body>
</html>
