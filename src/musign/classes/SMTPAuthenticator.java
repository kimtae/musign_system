package musign.classes;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class SMTPAuthenticator extends Authenticator{
		
		
		@Override
	    protected PasswordAuthentication getPasswordAuthentication() {
	        return new PasswordAuthentication("joyfive95@musign.net","whdlvkdlqm9");
	    }
	 
	}