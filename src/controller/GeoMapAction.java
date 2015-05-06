package controller;

import javax.servlet.http.HttpServletRequest;

public class GeoMapAction  extends Action{
	
	public String getName() {
		// TODO Auto-generated method stub
		return "geoPage.do";
	}

	@Override
	public String perform(HttpServletRequest request) {
		return "GeoMap.jsp";
	}

}
