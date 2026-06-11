var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var indexHtml = streamRead.ReadText();
streamRead.Close();

var lines = indexHtml.split("\n");
var mainStart = indexHtml.toLowerCase().indexOf("<main");
var mainEnd = indexHtml.toLowerCase().indexOf("</main>");

WScript.Echo("Main element range: " + mainStart + " to " + mainEnd);
if (mainStart !== -1 && mainEnd !== -1) {
    var mainHtml = indexHtml.substring(mainStart, mainEnd + 7);
    var mLines = mainHtml.split("\n");
    WScript.Echo("Main lines count: " + mLines.length);
    for (var i = 0; i < mLines.length; i++) {
        var line = mLines[i];
        // Print top level containers/sections
        if (line.indexOf("<div") !== -1 && (line.indexOf("e-parent") !== -1 || line.indexOf("elementor-section") !== -1)) {
            WScript.Echo("Line " + (i + 1) + ": " + line.substring(0, 150));
            // Find headings inside or right after
            for (var j = i + 1; j < Math.min(mLines.length, i + 15); j++) {
                if (mLines[j].indexOf("<h2") !== -1 || mLines[j].indexOf("<h1") !== -1 || mLines[j].indexOf("cursive-subtitle") !== -1) {
                    WScript.Echo("   H: " + mLines[j].replace(/^\s+|\s+$/g, ''));
                }
            }
        }
    }
}
