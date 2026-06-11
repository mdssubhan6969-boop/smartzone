var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var indexHtml = streamRead.ReadText();
streamRead.Close();

var lines = indexHtml.split("\n");
WScript.Echo("=== All IDs in index.html ===");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    var match = line.match(/id="([^"]+)"/i) || line.match(/id='([^']+)'/i);
    if (match) {
        WScript.Echo("Line " + (i + 1) + ": " + match[1]);
    }
}
 WScript.Echo("=============================");
