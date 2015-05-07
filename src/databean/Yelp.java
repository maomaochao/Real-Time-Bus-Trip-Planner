package databean;

import org.genericdao.PrimaryKey;

//@PrimaryKey("name")
public class Yelp {
	private String photo;
	private String name;
	public Yelp(String name,String photo){
		this.name = name;
		this.photo = photo;
		

		
		
	}
	
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
//	public String getOwner() {
//		return owner;
//	}
//	public void setOwner(String owner) {
//		this.owner = owner;
//	}
//	public String getSecret() {
//		return secret;
//	}
//	public void setSecret(String secret) {
//		this.secret = secret;
//	}
//	public String getServer() {
//		return server;
//	}
//	public void setServer(String server) {
//		this.server = server;
//	}
//	public String getFarm() {
//		return farm;
//	}
//	public void setFarm(String farm) {
//		this.farm = farm;
//	}
//	public String toString(){
//		return "https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+".jpg";
//		//https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg
//		
//	}
//	public String thumbnail(){
//		return "https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+"_q.jpg";
//		//https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg
//		
//	}
//	public String small(){
//		return "https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+"_s.jpg";
//		//https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg
//		
//	}
	
	
}
