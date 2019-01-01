<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//캐시 사용 안하도록
	response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!--모바일 반응형 지원 -->
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>pizza2.jsp</title>
<!--CDN 참조  -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script>
<!-- Latest compiled JavaScript -->
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<style type="text/css">
/* body,h2{
		font-family:돋움,돋움체,verdana;
		color:navy;
	} */
</style>

<script type="text/javascript">
	var req = false; //XMLHttpRequest 객체

	function init(){
		try{
			//req 객체 초기화
			req = new XMLHttpRequest();
			//Http 요청을 수행하도록 하고, 서버로부터 응답받은 내용(xml,json,text,html)을 파싱한다.	
		}catch(e){
			try{
				//IE6이하 버전일 경우
				req = new ActiveXObject("Msxml2.XMLHTTP");
			}catch(e2){
				req=false;
			}
		}
		
		if(!req){
			alert('req객체 생성 실패');
		}else{
			console.log('req객체 생성 성공');
		}
	}
	
	function getUserInfo(){
		//1. 사용자 입력한 전화번호 받기
		var tel = $('#phone').val();
		
		//2. 서버에 전화번호를 가지고 요청을 보내자. 이 때 사용되는 객체=> XMLHttpRequest객체
		var url="result2.jsp?phone="+tel;
		var url2="result2.jsp";
		
		/* [1] open(method,url,[async]) 전송방식,보내는곳,비동기방식 여부(true:비동기,false:동기) 
		요청을 보내기 전에 준비하는 일을 한다. */
		//req.open("get",url,true);
		req.open("post",url2,true);
		req.setRequestHeader("Content-type", "application/x-www-form-urlencoded"); //post방식일 때
		
		// [2] onreadystatechange속성에 콜백함수 지정
		// 요청을 보내기 전에 반드시 아래 코드가 기술되어야 한다.
		req.onreadystatechange = updatePage;
		
		// [3] send()함수를 통해 요청을 전송
		/* send(body)
			- get방식 요청일 경우 null을 넘긴다.
			- post방식일 경우 body부분에 전송할 파라미터 문자열을 지정하여 보낸다.
		*/
		//req.send(null);
		req.send("phone="+tel);
		
	}
	
	function updatePage(){
		//alert(req.readyState+"/"+req.status);
		if(req.readyState==4 && req.status==200){
			var res = req.responseXML;
			var data = $(res);
			var num = data.find('idx').text();
			var uname = data.find('name').text();
			var uaddr = data.find('addr').text();
			
			if(parseInt(num)==0){
				//비회원
				$('#nonUser').show(1000);
				$('#userInfo').hide(1000);
				$('#userInfo').html("");
				$('#addr').focus();
			}else{
				//회원
				var str="<table class='table table-striped'>";
				
				str+="<tr>";
				str+="<td width='30%'>회원번호</td><td width='70%'>"+num+"</td>";
				str+="</tr>";
				str+="<tr>";
				str+="<td>회원이름</td><td>"+uname+"</td>";
				str+="</tr>";
				str+="<tr>";
				str+="<td>회원주소</td><td>"+uaddr+"</td>";
				str+="</tr>";
				
				str+="</table>";
				$('#userInfo').html(str);
				$('#userInfo').show(1000);
				$('#nonUser').hide(1000);
			}
		}
	}
	
	window.onload = function(){
		init();
	};
</script>

</head>
<body>
	<div class="section">
		<div class="container">
			<h1>Pizza Order Page</h1>
			<form role="form" class="form-horizontal" name="orderF" id="orderF"
				action="order.jsp" method="POST">
				<div class="form-group">
					<p class="text-info">
						<b>귀하의 전화번호를 입력하세요:</b> <input type="text" size="20" name="phone"
							id="phone" onchange="getUserInfo()" class="form-control" />
					</p>
					<p class="text-danger">
						<b> 귀하가 주문하신 피자는 아래 주소로 배달됩니다. </b>
					</p>
					<div id="userInfo"></div>
					<div id="address"></div>
					<!-- 비회원 입력 폼 : 비회원일 경우 주소입력 폼을 보여주자.-->
					<div id="nonUser" style="display: none;">
						주소: <input type="text" name="addr" id="addr" size="60"
							style="border: 2px solid maroon;" class="form-control" />
					</div>
					<!-- ------------------------------------------- -->
					<p class="text-info">
						<b>주문 내역을 아래에 기입하세요</b>
					</p>
					<p>
						<textarea name="orderList" id="orderList" rows="6" cols="50"
							class="form-control"></textarea>
					</p>
					<p>
						<input type="submit" value="Order Pizza" class="btn btn-primary" />
					</p>
				</div>
			</form>
		</div>
	</div>
</body>
</html>




