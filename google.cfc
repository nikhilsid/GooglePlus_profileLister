component {
 
  public function init(clientid, clientsecret) {
		variables.clientid = arguments.clientid;
		variables.clientsecret = arguments.clientsecret;
		return this;
	}
 
	public string function generateAuthURL(redirecturl, state) {
		/*
		Scope is what you want to do with your access. Since this demo is ONLY for
		auth and user info, we have one hard coded value.
		*/
		return "https://accounts.google.com/o/oauth2/auth?" & 
				 "client_id=#urlEncodedFormat(variables.clientid)#" & 
     			 "&redirect_uri=#urlEncodedFormat(arguments.redirecturl)#" & 
				 "&scope=https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/drive &response_type=code" & 
				 "&state=#urlEncodedFormat(arguments.state)#";
 
	}
 
	public function getProfile(accesstoken,userid) {
 
		var h = new com.adobe.coldfusion.http();
		//h.setURL("https://www.googleapis.com/oauth2/v1/userinfo");
		//h.setURL("https://www.googleapis.com/plus/v1/people/" & #userid#);
		h.setURL("https://www.googleapis.com/plus/v1/people?query=nikhil");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	
	public function getProfileList (accesstoken,queryname,resultsNeeded) {
		var h = new com.adobe.coldfusion.http();
		h.setURL("https://www.googleapis.com/plus/v1/people?query=#queryname#&maxResults=#resultsNeeded#");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		var result = h.send().getPrefix();
		return deserializeJSON(result.filecontent.toString());
	}
	
	public function getFileList(accesstoken) {
		
		var h = new com.adobe.coldfusion.http();
		h.setUrl("https://www.googleapis.com/v2/files");
		h.setMethod("get");
		h.addParam(type="header",name="Authorization",value="OAuth #accesstoken#");
		h.addParam(type="header",name="GData-Version",value="3");
		h.setResolveURL(true);
		
		var result = h.send().getPrefix();
		return (result);
	}
 

	public struct function validateResult(code, error, remoteState, clientState) {
		var result = {};
 
		//If error is anything, we have an error
		if(error != "") {
			result.status = false;
			result.message = error;
			return result;
		}
 
		//Then, ensure states are equal
		
		if(remoteState != clientState) {
			result.status = false;
			result.message = "State values did not match!!";
			return result;
		}
 
		var token = getGoogleToken(code);
 
		if(structKeyExists(token, "error")) {
			result.status = false;
			result.message = token.error;
			return result;
		}
		
		result.status = true;
		result.token = token;
 
		return result;
	}
 
	//Credit: http://www.sitekickr.com/blog/http-post-oauth-coldfusion
	private function getGoogleToken(code) {
		var postBody = "code=" & UrlEncodedFormat(arguments.code) & "&";
			 postBody = postBody & "client_id=" & UrlEncodedFormat(application.clientid) & "&";
			 postBody = postBody & "client_secret=" & UrlEncodedFormat(application.clientsecret) & "&";
			 postBody = postBody & "redirect_uri=" & UrlEncodedFormat(application.callback) & "&";
			 postBody = postBody & "grant_type=authorization_code";
 
 
			var h = new com.adobe.coldfusion.http();
			h.setURL("https://accounts.google.com/o/oauth2/token");
			h.setMethod("post");
			h.addParam(type="header",name="Content-Type",value="application/x-www-form-urlencoded");
			h.addParam(type="body",value="#postBody#");
			h.setResolveURL(true);
			var result = h.send().getPrefix();
			return deserializeJSON(result.filecontent.toString());
 
	}
 
}