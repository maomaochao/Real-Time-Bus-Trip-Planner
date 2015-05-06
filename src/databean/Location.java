package databean;

import org.genericdao.PrimaryKey;

@PrimaryKey("locId")
public class Location {
	private int locId;
	private String locName;
	private int count;
	
	public int getLocId() {
		return this.locId;
	}
	
	public String getLocName() {
		return this.locName;
	}
	
	public int getCount() {
		return this.count;
	}
	
	public void setLocId(int aLocId) {
		this.locId = aLocId;
	}
	
	public void setLocName(String aName) {
		this.locName = aName;
	}
	
	public void setCount(int num) {
		this.count = num;
	}
}
