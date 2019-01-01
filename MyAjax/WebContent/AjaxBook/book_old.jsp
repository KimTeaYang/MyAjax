<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%
	response.setHeader("Pragma", "No-cache"); //HTTP 1.0 
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>BOOK</title>
<!-- CDN 참조-------------------------------------- -->
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- ------------------------------------------------- -->
<style type="text/css">
	.listbox{
		position: absolute;
		left:10px;
		margin:0px;
		width:510px;
		background:#efefef;
		color:blue;
		border:1px solid #cfcfcf;
	}
	.blist{
		maring:0px;
		padding:2px;
		
	}
	.blist ul li{
		list-style:none;
	}
</style>


<script type="text/javascript">
	
	var goDel = function(visbn){
		$.ajax({
			type:'get',
			url:'bookDel.jsp?isbn='+visbn,
			dataType:'text',
			cache:false,
			success:function(res){
				
				var data = res.split('|');
				if(parseInt(data[0])>0){
					getAllBook();	
				}
			},
			error:function(e){
				alert('Error: '+e.status);
			}
		});
	}
	
	var goEdit = function(visbn){
		$.ajax({
			type:'get',
			url:'bookIsbn.jsp?isbn='+visbn,
			dataType:'xml',
			cache:false,
			success:function(res){
				var data = $(res);
				var misbn = data.find('isbn').text();
				var mtitle = data.find('title').text();
				var mpublish = data.find('publish').text();
				var mprice = data.find('price').text();
				var mpubdate = data.find('pubdate').text();
				var mbimage = data.find('bimage').text();
				
				$('#isbn').val(misbn);
				$('#title').val(mtitle);
				$('#publish').val(mpublish);
				$('#price').val(mprice);
				$('#published').val(mpubdate);
				$('#bimage').html("<img class='img img-responsive img-thumbnail' src=../images/"+mbimage+">");
			},
			error:function(e){
				alert('Error: '+e.status);
			}
		});
	}
	
	var goEditEnd = function(){
		
		/* form 객체를 찾아서 serialize()함수를 이용하면 폼 요소의 파라미터를 데이터로 만들어준다 */
		var param = $('#editF').serialize();
		
		$.ajax({
			type:'post',
			url:'bookUpdate.jsp',
			dataType:'xml',
			data:param, /* post방식일 경우 전송할 데이터를 data속성값으로 준다. */
			cache:false,
			success:function(res){
				var data = $(res);
				var n = data.find('result').text();
				if(parseInt(n)>0){
					alert('수정 성공');
					getAllBook();
				}else{
					alert('수정 실패');
				}
				
			},
			error:function(e){
				alert('Error: '+e.status);	
			}	
		});
	}
	
	/* 모든 도서 정보 가져오기 */
	var getAllBook = function(){
		
		//jQuery $.ajax(객체)함수를 사용하여 ajax를 구현해보자.
		$.ajax({
			type:'get', //요청방식
			url:'bookAll.jsp', //요청보낼 url
			dataType:'text', //응답 데이터 유형(html,xml,json,text)
			cache:false, //캐시 사용 안함
			success:function(res){
				//응답이 성공적으로 왔을 경우 호출됨
				$('#book_data').html(res);
			},
			error:function(e){
				//에러 발생시
				alert('Error: '+e.status);
			}
		});
	}
	
	/* 출판사 목록 가져오기 */
	var getPublish = function(){
		$.ajax({
			type:'get',
			url:'bookPublish.jsp',
			dataType:'html',
			cache:false,
			success:function(res){
				$('#sel').html(res);
			},
			error:function(e){
				alert('Error: '+e.status);
			}
		});
	}
	
	/* 출판사에 따른 도서 목록 */
	var infoByPub = function(pub){
		
		var param = "publish="+pub;
		
		$.ajax({
			type:"post",
			url:"bookTitle.jsp",
			data:param,
			dataType:'html',
			cache:false,
			success:function(res){
				$('#sel2').html(res);
			},
			error:function(e){
				alert('Error: '+e.status);
			}
		});
	}
	
	var findBook = function(vtitle){
		var param1 = $('#findF').serialize();
		
		if(!vtitle){
			alert('도서명을 선택하세요');
			return;
		}
		
		$.ajax({
			type:"post",
			url:"bookSearch.jsp",
			data:param1,
			dataType:'html',
			cache:false,
			success:function(res){
				$('#book_data').html(res);
			},
			error:function(e){
				alert('Error: '+e.status);
			}
		});
	}
	
	var getBook = function(){
		var val = $('#books').val();
		findBook(val);
		$('#lst1').hide();
		$('#lst2').hide();
	}
	
	var autoComp = function(value){
		//$(선택자).serialize() 함수의 경우 인코딩을 해주고 이스케이프문자 인식 가능하다.
		//encodeURIComponent(value)를 이용하면 인코딩 처리가 되고 이스케이프문자도 인식 가능하다.
		var param = "books="+encodeURIComponent(value);
		
		$.ajax({
			type:"post",
			url:"bookName.jsp",
			data:param,
			dataType:'html',
			cache:false,
			success:function(res){
				$('#lst1').show();
				$('#lst2').show();
				$('#lst2').html(res);
			},
			error:function(e){
				alert('Error: '+e.status);
			}
		});
	}
	
	var autoSet = function(vtitle){
		$('#books').val(vtitle);
		$('#lst1').hide();
		$('#lst2').hide();
	}
	
	
	
	$(function(){
		/* $('#books').blur(function(){
			$('#lst1').hide();
			$('#lst2').hide();
		}); */
	});
	
