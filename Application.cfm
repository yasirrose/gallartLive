<cfapplication 
			   name="galleryart"
               clientmanagement="Yes"
               sessionmanagement="Yes"
               sessiontimeout="#CreateTimeSpan(0,6,0,0)#"
               applicationtimeout="#CreateTimeSpan(1,0,0,0)#">

<cfset application.dsource="gallartLive">
<cfset server_name="gallart.com">

<cfset COMPANYNAME="gallart">
<cfset dsource="gallartLive">
<cfset uname="admin">
<cfset pword="GAllart2022!!"> 
<cfset rootpath = "">
<cfset application.ppath = GetDirectoryFromPath(GetCurrentTemplatePath()) />
<cfset partner = "WEB">
<cfset batchproc = 0>
<cfset filelocation = "#application.ppath#gallart.com\vendors\pos\">
<cfset filemap = "/vendors/pos/">
<!--- if you wish to charge sales tax put in the appopriate state, and the amount of tax to charge.  Put in 6 for 6%, not .06 --->
<cfset taxst ="FL">
<cfset taxamount = "6.5">
<cfset shipopt = 1>
<cfset insurance = "10">

<cfset application.showSalePrice = 1 />

<cfset application.objectFactoryLeads = createObject('component','leads.models.objectFactory_app').init() />
<cfset application.objectFactory = createObject('component','orders.models.objectFactory_app').init() />
<cfset application.objectFactoryAdmin = createObject('component','admin.models.objectFactory_app').init() />
<cfset application.objectFactoryExtranet = createObject('component','extranet.models.objectFactory_app').init() />
<!--- 
1 = ship_weight * shipmult 
2 = Send to UPS for quote 
--->
<!--- Shipping will always be equal to or more than shipmin --->
<cfset shipmin = "25.00">
<!--- maximum for express air, this also shows on the airtable.cfm and is contained in the shippingoptions table as the expressair entry --->


<!--- shipmult is multiplies by the "shipweight" to get the base shipping charge --->
<cfset shipmult = "2">
<!--- set to 0 if you do not wish to insure OR insure amount will be added for each $100 after the first --->
<cfset insure = "0.35">
<!--- standard markup defaults. These will only be used if pricing fields in the products backoffice are left blank --->
<!--- <!--- from true cost, amount to mark up for "wholesale" --->
<cfset costmkup = "1.59">
<!--- from true cost, amount to mark up for "our web price" --->
<cfset webmkup = "2.25">
<!--- from truecost, amount to mark up for retail --->
<cfset retailmkup = "3.25"> --->

<cfif NOT structKeyExists(application, "encryptionKey")>
    <cfset application.encryptionKey = "k7vASHylotO9mtMuRTfa2g==">
</cfif>

<cfset imgpath = "https://#server_name#/images">

<!--- all emails will be sent to this email address. To add more, send to an alias and forward to additional accounts. If an address is put into cc, it will be sent as well --->
<cfset emailsupport = "websitegallart@gallart.com">
<cfset emailsupportcc = "KENGALLART@aol.com">
<!--- This should represent the page which should be used for secure processing.  set to a non secure page while developing, and change when ready --->
<cfset securepage = "https://#server_name#">
<cfset titletext="Buy and Sell - Peter Max, Andy Warhol, Tom Wesselmann">
<!--- When refering to the site, "sitename" is used. When refering to company, "companyname" is used --->
<cfset sitename = "#server_name#">
<cfset companyname="Gallart.com">

<cffunction name="seoReadableTitleValue" output="false" returntype="string">
	<cfargument name="value" required="false" default="">
	<cfset var label = trim("" & arguments.value)>

	<cfif NOT len(label)>
		<cfreturn "">
	</cfif>

	<cftry>
		<cfset label = urlDecode(label)>
		<cfcatch></cfcatch>
	</cftry>

	<cfset label = replace(label, "_", " ", "all")>
	<cfset label = replace(label, "-", " ", "all")>
	<cfset label = replace(label, ":", " - ", "all")>
	<cfset label = reReplace(label, "\s+", " ", "all")>

	<cfif listLen(label, ",") EQ 2>
		<cfset label = trim(listLast(label, ",")) & " " & trim(listFirst(label, ","))>
	</cfif>

	<cfreturn trim(label)>
