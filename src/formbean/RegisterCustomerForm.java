package formbean;

import java.util.ArrayList;
import java.util.List;

import org.mybeans.form.FormBean;

public class RegisterCustomerForm extends FormBean {
	private String userName;
	private String firstName;
	private String lastName;
	private String email;
	private String addrLine1;
	private String addrLine2;
	private String city;
	private String state;
	private String zip;
	private String password;
	private String confirmPassword;
	private String action;
	
	public String getUserName()  { return userName;  }
	public String getFirstName() { return firstName; }
	public String getLastName()  { return lastName;  }
	public String getEmail()     { return email;     }
	public String getAddrLine1() { return addrLine1; }
	public String getAddrLine2() { return addrLine2; }
	public String getCity()      { return city;      }
	public String getState()     { return state;     }
	public String getZip()       { return zip;       }
	public String getPassword()  { return password;  }
	public String getConfirmPassword()  { return confirmPassword; }
	public String getAction()    		{ return action;          }
	
	public void setUserName(String s)         { userName = s.trim();  }
	public void setFirstName(String s)        { firstName = s.trim(); }
	public void setLastName(String s)         { lastName = s.trim();  }
	public void setEmail(String s)            { email = s.trim();     }
	public void setAddrLine1(String s)        { addrLine1 = s.trim(); }
	public void setAddrLine2(String s)        { addrLine2 = s.trim(); }
	public void setCity(String s)             { city = s.trim();      }
	public void setState(String s)            { state = s.trim();     }
	public void setZip(String s)              { zip = s.trim();       }
	public void setPassword(String s)         { password = s.trim();  }
	public void setConfirmPassword(String s)  { confirmPassword = s.trim(); }
	public void setAction(String s)           { action   = s;               }

	public List<String> getValidationErrors() {
		List<String> errors = new ArrayList<String>();

		if (userName == null || userName.length() == 0) {
			errors.add("User Name is required");
		} else if (userName.matches(".*[<>\"].*")) {
			errors.add("User Name cannot contain angle brackets or quotes");
		}
		
		if (firstName == null || firstName.length() == 0) {
			errors.add("First Name is required");
		} else if (firstName.matches(".*[<>\"].*")) {
			errors.add("First Name cannot contain angle brackets or quotes");
		}
		
		if (lastName == null || lastName.length() == 0) {
			errors.add("Last Name is required");
		} else if (lastName.matches(".*[<>\"].*")) {
			errors.add("Last Name cannot contain angle brackets or quotes");
		}
		
		if (email == null || email.length() == 0) {
			errors.add("Email is required");
		} else if (email.matches(".*[<>\"].*")) {
			errors.add("Email cannot contain angle brackets or quotes");
		}
		
		if (addrLine1 == null || addrLine1.length() == 0) {
			errors.add("Street Address is required");
		} else if (addrLine1.matches(".*[<>\"].*")) {
			errors.add("Street Address cannot contain angle brackets or quotes");
		}
		
		if (city == null || city.length() == 0) {
			errors.add("City is required");
		} else if (city.matches(".*[<>\"].*")) {
			errors.add("City cannot contain angle brackets or quotes");
		}
		
		if (state == null || state.length() == 0) {
			errors.add("Pleace pick a State");
		} else if (state.matches(".*[<>\"].*")) {
			errors.add("State cannot contain angle brackets or quotes");
		}
		
		if (zip == null || zip.length() == 0) {
			errors.add("Postal Code is required");
		} else if (zip.matches(".*[<>\"].*")) {
			errors.add("Postal Code cannot contain angle brackets or quotes");
		}
		try {
		int iZip= Integer.parseInt(zip);			
		} catch(NumberFormatException e) {
			errors.add("Zip code should contains only digits");
		}

		if (password == null || password.length() == 0) {
			errors.add("Password is required");
		} else if (password.matches(".*[<>\"].*")) {
			errors.add("Password cannot contain angle brackets or quotes");
		} else if(password.length()<5) {
			errors.add("Password cannot be less than 5 characters");
		}

		if (confirmPassword == null || confirmPassword.length() == 0) {
			errors.add("Confirm Pwd is required");
		} else if (confirmPassword.matches(".*[<>\"].*")) {
			errors.add("Confirm Password cannot contain angle brackets or quotes");
		}
		
		if (!action.equals("regCust")) {errors.add("Invalid button");} 
		
		if (errors.size() > 0) return errors;
		
		if (!password.equals(confirmPassword)) {
			errors.add("Password and Confirm Pwd do not match");
		}		       
		
        return errors;
	}
}
