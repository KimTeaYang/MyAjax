<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="book" class="ajax.book.BookVO" />
<jsp:setProperty property="*" name="book"/>
<jsp:useBean id="bookDao" class="ajax.book.BookDAOMyBatis" scope="session" />

<%
	int n = bookDao.updateBook(book);
%>

<result><%=n%></result>