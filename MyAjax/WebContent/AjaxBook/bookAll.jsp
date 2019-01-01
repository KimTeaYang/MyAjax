<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="ajax.book.*,java.util.*,java.text.*"%>

<% 
	BookDAOMyBatis dao = new BookDAOMyBatis();
	List<BookVO> arr = dao.getAllBooks();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("###,###");
%>
	<table class="table table-striped">
<%
	if(arr==null||arr.size()==0){
%>
		<tr><th colspan="5">데이터가 없습니다.</th></tr>
<%
	}else{
		for(BookVO b:arr){
%>
			<tr>
				<td width="25%"><%=b.getTitle() %></td>
				<td width="20%"><%=b.getPublish() %></td>
				<td width="15%"><%=df.format(b.getPrice())+"원"%></td>
				<td width="20%"><%=sdf.format(b.getPublished()) %></td>
				<td width="20%">
					<a href="#book_info" onclick="goEdit('<%=b.getIsbn()%>')">수정</a>|<a href="#book_data" onclick="goDel('<%=b.getIsbn()%>')">삭제</a>
				</td>
			</tr>
<%
		}
	}
%>
	</table>