
<%@page import="firstWeb.board.daos.BoardDAO"%>
<%@page import="firstWeb.board.dtos.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");%>
<jsp:useBean id ="upDto" class ="firstWeb.board.dtos.BoardDTO">
<jsp:setProperty name="upDto" property="*"/>
</jsp:useBean>
<%
// DAO 의 업데이트 메서드를 호출(DTO 통채로 ) 해서 비번 검증 후 맞으면 내용과 제목 변경해주고 결과 리턴,
// 아닌 경우엔 비번이 틀리다는 결과 리턴하자.
// 메서드는 updateArticle(BoardDTO dto)
int result = BoardDAO.getInstance().updateArticle(upDto);

// 분기 시킨다 -> 1 인 경우엔 list 페이지의 요청 페이지로, 아닌 경우엔 back 

if(result == 1){
%>
<script>
alert("글이 수정 됨")
location.href='main.jsp?pageNum=<%=request.getParameter("pageNum")%>';
</script>
<%
} else{
    %>

<script>
alert("비번이 틀립니다.")
history.back();
</script>
<% 
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=result %>
</body>
</html>