</cffunction>

<cffunction name="seoListingTitleFilters" output="false" returntype="string">
	<cfset var filters = "">

	<cfif structKeyExists(url, "Subject") AND len(trim(url.Subject))>
		<cfset filters = listAppend(filters, "Subject: " & seoReadableTitleValue(url.Subject), " | ")>
	</cfif>
	<cfif structKeyExists(url, "Style") AND len(trim(url.Style))>
		<cfset filters = listAppend(filters, "Style: " & seoReadableTitleValue(url.Style), " | ")>
	</cfif>
	<cfif structKeyExists(url, "Size") AND len(trim(url.Size))>
		<cfset filters = listAppend(filters, "Size: " & seoReadableTitleValue(url.Size), " | ")>
	</cfif>
	<cfif structKeyExists(url, "Type") AND len(trim(url.Type))>
		<cfset filters = listAppend(filters, "Type: " & seoReadableTitleValue(url.Type), " | ")>
	</cfif>
	<cfif structKeyExists(url, "adv_artist") AND len(trim(url.adv_artist))>
		<cfset filters = listAppend(filters, "Artist: " & seoReadableTitleValue(url.adv_artist), " | ")>
	</cfif>
	<cfif structKeyExists(url, "adv_title") AND len(trim(url.adv_title))>
		<cfset filters = listAppend(filters, "Title: " & seoReadableTitleValue(url.adv_title), " | ")>
	</cfif>
	<cfif structKeyExists(url, "adv_year") AND len(trim(url.adv_year))>
		<cfset filters = listAppend(filters, "Year: " & seoReadableTitleValue(url.adv_year), " | ")>
	</cfif>
	<cfif structKeyExists(url, "adv_medium") AND len(trim(url.adv_medium))>
		<cfset filters = listAppend(filters, "Medium: " & seoReadableTitleValue(url.adv_medium), " | ")>
	</cfif>
	<cfif structKeyExists(url, "adv_price_range") AND len(trim(url.adv_price_range))>
		<cfset filters = listAppend(filters, "Price: " & seoReadableTitleValue(url.adv_price_range), " | ")>
	</cfif>

	<cfreturn filters>
</cffunction>

<cffunction name="seoListingDescriptionFilters" output="false" returntype="string">
	<cfset var filters = "">

	<cfif structKeyExists(url, "Subject") AND len(trim(url.Subject))>
		<cfset filters = listAppend(filters, "subject " & lCase(seoReadableTitleValue(url.Subject)), ", ")>
	</cfif>
	<cfif structKeyExists(url, "Style") AND len(trim(url.Style))>
		<cfset filters = listAppend(filters, "style " & lCase(seoReadableTitleValue(url.Style)), ", ")>
	</cfif>
	<cfif structKeyExists(url, "Size") AND len(trim(url.Size))>
		<cfset filters = listAppend(filters, "size " & lCase(seoReadableTitleValue(url.Size)), ", ")>
	</cfif>
	<cfif structKeyExists(url, "Type") AND len(trim(url.Type))>
		<cfset filters = listAppend(filters, "type " & lCase(seoReadableTitleValue(url.Type)), ", ")>
	</cfif>
	<cfif structKeyExists(url, "adv_artist") AND len(trim(url.adv_artist))>
		<cfset filters = listAppend(filters, "artist " & seoReadableTitleValue(url.adv_artist), ", ")>
	</cfif>
	<cfif structKeyExists(url, "adv_title") AND len(trim(url.adv_title))>
		<cfset filters = listAppend(filters, "title " & seoReadableTitleValue(url.adv_title), ", ")>
	</cfif>
	<cfif structKeyExists(url, "adv_year") AND len(trim(url.adv_year))>
		<cfset filters = listAppend(filters, "year " & seoReadableTitleValue(url.adv_year), ", ")>
	</cfif>
	<cfif structKeyExists(url, "adv_medium") AND len(trim(url.adv_medium))>
		<cfset filters = listAppend(filters, "medium " & lCase(seoReadableTitleValue(url.adv_medium)), ", ")>
	</cfif>
	<cfif structKeyExists(url, "adv_price_range") AND len(trim(url.adv_price_range))>
		<cfset filters = listAppend(filters, "price range " & seoReadableTitleValue(url.adv_price_range), ", ")>
	</cfif>

	<cfreturn filters>
