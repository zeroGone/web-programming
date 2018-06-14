<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="lab.*, java.net.*, java.util.*"%>
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
	Film film = new Film();
	if (request.getMethod().equals("GET")) {
		film.setTitle("");
		film.setDescription("");
		film.setReleaseYear(1994);
		film.setRentalRate(0.99);
		film.setLength(99);
	}
	else{
		film.setTitle(request.getParameter("title")==null?"":request.getParameter("title"));
		film.setDescription(request.getParameter("description")==null?"":request.getParameter("description"));
		String s0 = request.getParameter("releaseYear");
		film.setReleaseYear(ParseUtils.parseInt(s0,0));
		String s1 = request.getParameter("language");
		film.setLanguageId(ParseUtils.parseInt(s1,0));
		String s2 = request.getParameter("rentalDuration");
		film.setRentalDuration(ParseUtils.parseInt(s2, 0));
		String s3 = request.getParameter("rentalRate");
		film.setRentalRate(ParseUtils.parseDouble(s3, 0));
		String s4 = request.getParameter("length");
		film.setLength(ParseUtils.parseInt(s4, 0));
		String s5 = request.getParameter("category");
		film.setCategory(CategoryDAO.findOne(ParseUtils.parseInt(s5, 1)));
		
		if (film.getTitle() == null || film.getTitle().length() == 0)
			에러메시지 = "제목을 입력하세요";
		else if (film.getDescription() == null || film.getDescription().length() == 0)
			에러메시지 = "내용을 입력하세요";
		else if (film.getReleaseYear() == 0)
			에러메시지 = "출시년도를 입력하세요";
		else if (film.getRentalDuration() == 0)
			에러메시지 = "대여기간을 선택하세요";
		else if (film.getRentalRate() == 0)
			에러메시지 = "대여비용를 입력하세요";
		else if (film.getLanguageId() == 0)
			에러메시지 = "언어를 선택하세요";
		else if (film.getLength() == 0)
			에러메시지 = "시간를 입력하세요";
		else if (film.getCategory() == null || film.getCategory().length()==0)
			에러메시지 = "카테고리를 선택하세요";
		else {
			FilmDAO.insert(film);
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
    <textarea class="form-control" name="description" rows="5"><%=film.getDescription()%></textarea>
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
    	<input type="radio" class="form-control" name=rentalDuration value="<%=i%>" />
    <%} %>
  </div>
  <div class="form-group">
    <label>대여비용</label>
    <input type="text" class="form-control" name="rentalRate" 
           value="<%= film.getRentalRate() %>" />
  </div>
  <div class="form-group">
    <label>시간(분)</label>
    <input type="text" class="form-control" name="length" 
           value="<%= film.getLength() %>" />
  </div>
  <div class="form-group">
    <label>카테고리</label>
    <select class="form-control" name="category">
      <% for (Category c : CategoryDAO.findAll()) { %>
          <option value="<%= c.getId() %>">
            <%= c.getName() %>
          </option>
      <% } %>
    </select>
  </div>
  <div class="form-group">
    <label>언어</label>
    <select class="form-control" name="language">
      <% for (Language l : LanguageDAO.findAll()) { %>
          <option value="<%= l.getId() %>">
            <%= l.getName() %>
          </option>
      <% } %>
    </select>
  </div>
	
<div class="form-group">
  <button type="submit" class="btn btn-primary">
    <i class="glyphicon glyphicon-ok"></i> 저장
  </button>
  <a href="list.jsp?pg=<%= pg %>&ss=<%= ss %>&st=<%=stEncoded%>&od=<%=od%>" 
     class="btn btn-default">
    <i class="glyphicon glyphicon-list"></i> 목록으로
  </a>
 </div>
</form>


<hr />
<% if (에러메시지 != null) { %>
  <div class="alert alert-danger">
    영화 등록 실패: <%= 에러메시지 %>
  </div>
<% } %>
</div>
</body>
</html>
