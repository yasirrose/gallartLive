<!-- MMDW:beginning --><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!--MMDW 0 --><cfparam name="xss" default=""><!--MMDW 1 -->
<html>
<head>
<!--MMDW 2 --><cfoutput><!--MMDW 3 -->
<title><!--MMDW 4 -->#companyname#<!--MMDW 5 --> - <!--MMDW 6 -->#titletext#<!--MMDW 7 --></title>
<!--MMDW 8 --></cfoutput><!--MMDW 9 -->

<!--MMDW 10 --><cfinclude template="meta.cfm"><!--MMDW 11 -->

<!--MMDW 12 --><cfoutput><!--MMDW 13 -->
<!--MMDW 14 --><script language="JavaScript" src="http://#server_name#/js/utils.js"></script><!--MMDW 15 -->
<!--MMDW 16 --><script language="JavaScript" src="http://#server_name#/js/jquery-1.2.6.min.js"></script><!--MMDW 17 -->
<!--MMDW 18 --><script language="JavaScript" src="http://#server_name#/js/magnifier.js"></script><!--MMDW 19 -->
<!--MMDW 20 --><script language="JavaScript" src="http://#server_name#/js/slimbox2.js"></script><!--MMDW 21 -->
<link mmdw="0"  href="http://#server_name#/css/slimbox2.css" rel="stylesheet" type="text/css">
<!--MMDW 22 --></cfoutput><!--MMDW 23 -->

<!--MMDW 24 --><script type="text/javascript">
	$(function() {
		$("p img").each(function() {
			$(this).hide().load(function(){
				$(this).magnify().fadeIn("fast");
			});
		});
	});
</script><!--MMDW 25 -->

<!--MMDW 26 --><style type="text/css">
p {
	width:400px;
	margin:50px;
	float:left;
}
#huy-magnifier {
	width:300px;
	height:200px;
	border:1px solid #000;
}
</style><!--MMDW 27 -->



<link mmdw="1"  href="stylesheet.css" rel="stylesheet" type="text/css">


