var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\projects.html");
var projectsHtml = streamRead.ReadText();
streamRead.Close();

var lines = projectsHtml.split("\n");
WScript.Echo("=== Headings in projects.html ===");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    var hMatch = line.match(/<(h[1-6])[\s>]([\s\S]*?)<\/\1>/i);
    if (hMatch) {
        WScript.Echo("Line " + (i + 1) + " (" + hMatch[1] + "): " + hMatch[2].replace(/^\s+|\s+$/g, '').substring(0, 100));
    }
}
WScript.Echo("=================================");
