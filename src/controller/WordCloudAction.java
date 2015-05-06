package controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.genericdao.RollbackException;
import org.genericdao.Transaction;

import databean.Location;
import model.LocationDAO;
import model.Model;
import twitterAPI.*;

public class WordCloudAction extends Action{ 
		private LocationDAO locationDAO;
		
		public String getName() {
			return "googleCloud.do";
		}
		
		public WordCloudAction(Model model) {
			// TODO Auto-generated constructor stub
			locationDAO= model.getLocationDAO();
		}
		
		public String perform(HttpServletRequest request) {
			List<String> errors = new ArrayList<String>();
			request.setAttribute("errors", errors);
			
			String lat= request.getParameter("lat");
			String lang= request.getParameter("lng");

			try {
				YahooWoeid yahooid= new YahooWoeid();
				String city= yahooid.getCity(lat, lang);
				request.setAttribute("city", city);
				System.out.println("here");
				int num= locationDAO.numOfLocation(city);
				System.out.println("num: "+num);
				if(num==0) {
					Location loc= new Location();
					loc.setCount(1);
					loc.setLocName(city);
					locationDAO.createAutoIncrement(loc);
				} else {
					Location loc= locationDAO.getCount(city);					
					locationDAO.changeLocationNumber(loc.getLocId(), loc.getCount()+1);
				}
				
				Location[] locs= locationDAO.getTopTen();
				request.setAttribute("topten", locs);
				
				System.out.println(locs.length);
				
				String woeid= yahooid.getWoeid(lat, lang);
				
				System.out.println("woeid"+ woeid);
				ArrayList<String> trends =  GetHotTrends.getPopTrends(woeid);
				
				if (trends.size()>0){
					request.setAttribute("num", trends.size());				
					request.setAttribute("twitTrends", trends);
				} else {
					request.setAttribute("num", 0);				
					request.setAttribute("twitTrends", "We are sorry please try again");
				}
				
				request.setAttribute("woeid", woeid);
				
				return "GoogleCloud.jsp";
			} catch(RollbackException e) {
				errors.add(e.getMessage());
				return "createFund.jsp";
			
			}
		}
}