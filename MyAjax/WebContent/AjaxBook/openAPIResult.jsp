<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ajax.book.*" %>

<% 
	String keyword = request.getParameter("keyword");
	String start = request.getParameter("start");
	
	if(keyword==null){
		keyword = "Ajax";
	}
	
	BookNaverProxy bnp = new BookNaverProxy();
	String data = bnp.getDate(keyword,Integer.parseInt(start),10);
	
	out.println(data);
%>