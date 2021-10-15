<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Pharmacy Helper</title>
	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="/project/css/list.css" rel="stylesheet">
    <script src="/project/bootstrap/js/jquery.min.js"></script>
    <script type="text/javascript">
        function update(){
            var updateForm = document.updateForm;
            var userName = updateForm.update_name.value;
            var password = updateForm.update_pw.value;
            
            if(!userName || !password){
                alert("이름과 비밀번호를 모두 입력해주세요.")
            }else{
            	updateForm.submit();
            }
        }
    </script>

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
<div class="container">
	<div class="row justify-content-center" style="width:100%">
		<div class="col-12 col-md-10 col-lg-8">
				<h1 class="h2 mb-3 font-weight-normal">Pharmacy Helper</h1><br>
				<h4 style="margin-top:-15px">회원관리</h4>
		<ul class="list-group" style="pading:10px;padding-top: 15px;padding-right: 10px;padding-left: 10px;padding-bottom: 10px">
		<table class="table text-center" style="width:100%">
		<tr style="background-color:lightgrey">
		<td>ID</td>
		<td>PASSWORD</td><td>NAME</td> <td>reg_date</td><td>수정하기</td><td>삭제하기</td>
		</tr>
<%
String id = request.getParameter("id");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
Class.forName("org.mariadb.jdbc.Driver");
try{
    
    conn = DriverManager.getConnection(
        "jdbc:mariadb://127.0.0.1:3306/project",
        "root",
        "jean13568");
                
    stmt = conn.createStatement();
    
    String query = "select * from pharmacy_login where id !='admin'";
    
    rs = stmt.executeQuery(query);
    
    conn.commit();
    
	while(rs.next()) {
		%>	
		<tr>
			<td><%=rs.getString("id") %></td>
			<td><%=rs.getString("pw") %></td>
			<td><%=rs.getString("name") %></td>
			<td><%=rs.getString("reg_date") %></td>
			<td><a href="admin_login.jsp?id=<%=rs.getString("id") %>">수정</a></td>
			<td><a href="admin_login_delete.jsp?id=<%=rs.getString("id")%>&name=<%=rs.getString("name")%>">삭제</a></td>
		</tr>
	
		<% 
				}
	} 
catch(SQLException e) {
     out.println(e.getMessage() );
     } 
finally {
         if(rs != null) try {rs.close();} catch(SQLException ex){}
         
         if(stmt != null) try {stmt.close();} catch(SQLException ex){}
     
         if(conn != null) try {conn.close();} catch(SQLException ex){}
 		}

if(id != null){
%>
</table>
</ul>
<ul class="list-group" style="pading:10px;padding-top: 5px;padding-right: 10px;padding-left: 10px;">

<form action="admin_login_update.jsp" name ="updateForm">
<table class="table">
<tr>
	<td>아이디 입력</td><td><input type="text" name="update_id" id="update_id" value="<%=id%>" readonly></td>
</tr>
<tr>
	<td>수정할 비밀번호</td><td><input type="text" name="update_pw"></td>
</tr>
<tr>
	<td>수정할 이름</td><td><input type="text" name="update_name"></td>
</tr>
<tr>
<td></td><td><input type="button" value="수정" onclick="update()"></td>
<tr>
</table>
</form>
</ul>
</div>
</div>
</div>
<% 
}
%>
</body>
</html>