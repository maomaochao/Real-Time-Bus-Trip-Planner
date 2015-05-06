package controller;

import java.security.GeneralSecurityException;
import java.security.KeyManagementException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.InetSocketAddress;
import java.net.MalformedURLException;
import java.net.Socket;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

import javax.crypto.Mac;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.json.Json;
import javax.json.JsonArray;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.http.HttpException;
import org.apache.http.HttpHost;
import org.apache.http.HttpRequestInterceptor;
import org.apache.http.HttpResponse;
import org.apache.http.HttpVersion;
import org.apache.http.impl.DefaultHttpClientConnection;
import org.apache.http.message.BasicHttpEntityEnclosingRequest;
import org.apache.http.params.HttpParams;
import org.apache.http.params.HttpProtocolParams;
import org.apache.http.params.SyncBasicHttpParams;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.ExecutionContext;
import org.apache.http.protocol.HttpContext;
import org.apache.http.protocol.HttpProcessor;
import org.apache.http.protocol.HttpRequestExecutor;
import org.apache.http.protocol.ImmutableHttpProcessor;
import org.apache.http.protocol.RequestConnControl;
import org.apache.http.protocol.RequestContent;
import org.apache.http.protocol.RequestExpectContinue;
import org.apache.http.protocol.RequestTargetHost;
import org.apache.http.protocol.RequestUserAgent;
import org.apache.http.util.EntityUtils;
import org.json.JSONException;
import org.json.JSONObject;

import twitterAPI.GetHotTrends;
import databean.FlickrPhoto;

public class UploadAction extends Action {
	private static String twitter_consumer_key = "dB3by68F7PjybbLBjXyXsjbzz";
	private static String twitter_consumer_secret = "PZXONAiRgfbBH0LNo2Z4bRDeekiGgjizlFhSu0T3A24MihbyWc";

	public static String encode(String value) {
		String encoded = null;
		try {
			encoded = URLEncoder.encode(value, "UTF-8");
		} catch (UnsupportedEncodingException ignore) {
		}
		StringBuilder buf = new StringBuilder(encoded.length());
		char focus;
		for (int i = 0; i < encoded.length(); i++) {
			focus = encoded.charAt(i);
			if (focus == '*') {
				buf.append("%2A");
			} else if (focus == '+') {
				buf.append("%20");
			} else if (focus == '%' && (i + 1) < encoded.length()
					&& encoded.charAt(i + 1) == '7'
					&& encoded.charAt(i + 2) == 'E') {
				buf.append('~');
				i += 2;
			} else {
				buf.append(focus);
			}
		}
		return buf.toString();
	}

