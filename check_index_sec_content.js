var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var indexHtml = streamRead.ReadText();
streamRead.Close();

var lines = indexHtml.split("\n");
WScript.Echo("=== index.html section: The Artistry Behind Our Designs ===");
for (var i = 1620; i < Math.min(lines.length, 1690); i++) {
    WScript.Echo((i + 1) + ": " + lines[i]);
}

WScript.Echo("\n=== index.html section: Why Clients Trust Our Vision ===");
for (var i = 1810; i < Math.min(lines.length, 1870); i++) {
    WScript.Echo((i + 1) + ": " + lines[i]);
}
