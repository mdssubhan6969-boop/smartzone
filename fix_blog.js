
const fs = require("fs");
let html = fs.readFileSync("blog.html", "utf8");
let projHtml = fs.readFileSync("projects.html", "utf8");

// 1. Replace Footer (Last About Section)
let projFooterStart = projHtml.indexOf("<footer");
let projFooter = projHtml.substring(projFooterStart);
// projFooter might contain </body></html>, let's keep only up to </footer>
let projFooterEnd = projFooter.indexOf("</footer>") + "</footer>".length;
projFooter = projFooter.substring(0, projFooterEnd);

let blogFooterStart = html.indexOf("<footer");
let blogFooterEnd = html.indexOf("</footer>") + "</footer>".length;
if(blogFooterStart !== -1 && blogFooterEnd !== -1) {
    html = html.substring(0, blogFooterStart) + projFooter + html.substring(blogFooterEnd);
}

// 2. Remove Design Newsletter
let newsletterStart = html.indexOf("<!-- Newsletter Widget -->");
if(newsletterStart !== -1) {
    let newsletterEnd = html.indexOf("</div>", html.indexOf("</div>", html.indexOf("</div>", html.indexOf("<div class=\"newsletter-form\">"))) + 6) + 6;
    // Actually simpler to just use regex
    html = html.replace(/<!-- Newsletter Widget -->[\s\S]*?(?=<!-- Popular Tags -->)/, "");
}

// 3. Make Get a Quote simple
html = html.replace(/<a class="elementor-button elementor-button-link elementor-size-sm" href="#">\s*<span class="elementor-button-content-wrapper">\s*<span class="elementor-button-text">Get a Quote<\/span>\s*<\/span>\s*<\/a>/,
    `<a class="nav-simple-btn" href="#" style="background:transparent;color:#333!important;padding:8px 16px;border:1px solid #333;border-radius:0;text-decoration:none;font-weight:400;font-family:'Playfair Display', serif;text-transform:uppercase;letter-spacing:0.1em;display:inline-block;transition:all 0.3s;">
        <span class="elementor-button-content-wrapper">
            <span class="elementor-button-text">Get a Quote</span>
        </span>
    </a>`);

// 4. Fix social media icons
let socialRegex = /<a href="#" style="display:inline-flex;align-items:center;justify-content:center;width:44px;height:44px;background:[^;]+;border-radius:10px;color:#fff!important;text-decoration:none;font-size:1.1rem;transition:transform 0.2s;"><i class="fab (fa-[^"]+)"><\/i><\/a>/g;
html = html.replace(socialRegex, `<a href="#" style="display:inline-flex;align-items:center;justify-content:center;width:44px;height:44px;background:transparent;border:1px solid #333;border-radius:0;color:#333!important;text-decoration:none;font-size:1.1rem;transition:all 0.3s;"><i class="fab $1"></i></a>`);

// 5. Replace article images
let aiImages = [
    "C:/Users/sky/.gemini/antigravity/brain/78d97388-991f-44ce-ae5a-853c4647a362/article_ai_1_1781206574800.png",
    "C:/Users/sky/.gemini/antigravity/brain/78d97388-991f-44ce-ae5a-853c4647a362/article_ai_2_1781206586028.png",
    "C:/Users/sky/.gemini/antigravity/brain/78d97388-991f-44ce-ae5a-853c4647a362/article_ai_3_1781206597910.png"
];
let imgIndex = 0;
html = html.replace(/<img src="images\/img_\d+\.jpg"/g, () => {
    let src = aiImages[imgIndex % aiImages.length];
    imgIndex++;
    return `<img src="${src}"`;
});

fs.writeFileSync("blog.html", html, "utf8");
console.log("Done");

