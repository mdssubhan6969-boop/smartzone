var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var html = streamRead.ReadText();
streamRead.Close();

var lines = html.split("\n");
WScript.Echo("All headings in index.html:");
for (var i = 0; i < lines.length; i++) {
    var line = lines[i];
    var hMatch = line.match(/<(h[1-6])[\s>]([\s\S]*?)<\/\1>/i);
    if (hMatch) {
        WScript.Echo("Line " + (i + 1) + " (" + hMatch[1] + "): " + hMatch[2].replace(/^\s+|\s+$/g, '').substring(0, 100));
    } else {
        // Also look for elementor heading titles
        if (line.indexOf("elementor-heading-title") !== -1) {
            // Find content inside the tag
            var text = line.replace(/<[^>]+>/g, '').replace(/^\s+|\s+$/g, '');
            if (text.length > 0) {
                WScript.Echo("Line " + (i + 1) + " (elementor-heading): " + text.substring(0, 100));
            }
        }
    }
}
