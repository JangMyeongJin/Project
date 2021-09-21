<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>login_check</title>
	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="/project/css/login.css" rel="stylesheet">
</head>
<body>
<%
String id = request.getParameter("id");
String pw = request.getParameter("pw");
int count = 0;

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
    
    String query = "select count(1) from pharmacy_login where id = '"+id+"' and pw = '"+pw+"' ";
    
    rs = stmt.executeQuery(query);
    
    conn.commit();
    
	while(rs.next()) {
		count = rs.getInt(1);
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

%>
<%
if(count==1 && id.equals("admin")){
	session.setAttribute("project", 0000);
	response.sendRedirect("/project/jsp/list_admin.jsp");
}else if(count==1){
	session.setAttribute("project", 0000);
	response.sendRedirect("/project/jsp/list.jsp");
}else {
%>
	<script>
	 alert("아이디또는 비밀번호가 틀립니다.");
	 location.href = "login.html";
	</script>
<%
	
}
%>
</body>
</html>