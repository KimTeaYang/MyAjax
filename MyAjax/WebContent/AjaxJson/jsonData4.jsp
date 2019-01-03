<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ajax.book.*,java.util.*,java.text.*" %>
<% 
	BookDAOMyBatis dao = new BookDAOMyBatis();
	List<BookVO> arr = dao.getAllBooks();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("###,###");
	int cnt = 0;
%>
[
	<%
		for(BookVO bvo:arr){
			cnt++;
	%>
			{
				"isbn":"<%=bvo.getIsbn()%>",
				"title":"<%=bvo.getTitle()%>",
				"price":"<%=df.format(bvo.getPrice())%>",
				"publish":"<%=bvo.getPublish()%>",
				"published":"<%=sdf.format(bvo.getPublished())%>",
				"bimage":"<%=bvo.getBimage()%>"
			}
		<%
			if(cnt<arr.size()){
		%>
				,
		<%
			}
		}
		%>
		
]