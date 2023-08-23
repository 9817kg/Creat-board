var status = true;

$(document).ready(function(){
	//[로그인]버튼을 클릭하면 자동실행	
	//입력한 아이디와 비밀번호를 갖고 loginPro.jsp 페이지 실행
	$("#login").click(function(){
		checkIt();//입력폼에 입력한 상황 체크
		if(status){
		  //입력된 사용자의 아이디와 비밀번호를 얻어냄
		  var query = {id : $("#id").val(), 
				       passwd:$("#passwd").val()};
		  
		  $.ajax({
		     type: "POST",
		     url: "loginPro.jsp",
		     data: query,
		     success: function(data){
		    	 if(data == 1){//로그인 성공
		    		 $("#main_auth").load("loginForm.jsp");
		    		 $("#main_board").load("list.jsp");
		         }else if(data == 0){//비밀번호 틀림
		    	  	 alert("비밀번호가 맞지 않습니다.");
		    	  	 $("#passwd").val("");
		    	  	 $("#passwd").focus();
		    	 }else if(data == -1){//아이디 틀림
		    		 alert("아이디가 맞지 않습니다.");
		    		 $("#id").val("");
		    		 $("#passwd").val("");
		    	  	 $("#id").focus();
		    	 }
		     }
		  });
		}
	});
	
	//[로그아웃]버튼을 클릭하면 자동실행
	//logout.jsp페이지를 생행
	$("#logout").click(function(){//[회원정보수정]버튼 클릭
		$.ajax({
		   type: "POST",
		   url: "logout.jsp",
		   success: function(data){
			   $("#main_auth").load("loginForm.jsp");
	    	   $("#main_board").html("로그인하세요! 게시판은 회원만 볼 수 있습니다.");
		   }
		});
	});   
});

//인증되지 않은 사용자 영역에서 사용하는 입력 폼의 입력값 유무 확인
function checkIt(){
	status = true;
	if(!$.trim($("#id").val())){
		alert("아이디를 입력하세요.");
		$("#id").focus();
		status = false;
		return false;
	}
	
	if(!$.trim($("#passwd").val())){
		alert("비밀번호를 입력하세요.");
		$("#passwd").focus();
		status = false;
		return false;
	}
}