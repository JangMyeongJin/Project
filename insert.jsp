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

String unique_num = request.getParameter("unique_num");
String name = request.getParameter("name");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String language = request.getParameter("language");
String opti_mon = request.getParameter("opti_mon");
String opti_tue = request.getParameter("opti_tue");
String opti_wed = request.getParameter("opti_wed");
String opti_thu = request.getParameter("opti_thu");
String opti_fri = request.getParameter("opti_fri");
String opti_sat = request.getParameter("opti_sat");
String opti_sun = request.getParameter("opti_sun");
String x_location = request.getParameter("x_location");
String y_location = request.getParameter("y_location");

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
    	conn.prepareStatement("INSERT INTO project.seoul_pharmacy (unique_num, name, phone, address, language, opti_mon, opti_tue, opti_wed, opti_thu, opti_fri, opti_sat, opti_sun, x_location, y_location) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    
    pstmt.setString(1, unique_num); 
    pstmt.setString(2, name); 
    pstmt.setString(3, phone);
    pstmt.setString(4, address); 
    pstmt.setString(5, language); 
    pstmt.setString(6, opti_mon);
    pstmt.setString(7, opti_tue); 
    pstmt.setString(8, opti_wed); 
    pstmt.setString(9, opti_thu);
    pstmt.setString(10, opti_fri); 
    pstmt.setString(11, opti_sat); 
    pstmt.setString(12, opti_sun);
    pstmt.setString(13, x_location); 
    pstmt.setString(14, y_location);
    
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
</body>
<script>
alert("정보가 추가되었습니다.");
self.close();
</script>
</html>