</cffunction>

<cfif NOT reFindNoCase("^/admin(/|$)", cgi.script_name)>
	<cfset requestScript = lCase(listLast(cgi.script_name, "/"))>
	<cfset listingTitleFilters = seoListingTitleFilters()>
	<cfset listingDescriptionFilters = seoListingDescriptionFilters()>
	<cfset pageDescription = "Explore fine art, prints, and collectibles at Gallart, including buying, selling, and artist information.">

	<cfswitch expression="#requestScript#">
		<cfcase value="index.cfm">
			<cfset titletext = "Buy and Sell Fine Art Online">
			<cfset pageDescription = "Gallart offers curated fine art for buying and selling, featuring works by leading modern and contemporary artists.">
		</cfcase>
		<cfcase value="about.cfm">
			<cfset titletext = "About Gallart">
			<cfset pageDescription = "Learn about Gallart, our gallery, and our experience buying and selling modern and contemporary fine art.">
		</cfcase>
		<cfcase value="360_tour.cfm">
			<cfset titletext = "360 Gallery Tour">
			<cfset pageDescription = "Take a 360 degree tour of Gallart and explore the gallery space online.">
		</cfcase>
		<cfcase value="articles.cfm">
			<cfset titletext = "Fine Art Articles">
			<cfset pageDescription = "Read Gallart articles and insights about artists, artworks, and collecting fine art.">
		</cfcase>
		<cfcase value="artist_bio.cfm">
			<cfset titletext = "Artist Biography">
			<cfset pageDescription = "Read artist biography information and background details from Gallart.">
		</cfcase>
		<cfcase value="banner_listings.cfm">
			<cfset titletext = "Featured Banner Listings">
			<cfset pageDescription = "Browse featured Gallart banner listings and highlighted fine art selections.">
		</cfcase>
		<cfcase value="contact.cfm">
			<cfset titletext = "Contact Gallart">
			<cfset pageDescription = "Contact Gallart for questions about buying, selling, consigning, or locating fine art.">
		</cfcase>
		<cfcase value="chai_event.cfm">
			<cfset titletext = "Chai Lifeline Event">
			<cfset pageDescription = "Explore Gallart Chai Lifeline event details and featured artwork presentation information.">
		</cfcase>
		<cfcase value="products.cfm">
			<cfset titletext = "Artists and Fine Art for Sale">
			<cfset pageDescription = "Browse artists and fine art for sale at Gallart, including original works, prints, and collectible pieces.">
			<cfif structKeyExists(url, "man") AND len(trim(url.man))>
				<cfset titletext = seoReadableTitleValue(url.man) & " Art for Sale">
				<cfset pageDescription = "Browse " & seoReadableTitleValue(url.man) & " art for sale at Gallart, including original works, prints, and collectible fine art listings.">
			<cfelseif structKeyExists(url, "keywords") AND len(trim(url.keywords))>
				<cfset titletext = "Search Results for " & seoReadableTitleValue(url.keywords)>
				<cfset pageDescription = "Search Gallart for " & seoReadableTitleValue(url.keywords) & " and explore available fine art, prints, and collectibles online.">
			<cfelseif len(listingTitleFilters)>
				<cfset titletext = "Fine Art for Sale - " & listingTitleFilters>
				<cfset pageDescription = "Browse fine art for sale at Gallart filtered by " & listingDescriptionFilters & ".">
			</cfif>
		</cfcase>
		<cfcase value="item.cfm">
			<cfset titletext = "Artwork Details">
			<cfset pageDescription = "View artwork details, pricing, and availability for fine art offered by Gallart.">
			<cfif structKeyExists(url, "slug") AND len(trim(url.slug))>
				<cfset artworkTitle = seoReadableTitleValue(reReplace(url.slug, "-[0-9]+$", "", "one"))>
				<cfset titletext = artworkTitle>
				<cfset pageDescription = "View " & artworkTitle & " at Gallart, including artwork details, pricing, and availability information.">
				<cfif structKeyExists(url, "artist") AND len(trim(url.artist))>
					<cfset titletext = artworkTitle & " by " & seoReadableTitleValue(url.artist)>
					<cfset pageDescription = "View " & artworkTitle & " by " & seoReadableTitleValue(url.artist) & " at Gallart, including artwork details, pricing, and availability information.">
				</cfif>
			</cfif>
		</cfcase>
		<cfcase value="new_listings.cfm,recent_acquisitions.cfm">
			<cfif requestScript EQ "recent_acquisitions.cfm">
				<cfset titletext = "Recent Acquisitions Archive">
				<cfset pageDescription = "Browse the Gallart recent acquisitions archive and explore featured newly available artworks.">
			<cfelse>
				<cfset titletext = "Recent Acquisitions">
				<cfset pageDescription = "Explore recent fine art acquisitions at Gallart and discover newly available works.">
			</cfif>
			<cfif len(listingTitleFilters)>
				<cfset titletext = titletext & " - " & listingTitleFilters>
				<cfset pageDescription = "Explore recent fine art acquisitions at Gallart filtered by " & listingDescriptionFilters & ".">
			</cfif>
		</cfcase>
		<cfcase value="sales.cfm">
			<cfset titletext = "Fine Art on Sale">
			<cfset pageDescription = "Browse fine art on sale at Gallart, including discounted works and special offers.">
			<cfif len(listingTitleFilters)>
				<cfset titletext = titletext & " - " & listingTitleFilters>
				<cfset pageDescription = "Browse fine art on sale at Gallart filtered by " & listingDescriptionFilters & ".">
			</cfif>
		</cfcase>
		<cfcase value="classifieds.cfm">
			<cfset titletext = "Classified Art Listings">
			<cfset pageDescription = "Explore classified art listings from Gallart sellers, including fine art and collectible pieces.">
			<cfif len(listingTitleFilters)>
				<cfset titletext = titletext & " - " & listingTitleFilters>
				<cfset pageDescription = "Explore classified art listings from Gallart sellers filtered by " & listingDescriptionFilters & ".">
			</cfif>
		</cfcase>
		<cfcase value="alpha_list.cfm">
			<cfset titletext = "Artist Index">
			<cfset pageDescription = "Browse the Gallart artist index to explore available artists and fine art listings.">
			<cfif structKeyExists(url, "man") AND len(trim(url.man))>
				<cfset titletext = "Artists Starting With " & uCase(left(trim(url.man), 1))>
				<cfset pageDescription = "Browse Gallart artists starting with the letter " & uCase(left(trim(url.man), 1)) & " and explore available fine art listings.">
			</cfif>
		</cfcase>
		<cfcase value="featured_events.cfm">
			<cfset titletext = "Art Events">
			<cfset pageDescription = "Explore upcoming art events and special presentations from Gallart.">
		</cfcase>
		<cfcase value="new_user_registration.cfm">
			<cfset titletext = "Sell Your Art">
			<cfset pageDescription = "Learn how to sell your art through Gallart or request a direct purchase offer.">
		</cfcase>
		<cfcase value="user_registration.cfm">
			<cfset titletext = "Become a Seller">
			<cfset pageDescription = "Register as a Gallart seller and submit artwork details for review.">
		</cfcase>
		<cfcase value="buyer_info.cfm">
			<cfset titletext = "Buyer Information">
			<cfset pageDescription = "Review Gallart buyer information, including how to purchase artworks and what to expect.">
		</cfcase>
		<cfcase value="seller_info.cfm">
			<cfset titletext = "Seller Information">
			<cfset pageDescription = "Review Gallart seller information, including consignment and selling details.">
		</cfcase>
		<cfcase value="searchpage.cfm">
			<cfset titletext = "Search Fine Art">
			<cfset pageDescription = "Search Gallart for artists, artworks, mediums, and other fine art keywords.">
		</cfcase>
		<cfcase value="pns.cfm">
			<cfset titletext = "Privacy Policy">
			<cfset pageDescription = "Read Gallart's privacy policy and learn how customer information is handled.">
		</cfcase>
		<cfcase value="shippingpolicy.cfm">
			<cfset titletext = "Shipping Policy">
			<cfset pageDescription = "Review Gallart's shipping policy for artwork purchases and deliveries.">
		</cfcase>
		<cfcase value="termsuse.cfm">
			<cfset titletext = "Terms of Use">
			<cfset pageDescription = "Read Gallart's terms of use for browsing, buying, and selling on the site.">
		</cfcase>
		<cfcase value="alerts.cfm">
			<cfset titletext = "Art Alerts">
			<cfset pageDescription = "Sign up for Gallart art alerts and receive updates on listings and artists.">
		</cfcase>
		<cfcase value="alerts_info.cfm">
			<cfset titletext = "Alert Information">
			<cfset pageDescription = "Learn how Gallart art alerts work and what listing updates you can receive.">
		</cfcase>
		<cfcase value="alerts_registration.cfm">
			<cfset titletext = "Register for Art Alerts">
			<cfset pageDescription = "Register for Gallart art alerts to receive listing and artist notifications.">
		</cfcase>
		<cfcase value="requests.cfm">
			<cfset titletext = "Art Wanted Requests">
			<cfset pageDescription = "Browse art wanted requests from Gallart members and collectors.">
		</cfcase>
		<cfcase value="requests_info.cfm">
			<cfset titletext = "Request Information">
			<cfset pageDescription = "Learn how Gallart art requests work for buyers and sellers.">
		</cfcase>
		<cfcase value="requests_registration.cfm">
			<cfset titletext = "Request Registration">
			<cfset pageDescription = "Register to post or respond to Gallart art wanted requests.">
		</cfcase>
		<cfcase value="requests_submit.cfm">
			<cfset titletext = "Submit an Art Request">
			<cfset pageDescription = "Submit your art request to Gallart and let sellers respond.">
		</cfcase>
		<cfcase value="requests_thanks.cfm">
			<cfset titletext = "Request Submitted">
			<cfset pageDescription = "Your Gallart art request has been submitted successfully.">
		</cfcase>
		<cfcase value="quotes.cfm">
			<cfset titletext = "Fine Art Quotes">
			<cfset pageDescription = "Request fine art quotes and valuation information from Gallart.">
		</cfcase>
		<cfcase value="mailing_list.cfm">
			<cfset titletext = "Mailing List">
			<cfset pageDescription = "Join the Gallart mailing list for updates on art listings, events, and gallery news.">
		</cfcase>
		<cfcase value="user_login_page.cfm,sign_in.cfm">
			<cfif requestScript EQ "sign_in.cfm">
				<cfset titletext = "Seller Sign In">
				<cfset pageDescription = "Sign in to your Gallart seller account to manage listings and account activity.">
			<cfelse>
				<cfset titletext = "Account Login">
				<cfset pageDescription = "Sign in to your Gallart account to manage listings, requests, and purchases.">
			</cfif>
		</cfcase>
		<cfcase value="forgot_password.cfm">
			<cfset titletext = "Forgot Password">
			<cfset pageDescription = "Recover your Gallart account password and restore access to your account.">
		</cfcase>
		<cfcase value="register.cfm">
			<cfset titletext = "Create an Account">
			<cfset pageDescription = "Create a Gallart account to buy, sell, and manage fine art listings.">
		</cfcase>
		<cfcase value="review.cfm">
			<cfset titletext = "Order Review">
			<cfset pageDescription = "Review your Gallart order details before completing checkout.">
		</cfcase>
		<cfcase value="checkout.cfm,checkout_new.cfm">
			<cfset titletext = "Checkout">
			<cfif requestScript EQ "checkout_new.cfm">
				<cfset pageDescription = "Complete your Gallart checkout securely and submit your order details.">
			<cfelse>
				<cfset pageDescription = "Review checkout information for your Gallart purchase.">
			</cfif>
		</cfcase>
		<cfcase value="view.cfm">
			<cfset titletext = "View Cart">
			<cfset pageDescription = "Review the artworks currently in your Gallart shopping cart.">
		</cfcase>
		<cfcase value="database.cfm">
			<cfset titletext = "Art Database">
			<cfset pageDescription = "Browse the Gallart art database and explore available artists and artworks.">
		</cfcase>
		<cfcase value="database_search.cfm">
			<cfset titletext = "Database Search">
			<cfset pageDescription = "Search the Gallart art database for artists, works, and additional inventory details.">
		</cfcase>
		<cfcase value="epricing.cfm">
			<cfset titletext = "Artwork Pricing Request">
			<cfset pageDescription = "Request Gallart pricing information for artworks and review available fine art details.">
		</cfcase>
		<cfcase value="magnifier.cfm">
			<cfset titletext = "Artwork Image Magnifier">
			<cfset pageDescription = "Use the Gallart image magnifier to view artwork details more closely.">
		</cfcase>
		<cfcase value="make_offer.cfm">
			<cfset titletext = "Make an Offer">
			<cfset pageDescription = "Submit an offer to Gallart for an artwork you are interested in purchasing.">
		</cfcase>
		<cfcase value="make_offer_form.cfm">
			<cfset titletext = "Offer Form">
			<cfset pageDescription = "Complete the Gallart offer form to submit your proposed artwork purchase price.">
		</cfcase>
		<cfcase value="mail_log.cfm">
			<cfset titletext = "Mail Log">
			<cfset pageDescription = "Review Gallart mail log information and related customer communication details.">
		</cfcase>
		<cfcase value="overview.cfm">
			<cfset titletext = "Account Overview">
			<cfset pageDescription = "View your Gallart account overview, activity, and saved listing information.">
		</cfcase>
		<cfcase value="purchases_consignments.cfm">
			<cfset titletext = "Purchases and Consignments">
			<cfset pageDescription = "Learn about Gallart purchases and consignments for fine art sellers and collectors.">
		</cfcase>
		<cfcase value="showroom.cfm">
			<cfset titletext = "Gallery Showroom">
			<cfset pageDescription = "Explore the Gallart showroom and featured fine art presentations.">
		</cfcase>
		<cfcase value="red_dot.cfm">
			<cfset titletext = "Red Dot Collection">
			<cfset pageDescription = "Explore the Gallart red dot collection and featured available artworks.">
		</cfcase>
		<cfcase value="sns.cfm">
			<cfset titletext = "Social Media Sharing">
			<cfset pageDescription = "Explore Gallart social sharing and online fine art engagement resources.">
		</cfcase>
		<cfcase value="two_shows.cfm">
			<cfset titletext = "Two Shows">
			<cfset pageDescription = "Explore Gallart two shows information and featured exhibition details.">
		</cfcase>
		<cfcase value="user_listing_detail.cfm">
			<cfset titletext = "Manage Listing Details">
			<cfset pageDescription = "Manage your Gallart listing details, images, and artwork information.">
		</cfcase>
		<cfcase value="user_listing_results.cfm">
			<cfset titletext = "Listing Results">
			<cfset pageDescription = "Review your Gallart listing results and matching artwork entries.">
		</cfcase>
		<cfcase value="user_listing_search.cfm">
			<cfset titletext = "Search Your Listings">
			<cfset pageDescription = "Search your Gallart listings and review saved artwork information.">
		</cfcase>
		<cfcase value="user_registration_thanks.cfm">
			<cfset titletext = "Registration Complete">
			<cfset pageDescription = "Your Gallart registration is complete and your account setup has been received.">
		</cfcase>
		<cfcase value="framing.cfm">
			<cfset titletext = "Custom Framing">
			<cfset pageDescription = "Learn about Gallart custom framing options for fine art and collectibles.">
		</cfcase>
		<cfcase value="framing2.cfm">
			<cfset titletext = "Framing Services">
			<cfset pageDescription = "Explore Gallart framing services for artwork presentation and protection.">
		</cfcase>
		<cfcase value="framing_details.cfm">
			<cfset titletext = "Framing Details">
			<cfset pageDescription = "Review Gallart framing details, options, and presentation information.">
		</cfcase>
		<cfcase value="guarantee.cfm">
			<cfset titletext = "Guarantee">
			<cfset pageDescription = "Read the Gallart guarantee for artwork purchases and customer confidence.">
		</cfcase>
		<cfcase value="promotion.cfm">
			<cfset titletext = "Promotion">
			<cfset pageDescription = "Explore current Gallart promotions and special fine art offers.">
		</cfcase>
		<cfcase value="artbasel.cfm">
			<cfset titletext = "Art Basel Collection">
			<cfset pageDescription = "Explore Gallart's Art Basel collection and featured works.">
		</cfcase>
		<cfcase value="campaign.cfm">
			<cfset titletext = "Fine Art Campaign">
			<cfset pageDescription = "Explore featured Gallart fine art campaign highlights and selected works.">
		</cfcase>
		<cfcase value="guests.cfm">
			<cfset titletext = "Guest Book">
			<cfset pageDescription = "Read comments and feedback from Gallart guests and customers.">
		</cfcase>
		<cfcase value="sitemap.xml">
			<cfcontent type="application/xml; charset=UTF-8" reset="true">
			<cfinclude template="sitemap.xml">
			<cfabort>
		</cfcase>

		<cfcase value="llms.txt">
			<cfcontent type="text/plain; charset=UTF-8" reset="true">
			<cfinclude template="llms.txt">
			<cfabort>
		</cfcase>
	</cfswitch>
