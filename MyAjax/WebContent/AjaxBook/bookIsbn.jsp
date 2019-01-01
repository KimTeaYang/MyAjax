<%@ page import="ajax.book.*,java.util.*,java.text.*"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="dao" class="ajax.book.BookDAOMyBatis" />
<%
	//contextType을 xml/html로 설정해야 함에 유의하자.(응답유형이 xml이므로)
	String isbn=request.getParameter("isbn");
	BookVO b = dao.getBook(isbn);
	request.setAttribute("b", b);
%>

<book>
	<isbn>${b.isbn}</isbn>
	<title>${b.title}</title>
	<publish>${b.publish}</publish>
	<price>${b.price}</price>
	<pubdate>${b.published}</pubdate>
	<bimage>${b.bimage}</bimage>
</book>


<%-- 
<%
	String isbn = request.getParameter("isbn");

	BookDAOMyBatis dao = new BookDAOMyBatis();
	BookVO bookVO = dao.getBook(isbn);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	DecimalFormat df = new DecimalFormat("###,###");
	
%>

<%=bookVO.getIsbn()%>|<%=bookVO.getBimage()%>|<%=bookVO.getTitle()%>|<%=bookVO.getPublish()%>|<%=df.format(bookVO.getPrice())%>|<%=sdf.format(bookVO.getPublished())%> 
--%>