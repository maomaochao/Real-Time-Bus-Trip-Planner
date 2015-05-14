package controller;

import javax.servlet.http.HttpServletRequest;

public class MapAction extends Action {

	@Override
	public String getName() {
		return "map.do";
	}

	@Override
	public String perform(HttpServletRequest request) {

		return "map.jsp";

	}

}
