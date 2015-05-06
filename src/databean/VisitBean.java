package databean;

import org.genericdao.PrimaryKey;

@PrimaryKey("date")
public class VisitBean {
	private String date;
	private int numOfVisit;
	
	public void setDate(String date) {
		this.date = date;
	}
	
	public String getDate() {
		return this.date;
	}
	
	public void setNumOfVisit(int value) {
		this.numOfVisit = value;
	}
	
	public int getNumOfVisit() {
		return this.numOfVisit;
	}
}
