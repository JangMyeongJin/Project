<%@ page language="java" contentType="text/html;charset=utf-8" %>
<%@ page import = "java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
	<title>Pharmacy helper</title>
	<link href="/project/bootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="/project/css/list.css" rel="stylesheet">
   
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=webr3htmdq"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=webr3htmdq"></script>
    <script src="/project/bootstrap/js/jquery.min.js"></script>
    <script type="text/javascript">
     function goPage(page){
    	 $( '#curpage' ).val(page);
    	 document.getElementById('searchForm').submit();
     }
     
     $(function(){
     	$('#btn_submit').click(function(){
	     	var search_gu = $( '#search_gu' ).val();
	     	var search_language = $( '#search_language' ).val();
	      	if(search_gu=="none" && search_language == null){
	     	 	alert("해당구를 선택하세요.");
	     	 	$( '#search_gu' ).focus();
	     	 	return;
	      	}
	      	document.getElementById('formSearch').submit();
     	});
     	
 	}); 	 
     function showMap(){
    	var x_location = $('#x_location').val();
    	var y_location = $('#y_location').val();
     	window.open("show_map.jsp"+"?x_location="+x_location+"&y_location="+y_location ,"a","width:300px;height:300px;");
     }
     
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

String search_name = request.getParameter("search_name");
String search_gu = request.getParameter("search_gu");
String search_dong = request.getParameter("search_dong");
String search_english = request.getParameter("search_english");
String search_chinese = request.getParameter("search_chinese");
String search_japanese = request.getParameter("search_japanese");
String search_german = request.getParameter("search_german");
String search_french = request.getParameter("search_french");
String search_russian = request.getParameter("search_russian");
String search_spanish = request.getParameter("search_spanish");
String search_all = request.getParameter("search_all");

String gu[] = {"강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"};

int selected_gu = -1;
int selected_dong = -1;

for(int i=0; i<gu.length; i++){
	if(search_gu!=null && search_gu.equals("search_"+i)){
		search_gu = gu[i];
		selected_gu = i;
		break;
	}
}
if(search_dong==null || search_dong.equals("해당동 선택")){
	search_dong = "";
}
if(search_name==null){
	search_name = "";
}
if(search_gu==null || search_gu.equals("none")){
	search_gu = "";
}
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

int viewPages = 10;
int totalPage = 0;//Integer.parseInt(request.getParameter("totalpage"));
int totalCount = 0;
int curPage = 1;//Integer.parseInt(request.getParameter("curpage"));
if(request.getParameter("curpage") != null){
	try{
		curPage = Integer.parseInt(request.getParameter("curpage"));
	}catch(Exception ex){} 
}
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
    
    //검색결과의 갯수 정하는 쿼리
    String query = "select count(1)  from seoul_pharmacy ";
    
    String where = "where  name like '%"+search_name+"%' and address like '%"+search_gu+"%' and address like '%"+search_dong+"%' ";
    String where2 = "";
    if("all".equals(search_all)){
    	search_english = "영어";
        search_chinese = "중국어";
        search_japanese = "일본어";
        search_german = "독일어";
        search_french = "프랑스어";
        search_russian = "러시아어";
        search_spanish = "스페인어";
    }
    if(!"".equals(search_english)){
    	
    	where2+=" language like '%"+search_english+"%'";
    }
	if(!"".equals(search_chinese)){
		if(where2.length()>1){
    		where2+=" OR ";
    	}
		where2+=" language like '%"+search_chinese+"%'";
    }
	if(!"".equals(search_japanese)){
		if(where2.length()>1){
    		where2+=" OR ";
    	}
		where2+=" language like '%"+search_japanese+"%'";
    }
	if(!"".equals(search_german)){
		if(where2.length()>1){
    		where2+=" OR ";
    	}
		where2+=" language like '%"+search_german+"%'";
    }
	if(!"".equals(search_french)){
		if(where2.length()>1){
    		where2+=" OR ";
    	}
		where2+=" language like '%"+search_french+"%'";
    }
	if(!"".equals(search_russian)){
		if(where2.length()>1){
    		where2+=" OR ";
    	}
		where2+=" language like '%"+search_russian+"%'";
    }
	if(!"".equals(search_spanish)){
		if(where2.length()>1){
    		where2+=" OR ";
    	}
		where2+=" language like '%"+search_spanish+"%'";
    }
    if(where2.length()>2){
    	where +=" AND ("+where2+")";
    }
    query+=where;
    rs = stmt.executeQuery(query);

    if(rs.next()){
		totalCount = rs.getInt(1);
	}
    
	totalPage = (totalCount-1)/viewPages + 1;
	
	int startNum = (curPage-1) * viewPages;
