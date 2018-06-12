<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*, lab.*" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="my" %>
<%
int currentPage = 1;
int pageSize = 10;
request.setCharacterEncoding("UTF-8");
String pg = request.getParameter("pg");
if (pg != null) currentPage = ParseUtils.parseInt(pg, 1);

String ss = request.getParameter("ss");
String st = request.getParameter("st");
if (ss == null) ss = "0";
if (st == null) st = "";
String stEncoded = URLEncoder.encode(st, "UTF-8");

int recordCount = FilmDAO.count(ss, st);

int lastPage = Math.max(1, (recordCount + pageSize - 1) / pageSize);
if (currentPage > lastPage) currentPage = lastPage;

String od = request.getParameter("od");
if (od == null) od = "0";
List<Film> list = FilmDAO.findAll(currentPage, pageSize, ss, st, od);
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
      tr:hover td { background-color: #ffe; cursor: pointer; }
      table.table { margin-top: 5px; }
      select[name=od] { margin-right: 20px; }
  </style>
</head>
<body>
<div class="container">
<h1>영화 목록</h1>

<a id="createButton" class="btn btn-primary pull-right" 
   href="create.jsp?pg=<%=currentPage%>&ss=<%=ss%>&st=<%=stEncoded%>&od=<%=od%>">
  <i class="glyphicon glyphicon-plus"></i> 영화 등록
</a>

<form class="form-inline">
  <div class="form-group">
    <label>정렬</label>
    <select name="od" class="form-control">
    <%for(int i=0; i<8; i++) {
    	String num = Integer.toString(i);
    	String[] array=new String[]{"등록 순서","시간 오름차순","시간 내림차순","대여비용 오름차순","대여비용 내림차순","대여기간 오름차순","대여기간 내림차순","카테고리"};%>
    	<option value=<%=num%> <%=num.equals(od)?"selected" : "" %>><%=array[i]%></option>
    <%} %>
    </select>
    <select name="ss" class="form-control">
      <option value="0" <%= "0".equals(ss) ? "selected" : "" %>>전체</option>
      <option value="1" <%= "1".equals(ss) ? "selected" : "" %>>제목</option>
      <option value="2" <%= "2".equals(ss) ? "selected" : "" %>>내용</option>
      <option value="3" <%= "3".equals(ss) ? "selected" : "" %>>카테고리</option>
    </select>
    <input type="text" class="form-control" name="st" value="<%= st %>" />
  </div>
  <button type="submit" class="btn btn-primary">조회</button>
</form>

<table class="table table-bordered table-condensed">
  <thead>
    <tr>
    <%String[] array=new String[]{"id","제목","내용","출시년도","언어","대여기간","대여비용","시간(분)","특별출연","업데이트 날짜","카테고리"};
    for(int i=0; i<array.length; i++) {%>
      <th><%=array[i]%></th>
    <%} %>
    </tr>
  </thead>
  <tbody>
    <% for (Film film : list) { %>
      <tr data-url="edit.jsp?id=<%=film.getId()%>&pg=<%=currentPage%>&ss=<%=ss%>&st=<%=stEncoded%>&od=<%=od%>">
        <td><%= film.getId() %></td>
        <td><%= film.getTitle() %></td>
        <td><%= film.getDescription() %></td>
        <td><%= film.getReleaseYear() %></td>
        <td><%= LanguageDAO.findOne(film.getLanguageId()) %></td>
        <td><%= film.getRentalDuration() %></td>
        <td><%= film.getRentalRate() %></td>
        <td><%= film.getLength() %></td>
        <td><%= film.getSpecialFeatures() %></td>
        <td><%= film.getLastUpdate() %></td>
        <td><%= film.getCategory() %></td>
      </tr>
    <% } %>
  </tbody>
</table>

<my:pagination pageSize="<%= pageSize %>" recordCount="<%= recordCount %>" queryStringName="pg" />

</div>
<script>
$("[data-url]").click(function() {
    var url = $(this).attr("data-url");
    location.href = url;
})
</script>
</body>
</html>
