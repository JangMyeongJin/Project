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
<div class="container">
<h1 class="h2 mb-3 font-weight-normal">추가정보 입력</a></h1>
<ul class="list-group" style="pading:10px;padding-top: 5px;padding-right: 10px;padding-left: 10px;">

  <table class="table-condensed" style="width:100%;">
  <tr>
  <td style="width:60%">
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
      		<td><h3 class="list-group-item-heading">
      			<input type="text" name="name" id="name">
      	  		</h3>
      		</td>
    	</tr>
    	<tr>
    		<td><input type="text" name="phone" id="phone"></td>
    	</tr>
    	<tr>
    		<td><input type="text" name="address" id="address"></td>
    	</tr>
    </table>
    
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:120px;">가능한 외국어 :</td>
  			<td>
 				<input type="text" name="language" id="language">
			</td>
		</tr>
	</table>
    
    <table class="table" style="width:100%;margin-bottom:0px;background-color:transparent;">
    	<tr>
    		<td>운영시간</td>
    	</tr>
    </table>
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td>월요일</td><td><input type="text" name="opti_mon" id="opti_mon"></td> <td>화요일</td> <td style="padding-right:10px"><input type="text" name="opti_tue" id="opti_tue"></td><td>수요일</td><td><input type="text" name="opti_wed" id="opti_wed"></td><td></td><td></td>
    	</tr>
    	<tr>
    		<td>목요일</td><td><input type="text" name="opti_thu" id="opti_thu"></td><td>금요일</td><td><input type="text" name="opti_fri" id="opti_fri"></td><td>토요일</td><td><input type="text" name="opti_sat" id="opti_sat"></td><td>일요일</td><td><input type="text" name="opti_sun" id="opti_sun"></td>
    	</tr>
    </table>
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:80px;">x좌표 :</td>
  			<td>
 				<input type="text" name="x_location" id="x_location">
			</td>
		</tr>
		<tr>
    		<td style="width:80px;">y좌표 :</td>
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