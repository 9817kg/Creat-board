<%@page import="firstWeb.board.daos.BoardDAO"%>
<%@page import="firstWeb.board.dtos.BoardDTO"%>

<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--css import  -->
<link rel="stylesheet" , href="../css/style.css">
<!-- 스크립트 소스 import 시엔 반드시 한번에 하나만 하고, 선언문 사이엔 공백 없애기 -->
<script src="../js/jquery-1.11.0.min.js"></script>
<script src="../js/list.js"></script>
<%
request.setCharacterEncoding("utf-8");
%>

<%
// id 값을 게시판에서 전체적으로 사용할 예정
// 따라서 param 으로 받는다

String id = request.getParameter("id");
//게시판 페이징(paging) 을 하기 위해서 반드시 필요한 기준값이 한 페이지당 표시될 목록 수를 변수로 선언
// 지금은 3개로 한다( 즉 한 페이지당 글 목록 수를 3개만 표시 -> 단 댓글은 count 에 미포함)
int pageSize = 5;
// 작성일 포맷 생성
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-DD HH:mm");

// 신규 글 (article ) 을 작성하거나, 특정 글을 보다가 원래 페이지 목록으로 요청이 올 경우
// 항상 해당 페이지로 요청을 시켜야 하기 때문에 pageNum 이라는 변수를 두고, 요청 여부를 판단,
// 있는 경우엔 해당 페이지로, 아닌 경우엔 최신글 페이지로 설정한다. 따라서 변수 선언 및 param 유무 검사 후
// 페이지값 세팅 로직을 구현한다.

String pageNum = request.getParameter("pageNum");

if (pageNum == null) {
    pageNum = "1";

}

int count = 0; //리스트 페이지에서 표현할 글들의 전체 count 변수

// 사용자가 현재 보고있는 페이지에 번호를 담는 변수 선언 및 초기화.
int currentPage = Integer.parseInt(pageNum);
// 이 페이지가 요청된다는 말은 무조건 게시글을 보여줘야 한다
// 따라서  DAO 와 DTO, 그리고 컬렉션을 이용해서 전체글을 가져오는 Beans 이용시작

List<BoardDTO> articleList = null; // 전체글을 담는 컬렉션 선언.

// 게시글을 얻어오는 메서드를 호출한다.
BoardDAO dao = BoardDAO.getInstance();

// 페이징 처리를 하기 위해서 꼭 필요한 전체글  count 를 리턴하는 메서드를 호출
count = dao.getArticleCount();

// 현재 페이지의 index 를 얻는 산수를 적용
//예를 들어 10 개 글 존재, 페이지 당 3개의 글표시
// 필요페이지는 4페이지가 필요
// 모든 첫 페이지에는 최신글을 표현한다라고 가정
// DB count = 0 , 0 or 1 페이지 즉, 페이지 넘버 틀릴 뿐이지 글이 하나라도 존재하면 무조건 1페이지가 보여야 하고, 하나도 없을경우엔 페이지가 필요없음
if (count == (currentPage - 1) * pageSize) {
    currentPage -= 1;
}

// 위에서 조건절로 글의 갯수에 따른 보여줄 페이지 변수를 설정했으니
// 해당 페이지에서 보여질 글의 Row 값을 찾아야한다.
// 이것 역시 산수이다. 보통 공식으로 나와있으니 참고하고, 어렵지 않다.

int startRow = (currentPage - 1) * pageSize + 1; // 현재 페이지에서의 시작 글 번호 값 초기화

// 위에서 startRow 는 페이지에 표시될 글 번호를 나타내니, 이 번호를 기준으로 글들으 가져오도록 하는 DAO 의 메서드를 호출한다.
// 단 글이 없는경우(지금처럼 처음 만드는 경우) 도 생각을 해야한다.

