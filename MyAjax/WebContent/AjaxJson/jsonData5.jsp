<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.*,ajax.book.*" %>
<%-- 
	[1] json library를 download한다.
		json library
		http://json-lib.sourceforge.net/
		http://search.maven.org/#artifactdetails%7Cnet.sf.json-lib%7Cjson-lib%7C2.4%7Cjar
		
		의존성 라이브러리 다운로드
		http://commons.apache.org/
	[2] json-lib-2.4-jdk15.jar 파일과 그 외의 다른 의존성 있는 library 5개를 WEB-INF/lib에 붙여넣는다.
	[3] import="net.sf.json.*" 해서 사용한다.
--%>
<%--
	//1. 객체 유형일 경우=> JSONObject 객체 사용한다.
	JSONObject obj = new JSONObject();
	obj.put("title","JavaScript기초");
	obj.put("isbn","99887744");
	obj.put("price",35000);
	obj.put("publish","에이콘");
	obj.put("published","2019-02-11");
	obj.put("bimage","a.jpg");
	
	JSONObject obj1 = new JSONObject();
	obj1.put("title","JavaScript기초");
	obj1.put("isbn","99887744");
	obj1.put("price",35000);
	obj1.put("publish","에이콘");
	obj1.put("published","2019-02-11");
	obj1.put("bimage","a.jpg");
	
--%>
<%-- [<%=obj.toString()%>,<%=obj1.toString()%>] --%>

<%
	//2. 배열 유형일 경우
	BookVO b1 = new BookVO("789456","책제목1","대림1",20000,null,"a.jpg");
	BookVO b2 = new BookVO("129456","책제목2","대림2",30000,null,"b.jpg");
	BookVO b3 = new BookVO("349456","책제목3","대림3",40000,null,"c.jpg");
	BookVO b4 = new BookVO("569456","책제목4","대림4",50000,null,"d.jpg");

	JSONArray arr = new JSONArray();
	arr.add(b1);arr.add(b2);arr.add(b3);arr.add(b4);
	out.println(arr.toString());
%>











