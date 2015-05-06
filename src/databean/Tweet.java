package databean;

public class Tweet {
	private String name;
	private int id;
	private String text;
	public Tweet(String name, int id, String text) {
		this.name = name;
		this.id = id;
		this.text = text;
		
	}
	
	public String getName() {
		return this.name;
	}
	
	public int getId() {
		return this.id;
	}
	
	public String getText() {
		return this.text;
	}

}
