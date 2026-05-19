<cfoutput>
<footer>
	<div class="footer-container">
		<div class="footer-wrapper">
			<div class="top-footer">
				<a href="/">HOME</a>
				<cfif structKeyExists(session, 'sellerinfo') >
					<a href="/logout">LOG OUT</a>
				</cfif> 
				<!--- <a href="logout.cfm<cfif parameterexists(xss)>?xss=#xss#</cfif>">LOG OUT</a> --->
			</div>
			<div class="bottom-footer">
				<p>copyright #year(createodbcdate(now()))# www.gallart.com</p>
			</div>
		</div>
	</div>
</footer>
</cfoutput>
