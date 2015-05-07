package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

import org.genericdao.RollbackException;

import model.Model;
import model.UserDAO;
import databean.User;

public class LoginAction extends Action {

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return "login.do";
	}

	private UserDAO userDAO;

	public LoginAction(Model model) {
		userDAO = model.getUserDAO();
	}

	public LoginAction() {
		
	}

	@Override
	public String perform(HttpServletRequest request) throws IOException,
			ServletException {
		try {
			// TODO Auto-generated method stub
			String userid = (String) request.getParameter("userid");
			String username = (String) request.getParameter("username");

			System.out.println(userid);
			System.out.println(username);
			// Look up the user
			User user;

			user = userDAO.getUser(userid);

			if (user == null) {

				// Create the user bean
				user = new User();
				user.setId(userid);
				user.setName(username);
				userDAO.create(user);
			}

			
		} catch (RollbackException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "yelp.do";
	}

}
