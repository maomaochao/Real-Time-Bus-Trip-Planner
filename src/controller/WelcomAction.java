package controller;

import javax.servlet.http.HttpServletRequest;

import org.genericdao.RollbackException;

import databean.Location;
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
		
		
		
	
		return "welcome.jsp";
	}

}
