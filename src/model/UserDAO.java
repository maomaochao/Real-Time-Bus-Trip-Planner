package model;

import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;
import org.genericdao.MatchArg;
import org.genericdao.RollbackException;

import databean.User;

public class UserDAO extends GenericDAO<User>{

	public UserDAO(ConnectionPool cp, String tableName) throws DAOException {
		super(User.class, tableName, cp);
	}
	
	public User getUser(String userid) throws RollbackException {
		User[] user = match(MatchArg.equals("id", userid));
		if (user.length == 0)
			return null;
		return user[0];
	}
}
