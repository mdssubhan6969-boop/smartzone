var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var html = streamRead.ReadText();
streamRead.Close();

var lines = html.split("\n");
WScript.Echo("Checking for HTML comments representing sections/containers...");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.indexOf("<!--") !== -1 && (line.indexOf("section") !== -1 || line.indexOf("Section") !== -1 || line.indexOf("container") !== -1 || line.indexOf("Container") !== -1)) {
        WScript.Echo("Line " + (i + 1) + ": " + line.substring(0, 120));
    }
}

WScript.Echo("\nChecking for section elements or main containers in index.html...");
var elementorSections = [];
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    if (line.indexOf("data-element_type=\"section\"") !== -1 || line.indexOf("data-element_type=\"container\"") !== -1) {
        // Let's print the line and surrounding lines to find class/id
        var textMatch = "";
        // search forward for some text
        for (var j = i; j < Math.min(i + 15, lines.length); j++) {
            if (lines[j].indexOf("<h2>") !== -1 || lines[j].indexOf("<h1>") !== -1 || lines[j].indexOf("<h3>") !== -1 || lines[j].indexOf("<h4") !== -1) {
                textMatch += " [H: " + lines[j].replace(/^\s+|\s+$/g, '') + "]";
            }
        }
        WScript.Echo("Line " + (i + 1) + ": " + line.substring(0, 100) + textMatch);
    }
}
