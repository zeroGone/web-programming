<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.net.*, f201432008.*" %>
<%
String s1 = request.getParameter("id");
int id = ParseUtils.parseInt(s1, 0);
String pg = request.getParameter("pg");

BookDAO.delete(id);
response.sendRedirect("list3.jsp?pg=" + pg);
%>
