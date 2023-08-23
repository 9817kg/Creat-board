<%@page import="firstWeb.board.dtos.BoardDTO"%>
<%@page import="firstWeb.board.daos.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="../js/delete.js"></script>

<% request.setCharacterEncoding("utf-8");%>
<%
 //삭제할 글의 번호와 삭제할 글이 위치한 페이지 번호를 얻어냄
 int num = Integer.parseInt(request.getParameter("num"));
 String pageNum = request.getParameter("pageNum");
 
 BoardDAO dao = BoardDAO.getInstance();
 BoardDTO dto = dao.updateSel(num);
 out.println(dto);
%>
<form method="post" action="deletePro.jsp">
<div id="deleteForm">
   <ul>
      <li><p class="center">글삭제
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="pw" type="password" 
              size="20" placeholder="6~16자 숫자/문자" maxlength="16">
          <input type="hidden" id="num" name="num" value="<%=dto.getNum()%>">
          
          <input type="hidden" id="pageNum" name="pageNum" value="<%=pageNum %>">
      <li class="label2">
          <input type="submit" value="삭제">
        <button id="cancle" onclick="history.go(-1)">취소</button>
   </ul>
</div>
</form>