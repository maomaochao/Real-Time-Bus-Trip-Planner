
package databean;

import org.genericdao.PrimaryKey;


@PrimaryKey("favoriteid")
public class Favorite {
	private String departure;
	private String arrival;
	private int userid;
	private int favoriteid;




	public String getArrival() {
		return arrival;
	}

	public void setArrival(String arrival) {
		this.arrival = arrival;
	}

	public String getDeparture() {
		return departure;
	}

	public void setDeparture(String departure) {
		this.departure = departure;
	}

	public int getUserid() {
		return userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public int getFavoriteid() {
		return favoriteid;
	}

	public void setFavoriteid(int favoriteid) {
		this.favoriteid = favoriteid;
	}

}
