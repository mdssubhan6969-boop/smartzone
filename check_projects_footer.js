var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\projects.html");
var projectsHtml = streamRead.ReadText();
streamRead.Close();

var lines = projectsHtml.split("\n");
WScript.Echo("=== projects.html around footer ===");
var footerIdx = projectsHtml.toLowerCase().indexOf("<footer");
if (footerIdx !== -1) {
    var footerPart = projectsHtml.substring(footerIdx, footerIdx + 3000);
    var flines = footerPart.split("\n");
    for (var i = 0; i < Math.min(flines.length, 50); i++) {
        WScript.Echo((i + 1) + ": " + flines[i]);
    }
} else {
    WScript.Echo("No footer tag found!");
}
 WScript.Echo("===================================");
