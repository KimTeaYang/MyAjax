package ajax.rss;

import java.io.*;
import java.net.*;

public class RssProxy {
	
	/*public static void main(String[] args) throws Exception {
		
		RssProxy rp = new RssProxy();
		System.out.println(rp.getData("http://rss.kmib.co.kr/data/kmibPolRss.xml"));
		
	}*/

	public String getData(String urlStr) throws Exception {
		
		URL url = new URL(urlStr);
		InputStream is = url.openStream();
		BufferedReader br = new BufferedReader(new InputStreamReader(is,"EUC-KR"));
		
		String content = "", line="";
		int i=0;
		
		while((line=br.readLine())!=null) {
			if(i!=0) {
			content+=line+"\r\n";
			}
			i++;
		}
		
		
		
		if(br!=null) br.close();
		if(is!=null) is.close();
		
		return content;
	}
	
}