%>
    <div class="container">
    	<div class="row justify-content-center">
                        <div class="col-12 col-md-10 col-lg-8">
                        <h1 class="h2 mb-3 font-weight-normal"><a href="list.jsp">Pharmacy Helper</a></h1>
                            <form class="card card-sm" id="searchForm" method="get" action="list.jsp" >
                            <div style="margin-bottom:10px;">
			<select id="search_gu" name="search_gu" class="select" onChange="selectChange(this)">
				<option value="none">해당구 선택</option>
				<%
				for(int i=0; i<gu.length; i++){
				%>
				<option value="search_<%=i%>" <%if(selected_gu==i){out.println("selected");} %>><%=gu[i]%></option>
				<%
				}
				%>
			</select>
			
			<select id="search_dong" name="search_dong" style="width:120px">
				<option>해당동 선택</option>
			</select>
			
			<script>
			function selectChange(e) {
				var none = ["해당동 선택"];
				var search_0 = ["해당동 선택","개포동","논현동","대치동","도곡동","삼성동","세곡동","수서동","신사동","압구정동"];
				var search_1 = ["해당동 선택","강일동", "고덕동", "길동", "둔촌동","명일동","상일동","성내동","암사동","천호동"];
				var search_2 = ["해당동 선택","미아동", "번동", "수유동", "우이동"];
				var search_3 = ["해당동 선택","가양동", "개화동", "공항동", "과해동","내발산동","등촌동","마곡동","방화동","염창동","오곡동","오쇠동","외발산동","화곡동"];
				var search_4 = ["해당동 선택","남현동", "봉천동", "신림동"];
				var search_5 = ["해당동 선택","광장동", "구의동", "군자동","능동","자양동","중곡동","화양동"];
				var search_6 = ["해당동 선택","가리봉동", "개봉동", "고척동","구로동","궁동","신도림동","오류동","온수동","천왕동","항동"];
				var search_7 = ["해당동 선택","가산동","독산동","시흥동"];
				var search_8 = ["해당동 선택","공릉동","상계동","월계동","중계동","하계동"];
				var search_9 = ["해당동 선택","도봉동","방학동","쌍문동","창동"];
				var search_10 = ["해당동 선택","답십리동","신설동","용두동","이문동","장안동","전뇽동","제기동","청량리동","회기동","휘경동"];
				var search_11 = ["해당동 선택","노량진동","대방동","동작동","본동","사당동","상도동","신대방동","흑석동"];
				var search_12 = ["해당동 선택","공덕동","구수동","노고산동","당인동","대흥동","도화동","동교동","마포동","망원동","상수동","상암동","서교동","성산동","신공덕동","신수동","신정동","아현동","연남동","염리동","용강동","중동","창전동","토정동","하중동","합정동","현석동"];
				var search_13 = ["해당동 선택","남가좌동","냉천동","대신동","대현동","미근동","봉원동","북가좌동","북아현동","신촌동","연희동","영천동","옥천동","창천동","천연동","충정로2가","충정로3가","합동","현저동","홍은동","홍제동"];
				var search_14 = ["해당동 선택","내곡동","반포동","방배동","서초동","신원동","양재동","염곡동","우면동","원지동","잠원동"];
				var search_15 = ["해당동 선택","금호동1가","금호동2가","금호동3가","금호동4가","도선동","마장동","사근동","상왕십리동","성수동1가","성수동2가","송정동","옥수동","용답동","응봉동","하왕십리동","행당동","홍익동"];
				var search_16 = ["해당동 선택","길음동","돈암동","동선동","동수문동","보문동","삼선동","상월곡동","석관동","성북동","안암동","장위동","정릉동","종암동","하월곡동"];
				var search_17 = ["해당동 선택","가락동","거여동","마천동","문정동","방이동","삼전동","석촌동","송파동","신천동","오금동","잠실동","장지동","풍납동"];
				var search_18 = ["해당동 선택","목동","신월동","신정동"];
				var search_19 = ["해당동 선택","당산동","대림동","도림동","문래동","신길동","양평동","양화동","여이도동","영등포동"];
				var search_20 = ["해당동 선택","갈원동","남영동","도원동","도빙고동","동자동","문배동","보광동","산천동","서계동","서빙고동","신계동","신창동","용문동","원효로","이촌동","이태원동","주성동","청암동","청파동","한강로","한남동","효창동","후암동"];
				var search_21 = ["해당동 선택","갈현동","구산동","녹번동","대조동","불광동","수색동","신사동","역촌동","응암동","증산동","진관동"];
				var search_22 = ["해당동 선택","가회동","견지동","경운동","계동","공평동","관수동","관철동","관훈동","교남동","교북동","구기동","궁정동","권농동","낙원동","내수동","내자동","누상동","누하동","당주동","도렴동","돈의동","동숭동","명륜1가","명륜2가","명륜3가","명륜4가","묘동","무악동","봉익동","부암동","사간동","사직동","삼청동","서린동","세종로","소격동","송월동","송현동","수송동","숭인동","신교동","신문로","신영동","안국동","여건동","연지동","예지동","옥인동","와룡동","운니동","원남동","원서동","이화동","익선동","인사동","인의동","장사동","재동","적선동","종로1가","종로2가","종로3가","종로4가","종로5가","종로6가","중학동","창성동","창신동","청운동","청진동","체부동","충신동","통의동","통인동","팔판동","평동","평창동","필운동","행촌동","혜화동","홍지동","홍파동","화동","효자동","효제동","훈정동"];
				var search_23 = ["해당동 선택","광희동","남대문로","남산동","남창동","남학동","다동","만리동","명동","무교동","무학동","묵정동","방산동","봉래동","북창동","산림동","삼각동","서소문동","소공동","수표동","수하동","순화동","신당동","쌍림동","예관동","예장동","오창동","을지로1가","을지로2가","을지로3가","을지로4가","을지로5가","을지로6가","을지로7가","의주로","인현동","입정동","장교동","장충동","저동","정동","주교동","주자동","중림동","초동","충무로1가","충무로2가","충무로3가","충무로4가","충무로5가","태평로","필동1가","필동2가","필동3가","황학동","회현동1가","회현동2가","회현동3가","흥인동"];
				var search_24 = ["해당동 선택","망우동","면목동","묵동","상봉동","신내동","중화동"];
				var target = document.getElementById("search_dong");
			 
				if(e.value == "search_0") var d = search_0;
				else if(e.value == "search_1") var d = search_1;
				else if(e.value == "search_2") var d = search_2;
				else if(e.value == "search_3") var d = search_3;
				else if(e.value == "search_4") var d = search_4;
				else if(e.value == "search_5") var d = search_5;
				else if(e.value == "search_6") var d = search_6;
				else if(e.value == "search_7") var d = search_7;
				else if(e.value == "search_8") var d = search_8;
				else if(e.value == "search_9") var d = search_9;
				else if(e.value == "search_10") var d = search_10;
				else if(e.value == "search_11") var d = search_11;
				else if(e.value == "search_12") var d = search_12;
				else if(e.value == "search_13") var d = search_13;
				else if(e.value == "search_14") var d = search_14;
				else if(e.value == "search_15") var d = search_15;
				else if(e.value == "search_16") var d = search_16;
				else if(e.value == "search_17") var d = search_17;
				else if(e.value == "search_18") var d = search_18;
				else if(e.value == "search_19") var d = search_19;
				else if(e.value == "search_20") var d = search_20;
				else if(e.value == "search_21") var d = search_21;
				else if(e.value == "search_22") var d = search_22;
				else if(e.value == "search_23") var d = search_23;
				else if(e.value == "search_24") var d = search_24;
				else if(e.value == "none") var d = none;

				target.options.length = 0;

				for (x in d) {
					var opt = document.createElement("option");
					opt.value = d[x];
					opt.innerHTML = d[x];
					target.appendChild(opt);
				}
			}
			</script>
			</div>
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
                            	<input type="hidden" name="curpage" id="curpage">
                                <div class="card-body row no-gutters">
                                    <div class="col">
                                    	<label for="search_name" class="sr-only">Search</label>
                                        <input class="form-control form-control-lg form-control-borderless" type="search" id="search_name"  name="search_name" placeholder="약국명을 입력하세요." style="display: inline-block;width:80%;margin-bottom:15px;margin-left:15px;" value="<%=search_name%>"> 
                                        <button class="btn btn-lg btn-success" id="btn_submit">검색</button>
                                    </div>
                                     
                                </div>
                            </form>
                        </div>
                    </div>
                  <ul class="list-group">
    <li class="list-group-item clearfix">
    	검색된 약국 수:<%=totalCount %>
    </li>
