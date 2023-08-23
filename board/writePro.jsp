<%@page import="firstWeb.board.daos.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%request.setCharacterEncoding("utf-8"); %>
     <!--  글쓰기 폼에 입력된 데이터를  모두 DTO 에 세팅 -->
     <jsp:useBean id="article" class="firstWeb.board.dtos.BoardDTO">
     	<jsp:setProperty name="article" property="*"/>
     </jsp:useBean>
     
     <%
     String id ="";
     try{
	 id=(String)session.getAttribute("id");
	 
     }catch(Exception e){
	 e.getMessage();
     }
     // 위 action 태그에서 빠진 부분만 setter 를 통해 처리
     article.setWriter(id);
     article.setIp(request.getRemoteAddr());
     article.setReg_date(new Timestamp(System.currentTimeMillis()));
     
     
     // DAO 통해 insert 해준다.
     // insert row cnt 를 리턴 받아서, ajax로 통신한 writeForm.jsp 로 데이터를 넘긴다.
     
    BoardDAO dao = BoardDAO.getInstance();
     
    int check = dao.insertArticle(article);
    out.println( "<script>alert ('글이 등록 되었습니다.'); location.href='main.jsp'</script>");
   
     %>
     
    