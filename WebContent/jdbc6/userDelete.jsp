<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*, Study.jdbc6.*" %>
<%
String s1 = request.getParameter("id");
int id = Integer.parseInt(s1);
String pg = request.getParameter("pg");
String srchText = request.getParameter("srchText");
if (srchText == null) srchText = "";
String srchTextEncoded = URLEncoder.encode(srchText, "UTF-8");
String od = request.getParameter("od");

UserDAO.delete(id);
response.sendRedirect("userList.jsp?pg=" + pg + "&st=" + srchTextEncoded);
%>
