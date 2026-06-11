$path = "C:\Users\sky\.gemini\antigravity\scratch\arthouse-clone\projects.html"
$content = [System.IO.File]::ReadAllText($path)

$css1 = @"
<style id="blue-black-theme-overrides">
    :root {
        --bg-1800: #f4f1ea;
        --text-1800: #2c2a25;
        --accent-1800: #8c2a2a; /* Muted red for accents, like old wax seals */
        --font-serif: 'Playfair Display', 'Times New Roman', serif;
    }
    
    body, .elementor-section, .e-con, .e-con-inner, .e-con-boxed, header, footer, .hello-header, .hello-footer, .e-off-canvas__main, .e-off-canvas__content {
        background-color: var(--bg-1800) !important;
        background-image: none !important;
        color: var(--text-1800) !important;
        font-family: var(--font-serif) !important;
    }
    
    /* 1800s Shadows and Borders for Nav */
    header.elementor-location-header, .elementor-element-72e8682, .elementor-element-7c9a95c {
        border: none !important;
        border-bottom: 2px solid var(--text-1800) !important;
        box-shadow: none !important;
        background-color: var(--bg-1800) !important;
        backdrop-filter: none !important;
    }

    .e-n-menu-content, .e-n-menu-wrapper, .e-n-menu-content > .elementor-element, .elementor-element-a5e383d, .elementor-element-f7f117d .e-off-canvas__main, .elementor-element-2785e2f .e-off-canvas__main, .elementor-element-9ea6b72 .e-off-canvas__main {
        border: 2px solid var(--text-1800) !important;
        border-radius: 0 !important;
        background-color: var(--bg-1800) !important;
        box-shadow: 6px 6px 0px var(--text-1800) !important;
        backdrop-filter: none !important;
    }

    /* Typography */
    a, span, .nav a, .elementor-item, .e-n-menu-title-text, .elementor-heading-title, h1, h2, h3, h4, h5, h6, p, .elementor-icon-list-text, .elementor-icon-list-item {
        color: var(--text-1800) !important;
        font-family: var(--font-serif) !important;
    }

    a:hover, .nav a:hover, .elementor-item:hover, .e-n-menu-title-text:hover {
        color: var(--accent-1800) !important;
        font-style: italic;
    }

    /* Menu Cards */
    .menu-services-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 16px;
        padding: 24px;
    }
    .menu-services-card {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 16px 20px;
        background: var(--bg-1800);
        border: 1px solid var(--text-1800);
        text-decoration: none !important;
        box-shadow: 4px 4px 0px var(--text-1800);
        transition: all 0.15s ease;
    }
    .menu-services-card:hover {
        transform: translate(2px, 2px);
        box-shadow: 2px 2px 0px var(--text-1800);
    }
    .menu-services-card i {
        color: var(--text-1800);
    }
</style>
"@

