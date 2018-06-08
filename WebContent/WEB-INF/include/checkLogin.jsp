<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="login1.*" %>
<%
if (UserService.isCurrentUserLoggedIn(session) == false) {
    response.sendRedirect("login1.jsp");
    return;
}
%>
