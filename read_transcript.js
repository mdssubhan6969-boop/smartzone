var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\brain\\66b8d86f-66c1-4dd0-b2ac-f683848f5ff3\\.system_generated\\logs\\transcript.jsonl");
var transcript = streamRead.ReadText();
streamRead.Close();

var lines = transcript.split("\n");
WScript.Echo("Total lines in previous conversation transcript: " + lines.length);
// print the last 20 non-empty lines
var printed = 0;
for (var i = lines.length - 1; i >= 0 && printed < 30; i--) {
    var line = lines[i];
    if (line.replace(/^\s+|\s+$/g, '').length > 0) {
        WScript.Echo("Line " + (i + 1) + ": " + line.substring(0, 200));
        printed++;
    }
}
