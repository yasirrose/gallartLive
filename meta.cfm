<cfparam name="application.siteCanonicalBaseUrl" default="https://gallart.com">
<cfparam name="application.siteBaseUrl" default="https://gallart.com">
<cfparam name="application.siteName" default="Gallart">

<cffunction name="seoCanonicalSegment" output="false" returntype="string">
	<cfargument name="value" type="string" required="true">
	<cfset var encodedValue = urlEncodedFormat(trim(arguments.value))>
	<cfset encodedValue = replace(encodedValue, "+", "%20", "all")>
	<cfreturn encodedValue>
</cffunction>

<cfset seoDescriptionDefault = "Fine Art Buy and Sell gallery with curated works by Warhol, Lichtenstein, Wesselmann, Indiana, Picasso, Chagall, Haring, Max, Britto, Neiman, and more.">
<cfset seoKeywordsDefault = "fine art, buy art, sell art, warhol, lichtenstein, wesselmann, picasso, chagall, haring, peter max, britto, neiman">
<cfset seoTitle = companyname & " - " & titletext>
<cfset seoDescription = seoDescriptionDefault>
<cfset seoKeywords = seoKeywordsDefault>
<cfset seoRobots = "index, follow, max-image-preview:large">
<cfset canonicalPath = cgi.script_name>

<cfif structKeyExists(cgi, "request_uri") AND len(trim(cgi.request_uri))>
	<cfset canonicalPath = reReplace(trim(cgi.request_uri), "\?.*$", "", "one")>
<cfelseif structKeyExists(cgi, "path_info") AND len(trim(cgi.path_info))>
	<cfset canonicalPath = trim(cgi.path_info)>
</cfif>

<cfswitch expression="#lcase(cgi.script_name)#">
	<cfcase value="/index.cfm">
		<cfset canonicalPath = "/">
	</cfcase>
	<cfcase value="/item.cfm">
		<cfif structKeyExists(url, "artist") AND len(trim(url.artist)) AND structKeyExists(url, "slug") AND len(trim(url.slug))>
			<cfset canonicalPath = "/artist/#seoCanonicalSegment(url.artist)#/#seoCanonicalSegment(url.slug)#">
		</cfif>
	</cfcase>
	<cfcase value="/products.cfm">
		<cfset canonicalPath = "/artists">
		<cfif structKeyExists(url, "man") AND len(trim(url.man))>
			<cfset canonicalPath = "/artists/#seoCanonicalSegment(url.man)#">
		<cfelseif structKeyExists(url, "keywords") AND len(trim(url.keywords))>
			<cfset canonicalPath = "/artists/search/#seoCanonicalSegment(url.keywords)#">
		</cfif>
	</cfcase>
	<cfcase value="/alpha_list.cfm">
		<cfset canonicalPath = "/alpha_list">
		<cfif structKeyExists(url, "man") AND len(trim(url.man))>
			<cfset canonicalPath = "/alpha_list/#seoCanonicalSegment(url.man)#">
		</cfif>
	</cfcase>
	<cfcase value="/new_listings.cfm">
		<cfset canonicalPath = "/recent-acquisitions">
	</cfcase>
	<cfcase value="/sales.cfm">
		<cfset canonicalPath = "/sale-items">
	</cfcase>
	<cfcase value="/classifieds.cfm">
		<cfset canonicalPath = "/classifieds">
	</cfcase>
	<cfcase value="/featured_events.cfm">
		<cfset canonicalPath = "/events">
	</cfcase>
	<cfcase value="/new_user_registration.cfm">
		<cfset canonicalPath = "/sell-your-art">
	</cfcase>
	<cfcase value="/about.cfm">
		<cfset canonicalPath = "/about-us">
	</cfcase>
	<cfcase value="/contact.cfm">
		<cfset canonicalPath = "/contact-us">
	</cfcase>
	<cfcase value="/promotion.cfm">
		<cfset canonicalPath = "/promotion">
	</cfcase>
	<cfcase value="/requests.cfm">
		<cfset canonicalPath = "/requests">
	</cfcase>
	<cfcase value="/quotes.cfm">
		<cfset canonicalPath = "/quotes">
	</cfcase>
	<cfcase value="/mailing_list.cfm">
		<cfset canonicalPath = "/mailing-list">
	</cfcase>
	<cfcase value="/buyer_info.cfm">
		<cfset canonicalPath = "/buyer-info">
	</cfcase>
	<cfcase value="/seller_info.cfm">
		<cfset canonicalPath = "/seller-info">
	</cfcase>
	<cfcase value="/searchpage.cfm">
		<cfset canonicalPath = "/search">
	</cfcase>
	<cfcase value="/pns.cfm">
		<cfset canonicalPath = "/privacy">
	</cfcase>
	<cfcase value="/shippingpolicy.cfm">
		<cfset canonicalPath = "/shipping-policy">
	</cfcase>
	<cfcase value="/termsuse.cfm">
		<cfset canonicalPath = "/terms">
	</cfcase>
	<cfcase value="/alerts.cfm">
		<cfset canonicalPath = "/alerts">
	</cfcase>
	<cfcase value="/review.cfm">
		<cfset canonicalPath = "/review">
	</cfcase>
	<cfcase value="/user_login_page.cfm">
		<cfset canonicalPath = "/login">
	</cfcase>
	<cfcase value="/forgot_password.cfm">
		<cfset canonicalPath = "/forgot_password">
	</cfcase>
	<cfcase value="/register.cfm">
		<cfset canonicalPath = "/register">
	</cfcase>
	<cfcase value="/database.cfm">
		<cfset canonicalPath = "/database">
	</cfcase>
	<cfcase value="/view.cfm">
		<cfset canonicalPath = "/view-cart">
	</cfcase>
