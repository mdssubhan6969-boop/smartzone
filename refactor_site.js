var streamRead = new ActiveXObject("ADODB.Stream");
streamRead.Type = 2; // text
streamRead.Charset = "utf-8";
streamRead.Open();
streamRead.LoadFromFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html");
var html = streamRead.ReadText();
streamRead.Close();

WScript.Echo("Starting refactor pipeline...");

// 1. Remove the hue-rotate filter on logo images from the style block we'll inject
// And inject the custom style block
var styleBlock = 
"<!-- Blue & Black Theme Overrides -->\n" +
"<style id=\"blue-black-theme-overrides\">\n" +
"    :root {\n" +
"        --accent-blue: #0A84FF !important;\n" +
"        --accent-blue-hover: #0066FF !important;\n" +
"        --accent-blue-light: rgba(10, 132, 255, 0.12) !important;\n" +
"        --bg-black: #060607 !important;\n" +
"        --bg-dark-gray: #0D0D0F !important;\n" +
"        --border-blue: rgba(10, 132, 255, 0.2) !important;\n" +
"        \n" +
"        /* WordPress / Elementor Presets */\n" +
"        --wp--preset--color--luminous-vivid-orange: #0A84FF !important;\n" +
"        --wp--preset--color--luminous-vivid-amber: #0A84FF !important;\n" +
"        --wp--preset--color--vivid-cyan-blue: #0A84FF !important;\n" +
"        --wp--preset--color--pale-cyan-blue: rgba(10, 132, 255, 0.1) !important;\n" +
"    }\n" +
"\n" +
"    /* Global dark background overrides */\n" +
"    body, \n" +
"    .elementor-section, \n" +
"    .e-con, \n" +
"    .e-con-inner,\n" +
"    .e-con-boxed,\n" +
"    header, \n" +
"    footer,\n" +
"    .hello-header,\n" +
"    .hello-footer,\n" +
"    .e-off-canvas__main,\n" +
"    .e-off-canvas__content {\n" +
"        background-color: var(--bg-black) !important;\n" +
"        background-image: none !important;\n" +
"        color: #FFFFFF !important;\n" +
"    }\n" +
"\n" +
"    /* Keep containers black */\n" +
"    div.elementor-element[data-settings*='classic'],\n" +
"    section.elementor-element[data-settings*='classic'],\n" +
"    .elementor-section-wrap,\n" +
"    .elementor-widget-container {\n" +
"        background-color: var(--bg-black) !important;\n" +
"        background-image: none !important;\n" +
"    }\n" +
"\n" +
"    /* Cards & Sub-containers override */\n" +
"    .service-card,\n" +
"    .process-step,\n" +
"    .elementor-card,\n" +
"    .bdt-ps-content,\n" +
"    .bdt-prime-slider,\n" +
"    .e-con-inner > .elementor-element {\n" +
"        background-color: var(--bg-dark-gray) !important;\n" +
"        border-color: var(--border-blue) !important;\n" +
"        color: #FFFFFF !important;\n" +
"    }\n" +
"\n" +
"    /* Text colors override */\n" +
"    a, \n" +
"    p,\n" +
"    span,\n" +
"    .nav a,\n" +
"    .elementor-item,\n" +
"    .e-n-menu-title-text,\n" +
"    .elementor-heading-title,\n" +
"    .elementor-icon-list-text,\n" +
"    .bdt-title,\n" +
"    .bdt-title-tag,\n" +
"    h1, h2, h3, h4, h5, h6 {\n" +
"        color: #FFFFFF !important;\n" +
"    }\n" +
"\n" +
"    p, .elementor-icon-list-text, .bdt-title-tag {\n" +
"        color: #A0AEC0 !important; /* Muted gray for readability */\n" +
"    }\n" +
"\n" +
"    /* Accents and Highlight text */\n" +
"    .accent-text,\n" +
"    .bdt-ps-sub-title,\n" +
"    .elementor-heading-title.elementor-size-default,\n" +
"    .elementor-icon-list-icon svg,\n" +
"    h5.elementor-heading-title {\n" +
"        color: var(--accent-blue-hover) !important;\n" +
"    }\n" +
"\n" +
"    /* Hover Navigation States */\n" +
"    a:hover,\n" +
"    .nav a:hover,\n" +
"    .elementor-item:hover,\n" +
"    .elementor-item.elementor-item-active,\n" +
"    .e-n-menu-title-text:hover,\n" +
"    .e-current .e-n-menu-title-text,\n" +
"    .mmenu:hover {\n" +
"        color: var(--accent-blue) !important;\n" +
"    }\n" +
"\n" +
"    /* Button & Forms */\n" +
"    .btn-primary,\n" +
"    .elementor-button,\n" +
"    .elementor-button-link,\n" +
"    .bdt-ps-button,\n" +
"    button[type=\"submit\"] {\n" +
"        background-color: #0066FF !important;\n" +
"        color: #FFFFFF !important;\n" +
"        border: none !important;\n" +
"        box-shadow: 0 4px 15px rgba(0, 102, 255, 0.4) !important;\n" +
"        border-radius: 4px !important;\n" +
"        transition: all 0.3s ease !important;\n" +
"    }\n" +
"\n" +
"    .btn-primary:hover,\n" +
"    .elementor-button:hover,\n" +
"    .elementor-button-link:hover,\n" +
"    .bdt-ps-button:hover,\n" +
"    button[type=\"submit\"]:hover {\n" +
"        background-color: #0056e0 !important;\n" +
"        box-shadow: 0 6px 20px rgba(0, 102, 255, 0.6) !important;\n" +
"        transform: translateY(-2px) !important;\n" +
"    }\n" +
"\n" +
"    /* Override SVG circles/strokes from orange to blue */\n" +
"    svg path, \n" +
"    svg circle, \n" +
"    svg rect, \n" +
"    svg line,\n" +
"    .e-font-icon-svg path,\n" +
"    .elementor-icon svg {\n" +
"        transition: all 0.3s ease;\n" +
"    }\n" +
"\n" +
"    /* Slider dot bullets */\n" +
"    .swiper-pagination-bullet-active,\n" +
"    .bdt-ps-dot-active,\n" +
"    .bdt-ps-bullet-active {\n" +
"        background-color: var(--accent-blue-hover) !important;\n" +
"    }\n" +
"\n" +
"    /* Border blue accents */\n" +
"    .elementor-element-7cf5f55, \n" +
"    .elementor-widget-divider,\n" +
"    .elementor-divider-separator {\n" +
"        border-color: var(--border-blue) !important;\n" +
"    }\n" +
"</style>\n";

