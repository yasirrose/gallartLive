<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<cfparam name="xss" default="">
<html>
<head>
<cfoutput>
<title>#companyname# - #titletext#</title>
</cfoutput>

<cfinclude template="meta.cfm">
<link rel="shortcut icon" href="favicon.ico" >
<cfoutput>
	<link href="./css/photogallery.css" rel="stylesheet" type="text/css">
	<script language="JavaScript" src="./js/utils.js"></script>
	<script type="text/javascript" src="./js/jquery-1.2.6.min.js"></script>
	<script type="text/javascript" src="./js/jquery.bgpos.js"></script>
	<script type="text/javascript" src="./js/jquery.cross-slide.js"></script>
    <script language="JavaScript" src="./js/slimbox2.js"></script>
	<link href="./css/slimbox2.css" rel="stylesheet" type="text/css">
</cfoutput>
<cfquery name="qSlideshow" datasource="#application.dsource#">
    SELECT UID FROM products P
	WHERE slideshow = 1
</cfquery>
<script>
 $(function() {
 	if ( $('#slideshow').length ){
		$('#slideshow').crossSlide({
		  sleep: 2,
		  fade: 1
		}, [
		<cfoutput query="qSlideshow">
		  { src: 'http://#server_name#/img/thumbnails/#uid#.jpg' }<cfif currentrow LT qSlideshow.recordcount>,</cfif>
		</cfoutput>
		]);
	}
});
</script>


<link href="stylesheet.css?x=<cfoutput>#RandRange(0,100)#</cfoutput>" rel="stylesheet" type="text/css">
<script type="text/javascript">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-34565365-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'https://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>

<!-- BEGIN ROBLY WIDGET CODE -->
<script type='text/javascript'>
  var _d_site = _d_site || 'ebb8c5f7da7077e127988b3276107648';
  (function(w, d, p, s, s2) {
    w[p] = w[p] || function() { (w[p].q = w[p].q || []).push(arguments) };
    s = d.createElement('script'); s.async = 1; s.src = '//s3.amazonaws.com/roblyimages/accounts/20559/forms/29541/signup_popup.js';
    s2 = d.getElementsByTagName('script')[0]; s2.parentNode.insertBefore(s, s2);
  })(window, document, 'Robly');
