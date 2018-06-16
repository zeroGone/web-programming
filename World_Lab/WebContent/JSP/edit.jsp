<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Lab.*, java.net.*, java.util.*" %>
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
City city = null;

if (request.getMethod().equals("GET")) {
    city = CityDAO.findOne(id);
}
else {
    city = new City();
    city.setId(id);
    city.setName(request.getParameter("name")==null?"":request.getParameter("name"));
	city.setCountryCode(request.getParameter("countryCode")==null?"":request.getParameter("countryCode"));
	city.setDistrict(request.getParameter("district")==null?"":request.getParameter("district"));
	String s2 = request.getParameter("population");
	city.setPopulation(ParseUtils.parseInt(s2, 100));
	String s3 = request.getParameter("capital")==null?"false":request.getParameter("capital");
	if(s3.equals("true")) city.setCapital(true);
	
	if (city.getName() == null || city.getName().length() == 0)
		에러메시지 = "이름을 입력하세요";
	else if (city.getCountryCode() == null || city.getCountryCode().length() == 0)
		에러메시지 = "도시 코드를 입력하세요";
	else if (city.getDistrict() == null || city.getDistrict().length() == 0)
		에러메시지 = "지역를 입력하세요";
	else if (city.getPopulation()==0)
		에러메시지 = "인구 수를 입력하세요";
	else {
		CityDAO.update(city);
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
<h1>도시 등록</h1>
<hr />

<form method="post">
  <div class="form-group">
    <label>이름</label>
    <input type="text" class="form-control" name="name" 
           value="<%= city.getName() %>" />
  </div>
  <div class="form-group">
    <label>나라코드</label>
    <input type="text" class="form-control" name="countryCode" 
           value="<%= city.getCountryCode() %>" />
  </div>
  <div class="form-group">
    <label>지역</label>
    <input type="text" class="form-control" name="district" 
           value="<%= city.getDistrict() %>" />
  </div>
  <div class="form-group">
    <label>인구 수</label>
    <input type="text" class="form-control" name="population" 
           value="<%= city.getPopulation() %>" />
  </div>
  <div class="form-inline">
  	<label>수도 여부</label>
  	<%String checked = city.isCapital()?"checked":""; %>
    <input type="checkbox" class="form-control" name="capital" value="true" <%=checked %> />
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
