var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\brain\\66b8d86f-66c1-4dd0-b2ac-f683848f5ff3\\.system_generated\\logs\\transcript.jsonl");
var transcript = streamRead.ReadText();
streamRead.Close();

var lines = transcript.split("\n");
var last15 = [];
var count = 0;
for (var i = lines.length - 1; i >= 0; i--) {
    var line = lines[i];
    if (line.replace(/^\s+|\s+$/g, '').length > 0) {
        last15.push(line);
        count++;
        if (count >= 15) break;
    }
}

// Reverse so they are chronological
last15.reverse();

for (var i = 0; i < last15.length; i++) {
    var obj = eval("(" + last15[i] + ")"); // Safe eval for json line
    WScript.Echo("=== STEP " + obj.step_index + " (" + obj.source + " / " + obj.type + ") ===");
    if (obj.content) {
        WScript.Echo(obj.content.substring(0, 1000));
    }
    WScript.Echo("\n");
}
