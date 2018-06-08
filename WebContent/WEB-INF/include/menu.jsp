<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="login1.*" %>
<div class="container">
    <div class="navbar navbar-default">
       <div class="container-fluid">
          <div class="navbar-header">
             <a class="navbar-brand" href="/Study/login1/index.jsp">성공회대학교</a>
          </div>
          
          <% if (UserService.isCurrentUserLoggedIn(session) == false) { %>    
             <div class="collapse navbar-collapse">             
                <ul class="nav navbar-nav navbar-right">
                   <li><a href='/Study/login1/login1.jsp'>로그인</a></li>
                   <li><a href='#'>회원가입</a></li>
                </ul>
             </div>
          <% } else { %>
             <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav">
                    <li><a href="/Study/login1/index.jsp">index.jsp</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                   <li><a href='#'><%= UserService.getCurrentUserName(session) %> 정보수정</a></li>
                   <li><a href='/Study/login1/logout1.jsp'>로그아웃</a></li>
                </ul>
             </div>
          <% } %>
       </div>
    </div>
</div>
