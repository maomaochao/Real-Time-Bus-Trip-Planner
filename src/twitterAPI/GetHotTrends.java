package twitterAPI;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;

import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonException;
import javax.json.JsonObject;
import javax.json.JsonReader;

import org.scribe.builder.ServiceBuilder;
import org.scribe.builder.api.TwitterApi;
import org.scribe.model.OAuthRequest;
import org.scribe.model.Response;
import org.scribe.model.Token;
import org.scribe.model.Verb;
import org.scribe.oauth.OAuthService;

import auth.TwitterAuth;

public class GetHotTrends {
		private static final String link = "https://api.twitter.com/1.1/trends/place.json?id=";
		
		public static ArrayList<String> getPopTrends (String id) {
			ArrayList<String> result = new ArrayList<String>();
			
			OAuthService service = new ServiceBuilder()
		    .provider(TwitterApi.Authenticate.class)
		    .apiKey(TwitterAuth.API_KEY)
		    .apiSecret(TwitterAuth.API_SECRET)
		    .build();
			//String tweet = URLEncoder.encode(words, "UTF-8");
			Token accessToken = new Token(TwitterAuth.ACCESS_TOKEN, TwitterAuth.ACCESS_SECRET);

			// Now let's go and ask for a protected resource!
			System.out.println(id);
			OAuthRequest request = new OAuthRequest(Verb.GET, link + id);
			
			//request.addQuerystringParameter("q", "%23Pittsburgh");
			//request.addQuerystringParameter("count", "300");
//			request.addQuerystringParameter("lang", "en");
			service.signRequest(accessToken, request);
			Response response = request.send();
			//System.out.println(response.getCode());
			//System.out.println(response.getBody());
			String str = response.getBody();
			
			try {
				parseJson(str, result);
			} catch (JsonException e) {
				System.out.println("inside catch");

				result.clear();
				accessToken = new Token(TwitterAuth.ACCESS_TOKEN, TwitterAuth.ACCESS_SECRET);

				request = new OAuthRequest(Verb.GET, link + 2473224);
				
				//request.addQuerystringParameter("q", "%23Pittsburgh");
				//request.addQuerystringParameter("count", "300");
//				request.addQuerystringParameter("lang", "en");
				service.signRequest(accessToken, request);
				response = request.send();
				//System.out.println(response.getCode());
				//System.out.println(response.getBody());
				str = response.getBody();
				try {
					parseJson(str, result);
				} catch (JsonException e2) {
					result.clear();
					return result;
				}
			} 
//			try (InputStream is = new ByteArrayInputStream(str.getBytes("UTF-8")); JsonReader rdr = Json.createReader(is)) {
//				JsonArray results = rdr.readArray();
//				JsonObject obj = results.getJsonObject(0);
//				JsonArray res2 = obj.getJsonArray("trends");
//				int i = 0;
//				for (JsonObject jObj : res2.getValuesAs(JsonObject.class)) {
//					i++;
//					result.add(sanitize(jObj.getString("name")));
//					//System.out.println(jObj.getString("name"));
//					if (i == 10) {
//						break;
//					}
//				}
//			} catch (UnsupportedEncodingException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} catch (JsonException e) {
//				
//			}
			
			
			return result;
		}
		
		private static void parseJson (String str, ArrayList<String> result) {
			try (InputStream is = new ByteArrayInputStream(str.getBytes("UTF-8")); JsonReader rdr = Json.createReader(is)) {
				JsonArray results = rdr.readArray();
				JsonObject obj = results.getJsonObject(0);
				JsonArray res2 = obj.getJsonArray("trends");
				int i = 0;
				for (JsonObject jObj : res2.getValuesAs(JsonObject.class)) {
					i++;
					result.add(sanitize(jObj.getString("name")));
					//System.out.println(jObj.getString("name"));
					if (i == 10) {
						break;
					}
				}
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 
		}
		
		private static void parseTweetJson (String str, ArrayList<String> result) {
			try (InputStream is = new ByteArrayInputStream(
					str.getBytes("UTF-8"));
					JsonReader rdr = Json.createReader(is)) {
				JsonArray results = rdr.readObject().getJsonArray("statuses");
				for (JsonObject individualTweet : results.getValuesAs(JsonObject.class)) {
					result.add(sanitize(individualTweet.getString("text")));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		public static String sanitize(String s) {
	    	return s.replace("&", "&amp;").replace("<","&lt;").replace(">","&gt;").replace("\"","&quot;").replace("\'","").replace("#","");
		}
}