</head>
<body mmdw="2"  bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<!--MMDW 28 --><!--- Add Edit or Delete this Item from the Cart ---><!--MMDW 29 -->
<!--MMDW 30 --><cfif parameterexists(process)><!--MMDW 31 -->
	<!--MMDW 32 --><cfif process is "Add" and qty gt 0><!--MMDW 33 -->
		<!--MMDW 34 --><cfset opt_name=""><!--MMDW 35 -->
		<!--MMDW 36 --><cfset opt_value=""><!--MMDW 37 -->
		<!--MMDW 38 --><cfquery name="addtocart" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
		Insert into cart (qty, pid, trackerid,charge,options,optionvalues)values(#qty#, '#pid#', '#xss#', #charge#,'#opt_name#','#opt_value#')
		</cfquery><!--MMDW 39 -->
		
		<!--MMDW 40 --><cflocation url="checkout_new.cfm?xss=#xss#" addtoken="No"><!--MMDW 41 -->
	<!--MMDW 42 --></cfif><!--MMDW 43 -->
<!--MMDW 44 --></cfif><!--MMDW 45 -->
<!--MMDW 46 --><!--- End of Add Items to Cart ---><!--MMDW 47 -->
<!--MMDW 48 --><!--- Gather Product Information for product(s) ---><!--MMDW 49 -->
<!--MMDW 50 --><cfquery name="productinfo" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
SELECT path as pathstring, substring(path, 1, PATINDEX('%:%', path)-1) as ccat,*
FROM products where uid  = '#pid#' 
<cfif NOT isDefined('url.sellerlisting')>
	AND active = 1
</cfif> 
And (path <> '') AND (path IS NOT NULL)
</cfquery><!--MMDW 51 -->

<!--MMDW 52 --><cfquery name="bio_info" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
    SELECT * from bios
	WHERE artist = '#productinfo.manufacturer#'
</cfquery><!--MMDW 53 -->

<!--MMDW 54 --><!--- Search Individual Items ---><!--MMDW 55 -->

<!--MMDW 56 --><cfquery name="prodnav" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
	SELECT substring(path, 1, PATINDEX('%:%', path)-1) as ccat, uid FROM products 
	WHERE active = 1 And (path <> '') 
	AND (path IS NOT NULL)
	<cfif isDefined('keywords')>
		AND (name like '%#keywords#%' or caption like '%#keywords#%' or modelno like '#keywords#%')
	<cfelseif isDefined('fam')>
		AND family = '#fam#'
	<cfelseif isDefined('man')>
		AND manufacturer like '#man#%'
	<cfelseif isDefined('manufact')>
		AND manufacturer like '#manufact#%'
	<cfelseif isDefined('cat')>
		AND path like '%#cat#%'
	</cfif>
	ORDER by ccat, gallery_price
</cfquery><!--MMDW 57 -->

<!--MMDW 58 --><cfset prodlist = ""><!--MMDW 59 -->
<!--MMDW 60 --><cfloop query="prodnav"><!--MMDW 61 -->
<!--MMDW 62 --><cfset prodlist = #ListAppend(prodlist, uid)#><!--MMDW 63 -->
<!--MMDW 64 --></cfloop><!--MMDW 65 -->
<table mmdw="3"  id="Table_01" width="800" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td mmdw="4"  colspan="2" width="800" height="125" valign="top">
			<!--MMDW 66 --><cfinclude template="top.cfm"><!--MMDW 67 -->
		</td>
	</tr>
	<tr>
		<td mmdw="5"  colspan="2" width="800" valign="top" height="37">
			<!--MMDW 68 --><cfinclude template="navbar.cfm"><!--MMDW 69 -->
		</td>
	</tr>
	<tr mmdw="6"  height="100%">
		<td mmdw="7"  valign="top" height="100%">
			<!--MMDW 70 --><!--- content starts ---><!--MMDW 71 -->
			
			<table mmdw="8"  border="0" cellpadding="0" cellspacing="0" width="100%" style="padding-top: 10px;">
					
				<!--MMDW 72 --><cfoutput><!--MMDW 73 -->		
				<tr>
					<td mmdw="9"  width="453" height="16" bgcolor="#centercolor#" align="center">&nbsp;</td>
					<td mmdw="10"  width="207" height="16" bgcolor="#centercolor#" align="center"><font mmdw="11"  face="verdana, arial, helvetica" size="2" color="#displaycolor#"><b>Art ID:</b>&nbsp;<!--MMDW 74 -->#productinfo.modelno#<!--MMDW 75 --></td>
				</tr>		
				<!--MMDW 76 --></cfoutput><!--MMDW 77 -->	
				<tr>
					<td mmdw="12"  width="453" height="100%" align="center" valign="top">
					
					<!--MMDW 78 --><!--- Product info ---><!--MMDW 79 -->
					<table mmdw="13"  width="450" height="400" cellpadding="3" cellspacing="3" border="0">
					<!--MMDW 80 --><cfoutput query="productinfo"><!--MMDW 81 -->
						<tr mmdw="14"  bgcolor="#centercolor#">
							<td mmdw="15"  valign="top" colspan="3" width="450">
							<!--MMDW 82 --><cfif fileexists("#expandpath('.')#\img\#uid#.jpg")><!--MMDW 83 -->
								<img mmdw="16"  src="http://#server_name#/img/#uid#.jpg" border="2" width="300"><br>
								<a mmdw="17"  href="http://#server_name#/img/#uid#.jpg" rel="lightbox" title="#productinfo.name# - #ucase(manufacturer)#">[CLICK]</a> to view large image size in separate window.
							<!--MMDW 84 --><cfelse><!--MMDW 85 -->
								<div mmdw="18"  align="center" style="padding: 20px;">NO IMAGE AVAILABLE</div>
							<!--MMDW 86 --></cfif><!--MMDW 87 -->
								<table mmdw="19"  cellpadding="3" cellspacing="0" border="0" width="100%">
									<tr>
										<td mmdw="20"  colspan=2><br></td>
									</tr>
									<tr>
										<td mmdw="21"  width="50%"><!--MMDW 88 --><cfif productinfo.manufacturer gt 0><!--MMDW 89 --><font mmdw="22"  size="1" face="arial, helvetica"><h1>Artist: <!--MMDW 90 -->#ucase(manufacturer)#<!--MMDW 91 --></h1><!--MMDW 92 --></cfif><!--MMDW 93 --></td>
										<td mmdw="23"  width="50%"><!--MMDW 94 --><cfif productinfo.name gt 0><!--MMDW 95 --><font mmdw="24"  size="1" face="arial, helvetica">Title: <!--MMDW 96 -->#productinfo.name#<!--MMDW 97 --><!--MMDW 98 --></cfif><!--MMDW 99 --></td>
									</tr>
									
									<tr>
										<td><!--MMDW 100 --><cfif productinfo.retail_price gt 0><!--MMDW 101 --><font mmdw="25"  size="1" face="arial, helvetica">Retail Price: <!--MMDW 102 -->#DollarFormat(productinfo.retail_price)#<!--MMDW 103 --><!--MMDW 104 --></cfif><!--MMDW 105 --></td>
										<td>
											<font mmdw="26"  size="1" face="arial, helvetica">
											<!--MMDW 106 --><cfif productinfo.closeout eq 1 and productinfo.special_price gt 0><!--MMDW 107 -->
												<span mmdw="27"  style="color: ####ff0000;">Sale Price: <!--MMDW 108 -->#DollarFormat(productinfo.special_price)#<!--MMDW 109 --></span>
											<!--MMDW 110 --><cfelseif productinfo.gallery_price gt 0><!--MMDW 111 -->																														Gallery Price: <!--MMDW 112 -->#DollarFormat(productinfo.gallery_price)#<!--MMDW 113 -->
											<!--MMDW 114 --></cfif><!--MMDW 115 -->
											</font>
										</td>
									</tr>
									
									<tr>
										<td><!--MMDW 116 --><cfif productinfo.size gt 0><!--MMDW 117 --><font mmdw="28"  size="1" face="arial, helvetica">Size: <!--MMDW 118 -->#productinfo.size#<!--MMDW 119 --> INCHES<!--MMDW 120 --></cfif><!--MMDW 121 --></td>
										<td><!--MMDW 122 --><cfif productinfo.year gt 0><!--MMDW 123 --><font mmdw="29"  size="1" face="arial, helvetica">Year: <!--MMDW 124 -->#productinfo.year#<!--MMDW 125 --><!--MMDW 126 --></cfif><!--MMDW 127 --></td>
									</tr>
									
									<!--MMDW 128 --><cfset medium = replace(RemoveChars(path,len(path), 1),":","/","all")><!--MMDW 129 -->
									<tr>
										<td><!--MMDW 130 --><cfif medium gt 0><!--MMDW 131 --><font mmdw="30"  size="1" face="arial, helvetica">Medium: <!--MMDW 132 -->#medium#<!--MMDW 133 --><!--MMDW 134 --></cfif><!--MMDW 135 --></td>
										<td><!--MMDW 136 --><cfif edition gt 0><!--MMDW 137 --><font mmdw="31"  size="1" face="arial, helvetica">Edition: <!--MMDW 138 -->#edition#<!--MMDW 139 --><!--MMDW 140 --></cfif><!--MMDW 141 --></td>
									</tr>
									
									<tr>
										<td mmdw="32"  colspan=2><!--MMDW 142 --><cfif caption gt 0><!--MMDW 143 --><font mmdw="33"  size="1" face="arial, helvetica">Description: <!--MMDW 144 -->#trim(caption)#<!--MMDW 145 --><!--MMDW 146 --></cfif><!--MMDW 147 --></td>
									</tr>
									<!--MMDW 148 --><cfif isDefined('bio_info') and bio_info.recordcount><!--MMDW 149 -->
									<tr>
										<td>
											<a mmdw="34"  href="artist_bio.cfm?bioId=#bio_info.pk_bios#">VIEW ARTIST BIO</a>
										</td>
									</tr>
									<!--MMDW 150 --></cfif><!--MMDW 151 -->
								</table>
							</td>
						</tr>
						<!--MMDW 152 --></cfoutput><!--MMDW 153 -->
				
					</td>
				</tr>
				<!--MMDW 154 --><cfquery name="showitems" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					select cart.options as opt,cart.optionvalues as val,* from cart,products where trackerid='#xss#' and cart.pid = products.modelno
					</cfquery><!--MMDW 155 -->
				<tr>
					<Td mmdw="35"  colspan="3">
					<!--MMDW 156 --><!--- Product Info ---><!--MMDW 157 -->
					<!--MMDW 158 --><cfoutput query="showitems"><!--MMDW 159 -->
						<table>
							<tr>
								<td><font mmdw="36"  size="1" face="arial, helvetica"><!--MMDW 160 -->#name#<!--MMDW 161 --></font>
								</td>
							</tr>
							<tr>
								<td><font mmdw="37"  size="1" face="arial, helvetica">Product Number:  <!--MMDW 162 -->#pid#<!--MMDW 163 --></font>
								</td>
							</tr>
							<tr>
								<td><font mmdw="38"  size="1" face="arial, helvetica">Quantity = <!--MMDW 164 -->#qty#<!--MMDW 165 --></font>
								</td>
							</tr>
							<tr>
								<td><font mmdw="39"  size="1" face="arial, helvetica">
									<!--MMDW 166 --><cfloop index="opts" list="#opt#"><!--MMDW 167 -->
									<!--MMDW 168 -->#opts#<!--MMDW 169 --><br>
									<!--MMDW 170 --></cfloop><!--MMDW 171 --></font>
								</td>
								<td><font mmdw="40"  size="1" face="arial, helvetica">
								<!--MMDW 172 --><cfloop index="vals" list="#val#"><!--MMDW 173 -->
								<!--MMDW 174 -->#vals#<!--MMDW 175 --><br>
								<!--MMDW 176 --></cfloop><!--MMDW 177 --></font>
							</td>
						</tr>
					</table>
					<hr>
					<!--MMDW 178 --></cfoutput><!--MMDW 179 -->
					<Br>
					</td>
				</tr>
				</table>
					<!--MMDW 180 --><cfoutput><!--MMDW 181 --><!--MMDW 182 --><!--- End Product Info ---><!--MMDW 183 -->
					</td>
					<td mmdw="41"  width="207" height="100%" bgcolor="#centercolor#" valign="top">
					<!--MMDW 184 --></cfoutput><!--MMDW 185 -->
					<!--MMDW 186 --><cfoutput><!--MMDW 187 -->
					
					
					<table mmdw="42"  cellpadding="1" cellspacing="1" border="0" valign="top" width="100%">
					<!--MMDW 188 --><cfform action="item.cfm?pid=#pid#&xss=#xss#" method="POST"><!--MMDW 189 -->
									
					<input mmdw="43"  type="hidden" name="process" value="Add">
					<!--MMDW 190 --><cfif productinfo.closeout eq 1 and productinfo.special_price gt 0><!--MMDW 191 -->
						<input mmdw="44"  type="hidden" name="charge" value="#productinfo.special_price#">
					<!--MMDW 192 --><cfelse><!--MMDW 193 -->
						<input mmdw="45"  type="hidden" name="charge" value="#productinfo.gallery_price#">
					<!--MMDW 194 --></cfif><!--MMDW 195 -->
					<!--MMDW 196 --><cfif productinfo.gallery_price eq 0 and (productinfo.closeout neq 1 and productinfo.special_price gt 0)><!--MMDW 197 -->
					<tr>
						<td mmdw="46"  colspan="2" bgcolor="#centercolor#" align="center">
						<font mmdw="47"  face="arial, helvetica" size="1"><b>Price On Request</b></font></td>
					</tr>
					<!--MMDW 198 --><cfelseif productinfo.closeout eq 1 and productinfo.special_price gt 0><!--MMDW 199 -->
					<tr>
						<td mmdw="48"  colspan="2">
						<font mmdw="49"  face="arial, helvetica" size="2" color="red"><b>Sale Price:</b></font>&nbsp;&nbsp;
						<font mmdw="50"  face="arial, helvetica"  size="2" color="red"><!--MMDW 200 -->#dollarformat(productinfo.special_price)#<!--MMDW 201 --></font>
						</td>
					</tr>
					<!--MMDW 202 --><cfelse><!--MMDW 203 -->
					<tr>
						<td mmdw="51"  colspan="2" align="center">
						<font mmdw="52"  face="arial, helvetica" size="2"><b>Gallery Price:</b>&nbsp;&nbsp;
								<!--MMDW 204 --><cfif productinfo.gallery_price NEQ 0 AND len(productinfo.gallery_price)><!--MMDW 205 -->
									<!--MMDW 206 -->#dollarformat(productinfo.gallery_price)#<!--MMDW 207 -->
								<!--MMDW 208 --><cfelse><!--MMDW 209 -->
									<!--MMDW 210 -->#dollarformat(0)#<!--MMDW 211 -->
								<!--MMDW 212 --></cfif><!--MMDW 213 -->
							</font>
						</td>
					</tr>
					<!--MMDW 214 --></cfif><!--MMDW 215 -->
					<!--MMDW 216 --><cfif len(productinfo.fk_users)><!--MMDW 217 -->
					<tr>
						<td mmdw="53"  colspan="2" align="center">
							<span mmdw="54"  style="font-size: 12px; font-weight: bold; color: ####ff0000;">PRIVATE LISTING</span><br><br>
						</td
					></tr>
					<!--MMDW 218 --></cfif><!--MMDW 219 -->
					<!--MMDW 220 --><cfif productinfo.gallery_price neq 0 or (productinfo.closeout eq 1 and productinfo.special_price gt 0)><!--MMDW 221 -->

					<input mmdw="55"  type="HIDDEN" name="qty" value="1">
					<tr>
						<td mmdw="56"  colspan="2" align="center">
						<!--MMDW 222 --><!--- <input type="submit" value="ADD TO YOUR CART" style="font-size: 8pt;"> ---><!--MMDW 223 -->
						<input mmdw="57"  type="image" src="images/click_to_purchase.gif" style="border: none;">
						<br>
						</td>
					</tr>
					<!--MMDW 224 --></cfif><!--MMDW 225 -->
					<!--MMDW 226 --></cfform><!--MMDW 227 -->

					<tr>
						<td mmdw="58"  colspan="2">
					<div mmdw="59"  align="center"><a mmdw="60"  href="make_offer.cfm?pid=#pid#&xss=#xss#"><img mmdw="61"  src="images/make_offer.gif" border="0"></a></div><br>
					<table mmdw="62"  cellpadding="1" cellspacing="1" border="0" align="Center" width="95%" style="border: 1px solid ####bbbbbb;">
						<!--MMDW 228 --><cfif productinfo.closeout eq 1 and productinfo.special_price gt 0><!--MMDW 229 -->
							<Tr>
								<td mmdw="63"  align="center"><font mmdw="64"  face="verdana, arial, helvetica" size="1"><b>Retail Price</b></font>
								</td>
								<td mmdw="65"  align="center"><font mmdw="66"  face="verdana, arial, helvetica" size="1"><b>Gallery Price</b></font>
								<td mmdw="67"  align="center"><font mmdw="68"  face="verdana, arial, helvetica" size="1"><b>Sale Price</b></font>
								</td>
								<td mmdw="69"  align="center"><font mmdw="70"  face="verdana, arial, helvetica" size="1"><b>Your Savings</b></font>
								</td>
							</tr>
							<Tr>
								<td mmdw="71"  align="right"><font mmdw="72"  face="verdana, arial, helvetica" size="2"><!--MMDW 230 -->#dollarformat(productinfo.retail_price)#<!--MMDW 231 --></font>
								</td>
								<td mmdw="73"  align="right"><font mmdw="74"  face="verdana, arial, helvetica" size="2"><!--MMDW 232 -->#dollarformat(productinfo.gallery_price)#<!--MMDW 233 --></font>
								</td>
								<td mmdw="75"  align="right"><font mmdw="76"  face="verdana, arial, helvetica" size="2"><!--MMDW 234 -->#dollarformat(productinfo.special_price)#<!--MMDW 235 --></font>
								</td>
							<!--MMDW 236 --><cfset savings = #productinfo.retail_price# - #productinfo.special_price#><!--MMDW 237 -->
								<td mmdw="77"  align="right"><font mmdw="78"  face="verdana, arial, helvetica" size="2" color="red"><b><!--MMDW 238 -->#dollarformat(savings)#<!--MMDW 239 --></b></font>
								</td>
							</tr>
						
						<!--MMDW 240 --><cfelse><!--MMDW 241 -->
							<!--MMDW 242 --><cfif (productinfo.retail_price gt 0) and (productinfo.gallery_price gt 0) and (productinfo.retail_price gt productinfo.gallery_price)><!--MMDW 243 -->
							<Tr>
								<td mmdw="79"  align="center"><font mmdw="80"  face="verdana, arial, helvetica" size="1"><b>Retail Price</b></font>
								</td>
								<td mmdw="81"  align="center"><font mmdw="82"  face="verdana, arial, helvetica" size="1"><b>Gallery Price</b></font>
								</td>
								<td mmdw="83"  align="center"><font mmdw="84"  face="verdana, arial, helvetica" size="1"><b>Your Savings</b></font>
								</td>
							</tr>
							<Tr>
								<td mmdw="85"  align="right"><font mmdw="86"  face="verdana, arial, helvetica" size="2"><!--MMDW 244 -->#dollarformat(productinfo.retail_price)#<!--MMDW 245 --></font>
								</td>
								<td mmdw="87"  align="right"><font mmdw="88"  face="verdana, arial, helvetica" size="2"><!--MMDW 246 -->#dollarformat(productinfo.gallery_price)#<!--MMDW 247 --></font>
								</td>
							<!--MMDW 248 --><cfset savings = #productinfo.retail_price# - #productinfo.gallery_price#><!--MMDW 249 -->
								<td mmdw="89"  align="right"><font mmdw="90"  face="verdana, arial, helvetica" size="2" color="red"><b><!--MMDW 250 -->#dollarformat(savings)#<!--MMDW 251 --></b></font>
								</td>
							</tr>
							<!--MMDW 252 --></cfif><!--MMDW 253 -->
						
						<!--MMDW 254 --></cfif><!--MMDW 255 -->
						
					<!--MMDW 256 --><cfif parameterexists(process)><!--MMDW 257 -->
					<Tr>
						<td mmdw="91"  colspan="3" align="center"><p><font mmdw="92"  face="Arial, helvetica" size="1" color="#displaycolor#"><!--MMDW 258 -->#qty#<!--MMDW 259 --> <!--MMDW 260 -->#productinfo.name#<!--MMDW 261 -->(s) have been added to your list. <br><div mmdw="93"  align="center">Thank you!</div></font>
						</td>
					</tr>
					<!--MMDW 262 --></cfif><!--MMDW 263 -->
					</table>
						</td>
					</tr>
					
					</table>
					
					<!--MMDW 264 --><!--- End of Options Routine ---><!--MMDW 265 -->
					
					
					
					<!--MMDW 266 --></cfoutput><!--MMDW 267 -->
					<!--MMDW 268 --><!--- Matching and Similar ---><!--MMDW 269 -->
					<!--MMDW 270 --><cfoutput><!--MMDW 271 -->
					<!--MMDW 272 --><cfif parameterexists(process)><!--MMDW 273 -->
					<!--MMDW 274 --><cfset tdcolspan=0><!--MMDW 275 -->
					<!--MMDW 276 --><cfif #productinfo.match1# neq ""><!--MMDW 277 -->
					<!--MMDW 278 --><cfquery name="match1" maxrows="1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					Select uid,modelno, name, imageurl from products Where (modelno = '#productinfo.match1#') and active = 1
					</cfquery><!--MMDW 279 -->
					<!--MMDW 280 --><cfset tdcolspan = #tdcolspan#+1><!--MMDW 281 -->
					<!--MMDW 282 --></cfif><!--MMDW 283 -->
					<!--MMDW 284 --><cfif #productinfo.match2# neq ""><!--MMDW 285 -->
					<!--MMDW 286 --><cfquery name="match2" maxrows="1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					Select uid,modelno, name, imageurl from products Where (modelno = '#productinfo.match2#') and active = 1
					</cfquery><!--MMDW 287 -->
					<!--MMDW 288 --><cfset tdcolspan = #tdcolspan#+1><!--MMDW 289 -->
					<!--MMDW 290 --></cfif><!--MMDW 291 -->
					<!--MMDW 292 --><cfif #productinfo.match3# neq ""><!--MMDW 293 -->
					<!--MMDW 294 --><cfquery name="match3" maxrows="1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					Select uid, modelno, name, imageurl from products Where (modelno = '#productinfo.match3#') and active = 1
					</cfquery><!--MMDW 295 -->
					<!--MMDW 296 --><cfset tdcolspan = #tdcolspan#+1><!--MMDW 297 -->
					<!--MMDW 298 --></cfif><!--MMDW 299 -->
					<!--MMDW 300 --><cfif #productinfo.match4# neq ""><!--MMDW 301 -->
					<!--MMDW 302 --><cfquery name="match4" maxrows="1" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					Select uid, modelno, name, imageurl from products Where (modelno = '#productinfo.match4#') and active = 1
					</cfquery><!--MMDW 303 -->
					<!--MMDW 304 --><cfset tdcolspan = #tdcolspan#+1><!--MMDW 305 -->
					<!--MMDW 306 --></cfif><!--MMDW 307 -->
					<table mmdw="94"  cellpadding="2" cellspacing="2" border="0" width="120" align="center">
					<!--MMDW 308 --><cfif #tdcolspan# gt 0><!--MMDW 309 -->
					<!--MMDW 310 --><cfif match1.recordcount gt 0><!--MMDW 311 -->
							<tr>
								<td mmdw="95"  align="Center"><font mmdw="96"  face="arial, helvetica" size="-1" color="#displaycolor#"><b>You will also like these:<!--MMDW 312 --><cfif #tdcolspan# gt 1><!--MMDW 313 -->s<!--MMDW 314 --></cfif><!--MMDW 315 --></b>
					</font>
								</td>
							</tr>
							<tr>
								<td mmdw="97"  valign="top" align="Center">
						<A mmdw="98"  HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(match1.uid))#')">
							<img mmdw="99"  src="http://#server_name#/img/thumbnails/#match1.uid#.jpg" alt="#trim(match1.modelno)#" border="1">
							<!--MMDW 316 --><!--- <IMG SRC="#match1.imageurl#" WIDTH=75 BORDER=0 ALT="#match1.name#" border="0"> ---><!--MMDW 317 -->

						</a>
								</td>
							</tr>
					<!--MMDW 318 --></cfif><!--MMDW 319 -->
					<!--MMDW 320 --><cfif #tdcolspan# gt 1><!--MMDW 321 -->
					<!--MMDW 322 --><cfif match2.recordcount gt 0><!--MMDW 323 -->
							<Tr>
								<td mmdw="100"  valign="top" align="center">
					<A mmdw="101"  HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(match2.uid))#')">

						<img mmdw="102"  src="http://#server_name#/img/thumbnails/#match2.uid#.jpg" alt="#trim(match1.modelno)#" border="1">

						<!--MMDW 324 --><!--- <IMG SRC="#match2.imageurl#" WIDTH=75  BORDER=0 ALT="#match2.name#" border="1"> ---><!--MMDW 325 -->

					</a>
								</td>
							</tr>
					<!--MMDW 326 --></cfif><!--MMDW 327 -->
					<!--MMDW 328 --></cfif><!--MMDW 329 -->
					<!--MMDW 330 --><cfif #tdcolspan# gt 2><!--MMDW 331 -->
					<!--MMDW 332 --><cfif match3.recordcount gt 0><!--MMDW 333 -->
							<Tr>
								<td mmdw="103"  valign="top" align="center">
					<A mmdw="104"  HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(match3.uid))#')">

						<img mmdw="105"  src="http://#server_name#/img/thumbnails/#match3.uid#.jpg" alt="#trim(match1.modelno)#" border="1">
						
						<!--MMDW 334 --><!--- <IMG SRC="#match3.imageurl#"  WIDTH=75 BORDER=0 ALT="#match3.name#" border="1"> ---><!--MMDW 335 -->

					</a>
								</td>
							</tr>
					<!--MMDW 336 --></cfif><!--MMDW 337 -->
					<!--MMDW 338 --></cfif><!--MMDW 339 -->
					<!--MMDW 340 --><cfif #tdcolspan# gt 3><!--MMDW 341 -->
					<!--MMDW 342 --><cfif match4.recordcount gt 0><!--MMDW 343 -->
							<Tr>
								<td mmdw="106"  valign="top" align="center">
					<A mmdw="107"  HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(match4.uid))#')">

						<img mmdw="108"  src="http://#server_name#/img/thumbnails/#match4.uid#.jpg" alt="#trim(match1.modelno)#" border="1">
						
						<!--MMDW 344 --><!--- <IMG SRC="#match4.imageurl#"  WIDTH=75 BORDER=0 ALT="#match4.name#" border="1"> ---><!--MMDW 345 -->

					</a>
								</td>
							</tr>
					<!--MMDW 346 --></cfif><!--MMDW 347 -->
					<!--MMDW 348 --></cfif><!--MMDW 349 -->
					<!--MMDW 350 --></cfif><!--MMDW 351 -->
							</tr>
					</table>
					<!--MMDW 352 --><cfelse><!--MMDW 353 -->
					<!--MMDW 354 --><cfquery name="similar" maxrows="3" datasource="#dsource#" dbtype="ODBC" username="#uname#" password="#pword#">
					SELECT substring(path, 1, PATINDEX('%:%', path)-1) as ccat, * 
					FROM products
					WHERE active = 1 and manufacturer <> '#productinfo.manufacturer #' and path like '#productinfo.path#%'
					</cfquery><!--MMDW 355 -->
					<!--MMDW 356 --><cfif #similar.recordcount# gt 0><!--MMDW 357 -->
					
					<table mmdw="109"  cellspacing="2" cellpadding="2" border="0" align="center">
						<Tr>
							<td mmdw="110"  colspan="#similar.recordcount#" align="center">
						<font mmdw="111"  face="arial,helvetica" size="2"><b>You Might Also Like:</b></font>
							</td>
						</tr>
						<!--MMDW 358 --><cfloop query="similar"><!--MMDW 359 -->
							
							<!--MMDW 360 --><cfset thisFile = "#expandpath('.')#\img\#similar.uid#.jpg" /><!--MMDW 361 -->
						
							<!--MMDW 362 --><cfif listlen(manufacturer) gt 1><!--MMDW 363 -->
								<!--MMDW 364 --><cfset artist_name = "#listlast(manufacturer)# #listfirst(manufacturer)#" /><!--MMDW 365 -->
								<!--MMDW 366 --><cfset artist_name_url = "#listlast(manufacturer)#_#listfirst(manufacturer)#" /><!--MMDW 367 -->
							<!--MMDW 368 --><cfelse><!--MMDW 369 -->
								<!--MMDW 370 --><cfset artist_name = manufacturer /><!--MMDW 371 -->
								<!--MMDW 372 --><cfset artist_name_url = manufacturer /><!--MMDW 373 -->
							<!--MMDW 374 --></cfif><!--MMDW 375 -->
						
						<tr>
					
							<td mmdw="112"  valign="top" align="center">
							
					<A mmdw="113"  HREF="javascript:goxss('item.cfm?pid=#urlencodedformat(trim(uid))#&artistname=#urlencodedformat(trim(artist_name_url))#&gallery=GALLART&title=#urlencodedformat(trim(replace(name,"'",'')))#')">
					<!--MMDW 376 --><cfif fileExists(thisFile)><!--MMDW 377 -->
					<img mmdw="114"  src="http://#server_name#/img/thumbnails/#similar.uid#.jpg" alt="#ucase(similar.manufacturer)# - #similar.name#" border="1">
					<!--MMDW 378 --><cfelse><!--MMDW 379 -->
					<!--MMDW 380 -->#ucase(similar.manufacturer)#<!--MMDW 381 --> - <!--MMDW 382 -->#similar.name#<!--MMDW 383 -->
					<!--MMDW 384 --></cfif><!--MMDW 385 -->
						<Br>
						<font mmdw="115"  size="1" face="verdana, arial"><!--MMDW 386 -->#name#<!--MMDW 387 --></a>
							</td>
					
						</tr>
							<!--MMDW 388 --></cfloop><!--MMDW 389 -->
					</table>
					<!--MMDW 390 --></cfif><!--MMDW 391 -->
					<!--MMDW 392 --></cfif><!--MMDW 393 -->
					<!--MMDW 394 --></cfoutput><!--MMDW 395 -->
					<!--MMDW 396 --><!--- End of Side fill for product Entry ---><!--MMDW 397 -->
					<br><br>
					<!--MMDW 398 --><cfinclude template="sendtofriend.cfm"><!--MMDW 399 -->
					</td>
				</tr>	
			</table>
			
			
			<!--MMDW 400 --><!--- content ends ---><!--MMDW 401 -->
		</td>
	</tr>
	<tr>
		<td mmdw="116"  colspan="2" valign="baseline">
			<!--MMDW 402 --><cfinclude template="footer.cfm"><!--MMDW 403 -->
		</td>
	</tr>
</table>

<!--MMDW 404 --><cfinclude template="frmxss.cfm"><!--MMDW 405 -->

</body>
</html><!-- MMDW:success -->