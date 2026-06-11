var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var indexHtml = streamRead.ReadText();
streamRead.Close();

var lines = indexHtml.split("\n");
WScript.Echo("Checking for '#about' or 'about' ID in index.html...");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.indexOf("id=\"about\"") !== -1 || line.indexOf("id='about'") !== -1) {
        WScript.Echo("Line " + (i + 1) + ": " + line);
    }
}

WScript.Echo("\nChecking for comments containing 'ABOUT' or 'About' in index.html...");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.indexOf("<!--") !== -1 && line.toLowerCase().indexOf("about") !== -1) {
        WScript.Echo("Line " + (i + 1) + ": " + line);
    }
}
