<%@page import="firstWeb.board.daos.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("utf-8");%>
<jsp:useBean id ="delDto" class ="firstWeb.board.dtos.BoardDTO">
<jsp:setProperty name="delDto" property="*"/>
</jsp:useBean>
<%
int result = BoardDAO.getInstance().delArticle(delDto);

if(result == 1){
%>


<script>
alert("글이 삭제 되었습니다.")
location.href='main.jsp?pageNum=<%=request.getParameter("pageNum")%>';
</script>
<%
} else{
    %>

<script>
alert("pw 가 틀립니다.")
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