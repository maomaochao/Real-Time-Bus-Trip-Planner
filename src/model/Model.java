package model;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;

import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;

public class Model {
	private UserDAO userDAO;


	public Model(ServletConfig config) throws ServletException {		
		// initialise tables in my-sql database
		try {			
			String jdbcDrive 	= config.getInitParameter("jdbcDriver");
			String jdbcURL      = config.getInitParameter("jdbcURL");
			ConnectionPool cp 	= new ConnectionPool(jdbcDrive, jdbcURL);
			
			String userTbl = "team15_user";
			String commentTbl = "team8_comment";
			String locationtbl= "team8_location";
			String visittbl= "team8_visit";
			
			userDAO = new UserDAO(cp, userTbl);
		
			
		} catch (DAOException e) {
			throw new ServletException(e);
		} 
	}
	
	public UserDAO getUserDAO()  { return userDAO; }
}