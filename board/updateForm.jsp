<%@page import="firstWeb.board.dtos.BoardDTO"%>
<%@page import="firstWeb.board.daos.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="../js/update.js"></script>

<% request.setCharacterEncoding("utf-8");%>

<%
 //수정할 글의 번호와 수정할 글이 위치한 페이지 번호를 얻어냄
int num = Integer.parseInt(request.getParameter("num"));
String pageNum = request.getParameter("pageNum");

// update 할 게시글을 num을 기준으로 가져오는 dao 메서드를 호출해서
// 하나의 DTO로 받습니다.
BoardDAO dao = BoardDAO.getInstance();
BoardDTO dto = dao.updateSel(num);
out.println(dto);
%>

<%--수정할 글의 원래 저장내용을 글 수정폼에 표시 --%>
<form method="post" action="updatePro.jsp">
<div id="editForm" class="box">
   <ul>
      <li><p class="center">글수정
      <li><label for="subject">제목</label>
          <input id="subject" name="subject" type="text" 
           size="50" maxlength="50" value="<%=dto.getSubject() %> ">
          <input type="hidden" id="num" name="num" value="<%=dto.getNum() %>">
          <input type="hidden" id="pageNum" name="pageNum" value="<%=pageNum %>">
      <li><label for="content">내용</label>
          <textarea id="content" rows="13" cols="50" name="content">
            <%=dto.getContent() %> 
            </textarea>
      <li><label for="passwd">비밀번호</label>
          <input id="passwd" name="pw" type="password" 
           size="20" placeholder="6~16자 숫자/문자" maxlength="16" name = "passwd">
      <li class="label2">
         <input type="submit" value="수정">
        <button id="cancle" onclick="history.go(-1)">취소</button>
   </ul>
</div>
</form>