</ul>  
<%
//paging 지정 쿼리
if(totalCount > 0){
    stmt = conn.createStatement();
    
    query = "select * from seoul_pharmacy "+where;

    query += " limit "+2;//+startNum+","+viewPages;
    rs = stmt.executeQuery(query);
    
    int idx = 0;
    while(rs.next()) {
    	idx++;
%>
  <ul class="list-group" style="pading:10px;padding-top: 5px;padding-right: 10px;padding-left: 10px;">

  <table class="table-condensed" style="width:100%;">
  <tr>
  <td style="width:60%">
    <table class="table" style="width:100%;background-color:transparent;">
    	<tr>
      		<td><h3 class="list-group-item-heading">
      			<%=rs.getString("name") %>
      	  		</h3>
      		</td>
    	</tr>
    	<tr>
    		<td><%=rs.getString("phone") %></td>
    	</tr>
    	<tr>
    		<td><%=rs.getString("address") %> <button onclick="showMap()">지도보기</button></td>
    	</tr>
    </table>
    <input type="hidden" name="x_location" id="x_location" value=<%=rs.getString("x_location")%>>
    <input type="hidden" name="y_location" id="y_location" value=<%=rs.getString("y_location")%>>
    	<table class="table" style="width:100%;background-color:transparent;">
    	<tr>
    		<td style="width:120px;">가능한 외국어 :</td>
  			<td>
    <%
      	if(rs.getString("language").contains("영어")){
    %>
          	<img src="\project\images\Usa.png" style="height:45px;width:45px;" alt="영어">
    <%
    	}
    	if(rs.getString("language").contains("중국어")) {
    %>		
    		<img src="\project\images\China.png"style="height:45px;width:45px;" alt="중국어">
    <%
    	}
    	if(rs.getString("language").contains("일본어")) {
    %>
    		<img src="\project\images\Japan.png"style="height:45px;width:45px;" alt="중국어">
    <% }
    	if(rs.getString("language").contains("독일어")) {
    %>
    		<img src="\project\images\Germany.png"style="height:45px;width:45px;" alt="중국어">
    <% }
    	if(rs.getString("language").contains("프랑스어")) {
    %>
    		<img src="\project\images\France.png"style="height:45px;width:45px;" alt="중국어">
    <% }
    	if(rs.getString("language").contains("스페인어")) {
    %>
    	    <img src="\project\images\Spain.png"style="height:45px;width:45px;" alt="중국어">
    <% }
    	if(rs.getString("language").contains("러시아어")) {
    %>
    	    <img src="\project\images\Russia.png"style="height:45px;width:45px;" alt="중국어">
    <% }
    	if(rs.getString("language").contains("없음")) {
    %>
    	   	없음
    <% } %>
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
    		<td>월요일</td><td><%=rs.getString("opti_mon") %></td> <td>화요일</td> <td style="padding-right:10px"><%=rs.getString("opti_tue") %></td><td>수요일</td><td><%=rs.getString("opti_wed") %></td><td></td><td></td>
    	</tr>
    	<tr>
    		<td>목요일</td><td><%=rs.getString("opti_thu") %></td><td>금요일</td><td><%=rs.getString("opti_fri") %></td><td>토요일</td><td><%=rs.getString("opti_sat") %></td><td>일요일</td><td><%=rs.getString("opti_sun") %></td>
    	</tr>
    </table>
    
    </td>
    
    <td style="width:40%">
    <div id="map<%=idx%>" style="width:100%;height:280px"></div>
	<script>
	var mapOptions = {
   	 	zoom: 16,
    	center: new naver.maps.LatLng(<%=rs.getString("x_location") %>, <%=rs.getString("y_location") %>),
    	
    	zoomControl: true,
    	zoomControlOptions: {
        	style: naver.maps.ZoomControlStyle.SMALL,
        	position: naver.maps.Position.TOP_RIGHT
    	},
    	scaleControl: true,
    	scaleControlOptions: {
        	position: naver.maps.Position.BOTTOM_LEFT
    	}
    };
	
	var map = new naver.maps.Map(document.getElementById('map<%=idx%>'), mapOptions);
	
	var marker = new naver.maps.Marker({
	    position: new naver.maps.LatLng(<%=rs.getString("x_location") %>, <%=rs.getString("y_location") %>),
	    map: map
	});
	</script>

    </td>
    </tr>
  </table>
  
  </ul>
<%
    }
}else{
	
%>
<ul class="list-group">
    <li class="list-group-item align-items-center clearfix">
    	검색결과가 없습니다.
    </li>
</ul>
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

<%
	String add = "";
	
	String url = "#";
	
	String str = ""; 
	
	//시작숫자 start_page ~ 끝숫자 end_page
    int start_page = ( ( (int)( (curPage - 1 ) / viewPages ) ) * viewPages ) + 1;
    int end_page = start_page + viewPages - 1;

    if (end_page >= totalPage){
    	end_page = totalPage;
    }
	//처음표시
	if(curPage > 1){
		str += "<li class=\"page-item\"><a href='" + url + "' onclick='goPage(1)'  class=\"page-link\" title='처음'>처음</a></li>\n";
	}
  	//이전표시
    if (start_page > 1) 
    	str += "<li class=\"page-item\"><a href='" + url + "' onclick='goPage("+ (start_page - 1) + ")'  class=\"page-link\" title='이전'>이전</a></li>\n";
    //페이징 안의 숫자 표시	
	if (totalPage > 1) {
	    for (int k = start_page; k <= end_page; k++) {
	        if (curPage != k)
	            str += "<li class=\"page-item\"><a href='" + url + "' onclick='goPage("+ k +   ")'>" + k + "</a></li>\n";
	        else
	            str += "<li class=\"page-item active\"><a href='#' class=' tooltip-top' title='현재페이지'>" + k + "</a></li>\n";
	    }
	}
	//다음 표시
    if (totalPage > end_page){
    	str += "<li class=\"page-item\"><a href='" + url + "' onclick='goPage("+ (end_page + 1) +   ")'  class=\"page-link\" title='다음'>다음</a></li>\n";
    }
	//맨끝 표시
    if (curPage < totalPage) {
        str += "<li class=\"page-item\"><a href='" + url + "' onclick='goPage("+ totalPage +  ")'  class=\"page-link\" title='맨끝'>맨끝</a></li>\n";
    }

%>
<div class="col text-center">
<nav aria-label="Page navigation example   " >
	<ul class="pagination">
	<%= str %>
	</ul>
</nav>
</div>
</div>
  </body>
<script>
//selectChange($('#search_gu'));
$('#search_gu').trigger('change');
<%if(!search_dong.equals("")){
%>
$('#search_dong').find('option[value=<%=search_dong%>]').attr('selected','selected');
<%}
%>


</script>
</html>