</script>
<!-- END ROBLY WIDGET CODE -->

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="100%" height="125" valign="top" bgcolor="#000000">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="100%" valign="top" height="37" bgcolor="#000000">
			<cfinclude template="navbar.cfm">
		</td>
	</tr>
	<tr height="100%">
		<td valign="top" width="173" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%">
				<tr height="100%">
					<td valign="top" height="100%">	
						<cfinclude template="left.cfm">
					</td>
				</tr>
			</table>
		</td>
		<td valign="top" width="727" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top" style="width: 50%;">	
						<cfinclude template="search.cfm">
					</td>
					<td valign="top" style="padding-top: 10px;">
						<form action="360_tour.cfm" style="margin-bottom: 2px;">
						    <input type="submit" value="Click To Take A 360 Virtual Tour" style="background-color: #dd3a7d; color: #ffffff; font-weight: bold; font-size: 10px; padding: 6px; cursor: pointer;" />
						</form>
						<div>
							<a href="360_tour.cfm"><img src="/images/gallart_front.jpg" style="width: 176px;" alt="" border="0"></a>
						</div>
					</td>
					<td style="padding: 20px 0 0 0;">
						<div id="slideshow"></div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-left: 25px;">
						<iframe src="https://www.facebook.com/plugins/like.php?href=https%3A%2F%2Fwww.facebook.com%2Fpages%2FGallArt%2F119056118127427&amp;layout=standard&amp;show_faces=false&amp;width=450&amp;action=like&amp;colorscheme=light&amp;height=35" scrolling="no" frameborder="0" style="border:none; overflow:hidden; width:400px; height:35px;" allowTransparency="true"></iframe>
					</td>
				</tr>
				<tr height="100%">
					<td height="100%" valign="top" colspan="2">	
                    	<table border="0" width="100%">
                    		<tr>
								<td valign="top" align="center">
									<cfquery name="getCampaign" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
										select * from campaign
										where active = 1
									</cfquery>
									<cfif getCampaign.recordcount>

										<a href="campaign.cfm?xss=<cfoutput>#xss#</cfoutput>"><img src="https://<cfoutput>#server_name#</cfoutput>/admin/views/campaign/icons/campaign-icon-<cfoutput>#getCampaign.pk_campaign#</cfoutput>.png?x=#RandRange(0,100)#" border="0" style="-moz-border-radius: 15px;
			border-radius: 20px; border: 5px solid ##000;" /></a>
			                        	<br /><br />
									</cfif>	
								</td>
							</tr>
                        	<tr>
                                <td valign="top" align="center">
                                	<div style="width: 1000px; margin-bottom: 50px;">
                                		<cfoutput>
                                		<table id="Table_01" width="100%" height="205" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td>
													<a href="./banner_listings.cfm?listing=popart<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/pop_art.jpg" width="142" height="205" alt="" border="0"></a></td>
												<td>
													<img src="/images/banner_listings/banner_listings_02.jpg" width="22" height="205" alt=""></td>
												<td>
													<a href="./banner_listings.cfm?listing=traditional<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/traditional.jpg" width="150" height="205" alt=""></a></td>
												<td>
													<img src="/images/banner_listings/banner_listings_04.jpg" width="22" height="205" alt=""></td>
												<td>
													<a href="./banner_listings.cfm?listing=modernmasters<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/modern_masters.jpg" width="151" height="205" alt=""></a></td>
												<td>
													<img src="/images/banner_listings/banner_listings_06.jpg" width="21" height="205" alt=""></td>
												<td>
													<a href="./banner_listings.cfm?listing=urbanart<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/urban_art.jpg" width="144" height="205" alt=""></a></td>
												<td>
													<img src="/images/banner_listings/banner_listings_08.jpg" width="21" height="205" alt=""></td>
												<td>
													<a href="./banner_listings.cfm?listing=abstract<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/abstract.jpg" width="151" height="205" alt=""></a></td>
												<td>
													<img src="/images/banner_listings/banner_listings_10.jpg" width="22" height="205" alt=""></td>
												<td>
													<a href="./banner_listings.cfm?listing=latinamerican<cfif parameterexists(xss)>&xss=#xss#</cfif>"><img src="/images/banner_listings/latin_american.jpg" width="154" class="test" height="205" alt=""></a></td>
											</tr>
										</table>
										</cfoutput>
									</div>
									<!--- <div style="width: 800px;">
										
										<table border="0" width="100%">
	                                        <tr>
	                                            <td valign="top">
	                                                <a href="showroom.cfm?xss=<cfoutput>#xss#</cfoutput>">
	                                                    <img src="images/Frontcamera.png" width="125" alt="View Front Camera" border="0">
	                                                </a>
	                                            </td>
	                                            <td align="center">
	                                            	<table>
	                                            		<tr>
	                                            			<td align="center" style="padding: 0 0 10px;">
	                                            				<a href="framing2.cfm?xss=<cfoutput>#xss#</cfoutput>" style="font-size: 30px; font-weight: bold;">SEE GALLERY LIVE</a>
                                            				</td>
                                        				</tr>
                                        				<tr>
                                        					<td>
                                        						<a href="framing2.cfm?xss=<cfoutput>#xss#</cfoutput>">
				                                                    <img src="images/one_click.png" alt="View Center Camera" border="0">
				                                                </a>
				                                            </td>
				                                        </tr>
				                                        <tr>
	                                            			<td align="center" style="padding: 10px 0 20px;">
	                                            				<a href="framing2.cfm?xss=<cfoutput>#xss#</cfoutput>" style="font-size: 30px; font-weight: bold;">Zoom  -  Pan  -  360&deg;</a>
                                            				</td>
                                        				</tr>
                                    				</table>
	                                            </td>
	                                            <td align="right" valign="top">
	                                                <a href="framing2.cfm?xss=<cfoutput>#xss#</cfoutput>">
	                                                    <img src="images/centercamera.png" width="125" alt="View Center Camera" border="0">
	                                                </a><br>
	                                                
	                                            </td>	
	                                         </tr>
	                                    </table>
									</div> --->
           						
                                </td>
                                
                         	</tr>
                         	<!--- <tr>
                         		<td style="padding: 0 0 20px; font-style: italic; font-size: 18px; font-weight: bold;" valign="top" align="center">
                         			All artwork listed on <a style="font-style: italic; font-size: 18px; font-weight: bold; color: #db3a7d;" href="http://www.gallart.com">GallArt.com</a> is available for a LIVE viewing. <br />
                         			Call <a style="font-style: italic; font-size: 18px; font-weight: bold; color: #db3a7d;" href="tel:3059326166">305.932.6166</a> or email <a style="font-style: italic; font-size: 18px; font-weight: bold; color: #db3a7d;" href="mailto:sales@GallArt.com">sales@GallArt.com</a>
                         		</td>
                         	</tr>
                         	<tr>
                         		<td style="padding: 0 0 30px; font-style: italic; font-size: 18px; font-weight: bold;" valign="top" align="center">
                         			Our simple, Interactive HD Video Technology allows you to visit our Gallery <br/> from the convenience of your own computer or mobile device.
                         		</td>
                         	</tr> --->
                      	</table>
					</td>
				</tr>
				
				<tr>
					<td valign="top" colspan="2" align="center">
						<cfinclude template="center_featured.cfm">	
					</td>
				</tr>
				<tr>
					<td valign="top" colspan="2" align="center" style="margin-top: 30px;">
						<cfinclude template="home_page_content.cfm">	
					</td>
				</tr>
				<tr>
					<td valign="top" colspan="2" align="center" style="margin-top: 30px;">
						<cfinclude template="company.cfm">	
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" valign="baseline">
			<cfinclude template="footer.cfm">
		</td>
	</tr>
</table>
<div itemscope itemtype="https://schema.org/ArtGallery" class="desc">
    <h1 itemprop="name">Gallery Art - Buying & Selling Fine Art & Collections</h1>
    <span itemprop="url"><a href="http://www.gallart.com">Gallart.com</a></span>
    <span itemprop="description">Fine Art, Buy/Sell, 8,000 Sq, Ft. Showroom. Works by Warhol, Lichtenstein, Wesselmann, Indiana, Picasso, Chagall, Haring, Max, Britto, Neiman &amp; more</span>
    <span itemprop="address">20633 Biscayne Blvd, Aventura, FL 33180</span>
    <span itemprop="telephone">305.932.6166</span>
    <span itemprop="email">info@gallart.com</span>
</div>
<cfinclude template="frmxss.cfm">

</body>
</html>
