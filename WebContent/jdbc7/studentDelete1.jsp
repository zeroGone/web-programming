<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*, Study.jdbc7.*, lecture1.*" %>
<%
String s1 = request.getParameter("id");
int id = ParseUtils.parseInt(s1, 0);
String pg = request.getParameter("pg");
String ss = request.getParameter("ss");
String st = request.getParameter("st");
if (ss == null) ss = "0";
if (st == null) st = "";
String stEncoded = URLEncoder.encode(st, "UTF-8");
String od = request.getParameter("od");

StudentDAO.delete(id);
response.sendRedirect("studentList1.jsp?pg=" + pg + "&ss=" + ss + "&st=" + stEncoded + "&od=" + od);
%>
