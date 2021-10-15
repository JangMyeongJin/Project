<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<title>Pharmacy helper</title>
	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="/project/css/list.css" rel="stylesheet">
    
    <script src="/project/bootstrap/js/jquery.min.js"></script>
</head>

<body class="text-left">
<%
//세션받기
try{
	String project_session = (String)session.getAttribute("project");

	if(project_session==null){
%>
		<script>
		alert("로그인 후 이용가능합니다.");
		location.href = "login.html";
		</script>
<%
	}
}catch(NullPointerException e) {
%>
	<script>
	alert("로그인 후 이용가능합니다.");
	location.href = "login.html";
	</script>
<%
}
%>
<%
String project_session = (String)session.getAttribute("project");
%>
<div class="container">
	<div class="row justify-content-center">
		<div class="col-12 col-md-10 col-lg-8" style="margin-bottom:10px">
				<h1 class="h2 mb-3 font-weight-normal">Pharmacy Helper</h1>
				사용할 기능을 선택하세요.
		</div>
	</div>
	<ul class="list-group" style="pading:10px;padding-left:10px;width:50%">
    	<li class="list-group-item clearfix">
    		<a href ="search_location2.jsp">- 가까운 약국 찾기</a>
    	</li>
	</ul>
	<ul class="list-group" style="pading:10px;padding-left:10px;width:50%">
    	<li class="list-group-item clearfix">
    		<a href = "list.jsp">- 약국 검색하기</a>
    	</li>
	</ul>
	<%if(project_session.equals("admin")){ %>
	<ul class="list-group" style="pading:10px;padding-left:10px;width:50%">
    	<li class="list-group-item clearfix">
    		<a href = "admin_login.jsp">- 회원정보 관리하기</a>
    	</li>
	</ul>
	<%} %>
</div>
</body>
</html>