</cfswitch>

<cfif isDefined("pageTitle") AND len(trim(pageTitle))>
		<cfset seoTitle = trim(pageTitle)>
</cfif>
<cfif isDefined("pageDescription") AND len(trim(pageDescription))>
		<cfset seoDescription = trim(pageDescription)>
</cfif>
<cfif isDefined("pageKeywords") AND len(trim(pageKeywords))>
		<cfset seoKeywords = trim(pageKeywords)>
</cfif>
<cfif isDefined("pageRobots") AND len(trim(pageRobots))>
		<cfset seoRobots = trim(pageRobots)>
</cfif>
<cfif isDefined("pageCanonicalPath") AND len(trim(pageCanonicalPath))>
		<cfset canonicalPath = trim(pageCanonicalPath)>
</cfif>

<cfif len(canonicalPath) GT 1>
	<cfset canonicalPath = reReplace(canonicalPath, "/+$", "", "one")>
</cfif>

<cfif left(canonicalPath, 4) EQ "http">
		<cfset canonicalUrl = canonicalPath>
<cfelse>
		<cfif left(canonicalPath, 1) NEQ "/">
				<cfset canonicalPath = "/" & canonicalPath>
		</cfif>
		<cfset canonicalUrl = application.siteCanonicalBaseUrl & canonicalPath>
</cfif>

<cfoutput>
<meta name="description" content="#HTMLEditFormat(seoDescription)#">
<meta name="keywords" content="#HTMLEditFormat(seoKeywords)#">
<meta name="robots" content="#HTMLEditFormat(seoRobots)#">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
<link rel="canonical" href="#HTMLEditFormat(canonicalUrl)#">

<meta property="og:type" content="website">
<meta property="og:site_name" content="#HTMLEditFormat(application.siteName)#">
<meta property="og:title" content="#HTMLEditFormat(seoTitle)#">
<meta property="og:description" content="#HTMLEditFormat(seoDescription)#">
<meta property="og:url" content="#HTMLEditFormat(canonicalUrl)#">

<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="#HTMLEditFormat(seoTitle)#">
<meta name="twitter:description" content="#HTMLEditFormat(seoDescription)#">

<script type="application/ld+json">
{
	"@context": "https://schema.org",
	"@type": "Organization",
	"name": "#JSStringFormat(application.siteName)#",
	"url": "#JSStringFormat(application.siteCanonicalBaseUrl)#",
	"logo": "#JSStringFormat(application.siteCanonicalBaseUrl)#/img/djlogo.gif",
	"contactPoint": [{
		"@type": "ContactPoint",
		"telephone": "+1-305-932-6166",
		"contactType": "customer service"
	}],
	"sameAs": [
		"https://www.facebook.com/pages/GallArt/119056118127427"
	]
}
</script>
<script type="application/ld+json">
{
	"@context": "https://schema.org",
	"@type": "WebSite",
	"name": "#JSStringFormat(application.siteName)#",
	"url": "#JSStringFormat(application.siteCanonicalBaseUrl)#",
	"potentialAction": {
		"@type": "SearchAction",
		"target": "#JSStringFormat(application.siteCanonicalBaseUrl)#/artists/search/{search_term_string}",
		"query-input": "required name=search_term_string"
	}
}
</script>
</cfoutput>
