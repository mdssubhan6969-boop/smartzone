var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\projects.html");
var projectsHtml = streamRead.ReadText();
streamRead.Close();

var lines = projectsHtml.split("\n");
WScript.Echo("=== projects.html lines 1490-1520 ===");
for (var i = 1490; i < Math.min(lines.length, 1520); i++) {
    WScript.Echo((i + 1) + ": " + lines[i]);
}
 WScript.Echo("=====================================");
