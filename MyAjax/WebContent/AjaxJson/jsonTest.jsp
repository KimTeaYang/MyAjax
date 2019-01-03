<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jsonTest.jsp</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    
    <script>
    	$(function(){
    		$('#bt1').click(function(){
    			var url = 'jsonData1.jsp';
    			$.ajax({
    				type:'get',
    				url:url,
    				dataType:'json',
    				cache:false,
    				success:function(res){
    					showData(res);
    				},
    				error:function(e){
    					alert('error:'+e.status);
    				}
    			});
    		});
    		
    		$('#bt2').click(function(){
    			var url = 'jsonData2.jsp';
    			$.ajax({
    				type:'get',
    				url:url,
    				dataType:'json',
    				cache:false,
    				success:function(res){
    					showDataArr(res);
    				},
    				error:function(e){
    					alert('error:'+e.status);
    				}
    			});
    		});
    		
    		$('#bt3').click(function(){
    			$.ajax({
    				type:'get',
    				url:'jsonData3.jsp',
    				dataType:'json',
    				cache:false,
    				success:function(res){
    					alert(JSON.stringify(res));
    					showDataArr(res.books);	
    				},
    				error:function(e){
    					alert('error:'+e.status);
    				}
    			});
    		});
    		
    		$('#bt4').click(function(){
    			$.ajax({
    				type:'get',
    				url:'jsonData4.jsp',
    				dataType:'json',
    				cache:false,
    				success:function(res){
    					showDataArr(res);
    				},
    				error:function(e){
    					alert('error:'+e.status);
    				}
    			});
    		});
    		
    		$('#bt5').click(function(){
    			$.ajax({
    				type:'get',
    				url:'jsonData5.jsp',
    				dataType:'json',
    				cache:false,
    				success:function(res){
    					showDataArr(res);
    				},
    				error:function(e){
    					alert('error:'+e.status);
    				}
    			});
    		});
    		
    		$('#bt6').click(function(){
    			$.ajax({
    				type:'get',
    				url:'jsonData6.jsp',
    				dataType:'json',
    				cache:false,
    				success:function(res){
    					showDataArr3(res);
    				},
    				error:function(e){
    					alert('error:'+e.status);
    				}
    			});
    		});
    		
    	});
    	
    	var showDataArr = function(arr){
    		var str1="<table class='table table-striped mt-3'>";
			str1+="<tr><th>isbn</th><th>도서명</th><th>가격</th><th>출판사</th><th>출판일</th><th>사진</th></tr>";
    		$.each(arr,function(i,obj){
    			str1+="<tr>";
        		str1+="<td>"+obj.isbn+"</td>";
        		str1+="<td>"+obj.title+"</td>";
        		str1+="<td>"+obj.price+"</td>";
        		str1+="<td>"+obj.publish+"</td>";
        		str1+="<td>"+obj.published+"</td>";
        		str1+="<td><img style='height:50px;' src='../images/"+obj.bimage+"'></td>";
        		str1+="</tr>"
    		});
    		str1+="</table>";
    		
    		$('#msg').html(str1);
    	}
    	
    	var showDataArr3 = function(arr){
    		var str1="<table class='table table-striped mt-3'>";
			str1+="<tr><th>isbn</th><th>도서명</th><th>가격</th><th>출판사</th><th>출판일</th><th>사진</th></tr>";
    		$.each(arr,function(i,obj){
    			str1+="<tr>";
        		str1+="<td>"+obj.isbn+"</td>";
        		str1+="<td>"+obj.title+"</td>";
        		str1+="<td>"+obj.price+"</td>";
        		str1+="<td>"+obj.publish+"</td>";
        		var time = obj.published.time;
        		var date = new Date(time);
        		var day = date.getFullYear()+"-"+(date.getMonth()+1)+"-"+date.getDate();
        		str1+="<td>"+day+"</td>";
        		str1+="<td><img style='height:50px;' src='../images/"+obj.bimage+"'></td>";
        		str1+="</tr>"
    		});
    		str1+="</table>";
    		
    		$('#msg').html(str1);
    	}
    	
    	var showData = function(obj){
    		var str="<table class='table table-striped mt-3'>";
    		str+="<tr><th>번호</th><td>"+obj.isbn+"</td></tr>";
    		str+="<tr><th>도서명</th><td>"+obj.title+"</td></tr>";
    		str+="<tr><th>가격</th><td>"+obj.price+"</td></tr>";
    		str+="<tr><th>출판사</th><td>"+obj.publish+"</td></tr>";
    		str+="<tr><th>출판일</th><td>"+obj.published+"</td></tr>";
    		str+="<tr><th>사진</th><td><img src='../images/"+obj.bimage+"'></td></tr>";
    		str+="</table>";
    		$('#msg').html(str);
    	}
    </script>
    
</head>
<body>
	<div class="container">
		<h1>JSON형태로 데이터를 받아봅시다.</h1>
		<h2>JSON이란? JavaScript Object Notation</h2>
		<h3>JS에서 사용하는 개체 형태로 데이터를 표현하는 방식</h3>
		<h3>JSON객체에는 문자열,배열,숫자,boolean,null만 들어갈 수 있다.</h3>
		<hr>
		
		<button id="bt1">JSON형태로 받기1</button>
		<button id="bt2">JSON형태로 받기2</button>
		<button id="bt3">JSON형태로 받기3</button>
		<button id="bt4">JSON형태로 받기4-DB에서 가져오기</button>
		<button id="bt5">JSON형태로 받기5-library 사용하기</button>
		<button id="bt6">JSON형태로 받기6-library 사용하기</button>
		<hr>
		
		<div id="msg">
		</div>
	</div>
</body>
</html>