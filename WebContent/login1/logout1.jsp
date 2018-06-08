<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="login1.*" %>
<%
UserService.logout(session);
response.sendRedirect("login1.jsp");
%>
