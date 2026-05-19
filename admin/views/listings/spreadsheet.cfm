



<!--- <cfform name="spreadsheetForm">

	<cfloop collection="#form#" item="idx">
		<cfif left(idx,'6') EQ 'SEARCH'>
			#idx#: <cfinput name="idx" type="text" value="#evaluate('form.'&idx)#"><br>
		</cfif>


	</cfloop> --->


<cfhtmlhead text='<script type="text/javascript" src="/admin/scripts/listings.js.cfm" language="JavaScript"></script>'>

<table border = "0" width = "100%" cellpadding = "5" cellspacing = "0">
	<tr>
		<td><input type="Button" value="Back To Search" onclick="javascript:self.history.go(-1);" /></td>
	</tr>
	<tr>
		<td valign="top" width="350">
			<cfform name="gridForm">
				<cfif isDefined('form.searchModelno')>
					<cfinput type="Hidden" name="searchModelno" value="#form.searchModelno#" />
				<cfelse>
					<cfinput type="Hidden" name="searchModelno" value="" />
				</cfif>
				
				<cfif isDefined('form.searchTitle')>
					<cfinput type="Hidden" name="searchTitle" value="#form.searchTitle#" />
				<cfelse>
					<cfinput type="Hidden" name="searchTitle" value="" />
				</cfif>

				<cfif isDefined('form.searchArtist')>
					<cfinput type="Hidden" name="searchArtist" value="#form.searchArtist#" />
				<cfelse>
					<cfinput type="Hidden" name="searchArtist" value="" />
				</cfif>
				
				<cfif isDefined('form.searchMedium')>
					<cfinput type="Hidden" name="searchMedium" value="#form.searchMedium#" />
				<cfelse>
					<cfinput type="Hidden" name="searchMedium" value="" />
				</cfif>
				
				<cfif isDefined('form.searchYear')>
					<cfinput type="Hidden" name="searchYear" value="#form.searchYear#" />
				<cfelse>
					<cfinput type="Hidden" name="searchYear" value="" />
				</cfif>
				
				<cfif isDefined('form.searchHeight')>
					<cfinput type="Hidden" name="searchHeight" value="#form.searchHeight#">
				<cfelse>
					<cfinput type="Hidden" name="searchHeight" value="">
				</cfif>
				
				<cfif isDefined('form.searchWidth')>
					<cfinput type="Hidden" name="searchWidth" value="#form.searchWidth#">
				<cfelse>
					<cfinput type="Hidden" name="searchWidth" value="">
				</cfif>
				
				<cfif isDefined('form.searchDescription')>
					<cfinput type="Hidden" name="searchDescription" value="#form.searchDescription#" />
				<cfelse>
					<cfinput type="Hidden" name="searchDescription" value="" />
				</cfif>
				
				<cfif isDefined('form.searchFromPrice')>
					<cfinput type="Hidden" name="searchFromPrice" value="#form.searchFromPrice#" />
				<cfelse>
					<cfinput type="Hidden" name="searchFromPrice" value="" />
				</cfif>
				
				<cfif isDefined('form.searchToPrice')>
					<cfinput type="Hidden" name="searchToPrice" value="#form.searchToPrice#" />
				<cfelse>
					<cfinput type="Hidden" name="searchToPrice" value="" />
				</cfif>
				
				<cfif isDefined('form.searchFromDate')>
					<cfinput type="Hidden" name="searchFromDate" value="#form.searchFromDate#" />
				<cfelse>
					<cfinput type="Hidden" name="searchFromDate" value="" />
				</cfif>
				
				<cfif isDefined('form.searchToDate')>
					<cfinput type="Hidden" name="searchToDate" value="#form.searchToDate#" />
				<cfelse>
					<cfinput type="Hidden" name="searchToDate" value="" />
				</cfif>
				
				<cfif isDefined('form.searchFromLastedit')>
					<cfinput type="Hidden" name="searchFromLastedit" value="#form.searchFromLastedit#" />
				<cfelse>
					<cfinput type="Hidden" name="searchFromLastedit" value="" />
				</cfif>
				
				<cfif isDefined('form.searchToLastedit')>
					<cfinput type="Hidden" name="searchToLastedit" value="#form.searchToLastedit#" />
				<cfelse>
					<cfinput type="Hidden" name="searchToLastedit" value="" />
				</cfif>
				
				<cfif isDefined('form.searchSellerId')>
					<cfinput type="Hidden" name="searchSellerId" size="10" value="#form.searchSellerId#" />
				<cfelse>
					<cfinput type="Hidden" name="searchSellerId" size="10" value="" />
				</cfif>
				
				

				<input type="Hidden" name="searchActive"/>
				<input type="Checkbox" name="searchActive"  <cfif isDefined('searchActive') and form.searchActive EQ 'on'>checked</cfif> style="display: none;">

				<input type="Hidden" name="searchpromotion"/>
				<input type="Checkbox" name="searchpromotion"  <cfif isDefined('searchpromotion') and form.searchpromotion EQ 'on'>checked</cfif> style="display: none;">

				<input type="Checkbox" name="searchOnSale"  <cfif isDefined('searchOnSale') and form.searchOnSale EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchOnSale">

				<input type="Checkbox" name="searchTrump" <cfif isDefined('searchTrump') and form.searchTrump EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchTrump">

				<input type="Checkbox" name="searchAuction" <cfif isDefined('searchAuction') and form.searchAuction EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchAuction">
				
				<input type="Checkbox" name="searchSlideshow" <cfif isDefined('searchSlideshow') and form.searchSlideshow EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchSlideshow">

				<input type="Checkbox" name="searchFrontshow" <cfif isDefined('searchFrontshow') and form.searchFrontshow EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchFrontshow">

				<input type="Checkbox" name="searchBottomHome" <cfif isDefined('searchBottomHome') and form.searchBottomHome EQ 'on'>checked</cfif> style="display: none;">
				<input type="Hidden" name="searchBottomHome">

				<input type="Hidden" name="searchImageName">
				

				<cfgrid format="html" name="data" pagesize="250" stripeRows="true" stripeRowColor="##e0e0e0" bind="cfc:admin.models.art.getListings({cfgridpage},{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},{searchSellerId},{searchImageName},{searchModelno},{searchTitle},{searchArtist},{searchMedium},{searchYear},{searchHeight},{searchWidth},{searchDescription},{searchFromPrice},{searchToPrice},{searchFromDate},{searchToDate},{searchFromLastedit},{searchToLastedit},{searchOnSale},{searchTrump},{searchAuction},{searchSlideshow},{searchFrontshow},{searchBottomHome},{searchActive},{searchpromotion})">
					<cfgridcolumn name="modelno" header="Art ID" width="150" href="index.cfm?event=listings">
				    <cfgridcolumn name="name" header="Title" width="150">
					<cfgridcolumn name="manufacturer" header="Artist" width="150">
					<cfgridcolumn name="path" header="Medium" width="150">
					<cfgridcolumn name="retail_price" header="Retail Price" width="100">
					<cfgridcolumn name="gallery_price" header="Gallery Price" width="100">
					<cfgridcolumn name="Status" header="Status" width="75">
					<cfgridcolumn name="lasteditDate" header="Last Edited" width="100">
				</cfgrid>

			</cfform>
		</td>
	</tr>
</table>


