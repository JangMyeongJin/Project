<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Pharmacy Helper</title>
	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="/project/css/list.css" rel="stylesheet">
    <script src="/project/bootstrap/js/jquery.min.js"></script>
    <script type="text/javascript">
    $(function(){
		$("#search_all").click(function(){
			var chk = $(this).is(":checked");
			if(chk) {
				$(".select_subject input").prop('checked', true);
			}else {
				$(".select_subject input").prop('checked', false);
			}
		});
	});
    
    function checkSelectAll(){
    	 var eng = $('input[name="search_english"]').is(":checked");
    	 var jap = $('input[name="search_japanese"]').is(":checked");
    	 var chi = $('input[name="search_chinese"]').is(":checked");
    	 var ger = $('input[name="search_german"]').is(":checked");
    	 var fre = $('input[name="search_french"]').is(":checked");
    	 var spa = $('input[name="search_spanish"]').is(":checked");
    	 var rus = $('input[name="search_russian"]').is(":checked");
    	 if(eng && jap && chi && ger && fre && spa && rus){
    		 $('input[id="search_all"]').prop('checked',true);
    	 }else{
    		 $('input[id="search_all"]').prop('checked',false);
    	 }
     }
    </script>
</head>
<body class="text-left">
<%
String search_english = request.getParameter("search_english");
String search_chinese = request.getParameter("search_chinese");
String search_japanese = request.getParameter("search_japanese");
String search_german = request.getParameter("search_german");
String search_french = request.getParameter("search_french");
String search_russian = request.getParameter("search_russian");
String search_spanish = request.getParameter("search_spanish");
String search_all = request.getParameter("search_all");

if(search_english==null){
	search_english = "";
}
if(search_chinese==null){
	search_chinese = "";
}
if(search_japanese==null){
	search_japanese = "";
}
if(search_german==null){
	search_german = "";
}
if(search_french==null){
	search_french = "";
}
if(search_spanish==null){
	search_spanish = "";
}
if(search_russian==null){
	search_russian = "";
}

