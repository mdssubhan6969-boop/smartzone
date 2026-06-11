var streamRead1 = new ActiveXObject("ADODB.Stream");
streamRead1.Type = 2; // text
streamRead1.Charset = "utf-8";
streamRead1.Open();
streamRead1.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var indexHtml = streamRead1.ReadText();
streamRead1.Close();

var streamRead2 = new ActiveXObject("ADODB.Stream");
streamRead2.Type = 2; // text
streamRead2.Charset = "utf-8";
streamRead2.Open();
streamRead2.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\projects.html");
var projectsHtml = streamRead2.ReadText();
streamRead2.Close();

WScript.Echo("=== index.html bottom sections (last 15000 chars before footer) ===");
var footerIdx1 = indexHtml.toLowerCase().indexOf("<footer");
if (footerIdx1 !== -1) {
    WScript.Echo(indexHtml.substring(footerIdx1 - 8000, footerIdx1));
} else {
    WScript.Echo("No footer tag found in index.html");
}

WScript.Echo("=== projects.html bottom sections (last 15000 chars before footer) ===");
var footerIdx2 = projectsHtml.toLowerCase().indexOf("<footer");
if (footerIdx2 !== -1) {
    WScript.Echo(projectsHtml.substring(footerIdx2 - 8000, footerIdx2));
} else {
    WScript.Echo("No footer tag found in projects.html");
}