// Inject before </head>
html = html.replace("</head>", styleBlock + "</head>");
WScript.Echo("Custom style block injected.");

// 2. Replace Logo Image references
var logoRegex = /<img([^>]*?)src="https:\/\/datakoku\.com\/arthouseinteriordemo\/wp-content\/uploads\/2025\/11\/Logo-1\.png"([^>]*?)>/gi;
html = html.replace(logoRegex, '<img$1src="logo.png" style="max-height:80px; object-fit:contain;"$2>');
html = html.replace(/src="logo\.png"([^>]*?)srcset="[^"]*"/gi, 'src="logo.png"$1');
html = html.replace(/src="logo\.png"([^>]*?)sizes="[^"]*"/gi, 'src="logo.png"$1');
WScript.Echo("Logo images replaced with local logo.png.");

// 3. Remove content protection stylesheets and scripts
html = html.replace(/<link\s+rel='stylesheet'\s+id='disabled-source-and-content-protection-css-css'[^>]*>/gi, '<!-- removed protection css -->');
html = html.replace(/<script\s+src="[^"]*protection\.js[^"]*"[^>]*><\/script>/gi, '<!-- removed protection js -->');
html = html.replace(/<script\s+id="disabled-source-and-content-protection-js-js-extra"[\s\S]*?<\/script>/gi, '<!-- removed protection config -->');
WScript.Echo("Content protection scripts stripped.");

// 4. Replace process step images with the AI-generated ones
html = html.replace(/src="[^"]*Initial-Consultation-Requirement[^"]*"/gi, 'src="images/process_1.png"');
html = html.replace(/src="[^"]*Concept-Development-Mood-Board-Creation[^"]*"/gi, 'src="images/process_2.png"');
html = html.replace(/src="[^"]*Detailed-Design-Technical-Planning[^"]*"/gi, 'src="images/process_3.png"');
html = html.replace(/src="[^"]*Execution-Supervision-Final-Handover[^"]*"/gi, 'src="images/process_4.png"');

html = html.replace(/srcset="[^"]*Initial-Consultation-Requirement[^"]*"/gi, 'srcset=""');
html = html.replace(/srcset="[^"]*Concept-Development-Mood-Board-Creation[^"]*"/gi, 'srcset=""');
html = html.replace(/srcset="[^"]*Detailed-Design-Technical-Planning[^"]*"/gi, 'srcset=""');
html = html.replace(/srcset="[^"]*Execution-Supervision-Final-Handover[^"]*"/gi, 'srcset=""');
WScript.Echo("Process step images updated.");

// 5. Cycle through the 64 local images for all other content images
var imageIndex = 1;
var totalLocalImages = 64;
var imgTagRegex = /<img\s+([^>]*?)src="([^"]+)"([^>]*?)>/gi;

