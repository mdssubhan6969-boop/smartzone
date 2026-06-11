!function(){class e{constructor(){this.initSettings(),this.initElements(),this.bindEvents()}initSettings(){this.settings={selectors:{menuToggle:".site-header .site-navigation-toggle",menuToggleHolder:".site-header .site-navigation-toggle-holder",dropdownMenu:".site-header .site-navigation-dropdown"}}}initElements(){this.elements={window:window,menuToggle:document.querySelector(this.settings.selectors.menuToggle),menuToggleHolder:document.querySelector(this.settings.selectors.menuToggleHolder),dropdownMenu:document.querySelector(this.settings.selectors.dropdownMenu)}}bindEvents(){this.elements.menuToggleHolder&&!this.elements.menuToggleHolder?.classList.contains("hide")&&(this.elements.menuToggle.addEventListener("click",()=>this.handleMenuToggle()),this.elements.dropdownMenu.querySelectorAll(".menu-item-has-children > a").forEach(e=>e.addEventListener("click",e=>this.handleMenuChildren(e))))}closeMenuItems(){this.elements.menuToggleHolder.classList.remove("elementor-active"),this.elements.window.removeEventListener("resize",()=>this.closeMenuItems())}handleMenuToggle(){const e=!this.elements.menuToggleHolder.classList.contains("elementor-active");this.elements.menuToggle.setAttribute("aria-expanded",e),this.elements.dropdownMenu.setAttribute("aria-hidden",!e),this.elements.dropdownMenu.inert=!e,this.elements.menuToggleHolder.classList.toggle("elementor-active",e),this.elements.dropdownMenu.querySelectorAll(".elementor-active").forEach(e=>e.classList.remove("elementor-active")),e?this.elements.window.addEventListener("resize",()=>this.closeMenuItems()):this.elements.window.removeEventListener("resize",()=>this.closeMenuItems())}handleMenuChildren(e){const t=e.currentTarget.parentElement;t?.classList&&t.classList.toggle("elementor-active")}}document.addEventListener("DOMContentLoaded",()=>{new e})}();

// Dynamic 3D Adaptive Nav Pill Injection
(function() {
    const pathname = window.location.pathname;
    const filename = pathname.substring(pathname.lastIndexOf('/') + 1) || 'index.html';
    
    let activePage = 'home';
    let label = 'Home';
    
    if (filename.indexOf('services.html') !== -1) {
        activePage = 'services';
        label = 'Services';
    } else if (filename.indexOf('projects.html') !== -1) {
        activePage = 'projects';
        label = 'Our Projects';
    } else if (filename.indexOf('learn.html') !== -1) {
        activePage = 'learn';
        label = 'Learn & About';
    } else if (filename.indexOf('blog.html') !== -1) {
        activePage = 'blog';
        label = 'Design Blog';
    }
    
    // Create the Pill Markup
    const pill = document.createElement('div');
    pill.className = 'nav-pill-container';
    pill.innerHTML = `
        <div class="nav-pill-ridge"></div>
        <div class="nav-pill-gloss"></div>
        <div class="nav-pill-items-wrap">
            <span class="nav-pill-active-label"><i class="fas fa-bars" style="margin-right: 8px; color: #C5A880;"></i> ${label}</span>
            <ul class="nav-pill-links-list">
                <li class="nav-pill-link-item ${activePage === 'home' ? 'active' : ''}"><a href="index.html#home">Home</a></li>
                <li class="nav-pill-link-item ${activePage === 'services' ? 'active' : ''}"><a href="services.html">Services</a></li>

                <li class="nav-pill-link-item ${activePage === 'projects' ? 'active' : ''}"><a href="projects.html">Projects</a></li>
                <li class="nav-pill-link-item ${activePage === 'learn' ? 'active' : ''}"><a href="learn.html">Learn</a></li>
                <li class="nav-pill-link-item ${activePage === 'blog' ? 'active' : ''}"><a href="blog.html">Blog</a></li>
                <li class="nav-pill-link-item"><a href="index.html#contact">Contact</a></li>
            </ul>
        </div>
    `;
    
    // Append to body
    document.addEventListener("DOMContentLoaded", function() {
        document.body.appendChild(pill);
        
        // Remove Newsletter form from DOM
        const newsletter = document.querySelector('.elementor-element-d3d5bff');
        if (newsletter) {
            newsletter.remove();
        }
        
        // Convert static buttons to premium Flip buttons (including hero slide button)
        const buttons = document.querySelectorAll('.elementor-button, .btn, .btn-primary, .btn-secondary, .cta-btn, .cta-btn-secondary, .bdt-slide-btn');
        buttons.forEach(btn => {
            if (btn.classList.contains('flip-button') || btn.closest('.flip-button-wrap') || btn.closest('.elementor-widget-icon') || btn.classList.contains('elementor-icon')) return;
            
            const originalContent = btn.innerHTML;
            const originalText = btn.textContent ? btn.textContent.trim() : "";
            
            // Sizing classes mapping
            let sizeClass = "";
            if (btn.classList.contains('elementor-size-sm') || btn.classList.contains('btn-sm')) sizeClass = 'size-sm';
            if (btn.classList.contains('elementor-size-lg') || btn.classList.contains('btn-lg')) sizeClass = 'size-lg';

            // Determine the flipped text mapping based on original text
            const textMapping = {
                "Get a Quote": "Free Estimate",
                "Read Full Article": "Open Post",
                "Join": "Subscribe",
                "Book a Free Consultation": "Book Now",
                "Call our Expert Designers": "Dial (800)",
                "Consult Today": "Let's Start",
                "Submit": "Sending...",
                "Cancel": "Submit",
                "Back to Home": "Go Home",
                "Download / Print PDF": "Print Now"
            };

            // Clean up text for lookup (case insensitive / trim spaces / normalize newlines)
            let cleanedText = originalText.replace(/\s+/g, ' ').trim();
            let mappedText = "Click Me"; // Fallback
            
            // Look for a close match in the keys
            let matchFound = false;
            for (const [key, val] of Object.entries(textMapping)) {
                if (cleanedText.toLowerCase().includes(key.toLowerCase()) || key.toLowerCase().includes(cleanedText.toLowerCase())) {
                    mappedText = val;
                    matchFound = true;
                    break;
                }
            }
            if (!matchFound) {
                if (cleanedText.length > 0) {
                    mappedText = "Let's Go!";
                } else {
                    mappedText = "Learn More";
                }
            }

            // Create wrapper
            const wrapper = document.createElement('div');
            wrapper.className = 'flip-button-wrap';
            if (sizeClass) wrapper.classList.add(sizeClass);
            
            btn.parentNode.insertBefore(wrapper, btn);
            wrapper.appendChild(btn);
            
            btn.classList.add('flip-button');
            if (sizeClass) btn.classList.add(sizeClass);
            
            btn.innerHTML = `
                <span class="flip-button-front">${originalContent}</span>
                <span class="flip-button-back">${mappedText}</span>
            `;
            
            // Toggle state on click
            wrapper.addEventListener('click', (e) => {
                wrapper.classList.toggle('flipped');
                
                // If it is a link with a valid destination, delay navigation so they can see the flip animation
                const href = btn.getAttribute('href');
                const target = btn.getAttribute('target');
                if (href && href !== '#' && !href.startsWith('javascript:')) {
                    e.preventDefault();
                    setTimeout(() => {
                        if (target === '_blank') {
                            window.open(href, '_blank');
                        } else {
                            window.location.href = href;
                        }
                    }, 500); // 500ms allows the flip rotation to show clearly
                }
            });
        });
    });
})();