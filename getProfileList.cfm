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
		
		<cfset profilelist = application.google.getProfileList(session.token.access_token, #queryName#, #maxResults#)>
		<cfset pList = profilelist.items>
		 	



<table align="center" >
	
<cfloop array="#pList#" index="curProfile">
	
	<tr>
	<td>
	<cfoutput>
	<a href="#curProfile.url#">
		#curProfile['displayName']#
	</a>
	</cfoutput>
	</td>
	
	
	<cfset curImage = curProfile.image>
	
	<td>
	<cfimage action="writeToBrowser" source="#curImage.url#">
	</td>
	
	<!---
	<td>
	<cfoutput>
	<a href="#curProfile.id#">More Info</a>
	</cfoutput>
	</td>
	--->
	</tr>
</cfloop>

</table>

	</body>
</html>