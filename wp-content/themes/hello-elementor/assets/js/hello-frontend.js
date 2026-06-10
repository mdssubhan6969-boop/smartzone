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
        
        // Convert static buttons to premium Glass buttons
        const buttons = document.querySelectorAll('.elementor-button, .btn, .btn-primary, .btn-secondary, .cta-btn, .cta-btn-secondary');
        buttons.forEach(btn => {
            if (btn.classList.contains('glass-button') || btn.closest('.glass-button-wrap') || btn.closest('.elementor-widget-icon') || btn.classList.contains('elementor-icon')) return;
            
            const originalContent = btn.innerHTML;
            
            // Create wrapper
            const wrapper = document.createElement('div');
            wrapper.className = 'glass-button-wrap cursor-pointer rounded-full';
            
            // Sizing classes mapping
            if (btn.classList.contains('elementor-size-sm')) wrapper.classList.add('size-sm');
            if (btn.classList.contains('elementor-size-lg')) wrapper.classList.add('size-lg');
            
            btn.parentNode.insertBefore(wrapper, btn);
            wrapper.appendChild(btn);
            
            btn.classList.add('glass-button');
            btn.innerHTML = `<span class="glass-button-text relative block select-none tracking-tighter">${originalContent}</span>`;
            
            const shadow = document.createElement('div');
            shadow.className = 'glass-button-shadow rounded-full';
            wrapper.appendChild(shadow);
        });
    });
})();