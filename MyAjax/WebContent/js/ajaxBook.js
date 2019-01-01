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
	
	var findBook = function(){
		var param1 = $('#findF').serialize();
		
		$.ajax({
			type:"post",
			url:"bookSearch.jsp",
			data:param1,
			dataType:'html',
			cache:false,
			success:function(res){
				$('#book_data').html(res);
				$('#books').val('');
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