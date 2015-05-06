package controller;

import javax.servlet.http.HttpServletRequest;

public class MapKMLAction extends Action{ 
		
		public String getName() {
			// TODO Auto-generated method stub
			return "mapKML.do";
		}

		@Override
		public String perform(HttpServletRequest request) {
			return "MapKML.jsp";
		}

}