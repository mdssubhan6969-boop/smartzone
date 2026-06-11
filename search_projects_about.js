var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\projects.html");
var projectsHtml = streamRead.ReadText();
streamRead.Close();

var lines = projectsHtml.split("\n");
WScript.Echo("Checking for 'about' in projects.html...");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.toLowerCase().indexOf("about") !== -1 || line.toLowerCase().indexOf("learn") !== -1) {
        WScript.Echo("Line " + (i + 1) + ": " + line.substring(0, 150));
    }
}