</cfif>

<cfset caddress = "20633 Biscayne Blvd">
<cfset csz = "Aventura, FL 33180">
<cfset czip = "33180">
<cfset cphone = "305-932-6166">
<cfset footmess = "Gallery Art Online">
<Cfset addbutton = "/img/add.gif">
<cfset sidecolor ="cccccc">
<cfset centercolor ="ffffff">
<cfset displaycolor ="222222">
<cfset uploaddir = "#application.ppath#img">
<!--- FOR CFC ACCESS --->
<cfset application.uploaddir = "#application.ppath#img">
<cfset we_uploaddir = "#application.ppath#weimg\">
<cfset we_uploadweb = "https://#server_name#/weimg/">
<cfset uploaddirweb = "https://#server_name#/img">
<!--- If you want the email a friend option Put 'Y', else put 'N' --->
<cfset efriend = 'Y'>

<cfset vendoradd = "y">

<cfif NOT structKeyExists(session, "xss")>
	<!--- Generate a unique tracking ID --->
	<cfset session.xss = randrange(1,9999) & chr(randrange(65,90)) & randrange(1,9999)>

	<!--- Insert tracking data into database --->
	<cfquery name="insertTrack" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		INSERT INTO tracker(sessionid, referrer, entrypage, originIP)
		 VALUES (
			<cfqueryparam value="#session.xss#" cfsqltype="cf_sql_varchar">, 
			 <cfqueryparam value="#cgi.http_referer#" cfsqltype="cf_sql_varchar">,
			<cfqueryparam value="#cgi.path_info#" cfsqltype="cf_sql_varchar">, 
			<cfqueryparam value="#cgi.remote_addr#" cfsqltype="cf_sql_varchar">
			)
	</cfquery>
