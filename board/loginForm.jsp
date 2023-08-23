<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="../js/login.js"></script>
<%
String id ="";
try{
	//id세션 속성의 값을 얻어내서 id변수에 저장
	//인증된 사용자의 경우  id세션 속성의 값 null또는 공백이 아님
	id = (String)session.getAttribute("id");
%>

<%if(id == null || id.equals("")){ //인증되지 않은 사용자 영역%>
  <div id="status">
     <ul>
        <li><label for="id">아이디</label>
            <input id="id" name="id" type="email" size="20" 
              maxlength="50" placeholder="example@kings.com">
        <li><label for="passwd">비밀번호</label>
            <input id="passwd" name="passwd" type="password" 
              size="20" placeholder="6~16자 숫자/문자" maxlength="16">
        <li class="label2">
            <button id="login">로그인</button>
     </ul>
  </div>
<%}else{//인증된 사용자 영역%>
  <div id="status">
     <ul>
        <li><b><%=id %></b>님이 로그인 하셨습니다.
        <li class="label2"><button id="logout">로그아웃</button>
     </ul>
  </div>
<%}}catch(Exception e){e.printStackTrace();}%>
