var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\learn.html");
var learnHtml = streamRead.ReadText();
streamRead.Close();

var lines = learnHtml.split("\n");
WScript.Echo("=== All HTML comments in learn.html ===");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.indexOf("<!--") !== -1) {
        WScript.Echo("Line " + (i + 1) + ": " + line.substring(0, 150));
    }
}
 WScript.Echo("=======================================");