</cfif>


<cfif isDefined('url.emailLogId')>
	<cfquery name="insertTrack" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		INSERT INTO email_tracker
		(
			fk_email_log,
			referrer, 
			entrypage, 
			originIP
		) 
		VALUES
		(
			'#url.emailLogId#', 
			'#cgi.http_referer#', 
			'#cgi.path_info#', 
			'#cgi.remote_addr#'
		)
	</cfquery>
</cfif>

<cfquery name="cleanTracker" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	DELETE from tracker
WHERE createdon < '#DateFormat(createodbcdate(DateAdd('w',-1,now())))#'
</cfquery>

<!--- <cfparam name="flashow" default="siteflash"> --->
<!--- for mails sent from main site (contact forms, etc) --->

<!--- Change the SMTP Server 21 may 2025 --->
<!--- <cfset servername = "mail2.onlinegalleryart.com" /> --->
<cfset servername = "smtp.gmail.com" />

<!--- email blast server --->
<cfset application.email_server = "mail2.gallart.com" />
<cfset application.email_username = "info@onlinegalleryart.us" />
<cfset application.email_password = "22kenhen" />
<cfset application.email_from = "info@onlinegalleryart.us" />

<!--- TEMP: blast from web server --->
<!--- <cfset application.email_server = "mail2.onlinegalleryart.com" />
<cfset application.email_username = "onli16@onlinegalleryart.com" />
<cfset application.email_password = "re3objec" />
<cfset application.email_from = "info@gallart.com" /> --->

