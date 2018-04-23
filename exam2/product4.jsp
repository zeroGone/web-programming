<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*,jdbc.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style>
input.form-control { width: 200px; }
table.table { width: 500px; }
thead tr { background-color: #eee; }  
</style>
<%
String radio = request.getParameter("radio")==null?null:request.getParameter("radio");
List<Product> list =ProductDAO.findRadio(radio);
String all_checked = "".equals(radio) ? "checked" : "";
String drink_checked = "음료수".equals(radio) ? "checked" : "";
String drunken_checked = "주류".equals(radio) ? "checked" : "";
String swingchip_checked = "과자".equals(radio) ? "checked" : "";
%>
</head>
<body>
<div class="container">
	<h1>제품목록</h1>
	<form>	
			<div class="radio">
				<label>제품유형</label>
				<label><input type="radio" name="radio" value="" <%=all_checked %> /> 전체 </label> 
				<label><input type="radio" name="radio" value="음료수" <%=drink_checked %> /> 음료수 </label> 
				<label><input type="radio" name="radio" value="주류" <%=drunken_checked %> /> 주류 </label> 
				<label><input type="radio" name="radio" value="과자" <%=swingchip_checked %>/> 과자 </label> 
				<button class="btn btn-primary">조회</button>
			</div>
		</form>
	<table class="table table-bordered table-condensed">
    <thead>
        <tr> 
            <th>id</th>
            <th>제품명</th>
            <th>카테고리</th>
            <th>가격</th>
            <th>수량</th>
        </tr>
    </thead>
    <tbody>
        <% for (Product product : list) { %>
            <tr>
                <td><%= product.getId() %></td>
                <td><%= product.getTitle() %></td>
                <td><%= product.getCategory_name() %></td>
                <td><%= product.getUnitCost() %></td>
                <td><%= product.getQuantity() %></td>
            </tr>
        <% } %>
    </tbody>
</table>
</div>
</body>
</html>