<cfsilent>
	<!--- Optional public image attributes: missing, stale, or unreadable previews use the original src. --->
	<cfparam name="attributes.artworkId" default="">
	<cfparam name="attributes.sizes" default="100vw">
	<cfset usePublicPreviews = false>
	<cfset smallPreviewVersion = "">
	<cfset largePreviewVersion = "">
	<cftry>
		<cfif reFind("^[0-9]+$", attributes.artworkId)>
			<cfset originalPath = expandPath("/img/#attributes.artworkId#.jpg")>
			<cfset smallPreviewPath = expandPath("/img/previews/#attributes.artworkId#-640.jpg")>
			<cfset largePreviewPath = expandPath("/img/previews/#attributes.artworkId#-1280.jpg")>
			<cfif fileExists(originalPath) AND fileExists(smallPreviewPath) AND fileExists(largePreviewPath)>
				<cfset originalInfo = getFileInfo(originalPath)>
				<cfset smallPreviewInfo = getFileInfo(smallPreviewPath)>
				<cfset largePreviewInfo = getFileInfo(largePreviewPath)>
				<cfset usePublicPreviews = smallPreviewInfo.lastModified GTE originalInfo.lastModified AND largePreviewInfo.lastModified GTE originalInfo.lastModified>
				<cfset smallPreviewVersion = dateFormat(smallPreviewInfo.lastModified, "yyyymmdd") & timeFormat(smallPreviewInfo.lastModified, "HHmmss")>
				<cfset largePreviewVersion = dateFormat(largePreviewInfo.lastModified, "yyyymmdd") & timeFormat(largePreviewInfo.lastModified, "HHmmss")>
			</cfif>
		</cfif>
		<cfcatch type="any">
			<!--- An image can be replaced during the request; optional previews must never break the page. --->
			<cfset usePublicPreviews = false>
		</cfcatch>
	</cftry>
</cfsilent><cfif usePublicPreviews><cfoutput> srcset="/img/previews/#attributes.artworkId#-640.jpg?v=#smallPreviewVersion# 640w, /img/previews/#attributes.artworkId#-1280.jpg?v=#largePreviewVersion# 1280w" sizes="#HTMLEditFormat(attributes.sizes)#"</cfoutput></cfif>
