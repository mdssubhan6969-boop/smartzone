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

var fStart1 = indexHtml.toLowerCase().indexOf("<footer");
var fEnd1 = indexHtml.toLowerCase().indexOf("</footer>");
var footerIndex = indexHtml.substring(fStart1, fEnd1 + 9);

var fStart2 = projectsHtml.toLowerCase().indexOf("<footer");
var fEnd2 = projectsHtml.toLowerCase().indexOf("</footer>");
var footerProjects = projectsHtml.substring(fStart2, fEnd2 + 9);

if (footerIndex === footerProjects) {
    WScript.Echo("Footers are EXACTLY identical!");
} else {
    WScript.Echo("Footers are DIFFERENT!");
    WScript.Echo("index.html footer length: " + footerIndex.length);
    WScript.Echo("projects.html footer length: " + footerProjects.length);
}
