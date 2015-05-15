
package model;

import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;
import org.genericdao.MatchArg;
import org.genericdao.RollbackException;
import org.genericdao.Transaction;

import databean.Favorite;


public class FavoriteDAO extends GenericDAO<Favorite> {
	public FavoriteDAO(String tableName, ConnectionPool pool)
			throws DAOException {
		super(Favorite.class, tableName, pool);

	}

	public FavoriteDAO(ConnectionPool cp, String tableName) throws DAOException {
		super(Favorite.class, tableName, cp);
	}
	
	public void create(Favorite newFavorite) throws RollbackException {
		createAutoIncrement(newFavorite);
	}



	public Favorite[] getFavorites(int userID) throws RollbackException {
		Favorite[] list = match(MatchArg.equals("userID", userID));
		return list;
	}

}
