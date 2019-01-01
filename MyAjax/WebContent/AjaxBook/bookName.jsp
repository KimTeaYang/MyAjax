<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,ajax.book.BookVO,java.text.*"%>

<jsp:useBean id="bvo" class="ajax.book.BookVO" scope="page" />
<jsp:useBean id="bookDao" class="ajax.book.BookDAOMyBatis" scope="session" />

<%
	String books = request.getParameter("books");
	
	
	List<BookVO> arr = bookDao.getSearchName(books);
%>
<ul>
	<%
		if(arr!=null){
			if(arr.size()==8) return;
			for(BookVO b:arr){
	%>
				<li><a onclick="autoSet('<%=b.getTitle()%>')"><%=b.getTitle()%></a></li>
	<%
			}
		}
	%>
</ul>