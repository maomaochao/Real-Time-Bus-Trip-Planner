package controller;

import javax.servlet.http.HttpServletRequest;

import model.LocationDAO;
import model.Model;
import model.VisitDAO;

import org.genericdao.RollbackException;

import databean.Location;
import databean.VisitBean;

public class GoogleChartAction extends Action{
	private LocationDAO locationDAO;
	private VisitDAO visitDAO;	
		public String getName() {
			// TODO Auto-generated method stub
			return "googleChart.do";
		}
		
		public GoogleChartAction(Model model) {
			// TODO Auto-generated constructor stub
			locationDAO= model.getLocationDAO();
			visitDAO= model.getVisitDAO();
		}

		@Override
		public String perform(HttpServletRequest request) {
			
			Location[] locs;
			VisitBean[] visits;
			try {
				locs = locationDAO.getTopTen();
				request.setAttribute("topten", locs);
				
				visits=visitDAO.getRecord();
				request.setAttribute("visits", visits);
			} catch (RollbackException e) {
				e.printStackTrace();
			}
			
			return "Analytics.jsp";
		}

}
