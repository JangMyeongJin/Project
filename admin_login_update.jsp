<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Pharmacy helper</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");

String update_id = request.getParameter("update_id");
String update_pw = request.getParameter("update_pw");
String update_name = request.getParameter("update_name");

%>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
int updateCount = 0;
Class.forName("org.mariadb.jdbc.Driver");
try{
    
    conn = DriverManager.getConnection(
        "jdbc:mariadb://127.0.0.1:3306/project",
        "root",
        "jean13568");
    
    stmt = conn.createStatement();
    
    updateCount = 
    		stmt.executeUpdate("update pharmacy_login set pw = '"+update_pw+"', name = '"+update_name+"' where id = '"+update_id+"'");
         

	} catch(SQLException e) {
     out.println(e.getMessage() );
     } 
finally {
         if(rs != null) try {rs.close();} catch(SQLException ex){}
         
         if(stmt != null) try {stmt.close();} catch(SQLException ex){}
     
         if(conn != null) try {conn.close();} catch(SQLException ex){}
 		}

%>
</body>
<script>
alert("회원정보가 수정되었습니다.");
location.href="admin_login.jsp";
</script>
</html>