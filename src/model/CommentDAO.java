package model;

import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;

import databean.Comment;

public class CommentDAO extends GenericDAO<Comment>{

	public CommentDAO(ConnectionPool cp, String tableName) throws DAOException {
		super(Comment.class, tableName, cp);
	}
}
