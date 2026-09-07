<!--- FILE FOR TESTING: --->
<cfset emailFile = "PRIVATE_SALE_2009_07_29/index.html" />

<cffile action="READ" file="#expandpath('.')#/#emailFile#" variable="emailContent" />


<cfmail server="#servername#" username="onli16@onlinegalleryart.com"
password="re3objec" to="ruckerstev@hotmail.com" from="onli16@onlinegalleryart.com" subject="Gallery Art Test" type="HTML">

	#emailContent#

</cfmail>
EMAIL SENT