$css2 = @"
<style id="projects-page-styles">
    /* 1800s PROJECTS PAGE STYLES */
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
        font-family: var(--font-serif);
        background-color: var(--bg-1800);
        color: var(--text-1800);
        overflow-x: hidden;
    }

    /* ---- HERO SECTION ---- */
    .projects-hero {
        position: relative;
        width: 100%;
        min-height: 400px;
        background: var(--bg-1800);
        border-bottom: 3px double var(--text-1800);
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 120px 24px 80px;
        text-align: center;
    }

    .projects-hero-content {
        max-width: 700px;
        border: 1px solid var(--text-1800);
        padding: 40px;
        box-shadow: 8px 8px 0px var(--text-1800);
        background: #fffdf5; /* slightly lighter for contrast */
    }

    .hero-eyebrow {
        display: inline-block;
        font-size: 0.85rem;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 0.15em;
        border-bottom: 1px solid var(--text-1800);
        margin-bottom: 20px;
        padding-bottom: 5px;
    }

    .projects-hero h1 {
        font-size: clamp(2.5rem, 5vw, 4rem);
        font-weight: normal;
        margin-bottom: 10px;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    .projects-hero-subtitle {
        font-style: italic;
        font-size: clamp(1.2rem, 3vw, 1.8rem);
        margin-bottom: 20px;
        display: block;
    }

    .projects-hero-desc {
        font-size: 1.1rem;
        line-height: 1.6;
        max-width: 500px;
        margin: 0 auto;
    }

    /* ---- STATS BAR ---- */
    .stats-bar {
        border-bottom: 2px solid var(--text-1800);
        background: var(--bg-1800);
    }
    .stats-bar-inner {
        max-width: 1200px;
        margin: 0 auto;
        display: grid;
        grid-template-columns: repeat(4, 1fr);
    }
    .stat-item {
        padding: 30px 20px;
        text-align: center;
        border-right: 1px solid var(--text-1800);
    }
    .stat-item:last-child { border-right: none; }
    .stat-number {
        font-size: 2.5rem;
        font-weight: normal;
        margin-bottom: 5px;
    }
    .stat-label {
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 2px;
    }
    .stat-icon { display: none; } /* Hide modern icons */

    /* ---- FILTER TABS ---- */
    .projects-filter-section {
        padding: 60px 24px;
        text-align: center;
    }
    .filter-section-title {
        font-size: 2.2rem;
        text-transform: uppercase;
        margin-bottom: 10px;
        text-decoration: underline;
        text-underline-offset: 6px;
    }
    .filter-tabs {
        display: inline-flex;
        flex-wrap: wrap;
        gap: 10px;
        justify-content: center;
        margin-top: 20px;
    }
    .filter-tab {
        padding: 8px 16px;
        font-family: var(--font-serif);
        font-size: 1rem;
        background: transparent;
        border: 1px solid var(--text-1800);
        color: var(--text-1800) !important;
        cursor: pointer;
        box-shadow: 2px 2px 0px var(--text-1800);
        transition: transform 0.1s;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    .filter-tab:hover, .filter-tab.active {
        background: var(--text-1800);
        color: var(--bg-1800) !important;
        transform: translate(2px, 2px);
        box-shadow: 0px 0px 0px var(--text-1800);
    }

    /* ---- PROJECTS GRID SECTION ---- */
    .projects-section {
        padding: 20px 24px 80px;
        max-width: 1300px;
        margin: 0 auto;
    }
    .projects-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 40px;
    }

    /* ---- SINGLE PROJECT CARD ---- */
    .project-card {
        position: relative;
        background: #fffdf5; /* off-white paper */
        border: 2px solid var(--text-1800);
        box-shadow: 8px 8px 0px var(--text-1800); /* 1800s rigid shadow, no glow */
        padding: 10px;
        transition: transform 0.2s, box-shadow 0.2s;
        cursor: pointer;
    }
    .project-card:hover {
        transform: translate(4px, 4px);
        box-shadow: 4px 4px 0px var(--text-1800);
    }

    /* Image wrapper like an old photograph */
    .card-image-wrap {
        border: 1px solid var(--text-1800);
        aspect-ratio: 4/3;
        overflow: hidden;
        filter: grayscale(80%) sepia(30%); /* Vintage look for images */
        transition: filter 0.3s;
    }
    .project-card:hover .card-image-wrap {
        filter: grayscale(0%) sepia(10%);
    }
    .card-image-wrap img {
        width: 100%; height: 100%; object-fit: cover;
    }

    /* Low opacity cutout stickers */
    .card-badge {
        position: absolute;
        top: -15px;
        right: -15px;
        background: #f4eada;
        border: 1px dashed var(--text-1800);
        padding: 10px 20px;
        transform: rotate(8deg);
        opacity: 0.85;
        box-shadow: 2px 2px 0px rgba(44, 42, 37, 0.4);
        font-family: 'Courier New', Courier, monospace, serif;
        font-weight: bold;
        color: var(--text-1800) !important;
        text-transform: uppercase;
        letter-spacing: 2px;
        z-index: 10;
        clip-path: polygon(0% 5%, 5% 0%, 95% 0%, 100% 5%, 100% 95%, 95% 100%, 5% 100%, 0% 95%);
    }

    /* Hide modern overlays */
    .card-overlay { display: none; }

    /* Card footer */
    .card-footer {
        padding: 20px 10px 10px;
        text-align: center;
        border-top: 1px solid var(--text-1800);
        margin-top: 10px;
    }
    .card-title {
        font-size: 1.4rem;
        font-weight: normal;
        text-transform: uppercase;
        letter-spacing: 1px;
    }
    .card-meta { display: none; } /* hide modern meta data */

    /* ---- CTA SECTION ---- */
    .projects-cta {
        margin: 80px 24px;
        max-width: 900px;
        margin-left: auto;
        margin-right: auto;
        background: #fffdf5;
        border: 3px double var(--text-1800);
        box-shadow: 10px 10px 0px var(--text-1800);
        padding: 60px 40px;
        text-align: center;
        position: relative;
    }
    .cta-eyebrow {
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 3px;
        border-bottom: 1px solid var(--text-1800);
        margin-bottom: 20px;
        display: inline-block;
    }
    .cta-title {
        font-size: clamp(2rem, 4vw, 3rem);
        text-transform: uppercase;
        margin-bottom: 20px;
    }
    .cta-subtitle {
        font-style: italic;
        font-size: 1.5rem;
        margin-bottom: 20px;
        display: block;
    }
    .cta-desc {
        font-size: 1.1rem;
        max-width: 500px;
        margin: 0 auto 30px;
        line-height: 1.5;
    }
    .cta-buttons {
        display: flex;
        justify-content: center;
        gap: 20px;
    }
    .cta-btn-primary, .cta-btn-secondary {
        padding: 12px 30px;
        font-family: var(--font-serif);
        font-size: 1.1rem;
        text-transform: uppercase;
        letter-spacing: 2px;
        border: 1px solid var(--text-1800);
        text-decoration: none;
        color: var(--text-1800) !important;
        box-shadow: 4px 4px 0px var(--text-1800);
        background: transparent;
        transition: transform 0.1s, box-shadow 0.1s;
    }
    .cta-btn-primary:hover, .cta-btn-secondary:hover {
        transform: translate(2px, 2px);
        box-shadow: 2px 2px 0px var(--text-1800);
        background: var(--text-1800);
        color: var(--bg-1800) !important;
    }

    @media (max-width: 1024px) {
        .projects-grid { grid-template-columns: repeat(2, 1fr); }
    }
    @media (max-width: 768px) {
        .projects-grid { grid-template-columns: 1fr; }
        .stats-bar-inner { grid-template-columns: repeat(2, 1fr); }
        .stat-item { border-bottom: 1px solid var(--text-1800); }
    }
</style>
"@

$content = $content -replace '(?s)<style id="blue-black-theme-overrides">.*?</style>', $css1
$content = $content -replace '(?s)<style id="projects-page-styles">.*?</style>', $css2

[System.IO.File]::WriteAllText($path, $content)
Write-Output "Successfully replaced CSS."
