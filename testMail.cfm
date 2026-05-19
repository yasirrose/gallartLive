<cftry>
    <cfmail 
    to="tldz.dev12@gmail.com" 
    from="tldz.dev12@gmail.com" 
    subject="Test Email" 
    cc="" 
    server="#application.mailserver#" 
    username="#application.mailserver_un#"
    password="#application.mailserver_pw#" 
    port="587" 
    type="HTML"
    >
        <font style="font-size: 10pt; font-family: Arial;">
            The following user submitted an e-Pricing form:<br>
            Name: 'Testing mail'<br>
            Email Address: 'Addres'<br>
            Phone: '12345'<br>
            <!--- Phone Outside US: #form.otherphone# ---><br>
        </font>
    </cfmail>

    <!--- If the mail is sent successfully, display a message --->
    <cfoutput>
        <p style="color: green;">Mail has been sent to tldz.dev12@gmail.com successfully.</p>
    </cfoutput>

    <cfcatch type="any">
        <cfoutput>
            <p style="color: red;">Error sending mail: #cfcatch.message#</p>
        </cfoutput>
    </cfcatch>
</cftry>
