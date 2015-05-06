package model;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.genericdao.ConnectionPool;
import org.genericdao.DAOException;
import org.genericdao.GenericDAO;
import org.genericdao.RollbackException;

import databean.VisitBean;


public class VisitDAO extends GenericDAO<VisitBean>{
	public VisitDAO(ConnectionPool cp, String tableName) throws DAOException {
		super(VisitBean.class, tableName, cp);
	}
	
	public void increase() throws RollbackException {
		Date dt = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
		String str = dateFormat.format(dt);
		VisitBean visit  = read(str);
		if (visit == null) {
			VisitBean visitBean= new VisitBean();
			visitBean.setNumOfVisit(1);
			visitBean.setDate(str);
			create(visitBean);
		} else {
			visit.setNumOfVisit(visit.getNumOfVisit() + 1);
			update(visit);
		}
		
		
	}
	
	public VisitBean[] getRecord() throws RollbackException {
		VisitBean[] temp = match();
		return temp;
	}
}
