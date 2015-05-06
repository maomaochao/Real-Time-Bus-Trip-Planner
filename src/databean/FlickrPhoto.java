package databean;

import org.genericdao.PrimaryKey;

@PrimaryKey("photoId")
public class FlickrPhoto {
	private int photoId;
	private String id;
	private String owner;
	private String secret;
	private String server;
	private String farm;
	public FlickrPhoto(String id,String owner,String secret,String server,String farm){
		this.id = id;
		this.owner = owner;
		this.secret = secret;
		this.server = server;
		this.farm = farm;

		
		
	}
	
	public int getPhotoId() {
		return photoId;
	}
	public void setPhotoId(int photoId) {
		this.photoId = photoId;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getSecret() {
		return secret;
	}
	public void setSecret(String secret) {
		this.secret = secret;
	}
	public String getServer() {
		return server;
	}
	public void setServer(String server) {
		this.server = server;
	}
	public String getFarm() {
		return farm;
	}
	public void setFarm(String farm) {
		this.farm = farm;
	}
	public String toString(){
		return "https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+".jpg";
		//https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg
		
	}
	public String thumbnail(){
		return "https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+"_q.jpg";
		//https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg
		
	}
	public String small(){
		return "https://farm"+farm+".staticflickr.com/"+server+"/"+id+"_"+secret+"_s.jpg";
		//https://farm3.staticflickr.com/2634/4046568058_0d7cffe35d.jpg
		
	}
	
	
}
