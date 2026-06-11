var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var indexHtml = streamRead.ReadText();
streamRead.Close();

var lines = indexHtml.split("\n");
WScript.Echo("=== index.html Why Clients Trust Our Vision section ===");
for (var i = 1820; i < Math.min(lines.length, 1910); i++) {
    WScript.Echo((i + 1) + ": " + lines[i]);
}
 WScript.Echo("=====================================================");
