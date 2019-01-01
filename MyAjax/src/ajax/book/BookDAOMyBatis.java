package ajax.book;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class BookDAOMyBatis {
	
	private SqlSession ses;
	private SqlSessionFactory fac;
	private final String NS = "ajax.book.BookMapper";
	
	public BookDAOMyBatis() {
		String resource = "config/config.xml";
		try {
			InputStream is = Resources.getResourceAsStream(resource);
			
			fac = new SqlSessionFactoryBuilder().build(is);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/** ��� ���� ���� �������� */
	public List<BookVO> getAllBooks(){
		
		try {
			ses = fac.openSession();
			
			List<BookVO> arr = ses.selectList(NS+".allBooks");
			
			return arr;
		} finally {
			if(ses!=null) ses.close();
		}
	}
	
	/** �Ѱ��� ���� ���� �������� */
	public BookVO getBook(String isbn){
		
		try {
			ses = fac.openSession();
			
			BookVO bookVO = ses.selectOne(NS+".selectBook",isbn);
			
			return bookVO;
		} finally {
			if(ses!=null) ses.close();
		}
	}
	
	public int updateBook(BookVO bvo) {
		try {
			ses = fac.openSession(true);
			
			int n = ses.update(NS+".updateBook", bvo);
					
			return n;
		} finally {
			if(ses!=null) ses.close();
		}
	}
	
	/** �������� �����ϱ� */
	public int deleteBook(String isbn) {
		try {
			ses = fac.openSession(); // �Ű������� true���ָ� auto commit
			
			int n = ses.delete(NS+".deleteBook", isbn);
			
			if(n>0) {
				ses.commit();
			}else {
				ses.rollback();
			}
			
			return n;
			
		} finally {
			if(ses!=null) ses.close();
		}
	}
	
	/**  */
	public List<String> getPublishList() {
		try {
			ses = fac.openSession(); // �Ű������� true���ָ� auto commit
			
			List<String> arr = ses.selectList(NS+".pubList");
			
			return arr;
			
		} finally {
			if(ses!=null) ses.close();
		}
	}
	
	/**  */
	public List<String> getTitleList(String publish) {
		try {
			ses = fac.openSession(); // �Ű������� true���ָ� auto commit
			
			List<String> arr = ses.selectList(NS+".titList",publish);
			
			return arr;
			
		} finally {
			if(ses!=null) ses.close();
		}
	}
	
	/**  */
	public BookVO getSearch(String title) {
		try {
			ses = fac.openSession(); // �Ű������� true���ָ� auto commit
			
			Map<String,Object> val = new HashMap<>();
			
			val.put("title", title);
			
			BookVO bvo = ses.selectOne(NS+".search", val);
			
			
			return bvo;
			
		} finally {
			if(ses!=null) ses.close();
		}
	}
	
	public List<BookVO> getSearchName(String books) {
		try {
			if(books==null) books="";
			ses = fac.openSession();
			
			List<BookVO> arr = ses.selectList(NS+".searchName", books.toUpperCase());
			
			return arr;
			
		} finally {
			if(ses!=null) ses.close();
		}
	}
}