if(search_all==null){
	search_all = "";
}
%>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=webr3htmdq"></script>
<script src="/project/bootstrap/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	$('#search').click(function(){
		var query = $('#query').val();
		var language = "";
		if($('input[name="search_english"]').is(":checked")){
			language += "영어 ";
		}
   	 	if($('input[name="search_japanese"]').is(":checked")){
   	 		language += "일본어 ";
   	 	}
   	 	if($('input[name="search_chinese"]').is(":checked")){
   	 		language += "중국어 ";
   	 	}
   	 	if($('input[name="search_german"]').is(":checked")){
   	 		language += "독일어 ";
   	 	}
   	 	if($('input[name="search_french"]').is(":checked")){
   	 		language += "프랑스어 ";
   	 	}
   	 	if($('input[name="search_spanish"]').is(":checked")){
   	 		language += "스페인어 ";
   	 	}
   	 	if($('input[name="search_russian"]').is(":checked")){
   	 		language += "러시아어 ";
   	 	}
		alert(language+query);
		var x_location = $('#x_location').val();
		var y_location = $('#y_location').val();
		if(query=="" && language==""){
			var data = {
					"size":20,
					  "query": {
						    "bool": {
						      "must": {
						    	  "match_all":{}
						      },
						      "filter": {
						        "geo_distance": {
						          "distance": "3km",
						          "location": {
						            "lat": x_location,
						            "lon": y_location
						          }
						        }
						      }
						    }
						  },
						  "sort": [
						    {
						      "_geo_distance": {
						        "location": {
						          "lat": x_location,
						          "lon": y_location
						        },
						        "order": "asc",
						        "unit": "km"
						      }
						    }
						  ]
						}
		}else{
		var data = {
				"size":20,
				  "query": {
					    "bool": {
					      "must": {
					    	  "simple_query_string" : {
			    		       	"query": language + query,
			    		        "fields": ["name^5", "addr", "language^5"],
			    		        "default_operator": "and"
			    		    }
					      },
					      "filter": {
					        "geo_distance": {
					          "distance": "3km",
					          "location": {
					            "lat": x_location,
					            "lon": y_location
					          }
					        }
					      }
					    }
					  },
					  "sort": [
					    {
					      "_geo_distance": {
					        "location": {
					          "lat": x_location,
					          "lon": y_location
					        },
					        "order": "asc",
					        "unit": "km"
					      }
					    }
					  ]
					}
		}
		$.ajax({
		  method: "GET",
		  url: "http://localhost:9200/seoul_foregin_pharmacy/_search?source_content_type=application/json&source=" + JSON.stringify(data),
		  crossDomain: true,  
		  async: false,
		  dataType : 'json',
		  contentType: 'application/json; charset=UTF-8',
		  
		})
		.done(function( data ) {
		  console.log(data);
		  //var medicData = JSON.parse(data);
		  var dataset=data.hits.hits;
		  var latlngs = [];
		  var names = [];
		  $.each(dataset,function(idx,row){
			  var km = Math.round(dataset[idx].sort * 100)/100;
			  names.push(dataset[idx]._source.name+"\n"+dataset[idx]._source.addr+"\n"+dataset[idx]._source.language+"\n"+km+"km");//toFixed(2)
			  latlngs.push(new naver.maps.LatLng(dataset[idx]._source.location.lat, dataset[idx]._source.location.lon));
		  })
		  show(x_location,y_location,latlngs,names);
		  
		})
	});
});
function show(x,y,latlngs,names){
var HOME_PATH = window.HOME_PATH || '.';

var myPostion = new naver.maps.LatLng(x, y)

var mapOptions = {
	    zoom: 14,
	    center: myPostion,
	    
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

var myMarker = new naver.maps.Marker({
	position: myPostion,
	map: map,
	icon:'/project/images/mypoint.png',
	title: "현재위치"
});

var markerList = [];

for (var i=0, ii=latlngs.length; i<ii; i++) {
    var marker = new naver.maps.Marker({
            position: latlngs[i],
            map: map,
            icon: {
                url: '/project/images/medi_icon2.png',
                anchor: new naver.maps.Point(24, 35)
            },
            title: names[i]
        });

     marker.set('seq', i);
 
    markerList.push(marker);

    icon = null;
    marker = null;
}
}
</script>
<div class="container">
	<div class="row justify-content-center" style="width:100%">
		<div class="col-12 col-md-10 col-lg-8">
				<h1 class="h2 mb-3 font-weight-normal"><a href="search_location2.jsp">Pharmacy Helper</a></h1>
				<div style="margin-bottom:10px;" class="select_subject">
					가능한 외국어 : 
					<label><input type="checkbox" name="search_all" id="search_all" value="all" <%if(search_all.equals("all")){out.println("checked");} %>>외국어 전체</label>
					<label><input type="checkbox" name="search_english" id="search_language" onclick="checkSelectAll()" value="영어" <%if(search_english.equals("영어")){out.println("checked");} %>>영어</label>
					<label><input type="checkbox" name="search_chinese" id="search_language" value="중국어" <%if(search_chinese.equals("중국어")){out.println("checked");} %> onclick="checkSelectAll()">중국어</label>
					<label><input type="checkbox" name="search_japanese" id="search_language" value="일본어" <%if(search_japanese.equals("일본어")){out.println("checked");} %> onclick="checkSelectAll()">일본어</label>
					<label><input type="checkbox" name="search_german" id="search_language" value="독일어" <%if(search_german.equals("독일어")){out.println("checked");} %> onclick="checkSelectAll()">독일어</label>
					<label><input type="checkbox" name="search_french" id="search_language" value="프랑스어" <%if(search_french.equals("프랑스어")){out.println("checked");} %> onclick="checkSelectAll()">프랑스어</label>
					<label><input type="checkbox" name="search_spanish" id="search_language" value="스페인어" <%if(search_spanish.equals("스페인어")){out.println("checked");} %> onclick="checkSelectAll()">스페인어</label>
					<label><input type="checkbox" name="search_russian" id="search_language" value="러시아어" <%if(search_russian.equals("러시아어")){out.println("checked");} %> onclick="checkSelectAll()">러시아어</label>
				</div>
				<table class="table">
				<tr>
					<td style="border:0">검색어 : </td>
					<td style="border:0"><input type="text" name="query" id="query" placeholder="약국명"></td>
				</tr>
				<tr>
					<td style="border:0">좌   표 : </td>
					<td style="border:0"><input type="text" name="x_location" id="x_location" placeholder="위도(X좌표)"></td>
					<td style="border:0"><input type="text" name="y_location" id="y_location" placeholder="경도(y좌표)"></td>
					<td style="border:0"><button id="search">검색</button></td>
				</tr>
				</table>

		</div>
	</div>
	<ul class="list-group" style="width:100%">
	<div id="map" style="width:100%;height:600px;"></div>
	</ul>
</div>
</body>
</html>