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
	<link href="http://#server_name#/css/photogallery.css" rel="stylesheet" type="text/css">
	<script language="JavaScript" src="http://#server_name#/js/utils.js"></script>
	<script type="text/javascript" src="http://#server_name#/js/jquery-1.2.6.min.js"></script>
	<script type="text/javascript" src="http://#server_name#/js/jquery.bgpos.min.js"></script>
	<script type="text/javascript" src="http://#server_name#/js/jquery.cross-slide.min.js"></script>
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


<link href="stylesheet.css" rel="stylesheet" type="text/css">

</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="900" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td colspan="2" width="900" height="125" valign="top">
			<cfinclude template="top.cfm">
		</td>
	</tr>
	<tr>
		<td colspan="2" width="900" valign="top" height="37" bgcolor="#000000;">
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
		<td valign="top" width="100%" height="100%">
			<table border="0" cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td valign="top" width="627">	
						<cfinclude template="search.cfm">
					</td>
					<td align="center" style="padding: 20px 0 0 0;">
						<div id="slideshow"></div>
					</td>
				</tr>
				<tr height="100%">
					<td height="100%" valign="top" colspan="2" align="center">	
						<cfinclude template="home_page_content.cfm">
					</td>
				</tr>
				<tr>
					<td valign="top" colspan="2">
						<cfinclude template="center_featured.cfm">	
					</td>
				</tr>
				<tr>
					<td valign="top" colspan="2">
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

<cfinclude template="frmxss.cfm">

</body>
</html>