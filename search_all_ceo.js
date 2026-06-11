var fso = new ActiveXObject("Scripting.FileSystemObject");
var folder = fso.GetFolder("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone");
var files = new Enumerator(folder.Files);

for (; !files.atEnd(); files.moveNext()) {
    var file = files.item();
    if (file.Name.substring(file.Name.length - 5) === ".html") {
        WScript.Echo("Checking file: " + file.Name);
        var streamRead = new ActiveXObject("ADODB.Stream");
        streamRead.Type = 2; // text
        streamRead.Charset = "utf-8";
        streamRead.Open();
        streamRead.LoadFromFile(file.Path);
        var html = streamRead.ReadText();
        streamRead.Close();
        
        var lines = html.split("\n");
        for (var i = 0; i < lines.length; i++) {
            var line = lines[i];
            if (line.toLowerCase().indexOf("shakir") !== -1 || line.indexOf("ceo_shakir") !== -1) {
                WScript.Echo("  Line " + (i + 1) + ": " + line.substring(0, 150));
            }
        }
    }
}
