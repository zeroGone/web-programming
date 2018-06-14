<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="lab.*, java.net.*, java.util.*" %>
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
Film film = null;

if (request.getMethod().equals("GET")) {
    film = FilmDAO.findOne(id);
}
else {
    film = new Film();
    film.setId(id);
    film.setTitle(request.getParameter("title"));
    film.setDescription(request.getParameter("description"));
    String s2 = request.getParameter("releaseYear");
    film.setReleaseYear(ParseUtils.parseInt(s2, 1));
	String s3 = request.getParameter("rentalDuration");
	film.setRentalDuration(ParseUtils.parseInt(s3, 3));
	String s4 = request.getParameter("rentalRate");
	film.setRentalRate(ParseUtils.parseDouble(s4, 0.99));
	String s5 = request.getParameter("length");
	film.setLength(ParseUtils.parseInt(s5, 0));
	film.setSpecialFeatures(request.getParameter("special"));
	String s6 = request.getParameter("category");
	int categoryId = ParseUtils.parseInt(s6, 1);
	String s7 = request.getParameter("language");
	film.setLanguageId(ParseUtils.parseInt(s7, 1));
   
    if (film.getTitle() == null || film.getTitle().length() == 0) 
     	   에러메시지 = "제목을 입력하세요";
    else if (film.getDescription() == null || film.getDescription().length() == 0) 
      	  에러메시지 = "내용을 입력하세요";
    else {
    	FilmDAO.update(film, categoryId);
        response.sendRedirect("list.jsp?pg=" + pg + "&ss=" + ss + "&st=" + stEncoded + "&od=" + od);
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

<h1>영화 등록</h1>
<hr />

<form method="post">
  <div class="form-group">
    <label>제목</label>
    <input type="text" class="form-control" name="title" 
           value="<%= film.getTitle() %>" />
  </div>
  
  <div class="form-group">
    <label>내용</label>
    <textarea class="form-control" name="description" rows="5"><%= film.getDescription() %></textarea>
  </div>
  
  <div class="form-group">
    <label>출시년도</label>
    <input type="text" class="form-control" name="releaseYear" 
           value="<%= film.getReleaseYear() %>" />
  </div>
  
  <div class="form-inline">
  	<label>대여기간</label>
  	<%for(int i=3; i<8; i++) {%>	
  		<label><%=i%></label>  	
    	<input type="radio" class="form-control" name=rentalDuration value="<%=i%>" 
    	<%if(i==film.getRentalDuration()){%>checked<%}%>/>
    <%} %>
  </div>
  
  <div class="form-group">
    <label>렌트비용</label>
    <input type="text" class="form-control" name="rentalRate" 
           value="<%= film.getRentalRate() %>" />
  </div>
  
  <div class="form-group">
    <label>시간(분)</label>
    <input type="text" class="form-control" name="length" 
           value="<%= film.getLength() %>" />
  </div>
  
   <div class="form-group">
    <label>특별출연</label>
    <input type="text" class="form-control" name="special" 
           value="<%= film.getSpecialFeatures() %>" />
  </div>
  
  <div class="form-group">
    <label>카테고리</label>
    <select class="form-control" name="category">
      <% for (Category c : CategoryDAO.findAll()) { %>
          <% String selected = film.getCategory().equals(c.getName()) ? "selected" : ""; %>
          <option value="<%= c.getId() %>" <%= selected %>>
            <%= c.getName() %>
          </option>
      <% } %>
    </select>
  </div>
  
  <div class="form-group">
    <label>언어</label>
    <select class="form-control" name="language">
      <% for (Language l : LanguageDAO.findAll()) { %>
          <% String selected = film.getLanguageId()==l.getId() ? "selected" : ""; %>
          <option value="<%= l.getId() %>" <%= selected %>>
            <%= l.getName() %>
          </option>
      <% } %>
    </select>
  </div>
  
 
  
  <button type="submit" class="btn btn-primary">
    <i class="glyphicon glyphicon-ok"></i> 저장
  </button>
  <a href="delete.jsp?id=<%= id %>&pg=<%= pg %>&ss=<%=ss%>&st=<%=stEncoded%>&od=<%=od%>" 
     class="btn btn-danger" onclick="return confirm('삭제하시겠습니까?')">
    <i class="glyphicon glyphicon-trash"></i> 삭제
  </a>
  <a href="list.jsp?pg=<%= pg %>&ss=<%= ss %>&st=<%=stEncoded%>&od=<%=od%>" 
     class="btn btn-default">
    <i class="glyphicon glyphicon-list"></i> 목록으로
  </a>
</form>

<hr />
<%if (에러메시지 != null) { %>
  <div class="alert alert-danger">
    영화등록 실패: <%=에러메시지 %>
  </div>
<%} %>
</div>
</body>
</html>
