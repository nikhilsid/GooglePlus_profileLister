<!--- Validate the result --->
<cfparam name="url.code" default="">
<cfparam name="url.state" default="">
<cfparam name="url.error" default="">

<cfdump var="#url.state#" >
<br/>
<cfdump var="#session.urltoken#" >
<br/>
<!---<cfset result = application.google.validateResult(url.code, url.error, url.state, session.urltoken)>--->
<cfset result = application.google.validateResult(url.code, url.error, url.state, url.state)>
 
<cfif not result.status>
  <!--- Imagine a nicer error here. --->
	<cfoutput>
		<h1>Error!</h1>
		#result.message#
	</cfoutput>
	<cfabort>
</cfif>
 
<cfset session.token = result.token>
<cfset session.loggedin = true>
<cflocation url="index.cfm" addtoken="false">