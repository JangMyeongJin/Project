<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Pharmacy helper</title>

	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
	<link href="/project/css/list.css" rel="stylesheet">
	<script src="/project/bootstrap/js/jquery.min.js"></script>
	<script type="text/javascript">
	$(function(){
     	$('#insert').click(function(){
     		var name = $( '#name' ).val();
     		var phone = $( '#phone' ).val();
     		var address = $( '#address' ).val();
     		var language = $( '#language' ).val();
     		var opti_mon = $( '#opti_mon' ).val();
     		var opti_tue = $( '#opti_tue' ).val();
     		var opti_wed = $( '#opti_wed' ).val();
     		var opti_thu = $( '#opti_thu' ).val();
     		var opti_fri = $( '#opti_fri' ).val();
     		var opti_sat = $( '#opti_sat' ).val();
     		var opti_sun = $( '#opti_sun' ).val();
     		var x_location = $( '#x_location' ).val();
     		var y_location = $( '#y_location' ).val();
     		
            if(name==""){
           	 	alert("약국이름을 입력하세요.");
           	 	$( '#name' ).focus();
           	 	return;
            }
            if(phone==""){
            	alert("약국 전화번호를 입력하세요.");
              	 $( '#phone' ).focus();
              	 return;
            }
            if(address==""){
            	alert("약국 주소를 입력하세요.");
              	 $( '#address' ).focus();
              	 return;
            }
            if(language==""){
            	alert("가능한 외국어를 입력하세요.");
              	 $( '#language' ).focus();
              	 return;
            }
            if(opti_mon==""){
            	alert("월요일 운영시간을 입력하세요.");
              	 $( '#opti_mon' ).focus();
              	 return;
            }
            if(opti_tue==""){
            	alert("화요일 운영시간을 입력하세요.");
              	 $( '#opti_tue' ).focus();
              	 return;
            }
            if(opti_wed==""){
            	alert("수요일 운영시간을 입력하세요.");
              	 $( '#opti_wed' ).focus();
              	 return;
            }
            if(opti_thu==""){
            	alert("목요일 운영시간을 입력하세요.");
              	 $( '#opti_thu' ).focus();
              	 return;
            }
            if(opti_fri==""){
            	alert("금요일 운영시간을 입력하세요.");
              	 $( '#opti_fri' ).focus();
              	 return;
            }
            if(opti_sat==""){
            	alert("토요일 운영시간을 입력하세요.");
              	 $( '#opti_sat' ).focus();
              	 return;
            }
            if(opti_sun==""){
            	alert("일요일 운영시간을 입력하세요.");
              	 $( '#opti_sun' ).focus();
              	 return;
            }
            if(x_location==""){
            	alert("x좌표를 입력하세요.");
              	 $( '#x_location' ).focus();
              	 return;
            }
            if(y_location==""){
            	alert("y좌표를 입력하세요.");
              	 $( '#y_location' ).focus();
              	 return;
            }
     		document.getElementById('formInsert').submit();
     	});
     	
 	});
	</script>
</head>

<body class="text-left">
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
    
    String query = "select MAX(unique_num) as unique_num from project.seoul_pharmacy";
    
    rs = stmt.executeQuery(query);
    
    conn.commit();
    
	rs.next(); {
		String unique_num;
		unique_num = rs.getString("unique_num");
		
		String c = unique_num.substring(0, 1);
		String string_num = unique_num.substring(1);
		
		int num = Integer.parseInt(string_num);
		
		num += 1;
		
		string_num = Integer.toString(num);
		
		unique_num = c + string_num;
		
%>
<div class="container">
<h1 class="h2 mb-3 font-weight-normal">추가정보 입력</a></h1>
<ul class="list-group" style="pading:10px;padding-top: 5px;padding-right: 10px;padding-left: 10px;">
<form action="insert.jsp" id="formInsert" onsubmit="return false">
  <table class="table-condensed" style="width:100%;">
  <tr>
  <td style="width:60%">
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td>고유번호 :</td><td><input type="text" name="unique_num" value="<%=unique_num%>" readonly></td>
    	</tr>
    	<tr>
      		<td style="width:80px;">약국 이름 :</td><td><input type="text" name="name" id="name"></td>
    	</tr>
    	<tr>
    		<td>전화번호 :</td><td><input type="text" name="phone" id="phone"></td>
    	</tr>
    	<tr>
    		<td>주소 :</td><td><input type="text" name="address" id="address" style="width:300px"></td>
    	</tr>
    </table>
    
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:120px;">가능한 외국어 :</td>
  			<td>
 				<input type="text" name="language" id="language" style="width:250px" placeholder="가능한 외국어가 없으면 '없음' 입력">
			</td>
		</tr>
	</table>
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:140px;">월요일 운영시간 :</td><td style="width:300px;"><input type="text" name="opti_mon" id="opti_mon" style="width:100px" placeholder="00:00 ~ 00:00"> (쉬는날이면 '-' 입력)</td> <td style="width:140px;">화요일 운영시간 :</td><td><input type="text" name="opti_tue" id="opti_tue" style="width:100px" placeholder="00:00 ~ 00:00"></td>
    	</tr>
    	<tr>
    		<td>수요일 운영시간 :</td><td><input type="text" name="opti_wed" id="opti_wed" style="width:100px" ></td> <td>목요일 운영시간 :</td><td><input type="text" name="opti_thu" id="opti_thu" style="width:100px" ></td>
    	</tr>
    	<tr>
    		<td>금요일 운영시간 :</td><td><input type="text" name="opti_fri" id="opti_fri" style="width:100px" ></td><td>토요일 운영시간 :</td><td><input type="text" name="opti_sat" id="opti_sat" style="width:100px" ></td>
    	</tr>
    	<tr>
    		<td>일요일 운영시간 :</td><td><input type="text" name="opti_sun" id="opti_sun" style="width:100px" ></td><td></td><td></td>
    	</tr>
    </table>
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:60px;">x좌표 :</td>
  			<td>
 				<input type="text" name="x_location" id="x_location">
			</td>
		</tr>
		<tr>
    		<td>y좌표 :</td>
  			<td>
 				<input type="text" name="y_location" id="y_location">
			</td>
		</tr>
	</table>
     </td>
    </tr>
    <tr>
    	<td>
  		<table style="float:right;margin-bottom:10px">
    		<tr>
    			<td style="width:160px"><button id="insert" style="font-size:130%">정보 입력</button></td>
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