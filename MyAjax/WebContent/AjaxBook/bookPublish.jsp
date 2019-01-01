<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
    
<jsp:useBean id="bookDao" class="ajax.book.BookDAOMyBatis" scope="session" />

<%
	List<String> arr = bookDao.getPublishList();
%>
<select id="selPub" name="selPub" onchange="infoByPub(this.value)">
	<option>::출판사 목록::</option>
	<%
		if(arr!=null){
			for(String pub:arr){
				%>
					<option value="<%=pub%>"><%=pub%></option>
				<%
			}
		}
	%>
</select>