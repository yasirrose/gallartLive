
<!--- default event --->
<cftry>
<cfparam name="session.loggedin" default="false" />
<cfif structKeyExists(url, "logout")>
	<cfset session.loggedin = false>
	<cfset structDelete(session,'userinfo')>
</cfif>

<cfparam name="URL.event" default="login" />

<cfset ControllerPath = "controllers" />

<cfinclude template="#ControllerPath#/#listfirst(URL.event, '.')#.cfm" />
<cfcatch>
	<cfdump var="#cfcatch#" abort='true'>
</cfcatch>
</cftry>