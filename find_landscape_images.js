var fso = new ActiveXObject("Scripting.FileSystemObject");
var wia = null;
try {
    wia = new ActiveXObject("WIA.ImageFile");
} catch(e) {
    WScript.Echo("WIA not available. Fallback to file size analysis or printing list.");
}

var imagesDir = "C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\images";
var folder = fso.GetFolder(imagesDir);
var files = new Enumerator(folder.Files);

WScript.Echo("Auditing image orientations...");
var landscapeCount = 0;
for (; !files.atEnd(); files.moveNext()) {
    var file = files.item();
    var name = file.Name;
    if (name.indexOf("img_") === 0 && name.indexOf(".jpg") !== -1) {
        if (wia) {
            try {
                wia.LoadFile(file.Path);
                var w = wia.Width;
                var h = wia.Height;
                if (w > h) {
                    WScript.Echo("Landscape: " + name + " (" + w + "x" + h + ")");
                    landscapeCount++;
                }
            } catch(ex) {
                // Ignore load errors
            }
        } else {
            // If WIA is not available, just print some files
            WScript.Echo("Found file: " + name + " (Size: " + file.Size + " bytes)");
        }
    }
}
WScript.Echo("Total landscape images found: " + landscapeCount);
