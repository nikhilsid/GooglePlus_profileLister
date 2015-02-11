<html>
	<head>
		<style >
			h1 {
			text-align: center;
			}
		</style>
	</head>
	<body>
		
		<h1>Google+ Public Profile Finder</h1>
		
		
		<form action="getProfileList.cfm" method="post" name="inputtable" >
			<table align="center">
				<tr>
				<td>Give Full or partial names: </td>
				<td><input type="text" name="queryname" size="20"></td>
				</tr>
				<tr><td>Max Results: </td><td><input type="text" name="maxResults" value="20"></td></tr>
				<tr><td><input type="submit" name="Submit"></td></tr>
			</table>
		</form>
	</body>
</html>



<cffunction name="searchProfiles" >
	<cfargument name="queryName" >
	<cfset profilelist = application.google.getProfileList(session.token.access_token, #queryName#)>	
	<cfdump var="#profilelist#" >
</cffunction>



<br/>

<cfset clientid = "668680962395-22anedhdpg5d85laqk0v9rrke1ljroi3.apps.googleusercontent.com">
<cfset clientsecret = "dzdRkblVanqrloKz7lRHoufL">


<cfset temp = application.google.getFileList(session.token.access_token)>