	private static ArrayList parseTweetJson(String str, ArrayList<String> result) {
		try (InputStream is = new ByteArrayInputStream(str.getBytes("UTF-8"));
				JsonReader rdr = Json.createReader(is)) {
			JsonArray results = rdr.readObject().getJsonObject("twitter_jo")
					.getJsonArray("statuses");
			// .getJsonObject("statuses")；
			System.out.println(results.size());
			for (JsonObject individualTweet : results
					.getValuesAs(JsonObject.class)) {
				result.add(sanitize(individualTweet.getString("text")));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	private static String computeSignature(String baseString, String keyString)
			throws GeneralSecurityException, UnsupportedEncodingException {
		SecretKey secretKey = null;

		byte[] keyBytes = keyString.getBytes();
		secretKey = new SecretKeySpec(keyBytes, "HmacSHA1");

		Mac mac = Mac.getInstance("HmacSHA1");
		mac.init(secretKey);

		byte[] text = baseString.getBytes();

		return new String(Base64.encodeBase64(mac.doFinal(text))).trim();
	}

	public String getName() {
		// TODO Auto-generated method stub
		return "upload.do";
	}

	@Override
	public String perform(HttpServletRequest request) {

		try {
			try {
				MessageDigest hash = MessageDigest.getInstance("MD5");

			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			// File file =new File("333.jpg");

			String par = request.getParameter("keyword");
			String keyword = par.split("\\|")[0];
			String woeid = par.split("\\|")[1];
			keyword = keyword.replace(' ', '+');
			System.out.println(keyword);

			List<FlickrPhoto> photos = new ArrayList<FlickrPhoto>();
			String callTest = "https://api.flickr.com/services/rest/?method=flickr.tags.getClusterPhotos&api_key=d3803ebdf492372803328824620ab1d7&tag=BMW&cluster_id=car&format=rest&auth_token=72157650365512169-6655b6404f6f0cc7&api_sig=21fc5966999b117d0bf098de29936d1d";
			String uploadurl = "https://up.flickr.com/services/upload/&api_key=d3803ebdf492372803328824620ab1d7&auth_token=72157650365512169-6655b6404f6f0cc7&api_sig=21fc5966999b117d0bf098de29936d1d";
			String searchurl = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=9334fecf0b2c41602b2fd55a94a849e0&text="
					+ keyword + "&sort=relevance&format=rest";

			/*
			 * String searchurl =
			 * "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=1c3e423fa49c61f7a76964f5f667da97&tags="
			 * + request.getParameter("keyword") +
			 * "&format=rest&api_sig=009bb81a236ff6fe2ec774c62ce58560";
			 */

			URL myURL = new URL(searchurl);

			HttpURLConnection con = (HttpURLConnection) myURL.openConnection();
			con.setRequestMethod("GET");
			BufferedReader in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));

			String temp = in.readLine();
			String One = in.readLine();
			/* System.out.println(One); */

			String Two = in.readLine();
			/* System.out.println(Two); */

			String Three = in.readLine();
			/* System.out.println(Three); */

			for (int i = 0; i < 10; i++) {
				String line = in.readLine();
				if (!(line == null || line.equals(""))) {
					
					String[] parts = line.split("\\\"");
					if (parts.length >= 10) {
						String id = parts[1];
						String owner = parts[3];
						String secret = parts[5];
						String server = parts[7];
						String farm = parts[9];
						FlickrPhoto photo = new FlickrPhoto(id, owner, secret,
								server, farm);
						photos.add(photo);
					} else {
						System.out.println("backup branch");
					}
					



				}
			}

			in.close();
			con.disconnect();

			request.setAttribute("woeid", woeid);
			request.setAttribute("keyword", keyword);
			request.setAttribute("photos", photos);

			ArrayList<String> trends =  GetHotTrends.getPopTrends(woeid);
			
			if (trends.size()>0){
				request.setAttribute("num", trends.size());				
				request.setAttribute("twitTrends", trends);
			} else {
				request.setAttribute("num", 0);				
				request.setAttribute("twitTrends", "We are sorry please try again");
			}

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		JSONObject jsonresponse = new JSONObject();
		HttpSession session = request.getSession();
		String p =(String) request.getParameter("keyword");
		
		String q = "";
		if(p.contains("|"))
		{
			String myKeyword[] = p.split("\\|");
			q = myKeyword[0];
		}
		else
		{
			q = p;
		}
		
		//System.out.println("String p is " + p);
		
		
		//System.out.println("query string is: " + q);
		//System.out.println("the keyword is "+q);
		String access_token = (String) session.getAttribute("accessToken");
		//System.out.println("the acceess token is: " + access_token);
		String access_token_secret = (String) session
				.getAttribute("secretaccessToken");
		//System.out
			//	.println("the secret access token is: " + access_token_secret);
		String oauth_token = access_token;
		String oauth_token_secret = access_token_secret;

		// generate authorization header
		String get_or_post = "GET";
		String oauth_signature_method = "HMAC-SHA1";

		String uuid_string = UUID.randomUUID().toString();
		uuid_string = uuid_string.replaceAll("-", "");
		String oauth_nonce = uuid_string; // any relatively random alphanumeric
											// string will work here

		// get the timestamp
		Calendar tempcal = Calendar.getInstance();
		long ts = tempcal.getTimeInMillis();// get current time in milliseconds
		String oauth_timestamp = (new Long(ts / 1000)).toString(); // then
																	// divide by
																	// 1000 to
																	// get
																	// seconds

		// the parameter string must be in alphabetical order
		// this time, I add 3 extra params to the request, "lang", "result_type"
		// and "q".
		String parameter_string = "lang=en&oauth_consumer_key="
				+ twitter_consumer_key + "&oauth_nonce=" + oauth_nonce
				+ "&oauth_signature_method=" + oauth_signature_method
				+ "&oauth_timestamp=" + oauth_timestamp + "&oauth_token="
				+ encode(oauth_token) + "&oauth_version=1.0&q=" + encode(q)
				+ "&result_type=mixed";
		System.out.println("parameter_string=" + parameter_string);
		String twitter_endpoint = "https://api.twitter.com/1.1/search/tweets.json";
		String twitter_endpoint_host = "api.twitter.com";
		String twitter_endpoint_path = "/1.1/search/tweets.json";
		String signature_base_string = get_or_post + "&"
				+ encode(twitter_endpoint) + "&" + encode(parameter_string);
		System.out.println("signature_base_string=" + signature_base_string);

		// this time the base string is signed using twitter_consumer_secret +
		// "&" + encode(oauth_token_secret) instead of just
		// twitter_consumer_secret + "&"
		String oauth_signature = "";
		try {
			oauth_signature = computeSignature(signature_base_string,
					twitter_consumer_secret + "&" + encode(oauth_token_secret)); // note
			// request_token
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String authorization_header_string = "OAuth oauth_consumer_key=\""
				+ twitter_consumer_key
				+ "\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\""
				+ oauth_timestamp + "\",oauth_nonce=\"" + oauth_nonce
				+ "\",oauth_version=\"1.0\",oauth_signature=\""
				+ encode(oauth_signature) + "\",oauth_token=\""
				+ encode(oauth_token) + "\"";
		
		System.out.println("the authorization header is: " + authorization_header_string);
		// System.out.println("authorization_header_string="
		// + authorization_header_string);

		HttpParams params = new SyncBasicHttpParams();
		HttpProtocolParams.setVersion(params, HttpVersion.HTTP_1_1);
		HttpProtocolParams.setContentCharset(params, "UTF-8");
		HttpProtocolParams.setUserAgent(params, "HttpCore/1.1");
		HttpProtocolParams.setUseExpectContinue(params, false);

		HttpProcessor httpproc = new ImmutableHttpProcessor(
				new HttpRequestInterceptor[] {
						// Required protocol interceptors
						new RequestContent(), new RequestTargetHost(),
						// Recommended protocol interceptors
						new RequestConnControl(), new RequestUserAgent(),
						new RequestExpectContinue() });

		HttpRequestExecutor httpexecutor = new HttpRequestExecutor();
		HttpContext context = new BasicHttpContext(null);
		HttpHost host = new HttpHost(twitter_endpoint_host, 443);
		DefaultHttpClientConnection conn = new DefaultHttpClientConnection();

		context.setAttribute(ExecutionContext.HTTP_CONNECTION, conn);
		context.setAttribute(ExecutionContext.HTTP_TARGET_HOST, host);

		try {
			try {
				SSLContext sslcontext = SSLContext.getInstance("TLS");
				sslcontext.init(null, null, null);
				SSLSocketFactory ssf = sslcontext.getSocketFactory();
				Socket socket = ssf.createSocket();
				socket.connect(
						new InetSocketAddress(host.getHostName(), host
								.getPort()), 0);
				conn.bind(socket, params);

				// the following line adds 3 params to the request just as the
				// parameter string did above. They must match up or the request
				// will fail.
				BasicHttpEntityEnclosingRequest request2 = new BasicHttpEntityEnclosingRequest(
						"GET", twitter_endpoint_path
								+ "?lang=en&result_type=mixed&q=" + encode(q));
				request2.setParams(params);
				request2.addHeader("Authorization", authorization_header_string); // always
																					// add
																					// the
																					// Authorization
																					// header
				httpexecutor.preProcess(request2, httpproc, context);
				HttpResponse response2 = httpexecutor.execute(request2, conn,
						context);
				response2.setParams(params);
				httpexecutor.postProcess(response2, httpproc, context);

				if (response2.getStatusLine().toString().indexOf("500") != -1) {
					jsonresponse.put("response_status", "error");
					jsonresponse.put("message", "Twitter auth error.");
				} else {
					// if successful, the response should be a JSONObject of
					// tweets
					JSONObject jo = new JSONObject(
							EntityUtils.toString(response2.getEntity()));
					if (jo.has("errors")) {
						jsonresponse.put("response_status", "error");
						String message_from_twitter = jo.getJSONArray("errors")
								.getJSONObject(0).getString("message");
						if (message_from_twitter
								.equals("Invalid or expired token")
								|| message_from_twitter
										.equals("Could not authenticate you"))
							jsonresponse.put("message", "Twitter auth error.");
						else
							jsonresponse.put("message",
									jo.getJSONArray("errors").getJSONObject(0)
											.getString("message"));
					} else {
						jsonresponse.put("twitter_jo", jo); // this is the full
															// result object
															// from Twitter
					}

					conn.close();
				}
			} catch (HttpException he) {
				System.out.println(he.getMessage());
				jsonresponse.put("response_status", "error");
				jsonresponse
						.put("message", "searchTweets HttpException message="
								+ he.getMessage());
			} catch (NoSuchAlgorithmException nsae) {
				System.out.println(nsae.getMessage());
				jsonresponse.put("response_status", "error");
				jsonresponse.put(
						"message",
						"searchTweets NoSuchAlgorithmException message="
								+ nsae.getMessage());
			} catch (KeyManagementException kme) {
				System.out.println(kme.getMessage());
				jsonresponse.put("response_status", "error");
				jsonresponse.put(
						"message",
						"searchTweets KeyManagementException message="
								+ kme.getMessage());
			} finally {
				conn.close();
			}
		} catch (JSONException jsone) {

		} catch (IOException ioe) {

		}
		System.out.println(jsonresponse);
		// List tweets = new ArrayList();
		// tweets.add(jsonresponse);
		String result = jsonresponse.toString();
		ArrayList<String> tweets = new ArrayList<String>();
		tweets = parseTweetJson(result, tweets);
		session.setAttribute("tweets", tweets);
		return "Upload.jsp";
	}

}
