<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ajax.rss.*" %>
<%
	String rss = request.getParameter("rss");
	RssProxy rp = new RssProxy();
	String content = rp.getData(rss);
	out.println(content);
%>