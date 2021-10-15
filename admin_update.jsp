<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Pharmacy helper</title>

	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="/project/css/list.css" rel="stylesheet">
	<script src="/sample/bootstrap/js/jquery.min.js"></script>
	<script>
	
	</script>
</head>
<body class="text-left">
<%
request.setCharacterEncoding("utf-8");

String unique_num = request.getParameter("unique_num");
%>
<%
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
                
    String query = "select * from project.seoul_pharmacy where unique_num ='" + unique_num + "'";
    
    rs = stmt.executeQuery(query);
    
    rs.next(); {
%>
<div class="container">
<h1 class="h2 mb-3 font-weight-normal">정보 수정</h1>
<ul class="list-group" style="pading:10px;padding-top: 5px;padding-right: 10px;padding-left: 10px;">
<form action="update.jsp">
<input type="hidden" name="unique_num" value="<%=unique_num%>">
  <table class="table-condensed" style="width:100%;">
  <tr> 
  <td style="width:60%">
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr >
      		<td style="width:80px;">약국 이름 :</td><td><input type="text" name="name" id="name" value="<%=rs.getString("name") %>"></td>
    	</tr>
    	<tr>
    		<td>전화번호 :</td><td><input type="text" name="phone" id="phone" value="<%=rs.getString("phone")%>"></td>
    	</tr>
    	<tr>
    		<td>주소 :</td><td><input type="text" name="address" id="address" style="width:300px" value="<%=rs.getString("address")%>" ></td>
    	</tr>
    </table>
    
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:120px;">가능한 외국어 :</td>
  			<td>
 				<input type="text" name="language" id="language" value="<%=rs.getString("language")%>">
			</td>
		</tr>
	</table>
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:140px;">월요일 운영시간 :</td><td style="width:300px;"><input type="text" name="opti_mon" id="opti_mon" style="width:100px" value="<%=rs.getString("opti_mon")%>"></td> <td style="width:140px;">화요일 운영시간 :</td><td><input type="text" name="opti_tue" id="opti_tue" style="width:100px" value="<%=rs.getString("opti_tue")%>"></td>
    	</tr>
    	<tr>
    		<td>수요일 운영시간 :</td><td><input type="text" name="opti_wed" id="opti_wed" style="width:100px" value="<%=rs.getString("opti_wed")%>"></td> <td>목요일 운영시간 :</td><td><input type="text" name="opti_thu" id="opti_thu" style="width:100px" value="<%=rs.getString("opti_thu")%>"></td>
    	</tr>
    	<tr>
    		<td>금요일 운영시간 :</td><td><input type="text" name="opti_fri" id="opti_fri" style="width:100px" value="<%=rs.getString("opti_fri")%>"></td> <td>토요일 운영시간 :</td><td><input type="text" name="opti_sat" id="opti_sat" style="width:100px" value="<%=rs.getString("opti_sat")%>"></td>
    	</tr>
    	<tr>
    		<td>일요일 운영시간 :</td><td><input type="text" name="opti_sun" id="opti_sun" style="width:100px" value="<%=rs.getString("opti_sun")%>"></td><td></td><td></td>
    	</tr>
    </table>
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:60px;">x좌표 :</td>
  			<td>
 				<input type="text" name="x_location" id="x_location" value="<%=rs.getString("x_location")%>">
			</td>
		</tr>
		<tr>
    		<td>y좌표 :</td>
  			<td>
 				<input type="text" name="y_location" id="y_location" value="<%=rs.getString("y_location")%>">
			</td>
		</tr>
	</table>
	<table style="float:right;margin-bottom:10px">
    	<tr>
    		<td style="width:160px"><button id="insert" style="font-size:130%">정보 수정</button></td>
    	</tr>
   	</table>
  </td>
  </tr>
  </table>
  </form>
  </ul>
</div>
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

%>
</body>
</html>