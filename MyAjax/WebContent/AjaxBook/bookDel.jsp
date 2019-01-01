<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.*,java.text.*"%>

<jsp:useBean id="dao" class="ajax.book.BookDAOMyBatis" scope="session" />

<%
	String isbn = request.getParameter("isbn");
	int n = dao.deleteBook(isbn);
%>

<%=n%>|