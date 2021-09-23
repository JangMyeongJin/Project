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
</head>
<body class="text-left">
<%
String name = request.getParameter("name");
String phone = request.getParameter("phone");
String address = request.getParameter("address");
String language = request.getParameter("language");
String opti_mon = request.getParameter("opti_mon");
String opti_tue = request.getParameter("opti_tue");
String opti_wed = request.getParameter("opti_wed");
String opti_thu = request.getParameter("opti_thu");
String opti_fri = request.getParameter("fri");
String opti_sat = request.getParameter("opti_sat");
String opti_sun = request.getParameter("opti_sun");
String x_location = request.getParameter("x_location");
String y_location = request.getParameter("y_location");
%>
<div class="container">
<h1 class="h2 mb-3 font-weight-normal">정보 수정</a></h1>
<ul class="list-group" style="pading:10px;padding-top: 5px;padding-right: 10px;padding-left: 10px;">

  <table class="table-condensed" style="width:100%;">
  <tr>
  <td style="width:60%">
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr >
      		<td style="width:80px;">약국 이름 :</td><td><input type="text" name="name" id="name" value="<%=name %>"></td>
    	</tr>
    	<tr>
    		<td>전화번호 :</td><td><input type="text" name="phone" id="phone" value="<%=phone%>"></td>
    	</tr>
    	<tr>
    		<td>주소 :</td><td><input type="text" name="address" id="address" style="width:300px" value="<%=address%>"></td>
    	</tr>
    </table>
    
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:120px;">가능한 외국어 :</td>
  			<td>
 				<input type="text" name="language" id="language" value="<%=language%>">
			</td>
		</tr>
	</table>
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:140px;">월요일 운영시간 :</td><td style="width:300px;"><input type="text" name="opti_mon" id="opti_mon" style="width:100px" value="<%=opti_mon%>"></td> <td style="width:140px;">화요일 운영시간 :</td><td><input type="text" name="opti_tue" id="opti_tue" style="width:100px" value="<%=opti_tue%>"></td>
    	</tr>
    	<tr>
    		<td>수요일 운영시간 :</td><td><input type="text" name="opti_wed" id="opti_wed" style="width:100px" value="<%=opti_wed%>"></td> <td>목요일 운영시간 :</td><td><input type="text" name="opti_thu" id="opti_thu" style="width:100px" value="<%=opti_thu%>"></td>
    	</tr>
    	<tr>
    		<td>금요일 운영시간 :</td><td><input type="text" name="opti_fri" id="opti_fri" style="width:100px" value="<%=opti_fri%>"></td><td>토요일 운영시간 :</td><td><input type="text" name="opti_sat" id="opti_sat" style="width:100px" value="<%=opti_sat%>"></td>
    	</tr>
    	<tr>
    		<td>일요일 운영시간 :</td><td><input type="text" name="opti_sun" id="opti_sun" style="width:100px" value="<%=opti_sun%>"></td><td></td><td></td>
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
  </table>
  </ul>
</div>
</body>
</html>