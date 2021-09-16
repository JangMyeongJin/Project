<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>회원가입완료</title>
	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="/project/css/login.css" rel="stylesheet">
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String pw = request.getParameter("pw");
String name = request.getParameter("name");

%>
<%
Connection conn = null;
PreparedStatement pstmt = null;
ResultSet rs = null;
Class.forName("org.mariadb.jdbc.Driver");
try{
    
    conn = DriverManager.getConnection(
        "jdbc:mariadb://127.0.0.1:3306/project",
        "root",
        "jean13568");
                
    pstmt = 
    	conn.prepareStatement("INSERT INTO project.pharmacy_login (id, pw, name, reg_date) VALUES (?, ?, ?, now())");
    
    pstmt.setString(1, id); 
    pstmt.setString(2, pw); 
    pstmt.setString(3, name);
    
    pstmt.executeUpdate();
    
    conn.commit();

	} catch(SQLException e) {
     out.println(e.getMessage() );
     } 
finally {
         if(rs != null) try {rs.close();} catch(SQLException ex){}
         
         if(pstmt != null) try {pstmt.close();} catch(SQLException ex){}
     
         if(conn != null) try {conn.close();} catch(SQLException ex){}
 		}

%>
<form action="login.html">
	<h1 class="h2 mb-3 font-weight-normal">회원가입이 완료되었습니다!</h1>
	<button class="btn btn-lg btn-primary btn-block" type="submit">로그인페이지로 돌아가기</button>
</form>
</body>
</html>