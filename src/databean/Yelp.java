package databean;

import org.genericdao.PrimaryKey;

//@PrimaryKey("name")
public class Yelp {
	private String photo;
	private String name;
	private String rank;
	private String address;
	private String url;
	private String time;
	private String snippet;

	
	public Yelp(String name,String photo,String address,String rank, String url,String time,String snippet){
		this.name = name;
		this.photo = photo;
		this.address = address;
		this.rank = rank;
		this.url = url;
		this.time = time;
		this.snippet = snippet;

		
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address){
		this.address = address;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getSnippet() {
		return snippet;
	}
	public void setSnippet(String snippet) {
		this.snippet = snippet;
	}
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
