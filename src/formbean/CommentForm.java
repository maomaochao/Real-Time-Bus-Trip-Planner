package formbean;

import java.util.ArrayList;
import java.util.List;

public class CommentForm {

	String comment;

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (comment == null || comment.length() == 0) {
			errors.add("Comment is required");
		}
		return errors;
	}
}
