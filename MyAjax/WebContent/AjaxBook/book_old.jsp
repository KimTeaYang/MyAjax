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
<!-- CDN ����-------------------------------------- -->
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
		
		/* form ��ü�� ã�Ƽ� serialize()�Լ��� �̿��ϸ� �� ����� �Ķ���͸� �����ͷ� ������ش� */
		var param = $('#editF').serialize();
		
		$.ajax({
			type:'post',
			url:'bookUpdate.jsp',
			dataType:'xml',
			data:param, /* post����� ��� ������ �����͸� data�Ӽ������� �ش�. */
			cache:false,
			success:function(res){
				var data = $(res);
				var n = data.find('result').text();
				if(parseInt(n)>0){
					alert('���� ����');
					getAllBook();
				}else{
					alert('���� ����');
				}
				
			},
			error:function(e){
				alert('Error: '+e.status);	
			}	
		});
	}
	
	/* ��� ���� ���� �������� */
	var getAllBook = function(){
		
		//jQuery $.ajax(��ü)�Լ��� ����Ͽ� ajax�� �����غ���.
		$.ajax({
			type:'get', //��û���
			url:'bookAll.jsp', //��û���� url
			dataType:'text', //���� ������ ����(html,xml,json,text)
			cache:false, //ĳ�� ��� ����
			success:function(res){
				//������ ���������� ���� ��� ȣ���
				$('#book_data').html(res);
			},
			error:function(e){
				//���� �߻���
				alert('Error: '+e.status);
			}
		});
	}
	
	/* ���ǻ� ��� �������� */
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
	
	/* ���ǻ翡 ���� ���� ��� */
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
			alert('�������� �����ϼ���');
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
		//$(������).serialize() �Լ��� ��� ���ڵ��� ���ְ� �̽����������� �ν� �����ϴ�.
		//encodeURIComponent(value)�� �̿��ϸ� ���ڵ� ó���� �ǰ� �̽����������ڵ� �ν� �����ϴ�.
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
<!--onload�� ���ǻ� ��� ��������  -->
<body onload="getPublish();getAllBook()">
	<div class="container">
		<h2 id="msg">���� ���� ������</h2>
		<form name="findF" id="findF" role="form" action="" method="POST">
			<div class="form-group">
				<label for="sel" class="control-label col-sm-2">���ǻ�</label> 
				<span id="sel"></span>
				<span id="sel2"></span>
			</div>
			<p>
			<div class='form-group'>
				<label for="books" class="control-label col-sm-2" id="msg1">�����˻�</label>
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
			<button type="button" onclick="getBook()" class="btn btn-primary">�˻�</button>
			<button type="button" onclick="getAllBook()" class="btn btn-success">��κ���</button>
			<button type="button" id="openBtn" class="btn btn-info">OPEN API���� �˻�</button>
			<br>
			<br>
		</div>
		<div id="localBook">

			<table class="table table-bordered" border="1">
				<tr class="info">
					<td style="width: 25%;">����</td>
					<td style="width: 20%;">���ǻ�</td>
					<td style="width: 15%;">����</td>
					<td style="width: 20%;">������</td>
					<td style="width: 20%;">����</td>
				</tr>
			</table>
			<!-- ----------------------- -->
			<div id="book_data"></div>
			<!-- ----------------------- -->
			<form id="editF" name="editF">
				<table id="book_info" class="table table-hover" border="2">
					<tr>
						<td width="20%">ISBN�ڵ�</td>
						<td><input type="text" name="isbn" id="isbn"
							class="form-control" readonly></td>
						<td rowspan="6" width="30%" id="bimage" class="text-center">
							
						</td>
					</tr>
					<tr>
						<td>����</td>
						<td><input type="text" name="title" id="title"
							class="form-control"></td>

					</tr>
					<tr>

						<td>���ǻ�</td>
						<td><input type="text" name="publish" id="publish"
							class="form-control"></td>


					</tr>
					<tr>

						<td>����</td>
						<td><input type="text" name="price" id="price"
							class="form-control"></td>

					</tr>
					<tr>

						<td>������</td>
						<td><input type="text" name="published" id="published"
							disabled class="form-control"></td>

					</tr>
					<tr>
						<td colspan="2">
							<button type="button" onclick="goEditEnd()"
								class="btn btn-danger">����</button>
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

<!-- https://apis.daum.net/search/book?apikey=53c73f32f6c4150ca5aa184ba6250d8e&q=����īī��&output=json -->




