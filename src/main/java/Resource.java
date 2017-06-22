import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class Resource extends HttpServlet {	
	private static final long serialVersionUID = 5212590796318890570L;
	private static Logger logger = Logger.getLogger(Resource.class);
	
	@Override
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException{		
		int goodat = Integer.parseInt(request.getParameter("goodat"));
		String[] urls = {"http://freegeoip.net/json/?callback=?", "https://ipinfo.io/?callback=?", "http://geoip.nekudo.com/api/?callback="};
				
		PrintWriter out = response.getWriter();
			
		JSONArray array = new JSONArray();
		JSONObject data = new JSONObject();
		try {
			for (int i=0; i<urls.length; i++) {
				if (i != goodat) {
					array.put(urls[i].replaceAll("https|http", "malformed"));
				}
				else {
					array.put(urls[i]);
				}
			}
			data.put("result", array);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		out.println(data.toString());
	}

}

