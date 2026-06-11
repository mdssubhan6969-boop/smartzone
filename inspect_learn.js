var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\learn.html");
var learnHtml = streamRead.ReadText();
streamRead.Close();

var lines = learnHtml.split("\n");
WScript.Echo("=== learn.html sections around Shakir ===");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.toLowerCase().indexOf("shakir") !== -1) {
        var start = Math.max(0, i - 15);
        var end = Math.min(lines.length, i + 35);
        WScript.Echo("Lines " + (start + 1) + " to " + end + ":");
        for (var j = start; j < end; j++) {
            WScript.Echo((j + 1) + ": " + lines[j]);
        }
        WScript.Echo("----------------------------\n");
        break; // just show the first match area
    }
}
