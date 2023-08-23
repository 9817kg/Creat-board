<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
<link rel="stylesheet" href="../css/style.css"/>
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="../js/write.js"></script>

<% request.setCharacterEncoding("utf-8");%>
<% 
//만약 이 폼이 댓글용이라면 부모의 키값들을 파람으로 주면서 요청을 한다
//따라서 파람을 모두 받는 작업을 한다
//만약 그렇지않고 제목글인 경우엔 , 제목글이 갖는 기본값으로 세팅


int num=0,ref=1,re_step=0,re_level=0; 
//제목글의 경우 작성 후 list 페이지의 첫 페이지로 보내야하기 때문에
// pageNum 을 파라미터로 주기위해 변수 및 값 초기화
int pageNum = 1;

try{//이 부분은 댓글을 작성 시 전달되는 파람 처리 코드
   if(request.getParameter("num")!=null){//댓글
     //댓글인 경우 부모글의 num 을 키로 사용해야 하기 때문에 반드시 num 이 존재한다
     // 제목글의 글번호, 그룹번호, 그룹내에서의 순서, list 에서 뿌려지는 계층의 level 값 등을 모두 처리함
     //list.jsp페이지에서 넘어옴
     num=Integer.parseInt(request.getParameter("num"));
	 ref=Integer.parseInt(request.getParameter("ref"));
	 re_step=Integer.parseInt(request.getParameter("re_step"));
	 re_level=Integer.parseInt(request.getParameter("re_level"));
	 pageNum=Integer.parseInt(request.getParameter("pageNum"));
   }// end of if
   
%>


<form method="post" action="writePro.jsp">
<input type="hidden" id="num" name="num" value="<%=num %>">
<input type="hidden" id="ref" name="fef" value="<%=ref %>">
<input type="hidden" id="re_step" name="re_step" value="<%=re_step %>">
<input type="hidden" id="re_level" name="re_level value="<%=re_level %>">
<input type="hidden" id="pageNum" name="pateNum" value="<%=pageNum %>">
<div id="writeForm" class="box">
   <ul>
      <li><label for="subject">제목</label>
        <%if(num != 0){//댓글%>
          <img src="../images/re.gif">
        <%}%>
          <input id="subject" name="subject" type="text" 
           size="50" placeholder="제목" maxlength="50">
      <li><label for="content">내용</label>
          <textarea id="content" name="content"  rows="13" cols="50"></textarea>
      <li><label for="pw">비밀번호</label>
          <input id="pw" name="pw" type="password" 
           size="20" placeholder="6~16자 숫자/문자" maxlength="16">
      <li class="label2">
          <input type="submit" value="등록"/>
          <button id="cancle" value="<%=pageNum %>">취소</button>
   </ul>
</div>  
</form>
 <%}catch(Exception e){}%>     