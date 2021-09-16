<%@ page language="java" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>회원가입</title>
	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="/project/css/signup.css" rel="stylesheet">
	
	<script src="/sample/bootstrap/js/jquery.min.js"></script>
	<script type="text/javascript">
      $(function(){
        $('#btn_submit').click(function(){
        var jb = $( '#id' ).val();
         if(jb==""){
        	 alert("아이디를 입력하세요.");
        	 $( '#id' ).focus();
        	 return;
         }
         
         var pd = $( '#pw' ).val();
         if(pd==""){
        	 alert("비밀번호를 입력하세요.");
        	 $( '#pw' ).focus();
        	 return;
         }
         
         var pd = $( '#name' ).val();
         if(pd==""){
        	 alert("이름을 입력하세요.");
        	 $( '#name' ).focus();
        	 return;
         }
         document.getElementById('form-signin').submit();
        });
      });
      </script>
</head>

<body class="text-center">
	<form class="form-signin" action="signup_check.jsp" method="post" onsubmit="return false" id="form-signin">
		<h1 class="h2 mb-3 font-weight-normal">회원가입</h1>
		<table class="table" style="width:100%">
			<tr>
				<td>아이디 입력</td>
				<td>
				<label for="inputId" class="sr-only">ID</label>
				<input type="text" id="id" name="id" class="form-control" placeholder="ID">
				</td>
			</tr>

			<tr>
				<td>비밀번호 입력</td>
				<td>
				<label for="inputPassword" class="sr-only">Password</label>
				<input type="password" id="pw" name="pw" class="form-control" placeholder="Password">
				</td>
			</tr>

			<tr>
				<td>사용자 이름 입력</td>
				<td>
				<label for="inputName" class="sr-only">Name</label>
				<input type="text" id="name" name="name" class="form-control" placeholder="name">
				</td>
				</tr>
		</table>
		<button class="btn btn-lg btn-primary btn-block" id="btn_submit">회원가입</button>
	</form>

</body>
</html>