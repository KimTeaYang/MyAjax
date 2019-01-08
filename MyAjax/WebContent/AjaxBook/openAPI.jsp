<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ajax.book.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- CDN 참조-------------------------------------- -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- ------------------------------------------------- -->
	<script>
		$(function(){
			$('#openBtn').click(function(){
				var keyword = $('#books').val();
				if(!keyword){
					alert('검색어를 입력하세요');
					$('#books').focus();
					return false;
				}
				send(keyword,1,'a1');
			});
		});
		
		function send(keyword,start,aid){
			$.ajax({
				type:'get',
				url:'openAPIResult.jsp?keyword='+encodeURIComponent(keyword)+"&start="+start,
				dataType:'json',
				cache:false,
				success:function(res){
					var total = res.total;
					var pageSize = res.display;
					showData(res.items);
					showPage(total,pageSize,keyword,aid);
					$('#'+aid).addClass('active');
				},
				error:function(e){
					alert('error:'+e.status);
				}
			});
		}
		
		var showData = function(items){
    		var str="<table class='table table-striped mt-3'>";
    		$.each(items, function(i,book){
				//console.log(book.title);
				str+="<td width='20%'>";	
				str+="<a href='"+book.link+"' target='_blank'>";
				str+="<img src='"+book.image+"' class='img img-thumbnail'>";
				str+="</a><br>"
				str+=book.title+"<br>";
				str+=book.author+"<br>";
				if(!book.discount){
					str+="<p>정가: "+book.price+"</p>";
				}else{
					str+="<p>정가: <del>"+book.price+"</del></p>";
					str+="<p>판매가: "+book.discount+"</p>";
				}
				str+="</td>";
				if(i%5==4){
					str+="</tr><tr>";//줄바꿈. (5개단위로 보여주기 위해)
				}
			});
    		$('#result').html(str);
    	}
		
		var showPage = function(total,pageSize,keyword,aid){
			//최대 200개의 검색 결과만 보여주자.
			if(total>200){
				total=200; //max 200개만 보여주자
			}
			
			//var pageCount = ((total-1)/pageSize)+1;
			var pageCount = Math.floor((total-1)/pageSize+1);
			var start = 1;
			
			var str="<ul class='pagination'>";
			for(var i=1;i<=pageCount;i++){
				start = pageSize*(i-1)+1;
				str+="<li id='a"+i+"' class='page-item'><a class='page-link' href=javascript:send('"+keyword+"','"+start+"','a"+i+"')>"+i+"</a></li>";
			}
			str+="</ul>";
			$('#paging').html(str);
		}
		
		
	</script>
</head>
<body>
	<div class="container">
		<h1>Naver Open API Books</h1>
		<div class="col-md-1 col-md-offset-1">
			<label>도서검색</label>
		</div>
		<div class="col-md-8">
			<input type="text" name="books" id="books" class="form-control">
		</div>
		<div>
			<button id="openBtn" class="btn btn-primary">검색</button>
		</div>
		
		<div id="openBook">
			<div id="result"></div>
			<div id="paging"></div>
		</div>
	</div>

</body>
</html>