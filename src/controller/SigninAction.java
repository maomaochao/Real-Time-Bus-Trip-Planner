package controller;

import java.io.IOException;

import model.Model;
import model.VisitDAO;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.genericdao.RollbackException;
import org.scribe.builder.ServiceBuilder;
import org.scribe.builder.api.Api;
import org.scribe.builder.api.TwitterApi;
import org.scribe.model.OAuthRequest;
import org.scribe.model.Response;
import org.scribe.model.Token;
import org.scribe.model.Verb;
import org.scribe.model.Verifier;
import org.scribe.oauth.OAuthService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


public class SigninAction extends Action {
	private VisitDAO visitDao;
	private static final String PROTECTED_RESOURCE_URL = "https://api.twitter.com/1.1/account/verify_credentials.json";

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return "signIn.do";
	}

	public SigninAction(Model model) {
		// TODO Auto-generated constructor stub
		visitDao= model.getVisitDAO();
	}
	@Override
	public String perform(HttpServletRequest request)
			{

		OAuthService service = new ServiceBuilder()
				.provider(TwitterApi.class)
				.apiKey("dB3by68F7PjybbLBjXyXsjbzz")
				.apiSecret("PZXONAiRgfbBH0LNo2Z4bRDeekiGgjizlFhSu0T3A24MihbyWc")
				.callback("http://localhost:8080/Task8/getVerify.do").build();


		// Obtain the Request Token
		System.out.println("Fetching the Request Token...");
		Token requestToken = service.getRequestToken();
		
		System.out.println("Got the Request Token!");
		System.out.println("The request token is: " + requestToken);
		 System.out.println(service.getAuthorizationUrl(requestToken));
		 HttpSession session = request.getSession();
	     session.setAttribute("token",requestToken);
	     try {
			visitDao.increase();
		} catch (RollbackException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// request.setAttribute("token", requestToken);
		//String url = service.getAuthorizationUrl(requestToken);
		//System.out.println(url);
		//callURL(url);
		/*Verifier v = new Verifier(request.getParameter("oauth_verifier"));
		Token accessToken = service.getAccessToken(requestToken, v);

		System.out.println(v);

		// Trade the Request Token and Verfier for the Access Token
		// System.out.println("Trading the Request Token for an Access Token...");
		// Token accessToken = service.getAccessToken(requestToken, verifier);
		System.out.println("Got the Access Token!");
		System.out.println("(if you're curious, it looks like this: "
				+ accessToken + " )");
		System.out.println();

		// Now let's go and ask for a protected resource!
		System.out.println("Now we're going to access a protected resource...");
		// OAuthRequest request = new OAuthRequest(Verb.GET,
		// PROTECTED_RESOURCE_URL);
		OAuthRequest req = new OAuthRequest(Verb.GET,
				"https://api.twitter.com/1.1/statuses/lookup.json");
		req.addQuerystringParameter("id", "20,432656548536401920");

		service.signRequest(accessToken, req);

		// request.addBodyParameter("id", value);
		Response response = req.send();
		System.out.println(response.getBody());
		System.out.println();

		/*
		 * JSONObject jsonObject = JSONObject.fromObject(response.getBody());
		 * String aString = jsonObject.getString("text");
		 * System.out.println("========" + aString);
		 */
		// System.out.println();
		// System.out.println("That's it man! Go and build something awesome with Scribe! :)");
		// TODO Auto-generated method stub*/
		return service.getAuthorizationUrl(requestToken);
	}
}