try {
    // 글이 존재하는 경우-
    if (count > 0) {
	articleList = dao.getArticles(startRow, pageSize);
    }
    if (articleList == null) { // 저장된 글이 하나도 없을 경우
	count = 0; // 글 갯수 변수 0 초기화

    }
} catch (Exception e) {

}
%>
</head>
<body>
	<div id="list_head" class="box2">
		<h3 class="inline">
			글 목록(전체글 :
			<%=count%>)
		</h3>
		<button id="new">글쓰기</button>
	</div>

	<!--아래는 글이 존재 여부에 따라서 조건문을 태운다. -->
	<%
	if (count == 0) { // 게시글이 존재하지 않을 경우
	%>
	<div id="list_article" class="box2">
		<ul>
			<li><p>게시판에 저장된 글이 없습니다.</p></li>
		</ul>
	</div>
	<%
	} // 글 없는 if end
	else {
	%>
	<div id="list_article" class="box2">
		<%
		//글 목록을 loop
		for (int i = 0; i < articleList.size(); i++) {
		    BoardDTO article = articleList.get(i);
		%>
		<ul class="article">
			<li class="layout_f" />
			<%
			String writer = article.getWriter();
			out.println(writer.substring(0, 2) + "****");
			%>
			<li class="layout_f" />
			<%
			// 이 부분은 제목의 내용에 대한 depth를 설정하는 구간이다.
			//re_level 은 댓글의 순서에 대한 기준값으로 그 값을 이용해서 
			// 공백 이미지의 size 를 증가하는 형태로 표현할 예정이다.

			int width = 0;
			if (article.getRe_level() > 0) {
			    // 이 조건이 만족되면 무조건 댓글
			    width = 5 * (article.getRe_level());
			%>
			<img src="../images/level.gif" width="<%=width%>" />
			<img src="../images/re.gif" />
			<%
			} else {// 댓글이 아닐 경우
			%>
			<img src="../images/level.gif" width="<%=width%>" height="16" />
			<%
			}
			%>

			<%
			// 각 페이지(상세, 삭제, 댓글 등의 페이지로 보내지는 key값을 세팅)
			int num = article.getNum();
			int ref = article.getRef();
			int re_step = article.getRe_step();
			int re_level = article.getRe_level();
			%>

			<%=article.getSubject()%>
			<p class="date"><%=sdf.format(article.getReg_date())%></p>
			<!--content  -->
			<pre><%=article.getContent()%></pre>
			<br>

			<%
			// 로그인한 유저가 글을 작성한 유저라면 삭제나 수정 버튼을 보여주도록 한다.
			id = (String) session.getAttribute("id");
			if (id.equals(writer)) {
			%>
			<button id="edit" name="<%=num + "," + pageNum%>"
				onclick="edit(this);">수정</button>
			<button id="delete" name="<%=num + "," + pageNum%>"
				onclick="del(this);">삭제</button>
			<%
			} else {
			%>
			<button id="reply"
				name="<%=num + "," + ref + "," + re_step + "," + re_level + "," + pageNum%>"
				onclick="reply(this);">댓글쓰기</button>
			<%
			}
			%>
		</ul>
		<%
		} //end of  글목록 loop
		%>
	</div>
	<%
	}
	%>
	
	<!--페이징 처리(paging)
	전체 글 목록 수를 기준으로 페이지 수를 계산하고, 사용자가 보고있는 글에 대한 목록들이 
	해당 페이지에 나타날 수 있도록 해야한다.
	이러한 paging 계산식 또한 다양한 수식으로 고정화 되어 있으니, 지금 하는 것 외에 필요 시 찾아서 바꿔보자
	
	-->
	<div id="jump" class="box3">
	<!--전체 글이 존재 하는지의 여부 확인 한다 -->
	<%
	if(count > 0){ // 글이 하나라도 존재한다면
	    // 전체 페이지 수를 계산한다.
	    int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	
		// 시작페이지는 1로 설정
		int startPage = 1;
		// 현재 페이지의 번호값을 전체 페이지와 비교한다.
		if(currentPage % pageSize != 0){
		    startPage = (int)(currentPage / pageSize ) * pageSize + 1;
		    
		}else{
		    startPage = ((int)(currentPage / pageSize )-1) * pageSize + 1;
		}
		
		// 전체 페이지가 이동하는 페이지 블락을 선언한다.
		// 이 블락은 아까 말했듯이, 이전, 다음 등의 page 리스트가 그룹 단위로 이동 할 때 사용되도록 한다.
		int pageBlock = 3;
		int endPage = startPage + pageBlock -1;
		// 11개의 글 존제, 1부터 4까지의 페이지가 존재한다
		// 3페이지를 본다.
		
		// endPage 가 만약 pageCount 보다 큰 경우를 생각해보자.(공백 페이지가 발생하는 경우 처리)
		if(endPage > pageCount){ 
		    endPage = pageCount;
		}
		// 위 까지가 공백페이지, 페이지 블락, 페이지 갯수를 처리하는 산수 끝
		// 이제부터 페이지를 뿌려주기만 하면 됨
		
		// startPage 가 pageBlock 보다 작은 경우를 생각해보자.
		if(startPage > pageBlock){
%>
		    <button id="jup" name="<%=startPage - pageBlock %>" onclick="p(this);" class=" w2">
		    이전
		    </button>&nbsp;
		    
<% 
		
		}// 이전 페이지 블락 if 문 end
		for(int i = startPage; i <= endPage; i++){
		    //i 가 페이지 index 번호로 사용된다
		    if(currentPage == i){
%>
		<button id ="ju" name="<%= i%>" onclick="p(this);" class="w1">
			<%= i%>
		</button>
<% 
		    }
		 else{
			%>
		<button id ="ju" name="<%= i%>" onclick="p(this);" class="w">
			<%= i%>
		</button>
<% 
		    }
		}//end of for
	    // 마지막으로  endPage 블락을 처리할 조건을 넣어서 [다음] 을 표기한다.
	    if(endPage < pageCount){
		%>
		<button id ="juN" name="<%=startPage + pageBlock %>" onclick="p(this);" class="w2">
			다음
		</button>
		<% 
	    }
	}
	
	
%>
	</div>


</body>
</html>