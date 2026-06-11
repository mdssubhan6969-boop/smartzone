var fso = new ActiveXObject("Scripting.FileSystemObject");
var targetDir = "C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\images";

var files = [
    { src: "C:\\Users\\sky\\.gemini\\antigravity\\brain\\17405825-358d-449d-8f2c-54187fdc3def\\initial_consultation_1781031238415.png", dest: "process_1.png" },
    { src: "C:\\Users\\sky\\.gemini\\antigravity\\brain\\17405825-358d-449d-8f2c-54187fdc3def\\concept_moodboard_1781031253151.png", dest: "process_2.png" },
    { src: "C:\\Users\\sky\\.gemini\\antigravity\\brain\\17405825-358d-449d-8f2c-54187fdc3def\\technical_planning_1781031268513.png", dest: "process_3.png" },
    { src: "C:\\Users\\sky\\.gemini\\antigravity\\brain\\17405825-358d-449d-8f2c-54187fdc3def\\execution_handover_1781031282806.png", dest: "process_4.png" }
];

for (var i = 0; i < files.length; i++) {
    var item = files[i];
    if (fso.FileExists(item.src)) {
        var targetPath = targetDir + "\\" + item.dest;
        fso.CopyFile(item.src, targetPath, true);
        WScript.Echo("Copied AI Image: " + item.dest);
    } else {
        WScript.Echo("Source file not found: " + item.src);
    }
}
WScript.Echo("AI Images copying completed.");
