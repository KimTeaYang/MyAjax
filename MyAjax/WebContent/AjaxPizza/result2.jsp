<%@ page language="java" contentType="text/xml; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*,javax.naming.*,javax.sql.*"%>

<%
	//contentType을 text/xml로 지정해야 함에 유의하자.
	//캐시 사용 안하도록
	response.setHeader("Cache-Control", "no-cache");

	String phone = request.getParameter("phone");
	Context ctx = new InitialContext();
	DataSource ds = (DataSource)ctx.lookup("java:comp/env/oracle/myshop");
	
	
	Connection con = ds.getConnection();
	String sql = "SELECT * FROM PIZZA_USER WHERE PHONE=?";
	
	
	PreparedStatement ps = con.prepareStatement(sql);
	ps.setString(1, phone);
	ResultSet rs = ps.executeQuery();
	
	
	int idx = 0;
	String name="",addr="";
	
	
	while(rs.next()){
		idx = rs.getInt("idx");
		name = rs.getString("name");
		addr = rs.getString("addr");
	}
	rs.close();
	ps.close();
	con.close();
%>

<member>
	<idx><%=idx%></idx>
	<name><%=name %></name>
	<phone><%=phone %></phone>
	<addr><%=addr %></addr>
</member>









