package databean;

import org.genericdao.PrimaryKey;

@PrimaryKey("commentId")
public class Comment {

	private int commentId;
	private String comment;
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
}
