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

String id = request.getParameter("id");
String name = request.getParameter("name");

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
    		stmt.executeUpdate("delete from pharmacy_login where name = '"+name+"' and id = '"+id+"'");
         

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
alert("회원정보가 삭제되었습니다.");
location.href="admin_login.jsp";
</script>
</html>