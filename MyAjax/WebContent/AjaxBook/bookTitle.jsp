<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>

<jsp:useBean id="bookDao" class="ajax.book.BookDAOMyBatis" scope="session" />

<%
	String publish = request.getParameter("publish");
	List<String> arr = bookDao.getTitleList(publish);
%>
<select id="selTit" name="selTit" onchange="findBook(this.value)">
	<option>::도서 목록::</option>
	<%
		if(arr!=null){
			for(String tit:arr){
				%>
					<option value="<%=tit%>"><%=tit%></option>
				<%
			}
		}
	%>
</select>