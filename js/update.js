var wStatus = true;

$(document).ready(function(){
	
	//글수정폼의 [수정]버튼을 클릭하면 자동실행
    $("#update").click(function(){
    	formCheckIt();//글수정 폼의 입력 여부 체크
    	if(wStatus){
  		  //[수정]버튼의 값으로 지정된 현재페이지 번호를 얻어냄
    	  var pageNum = $("#update").val();
    	  //글번호와 글수정폼에 입력된 값을 얻어내서 query에 저장
  		  var query = {subject:$("#subject").val(),
  				       content:$("#content").val(),
  				       passwd:$("#passwd").val(),
  				       num:$("#num").val()};
  		  
  		 //query값을 갖고 updatePro.jsp실행
  		  $.ajax({
  		     type: "POST",
  		     url: "updatePro.jsp",
  		     data: query,
  		     success: function(data){
  		    	 if(data == 1){//글수정 처리가 성공한 경우
  		    		alert("글이 수정되었습니다.");
  		    		var query = "list.jsp?pageNum="+pageNum;
  		    		$("#main_board").load(query);
  		         }else{//글수정 처리가 실패한 경우
  		        	alert("비밀번호 틀림.");
  		        	$("#passwd").val("");
  		        	$("#passwd").focus();
  		         }
  		     }
  		  });
  		}
	});
    
    //글수정폼의 [취소]버튼을 클릭하면 자동실행
    //글목록보기 list.jsp페이지를 표시
    $("#cancle").click(function(){
    	var pageNum = $("#cancle").val();
    	var query = "list.jsp?pageNum="+pageNum;
  		$("#main_board").load(query);
	});
     
});

//글수정 폼의 입력값 유무 확인
function formCheckIt(){
	wStatus = true;
	if(!$.trim($("#subject").val())){
		alert("제목을 입력하세요.");
		$("#subject").focus();
		wStatus = false;
		return false;
	}
	
	if(!$.trim($("#content").val())){
		alert("내용을 입력하세요.");
		$("#content").focus();
		wStatus = false;
		return false;
	}
	
	if(!$.trim($("#passwd").val())){
		alert("비밀번호를 입력하세요.");
		$("#passwd").focus();
		wStatus = false;
		return false;
	}
}