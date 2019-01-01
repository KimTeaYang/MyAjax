<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="bvo" class="ajax.book.BookVO" scope="page" />
<jsp:useBean id="bookDao" class="ajax.book.BookDAOMyBatis" scope="session" />

<%
	String title = request.getParameter("selTit");

	if(title==null){
		title = request.getParameter("books");
	}
	
	bvo = bookDao.getSearch(title);
%>
<table class="table table-striped">
	<tr>
		<td width="25%"><%=bvo.getTitle() %></td>
		<td width="20%"><%=bvo.getPublish() %></td>
		<td width="15%"><%=bvo.getPrice()%></td>
		<td width="20%"><%=bvo.getPublished()%></td>
		<td width="20%">
			<a>수정</a>|<a>삭제</a>
		</td>
	</tr>
</table>