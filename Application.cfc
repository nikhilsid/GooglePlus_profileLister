component 
{
	 this.name="googleoauthlogin4";
     this.sessionManagement=true;
 
    public boolean function onApplicationStart() {
        application.clientid="668680962395-22anedhdpg5d85laqk0v9rrke1ljroi3.apps.googleusercontent.com";
        application.clientsecret="dzdRkblVanqrloKz7lRHoufL";
        application.callback="http://localhost:8500/googledrive_app/callback.cfm";
 
       // application.google = new google(application.clientid, application.clientsecret);  
        return true;
    }
 
    public boolean function onRequestStart(required string req) {
 
      application.google = new google(application.clientid, application.clientsecret);
      if(!findNoCase("/login.cfm", arguments.req) && !findNoCase("/callback.cfm", arguments.req) && !session.loggedin) {
    		location(url="./login.cfm", addToken="false");
    	}
    	return true;
    }
 
    public boolean function onSessionStart() {
    	session.loggedin = false;
 
    	return true;
    }
}