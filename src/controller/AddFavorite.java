package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.genericdao.RollbackException;

import model.FavoriteDAO;
import model.Model;
import model.UserDAO;
import databean.User;
import databean.Favorite;

public class AddFavorite extends Action {

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return "addFavorite.do";
	}

	private FavoriteDAO favoriteDAO;

	public AddFavorite(Model model) {
		favoriteDAO = model.getFavoriteDAO();
	}

	@Override
	public String perform(HttpServletRequest request) throws IOException,
			ServletException {
		try {
			HttpSession session = request.getSession();
			User user = (User) request.getSession(false).getAttribute("user");
			
			
			String departure = (String) request.getParameter("departure");
			String arrival = (String) request.getParameter("arrival");
			
			System.out.println("departure is "+departure);
			
			if (user == null) {
				System.out
				.println("user is null. We can not add it to favorite. Please Login first.");
				return "login.jsp";
				
			}

		//	if (user != null) {
				Favorite favorite = new Favorite(); // FavoriteID & clickCount
													// will
				// be set when created

				favorite.setUserid(user.getUserId());
				favorite.setDeparture(departure);
				favorite.setArrival(arrival);
		

				favoriteDAO.create(favorite);


		} catch (RollbackException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "welcome.jsp";
	}

}
