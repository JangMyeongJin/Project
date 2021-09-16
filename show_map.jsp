<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
    <title>Pharmacy helper</title>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=webr3htmdq"></script>
</head>
<body>
<%
//세션받기
try{
	int i_session = (Integer)session.getAttribute("project");

	if(i_session!=0000){
%>
		<script>
		alert("로그인 후 이용가능합니다.");
		location.href = "login.html";
		</script>
<%
	}
}catch(NullPointerException e) {
%>
	<script>
	alert("로그인 후 이용가능합니다.");
	location.href = "login.html";
	</script>
<%
}
%>
<%
request.setCharacterEncoding("utf-8");

String x_location = request.getParameter("x_location");
String y_location = request.getParameter("y_location");
%>
<div id="map" style="width:100%;height:600px;"></div>	
<script>
var mapOptions = {
    zoom: 17,
    center: new naver.maps.LatLng(<%=x_location%>,<%=y_location%>),
    
    zoomControl: true,
	zoomControlOptions: {
    	style: naver.maps.ZoomControlStyle.BIG,
    	position: naver.maps.Position.TOP_RIGHT
	},
	mapTypeControl: true,
	mapTypeControlOptions: {
    	style: naver.maps.MapTypeControlStyle.BUTTON,
    	position: naver.maps.Position.TOP_RIGHT
	},
	scaleControl: true,
	scaleControlOptions: {
    	position: naver.maps.Position.BOTTOM_LEFT
	},
	logoControl: true,
	logoControlOptions: {
    	position: naver.maps.Position.TOP_LEFT
	}
};

var map = new naver.maps.Map(document.getElementById('map'), mapOptions);

var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng(<%=x_location%>,<%=y_location%>),
    map: map
});
</script>
</body>
</html>