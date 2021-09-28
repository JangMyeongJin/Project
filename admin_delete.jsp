<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
String unique_num = request.getParameter("unique_num");
%>
<%
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
Class.forName("org.mariadb.jdbc.Driver");
try{
    
    conn = DriverManager.getConnection(
        "jdbc:mariadb://127.0.0.1:3306/project",
        "root",
        "jean13568");
    
    stmt = conn.prepareStatement("delete from project.seoul_pharmacy where unique_num = ?");
    
    stmt.setString(1, unique_num);
    
    stmt.executeUpdate();
    
    conn.commit();

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
alert("정보가 삭제되었습니다.");
location.href="list.jsp"
</script>
</html>