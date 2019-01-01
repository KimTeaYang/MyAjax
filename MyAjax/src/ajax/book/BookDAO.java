package ajax.book;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class BookDAO {
	DataSource ds;
	Connection con;
	PreparedStatement ps;
	ResultSet rs;
	
	public BookDAO() throws Exception{
		Context ctx=new InitialContext();
		ds=(DataSource)ctx.lookup("java:comp/env/oracle/myshop");
	}
	
	public List<BookVO> getPublishList() throws SQLException{
		try{
			con=ds.getConnection();
	String sql="select distinct publish from book order by publish asc";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			List<BookVO> arr=new ArrayList<BookVO>();
			while(rs.next()){
				String publish=rs.getString("publish");
				BookVO b=new BookVO();
				b.setPublish(publish);
				arr.add(b);
			}//while----
			return arr;
		}finally{
			close();
		}
	}//-------------------------------------------------
	
	public List<BookVO> getTitleList(String pub) throws SQLException{
		try{
			con=ds.getConnection();
	String sql="select title from book where publish=? order by title";
			ps=con.prepareStatement(sql);
			ps.setString(1,pub);
			rs=ps.executeQuery();
			List<BookVO> arr=new ArrayList<BookVO>();
			while(rs.next()){
				String title=rs.getString("title");
				BookVO b=new BookVO(); 
				b.setTitle(title);
				arr.add(b);
			}//while----
			return arr;
		}finally{
			close();
		}
	}//-------------------------------------------------
	
	public List<BookVO> getFindBook(String title) throws SQLException{
		try{
			con=ds.getConnection();
			String sql="select * from book where title like upper(?)";
			ps=con.prepareStatement(sql);			
			ps.setString(1,"%"+title+"%");
			rs=ps.executeQuery();
			List<BookVO> arr=new ArrayList<BookVO>();
			while(rs.next()){
				String isbn=rs.getString("isbn");
				String title2=rs.getString("title");
				String publish=rs.getString("publish");
				int price=rs.getInt("price");
				java.sql.Timestamp pubDate
						=rs.getTimestamp("published");
				String bimage=rs.getString("bimage");
				BookVO book
				=new BookVO(isbn,title2,publish,price,pubDate,bimage);
				arr.add(book);
			}
			return arr;
			
		}finally{
			close();
		}
	}//--------------------------------------
	
	public BookVO getBookInfo(String isbn) throws SQLException{
		try{
			con=ds.getConnection();
		String sql="select * from book where isbn=?";
			ps=con.prepareStatement(sql);
			ps.setString(1, isbn);
			rs=ps.executeQuery();
			List<BookVO> arr=new ArrayList<BookVO>();
			while(rs.next()){
				String isbn2=rs.getString("isbn");
				String title=rs.getString("title");
				String publish=rs.getString("publish");
				int price=rs.getInt("price");
				java.sql.Timestamp pubDate
						=rs.getTimestamp("published");
				String bimage=rs.getString("bimage");
				BookVO book
				=new BookVO(isbn2,title,publish,price,pubDate,bimage);
				arr.add(book);
			}
			if(arr!=null && arr.size()==1){
				BookVO book=arr.get(0);
				return book;
			}
			return null;
			
		}finally{
			close();
		}
	} //---------------------------------------
	
	public List<BookVO> getAllBook() throws SQLException{
		try{
			con=ds.getConnection();
			String sql="select * from book order by isbn asc";
			ps=con.prepareStatement(sql);
			rs=ps.executeQuery();
			List<BookVO> arr=new ArrayList<BookVO>();
			while(rs.next()){
				String isbn=rs.getString("isbn");
				String title=rs.getString("title");
				String publish=rs.getString("publish");
				int price=rs.getInt("price");
				java.sql.Timestamp pubDate
						=rs.getTimestamp("published");
				String bimage=rs.getString("bimage");
				BookVO book
				=new BookVO(isbn,title,publish,price,pubDate,bimage);
				arr.add(book);
			}
			return arr;
		}finally{
			close();
		}
	}//------------------------------------
	
	public int updateBook(BookVO b) throws SQLException{
		try{
			con=ds.getConnection();
		String sql
		="update book set title=?, publish=?, price=? where isbn=?";
		ps=con.prepareStatement(sql);
		ps.setString(1, b.getTitle());
		ps.setString(2, b.getPublish());
		ps.setInt(3, b.getPrice());
		ps.setString(4,b.getIsbn());
		System.out.println("isbn="+b.getIsbn());
		int n=ps.executeUpdate();
		return n;
		}finally{
			close();
		}
	}//------------------------------------
	
	private void close() {
		try {
			if(rs!=null) rs.close();
			if(ps!=null) ps.close();
			if(con!=null) con.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

}//////////////////////////










