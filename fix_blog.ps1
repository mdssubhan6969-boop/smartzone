
$blog = Get-Content -Raw blog.html
$proj = Get-Content -Raw projects.html

# 1. Replace Footer
$projFooterStart = $proj.IndexOf("<footer")
$projFooter = $proj.Substring($projFooterStart)
$projFooterEnd = $projFooter.IndexOf("</footer>") + "</footer>".Length
$projFooter = $projFooter.Substring(0, $projFooterEnd)

$blogFooterStart = $blog.IndexOf("<footer")
$blogFooterEnd = $blog.IndexOf("</footer>") + "</footer>".Length
if ($blogFooterStart -ne -1 -and $blogFooterEnd -ne -1) {
    $blog = $blog.Substring(0, $blogFooterStart) + $projFooter + $blog.Substring($blogFooterEnd)
}

# 2. Remove Design Newsletter
$blog = $blog -replace "(?s)<!-- Newsletter Widget -->.*?(?=<!-- Popular Tags -->)", ""

# 3. Make Get a Quote simple
$quoteRegex = "(?s)<a class=""elementor-button elementor-button-link elementor-size-sm"" href=""#"">\s*<span class=""elementor-button-content-wrapper"">\s*<span class=""elementor-button-text"">Get a Quote</span>\s*</span>\s*</a>"
$quoteReplacement = "<a class=""nav-simple-btn"" href=""#"" style=""background:transparent;color:#333!important;padding:8px 16px;border:1px solid #333;border-radius:0;text-decoration:none;font-weight:400;font-family:'Playfair Display', serif;text-transform:uppercase;letter-spacing:0.1em;display:inline-block;transition:all 0.3s;""><span class=""elementor-button-content-wrapper""><span class=""elementor-button-text"">Get a Quote</span></span></a>"
$blog = [regex]::Replace($blog, $quoteRegex, $quoteReplacement)

# 4. Fix social media icons
$socialRegex = "(?s)<a href=""#"" style=""display:inline-flex;align-items:center;justify-content:center;width:44px;height:44px;background:[^;]+;border-radius:10px;color:#fff!important;text-decoration:none;font-size:1.1rem;transition:transform 0\.2s;""><i class=""fab (fa-[^""]+)""></i></a>"
$socialReplacement = "<a href=""#"" style=""display:inline-flex;align-items:center;justify-content:center;width:44px;height:44px;background:transparent;border:1px solid #333;border-radius:0;color:#333!important;text-decoration:none;font-size:1.1rem;transition:all 0.3s;""><i class=""fab `$1""></i></a>"
$blog = [regex]::Replace($blog, $socialRegex, $socialReplacement)

# 5. Replace article images
$aiImages = @(
    "C:/Users/sky/.gemini/antigravity/brain/78d97388-991f-44ce-ae5a-853c4647a362/article_ai_1_1781206574800.png",
    "C:/Users/sky/.gemini/antigravity/brain/78d97388-991f-44ce-ae5a-853c4647a362/article_ai_2_1781206586028.png",
    "C:/Users/sky/.gemini/antigravity/brain/78d97388-991f-44ce-ae5a-853c4647a362/article_ai_3_1781206597910.png"
)
$i = 0
$regex = [regex]"<img src=""images/img_\d+\.(jpg|png)"""
while ($blog -match "<img src=""images/img_\d+\.(jpg|png)""") {
    $src = $aiImages[$i % $aiImages.Length]
    $blog = $regex.Replace($blog, "<img src=""$src""", 1)
    $i++
}

Set-Content -Path blog.html -Value $blog -Encoding UTF8
Write-Host "Done"

