<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<title>Insert title here</title>
<script>
	/*  
		Javascript 보안(SOP)정책에 따라 데이터 를 요청하는 쪽 도메인과 
		데이터를 반환하는 쪽 도메인이 다르면 ajax를 사용할 수 없다.
	*/
	$(function(){
		$('#bt').click(function(){
			var rss = "http://rss.kmib.co.kr/data/kmibPolRss.xml";
			
			$.ajax({
				type:'get',
				url:"newResult.jsp?rss="+rss,
				dataType:'xml',
				cache:false,
				success:function(res){
					var vtitle = $(res).find('item>title');
					var vlink = $(res).find('item>link');
					
					var str = "<ul>";
					$.each(vtitle,function(i,data){
						str+="<li><a href='"+$(vlink[i]).text()+"' target='_blank'>";
						str+=$(vtitle[i]).text();
						str+="</a></li>";
					});
					str += "</ul>";
					
					$('#msg').html(str);
				},
				error:function(e){
					alert('error:'+e.status);
				}
			});
		}); 
		
	});
</script>
</head>
<body>
	<h1>RSS NEWS</h1>
	<button id="bt">오늘의 뉴스 가져오기</button>
	<hr color="red">
	<div id="msg"></div>
	
</body>
</html>