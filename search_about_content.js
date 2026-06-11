var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var indexHtml = streamRead.ReadText();
streamRead.Close();

var lines = indexHtml.split("\n");
WScript.Echo("Searching for 'Smartzone' or 'Arthouse' or 'About' or 'Who we are' in index.html...");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.toLowerCase().indexOf("smartzone") !== -1 || line.toLowerCase().indexOf("arthouse") !== -1) {
        WScript.Echo("Line " + (i + 1) + ": " + line.substring(0, 150));
    }
}
