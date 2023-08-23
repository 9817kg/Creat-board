$(document).ready(function(){
	//[글쓰기]버튼을 클릭하면 자동실행 :제목글 쓰기 
	//main.jsp의 main_board영역에 writeForm.jsp표시
	$("#new").click(function(){
		$("#main_board").load("writeForm.jsp");
	});  
});

//[글수정]버튼을 클릭하면 자동실행
//main.jsp의 main_board영역에 글수정폼 표시
function edit(editBtn){
	//수정할 글의 정보가 [글수정]버튼인 editBtn의 name속성에 지정
	var rStr = editBtn.name;
	var arr = rStr.split(",");
	//글번호와 페이지번호를 갖고 updateForm.jsp 페이지 로드
	var query = "updateForm.jsp?num="+arr[0];
	query += "&pageNum="+arr[1];
	$("#main_board").load(query);
}

//[글삭제]버튼을 클릭하면 자동실행
//main.jsp의 main_board영역에 글삭제폼 표시
function del(delBtn){
	var rStr = delBtn.name;
	var arr = rStr.split(",");
	//글번호와 페이지번호를 갖고 deleteForm.jsp 페이지 로드
	var query = "deleteForm.jsp?num="+arr[0];
	query += "&pageNum="+arr[1];
	$("#main_board").load(query);
}

//[댓글쓰기]버튼을 클릭하면 자동실행
//main.jsp의 main_board영역에 글쓰기폼 표시
function reply(replyBtn){
	var rStr = replyBtn.name;
	var arr = rStr.split(",");
	//댓글쓰기에 필요한 정보를 갖고 writeForm.jsp 페이지 로드
	var query = "writeForm.jsp?num="+arr[0]+"&ref="+arr[1];
	query += "&re_step="+arr[2]+"&re_level="+arr[3]+"&pageNum="+arr[4];
	$("#main_board").load(query);
}

//페이지 이동 버튼을 누르면 자동으로 실행
//main.jsp의 main_board영역에 해당페이지의 글목록 표시
function p(jumpBtn){
	var rStr = jumpBtn.name;
	var query = "list.jsp?pageNum="+rStr;
	$("#main_board").load(query);
}