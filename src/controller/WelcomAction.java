package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.genericdao.RollbackException;

import databean.User;
import model.Model;

public class WelcomAction extends Action{

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return "welcome.do";
	}
	
	

	@Override
	public String perform(HttpServletRequest request) {
		HttpSession session = request.getSession();
 

			User user = (User) session.getAttribute("user");
			if (user!=null)
			System.out.println("user "+user.getName());
			else 
				System.out.println("user is null");

			return "welcome.jsp";
					
		
	}

}
