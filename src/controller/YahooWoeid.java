package controller;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;

public class YahooWoeid{


	public String getWoeid(String lat, String lang) {
		// TODO Auto-generated method stub
		//select * from geo.placefinder where text="40.4449596,-79.9484689" and gflags="R"
		//https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20geo.placefinder%20where%20text%3D%2240.4449596%2C-79.9484689%22%20and%20gflags%3D%22R%22&format=json&diagnostics=true&callback=
		String temp="";
		String city="";
		try {
			System.out.println("lat: "+lat+" "+lang);
			String baseUrl = "https://query.yahooapis.com/v1/public/yql?q=";
			String query1="select * from geo.placefinder where text=\""+lat+","+lang+"\" and gflags=\"R\"";
			String fullUrlStr1 = baseUrl + URLEncoder.encode(query1, "UTF-8")
					+ "&format=json";
			URL fullUrl1 = new URL(fullUrlStr1);
			String temp1="";
			try (InputStream is1 = fullUrl1.openStream(); JsonReader rdr1 = Json.createReader(is1)) {
				JsonObject results1 = rdr1.readObject().getJsonObject("query").getJsonObject("results").getJsonObject("Result");
				temp1 = results1.getString("woeid");
				city= results1.getString("city");
				
				System.out.println(temp1);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			String query = "select woeid from geo.places.parent where child_woeid in (select woeid from geo.places where woeid="+temp1+")";
			String fullUrlStr = baseUrl + URLEncoder.encode(query, "UTF-8")
					+ "&format=json";
			URL fullUrl = new URL(fullUrlStr);
			try (InputStream is = fullUrl.openStream(); JsonReader rdr = Json.createReader(is)) {
				JsonObject results = rdr.readObject().getJsonObject("query").getJsonObject("results").getJsonObject("place");
				temp = results.getString("woeid");
				System.out.print(temp);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return temp;
	}

	public String getCity(String lat, String lang) {
		String city="";
		try {
			System.out.println("lat: "+lat+" "+lang);
			String baseUrl = "https://query.yahooapis.com/v1/public/yql?q=";
			String query1="select * from geo.placefinder where text=\""+lat+","+lang+"\" and gflags=\"R\"";
			String fullUrlStr1 = baseUrl + URLEncoder.encode(query1, "UTF-8")
					+ "&format=json";
			URL fullUrl1 = new URL(fullUrlStr1);
			try (InputStream is1 = fullUrl1.openStream(); JsonReader rdr1 = Json.createReader(is1)) {
				JsonObject results1 = rdr1.readObject().getJsonObject("query").getJsonObject("results").getJsonObject("Result");
				
				city= results1.getString("city");
				
				System.out.println(city);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return city;
	}
}
