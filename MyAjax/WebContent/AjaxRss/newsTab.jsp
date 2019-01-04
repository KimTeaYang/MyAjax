<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0
 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <title>sample2</title>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
        }
        
        #container {
            width: 500px;
            margin: 50px auto;
        }
        
        ul.tab {
            padding: 0;
        }
        
        ul.tab li {
            list-style-type: none;
            width: 100px;
            height: 40px;
            float: left;
        }
        
        ul.tab li a {
            outline: none;
            background: url("../images/tab.jpg");
            display: block;
            color: blue;
            line-height: 40px;
            text-align: center;
        }
        
        ul.tab li a.selected {
            background: url("../images/tab_selected.jpg");
            text-decoration: none;
            color: #333;
            cursor: default;
        }
        
        ul.panel {
            clear: both;
            border: 1px solid #9FB7D4;
            border-top: none;
            padding: 0;
        }
        
        ul.panel li {
            list-style-type: none;
            padding: 10px;
            text-indent: 1em;
            color: #333;
        }
    </style>
    
    <script type="text/javascript">
        $(function () {
            $('ul.panel>li').not('ul.panel>li#tab1').hide();
            
            $('ul.tab>li>a').click(function(){
            	
            	var rss="http://rss.kmib.co.kr/data/";
            	
                var $id = $(this).attr('href');
                 
                if($id=='#tab1'){
                	rss+="kmibLifRss.xml";
                }else if($id=='#tab2'){
                	rss+="kmibPolRss.xml";
                }else if($id=='#tab3'){
                	rss+="kmibEcoRss.xml";
                }else if($id=='#tab4'){
                	rss+="kmibSocRss.xml";
                }else if($id=='#tab5'){
                	rss+="kmibSpoRss.xml";
                }
                
                $('ul.tab>li>a').not($(this)).removeClass('selected');
                $(this).addClass('selected');
                
                $.ajax({
    				type:'get',
    				url:'newResult.jsp?rss='+rss,
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
    					
    					$('ul.panel>li'+$id).html(str);
    	                $('ul.panel>li').slideUp('slow');
    	                $('ul.panel>li'+$id).slideDown('slow');
    	                
    	                return false; // href로 이동하는 것을 방지하기 위해 false반환
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
    <div id="container">
        <ul class="tab">
            <li><a href="#tab1" class="selected">생활</a></li>
            <li><a href="#tab2">정치</a></li>
            <li><a href="#tab3">사회</a></li>
            <li><a href="#tab4">경제</a></li>
            <li><a href="#tab5">스포츠</a></li>
        </ul>
        <ul class="panel">
            <li id="tab1"></li>
            <li id="tab2"></li>
            <li id="tab3"></li>
            <li id="tab4"></li>
            <li id="tab5"></li>
        </ul>
    </div>
</body>

</html>