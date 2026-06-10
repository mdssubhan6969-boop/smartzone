var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var html = streamRead.ReadText();
streamRead.Close();

var lines = html.split("\n");
WScript.Echo("Checking for redirection scripts/meta tags...");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.indexOf("window.location") !== -1 || line.indexOf("location.href") !== -1 || line.indexOf("location.replace") !== -1 || line.indexOf("http-equiv=\"refresh\"") !== -1 || line.indexOf("location.assign") !== -1) {
        WScript.Echo("Line " + (i + 1) + ": " + line);
    }
}

// Also count how many absolute hrefs point to datakoku.com
var match;
var datakokuHrefs = 0;
var hrefRegex = /href="https?:\/\/datakoku\.com[^"]*"/gi;
while ((match = hrefRegex.exec(html)) !== null) {
    datakokuHrefs++;
}
WScript.Echo("\nTotal absolute link hrefs pointing to datakoku.com: " + datakokuHrefs);
