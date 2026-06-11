var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var indexHtml = streamRead.ReadText();
streamRead.Close();

var lines = indexHtml.split("\n");
WScript.Echo("=== Index sections with h2 headings ===");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.indexOf("<h2") !== -1 || line.indexOf("heading-title") !== -1) {
        // Find adjacent lines
        var snippet = [];
        for (var j = Math.max(0, i - 2); j < Math.min(lines.length, i + 10); j++) {
            snippet.push("Line " + (j + 1) + ": " + lines[j]);
        }
        WScript.Echo(snippet.join("\n"));
        WScript.Echo("----------------------------\n");
    }
}
