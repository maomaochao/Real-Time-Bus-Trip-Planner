package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.genericdao.RollbackException;

import databean.Location;
import databean.User;
import model.LocationDAO;
import model.Model;

public class WelcomAction extends Action{
	private LocationDAO locationDAO;

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return "welcome.do";
	}
	
	

	@Override
	public String perform(HttpServletRequest request) {
		HttpSession session = request.getSession();
 
		if (session.getAttribute("user")==null){
			System.out.println("user is null");
		return "welcome.jsp";
		}
		else {
			User user = (User) session.getAttribute("user");
			System.out.println("user "+user.getName());

			return "yelp.do";
					
		}
	}

}
