package databean;

import org.genericdao.PrimaryKey;

@PrimaryKey("userId")
public class User {
	private int userId;
	private String id;
	private String name;

	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

}
