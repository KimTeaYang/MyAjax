<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="net.sf.json.*,ajax.book.*,java.util.*" %>

<% 
	BookDAOMyBatis dao = new BookDAOMyBatis();
	List<BookVO> arr = dao.getAllBooks();
	
	//배열일 경우
	JSONArray jarr = JSONArray.fromObject(arr);
	
	//객체 1개일 경우
	JSONObject jobj = JSONObject.fromObject(arr.get(0));
	
	out.println(jarr.toString());
%>