<cfscript>
    session.loggedin = true;

    session.userinfo = {
        pk_employees = 1,
        fname = "Admin",
        lname = "User",
        email = "admin@example.com",
        emp_email = "admin@example.com",
        roles = "admin",
        sa = 1
    };

    location(url="index.cfm", addtoken=false);
</cfscript>