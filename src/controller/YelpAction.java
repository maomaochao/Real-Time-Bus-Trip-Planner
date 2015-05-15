package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import model.Model;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import databean.Yelp;
import API.YelpAPI;

public class YelpAction extends Action{
	public String getName() {
		return "yelp.do";
	}
//	public YelpAction(Model model) {
//		// TODO Auto-generated constructor stub
//		//locationDAO= model.getLocationDAO();
//	}
	public String perform(HttpServletRequest request) {
		
		List<Yelp> yelps = new ArrayList<Yelp>();
		
	    System.out.println("performing");
	    
	    String cate ="restaurants";
	    		if (request.getParameter("cate")!=null){
	    			cate = request.getParameter("cate");
	    		}

		YelpAPI yelpApi = new YelpAPI();
		String searchResponseJSON =
		        yelpApi.searchForBusinessesByLocation("", "Pittsburgh, PA", cate);
		
		 JSONParser parser = new JSONParser();
		 JSONObject response = null;
		try {
		      response = (JSONObject) parser.parse(searchResponseJSON);
		    } catch (ParseException pe) {
		      System.out.println("Error: could not parse JSON response:");
		      System.out.println(searchResponseJSON);
		      System.exit(1);
		    }
		
		JSONArray businesses = (JSONArray) response.get("businesses");
	      System.out.println(businesses.size());

	    for ( int i = 0 ; i < Math.min(10, businesses.size()) ; i ++ ){
	    	JSONObject thisobj = (JSONObject) businesses.get(i);
		      System.out.println("this is no. "+i+" "+ thisobj.toString());

	    	 String name = thisobj.get("name").toString();
	    	 String photo = "N/A";
	    	 String rank = "N/A";
	    	 String url = "N/A";

	    	 
	    	 if (thisobj.get("image_url")!= null){  photo = thisobj.get("image_url").toString();}
	    	 if (thisobj.get("rating_img_url_small")!= null){  rank = thisobj.get("rating_img_url_small").toString();}
	    	 if (thisobj.get("url")!= null){  url = thisobj.get("url").toString();}

	    	 JSONObject location = (JSONObject) thisobj.get("location");
	    	 JSONArray addresses = (JSONArray) location.get("address");
	    	 String address = addresses.get(0).toString();
	    	 

	 	    System.out.println(name);

	    	 Yelp yelp = new Yelp( name,photo,address,rank,url );
	    	 yelps.add(yelp);
	    }
	    
	   
	    System.out.println("hehe");
	    request.setAttribute("yelps", yelps);
	    System.out.println("request set");
	    return "Yelp.jsp";
	}
}