html = html.replace(imgTagRegex, function(match, before, src, after) {
    var srcLower = src.toLowerCase();
    // Keep logos, process images, tiny step badges, and graphic icons
    if (srcLower.indexOf("logo.png") !== -1 || 
        srcLower.indexOf("process_") !== -1 ||
        srcLower.indexOf("1-1.png") !== -1 ||
        srcLower.indexOf("2-1.png") !== -1 ||
        srcLower.indexOf("3-1.png") !== -1 ||
        srcLower.indexOf("4-1.png") !== -1 ||
        srcLower.indexOf("graphic-element.png") !== -1) {
        return match;
    }
    
    var localImgSrc = "images/img_" + imageIndex + ".jpg";
    imageIndex++;
    if (imageIndex > totalLocalImages) {
        imageIndex = 1;
    }
    
    var cleanedBefore = before.replace(/srcset="[^"]*"/gi, '').replace(/sizes="[^"]*"/gi, '');
    var cleanedAfter = after.replace(/srcset="[^"]*"/gi, '').replace(/sizes="[^"]*"/gi, '');
    
    return '<img ' + cleanedBefore + 'src="' + localImgSrc + '"' + cleanedAfter + '>';
});
WScript.Echo("Local cycled images applied: " + (imageIndex - 1) + " elements updated.");

// 6. Replace CSS background webp images
var bgIndex = 1;
html = html.replace(/url\(['"]?https?:\/\/datakoku\.com\/arthouseinteriordemo\/wp-content\/uploads\/2026\/03\/[357]\.webp['"]?\)/gi, function() {
    var bgUrl = "url('images/img_" + bgIndex + ".jpg')";
    bgIndex++;
    return bgUrl;
});
WScript.Echo("Background images mapped to local assets.");

// 7. Neutralize links without breaking CSS/JS assets (using negative lookaheads!)
// Strip alternate meta links in head
html = html.replace(/<link\s+rel="alternate"[^>]*>/gi, '<!-- removed alternate link -->');
html = html.replace(/<link\s+rel='shortlink'[^>]*>/gi, '<!-- removed shortlink -->');
html = html.replace(/<link\s+rel="https:\/\/api\.w\.org\/"[^>]*>/gi, '<!-- removed api link -->');

// Replaces page links
html = html.replace(/https?:\/\/datakoku\.com\/arthouseinteriordemo\/services\/[a-zA-Z0-9_-]*\/?/gi, '#services');
html = html.replace(/https?:\/\/datakoku\.com\/arthouseinteriordemo\/projects\/[a-zA-Z0-9_-]*\/?/gi, '#projects');
html = html.replace(/https?:\/\/datakoku\.com\/arthouseinteriordemo\/contact-us\/?/gi, '#contact');
html = html.replace(/https?:\/\/datakoku\.com\/arthouseinteriordemo\/about-us\/?/gi, '#about');
html = html.replace(/https?:\/\/datakoku\.com\/arthouseinteriordemo\/our-certifications\/?/gi, '#certifications');
html = html.replace(/https?:\/\/datakoku\.com\/arthouseinteriordemo\/blog\/?/gi, '#blog');

// Replaces JSON-escaped page links
html = html.replace(/https?:\\\/\\\/datakoku\.com\\\/arthouseinteriordemo\\\/services\\\/[a-zA-Z0-9_-]*\\\/?/gi, '#services');
html = html.replace(/https?:\\\/\\\/datakoku\.com\\\/arthouseinteriordemo\\\/projects\\\/[a-zA-Z0-9_-]*\\\/?/gi, '#projects');
html = html.replace(/https?:\\\/\\\/datakoku\.com\\\/arthouseinteriordemo\\\/contact-us\\\/?/gi, '#contact');
html = html.replace(/https?:\\\/\\\/datakoku\.com\\\/arthouseinteriordemo\\\/about-us\\\/?/gi, '#about');
html = html.replace(/https?:\\\/\\\/datakoku\.com\\\/arthouseinteriordemo\\\/our-certifications\\\/?/gi, '#certifications');
html = html.replace(/https?:\\\/\\\/datakoku\.com\\\/arthouseinteriordemo\\\/blog\\\/?/gi, '#blog');

// Neutralize base domain references EXCEPT wp-content / wp-includes assets
// Negative lookahead: (?!wp-) matches only when not followed by wp-content or wp-includes
html = html.replace(/https?:\/\/datakoku\.com\/arthouseinteriordemo\/(?!wp-)[^"\s']*/gi, '#home');
html = html.replace(/https?:\\\/\\\/datakoku\.com\\\/arthouseinteriordemo\\\/(?!wp-)[^"\s'\\\}]*/gi, '#home');

WScript.Echo("Links neutralized. Styles/scripts preserved.");

// 8. Save refactored HTML
var streamWrite = new ActiveXObject("ADODB.Stream");
streamWrite.Type = 2; // text
streamWrite.Charset = "utf-8";
streamWrite.Open();
streamWrite.WriteText(html);
streamWrite.SaveToFile("C:\\Users\\sky\\.gemini\\antigravity\\scratch\\arthouse-clone\\index.html", 2); // 2 = overwrite
streamWrite.Close();

WScript.Echo("Refactor complete.");