</script>
</head>
<!--onload시 출판사 목록 가져오기  -->
<body onload="getPublish();getAllBook()">
	<div class="container">
		<h2 id="msg">서적 정보 페이지</h2>
		<form name="findF" id="findF" role="form" action="" method="POST">
			<div class="form-group">
				<label for="sel" class="control-label col-sm-2">출판사</label> 
				<span id="sel"></span>
				<span id="sel2"></span>
			</div>
			<p>
			<div class='form-group'>
				<label for="books" class="control-label col-sm-2" id="msg1">도서검색</label>
				<div class="col-sm-6">
					<input type="text" name="books" id="books"
						onkeyup="autoComp(this.value)" class="form-control">
					<!-- ---------------------------- -->
					<div id="lst1" class="listbox" style="display: none">
						<div id="lst2" class="blist" style="display: none">
					
						</div>
					</div>
					<!-- ---------------------------- -->
				</div>
			</div>
		</form>
		<div>
			<button type="button" onclick="getBook()" class="btn btn-primary">검색</button>
			<button type="button" onclick="getAllBook()" class="btn btn-success">모두보기</button>
			<button type="button" id="openBtn" class="btn btn-info">OPEN API에서 검색</button>
			<br>
			<br>
		</div>
		<div id="localBook">

			<table class="table table-bordered" border="1">
				<tr class="info">
					<td style="width: 25%;">서명</td>
					<td style="width: 20%;">출판사</td>
					<td style="width: 15%;">가격</td>
					<td style="width: 20%;">출판일</td>
					<td style="width: 20%;">편집</td>
				</tr>
			</table>
			<!-- ----------------------- -->
			<div id="book_data"></div>
			<!-- ----------------------- -->
			<form id="editF" name="editF">
				<table id="book_info" class="table table-hover" border="2">
					<tr>
						<td width="20%">ISBN코드</td>
						<td><input type="text" name="isbn" id="isbn"
							class="form-control" readonly></td>
						<td rowspan="6" width="30%" id="bimage" class="text-center">
							
						</td>
					</tr>
					<tr>
						<td>서명</td>
						<td><input type="text" name="title" id="title"
							class="form-control"></td>

					</tr>
					<tr>

						<td>출판사</td>
						<td><input type="text" name="publish" id="publish"
							class="form-control"></td>


					</tr>
					<tr>

						<td>가격</td>
						<td><input type="text" name="price" id="price"
							class="form-control"></td>

					</tr>
					<tr>

						<td>출판일</td>
						<td><input type="text" name="published" id="published"
							disabled class="form-control"></td>

					</tr>
					<tr>
						<td colspan="2">
							<button type="button" onclick="goEditEnd()"
								class="btn btn-danger">갱신</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- #localBook end -->

	<!-- ------------------------------- -->
	<div id="openApiBook"></div>

</body>
</html>

<!-- https://apis.daum.net/search/book -->
<!-- 53c73f32f6c4150ca5aa184ba6250d8e -->

<!-- https://apis.daum.net/search/book?apikey=53c73f32f6c4150ca5aa184ba6250d8e&q=다음카카오&output=json -->