<!--- LinkPoint Global Settings --->
<cfset merchuname="">
<cfset merchantpass="">
<cfset KeyFile ="">
<cfset HostAddr = "">
<Cfset PORT = "1139">
<!--- LP Mode --->
<!--- 0: Run transactions in LIVE mode, transaction charges apply --->
<!--- 1: Run transactions in TEST mode, no transaction charges --->
<!--- 2: Return a duplicate transaction result --->
<!--- 3: Return a decline transaction result --->
<CFSET MODE = 1> 
<cfset sitecolor = "777777">
<cfset ImgFile = "http://3.235.23.60/img/djlogo.gif">

<cfset adminuname="kengallart@aol.com">
<cfset adminpass="DsT48c">

<cfset biouname="PrvtSpace@aol.com">
<cfset biopass="bioentry">



<cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	delete from tracker
	where createdon < #dateadd('m',-1,createodbcdate(now()))#
</cfquery>


<cfinclude template="functions.cfm">

<!--- SET THESE VARIABLES FOR LEAD SYSTEM - CONFIGBEAN --->

<cfscript>
	application.dsource='gallartLive';
	application.dbuname='admin';
	application.dbpword='GAllart2022!!';
	application.rootpath='';
	application.vmap='';
	application.mailserver='mail2.onlinegalleryart.com';
</cfscript>

<!--- mailserver for web --->

<!--- re3objec --->


<!--- <cfscript>
	application.mailserver='mail2.onlinegalleryart.com';
	application.mailserver_un='gallart@onlinegalleryart.com';
	application.mailserver_pw='re3objeC!P';
</cfscript> --->

<!--- <cfscript>
	application.mailserver='smtp.sendgrid.net';
	application.mailserver_un='apikey';
	application.mailserver_pw='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';
</cfscript> --->
<cfscript>
	application.mailserver='smtp.gmail.com';
	application.mailserver_un='Sales@GallArt.com';
	// application.mailserver_pw='ylzwtvepstcsammm';
	application.mailserver_pw='nrsnmsnwgdcfiavj';
</cfscript>
