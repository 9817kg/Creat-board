<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="../js/list.js"></script>
<script src="../js/login.js"></script>

<%
session.setAttribute("id", "kyojin");


%>
<div id="main_user_cert" class="box2">
   <div id="main_image" class="box">
     <img class="noborder" id="logo" src="../images/mollahalf.png"/></div>
   <div id="main_auth" class="box"><jsp:include page="loginForm.jsp"/></div>
</div>
<div id="main_board" class="box2"><jsp:include page="main_board.jsp"/></div>