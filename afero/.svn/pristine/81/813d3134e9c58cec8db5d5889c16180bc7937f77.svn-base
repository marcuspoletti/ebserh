package afero.util;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

class SimpleAuth extends Authenticator {
	public String username = "mvpoletti";
	public String password = "840809101112131415";


	public SimpleAuth(String user, String pwd) {
		username = user;
		password = pwd;
	}

	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication (username,password);
	}
} 
