package model;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;

public class Model {
	private UserDAO userDAO;
	private FavoriteDAO favoriteDAO;


	public Model(ServletConfig config) throws ServletException {		
		// initialise tables in my-sql database
		try {			
			String jdbcDrive 	= config.getInitParameter("jdbcDriver");
			String jdbcURL      = config.getInitParameter("jdbcURL");
			ConnectionPool cp 	= new ConnectionPool(jdbcDrive, jdbcURL);
			
			String userTbl = "team15_user";
			String favoriteTbl = "team15_favorite";

			
			userDAO = new UserDAO(cp, userTbl);
			favoriteDAO= new FavoriteDAO(cp, favoriteTbl);
		
			
		} catch (DAOException e) {
			throw new ServletException(e);
		} 
	}
	
	public UserDAO getUserDAO()  { return userDAO; }

	public FavoriteDAO getFavoriteDAO() {
		return favoriteDAO;
	}

}