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

		YelpAPI yelpApi = new YelpAPI();
		String searchResponseJSON =
		        yelpApi.searchForBusinessesByLocation("dinner", "San Francisco, CA");
		
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
	    for ( int i = 0 ; i < 5 ; i ++ ){
	    	JSONObject thisobj = (JSONObject) businesses.get(i);
	    	 String name = thisobj.get("name").toString();
	    	 String photo = thisobj.get("image_url").toString();
	 	    System.out.println(name);

	    	 Yelp yelp = new Yelp( name,photo );
	    	 yelps.add(yelp);
	    }
	    
	   
	    System.out.println("hehe");
	    request.setAttribute("yelps", yelps);
	    
	return "Yelp.jsp";
	}
}
