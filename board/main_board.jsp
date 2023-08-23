<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>

<%
String id = "";
try{
	id = (String)session.getAttribute("id");
%>

<%if(id == null || id.equals("")){%>
  <div id="display_board" class="box2">로그인하세요!게시판은 회원만 볼수 있습니다.
  <jsp:include page="list.jsp"/>
  </div>
<%}else{%>
  <div id="display_board" class="box2"><jsp:include page="list.jsp"/></div>
<%}}catch(Exception e){e.printStackTrace();}%>