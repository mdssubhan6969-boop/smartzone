$template = Get-Content -Path .\projects.html -Raw
$headerIndex = $template.IndexOf("</header>")
if ($headerIndex -eq -1) { Write-Host "Error finding header"; exit }
$headerHtml = $template.Substring(0, $headerIndex + 9)

$footerIndex = $template.IndexOf('<footer data-elementor-type="footer"')
if ($footerIndex -eq -1) { Write-Host "Error finding footer"; exit }
$footerHtml = $template.Substring($footerIndex)

$explorerHtml = @'

<main id="content" class="site-main">
    <!-- Hero Section for Contact -->
    <div class="elementor-section elementor-section-height-default" style="padding: 60px 20px 20px 20px; text-align: center; background-color: #f9f9fb; border-bottom: 1px solid rgba(0,0,0,0.03);">
        <span class="cursive-subtitle" style="font-family: var(--font-serif); font-style: italic; font-size: 1.5rem; color: #8c2a2a; display: block; margin-bottom: 5px;">Virtual Design Experience</span>
        <h1 style="font-family: var(--font-serif); font-size: clamp(2.2rem, 5vw, 3.5rem); font-weight: normal; color: var(--text-1800); margin-top: 10px; letter-spacing: -0.02em; text-transform: uppercase;">3D Design Studio Explorer</h1>
        <p style="font-family: var(--font-serif); color: var(--text-1800); max-width: 650px; margin: 15px auto 0 auto; font-size: 1.05rem; line-height: 1.6; font-style: italic;">
            Explore our interactive 3D floor plan layout. Click on glowing hotspots to zoom in and compare our real-life project visualizations with the interactive virtual space in real-time.
        </p>
    </div>

    <!-- 3D Scene Section -->
    <div style="max-width: 1400px; margin: 0 auto; padding: 0 20px;">
        <div id="canvas-container">
            <!-- Left Pane: Interactive 3D Canvas -->
            <div id="canvas-wrapper">
                <canvas id="three-canvas"></canvas>
                
                <!-- Game HUD Overlay inside Canvas -->
                <div id="ui-overlay">
                    <div class="instructions-card">
                        <h3><i class="fas fa-gamepad" style="color: #8c2a2a; margin-right: 8px;"></i> Studio Explorer HUD</h3>
                        <p style="margin-bottom: 10px; font-size: 0.78rem; line-height: 1.35;">Click pulsing hotspots, use the selector, or start a cinematic camera flythrough.</p>
                        
                        <div style="display: flex; flex-direction: column; gap: 8px; margin-top: 12px; pointer-events: auto;">
                            <button class="hud-action-btn" onclick="startCinematicTour()"><i class="fas fa-video"></i> Cinematic Tour</button>
                            <button class="hud-action-btn" onclick="toggleAllLights()"><i class="fas fa-lightbulb"></i> Toggle Room Lights</button>
                        </div>
                    </div>
                    
                    <div class="room-selector-widget">
                        <span style="font-size: 0.7rem; text-transform: uppercase; font-weight: 700; color: #94a3b8; padding-left: 10px; letter-spacing: 0.05em; font-family: sans-serif;">Navigate Rooms</span>
                        <button class="room-btn active" data-room="all"><i class="fas fa-map-marked-alt"></i> Full House Overview</button>
                        <button class="room-btn" data-room="living"><i class="fas fa-couch"></i> Living Room</button>
                        <button class="room-btn" data-room="bedroom"><i class="fas fa-bed"></i> Master Bed Suite</button>
                        <button class="room-btn" data-room="office"><i class="fas fa-desktop"></i> Creative Office</button>
                        <button class="room-btn" data-room="kitchen"><i class="fas fa-utensils"></i> Kitchen & Dining</button>
                    </div>
                </div>
            </div>
            
            <!-- Right Pane: Real-Life Reality Sync Showcase Panel -->
            <div id="reality-panel">
                <button class="close-card-btn" onclick="focusRoom('all')"><i class="fas fa-times"></i></button>
                <div class="reality-panel-content">
                    <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 6px;">
                        <span id="resemblance-badge" class="tag" style="background: rgba(140, 42, 42, 0.07); color: #8c2a2a; font-family: sans-serif; font-size: 0.65rem; font-weight: 700; letter-spacing: 0.05em; padding: 4px 8px; border-radius: 0; border: 1px solid #8c2a2a;">98% DESIGN SYNC</span>
                        <span style="font-size: 0.72rem; color: #64748B; font-weight: 500; font-family: sans-serif;">Reality Match Mode</span>
                    </div>
                    <h2 id="room-title" style="font-family: var(--font-serif); font-size: 1.6rem; color: var(--text-1800); margin: 5px 0 10px 0; font-weight: normal; text-transform: uppercase;">Minimalist Living Room</h2>
                    
                    <!-- Reality Photo and Hotspot Overlay -->
                    <div id="reality-image-container">
                        <img id="room-image" src="images/sofa_ivory_lshape.png" alt="Reality Visualizer Reference">
                        <!-- Hotspots dynamically injected here -->
                        <div id="photo-hotspots-overlay" style="position: absolute; top:0; left:0; width:100%; height:100%; pointer-events: auto;"></div>
                    </div>
                    
                    <p id="room-description" style="font-family: var(--font-serif); font-size: 0.95rem; line-height: 1.5; color: #475569; margin-bottom: 20px; font-style: italic;">
                        A thoughtfully curated space emphasizing organic textures, clean lines, and soft ambient lighting. Featuring our custom Ivory L-Shape sectional.
                    </p>
                    
                    <!-- Camera Perspective Match Dashboard -->
                    <button class="camera-sync-btn" onclick="matchPerspective()">
                        <i class="fas fa-camera"></i> Match Photo Camera Angle
                    </button>
                    
                    <!-- Swatches Board -->
                    <div class="material-board-container" style="margin-top: 15px; border-top: 1px solid rgba(0,0,0,0.06); padding-top: 15px;">
                        <h4 style="font-size: 0.72rem; font-weight: 700; color: #64748B; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 12px; font-family: sans-serif;">Material Palette</h4>
                        <div id="material-swatches" style="display: flex; flex-direction: column; gap: 10px;">
                            <!-- Swatches injected dynamically -->
                        </div>
                    </div>
                    
                    <div class="design-details-list" style="margin: 20px 0; border-top: 1px solid rgba(0,0,0,0.06); padding-top: 15px;">
                        <h4 style="font-size: 0.72rem; font-weight: 700; color: #64748B; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 8px; font-family: sans-serif;">Spatial Details:</h4>
                        <ul id="room-specs" style="list-style: none; padding-left: 0; font-family: var(--font-serif); font-size: 0.88rem; color: #475569; display: flex; flex-direction: column; gap: 6px;">
                            <!-- Injected dynamically -->
                        </ul>
                    </div>
                    
                    <a id="whatsapp-inquire-btn" href="#" target="_blank" class="inquire-btn" style="text-align: center; text-decoration: none; display: block; padding: 14px; background: #8c2a2a; color: #ffffff !important; border: 1px solid var(--text-1800); box-shadow: 4px 4px 0px var(--text-1800); font-weight: bold; font-family: sans-serif; text-transform: uppercase; letter-spacing: 0.05em; transition: all 0.2s; margin-top: auto;">
                        Inquire About This Space
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Contact Form Section -->
    <div id="quick-contact" class="elementor-section" style="padding: 80px 20px; background-color: var(--bg-1800); border-top: 2px solid var(--text-1800);">
        <div style="max-width: 800px; margin: 0 auto; background: #fffdf5; padding: 50px 40px; border-radius: 0; border: 2px solid var(--text-1800); box-shadow: 8px 8px 0px var(--text-1800);">
            <div style="text-align: center; margin-bottom: 40px;">
                <span class="cursive-subtitle" style="font-family: var(--font-serif); font-style: italic; font-size: 1.4rem; color: #8c2a2a;">Get in Touch</span>
                <h2 style="font-family: var(--font-serif); font-size: 2.2rem; font-weight: normal; color: var(--text-1800); margin-top: 10px; text-transform: uppercase; letter-spacing: 1px;">Request a Consultation</h2>
                <p style="color: var(--text-1800); font-size: 1rem; margin-top: 8px; font-style: italic;">Let us help translate your vision into a premium reality.</p>
            </div>
            
            <form id="contact-form" onsubmit="handleContactSubmit(event)" style="display: flex; flex-direction: column; gap: 20px;">
                <div style="display: flex; gap: 20px; flex-wrap: wrap;">
                    <div style="flex: 1; min-width: 280px; display: flex; flex-direction: column; gap: 8px;">
                        <label for="name" style="font-size: 0.85rem; font-weight: bold; text-transform: uppercase; color: var(--text-1800); font-family: var(--font-serif);">Full Name</label>
                        <input type="text" id="name" required style="padding: 12px; border: 1px solid var(--text-1800); background: #ffffff; border-radius: 0; font-family: var(--font-serif); font-size: 0.95rem; outline: none;">
                    </div>
                    <div style="flex: 1; min-width: 280px; display: flex; flex-direction: column; gap: 8px;">
                        <label for="email" style="font-size: 0.85rem; font-weight: bold; text-transform: uppercase; color: var(--text-1800); font-family: var(--font-serif);">Email Address</label>
                        <input type="email" id="email" required style="padding: 12px; border: 1px solid var(--text-1800); background: #ffffff; border-radius: 0; font-family: var(--font-serif); font-size: 0.95rem; outline: none;">
                    </div>
                </div>
                
                <div style="display: flex; gap: 20px; flex-wrap: wrap;">
                    <div style="flex: 1; min-width: 280px; display: flex; flex-direction: column; gap: 8px;">
                        <label for="phone" style="font-size: 0.85rem; font-weight: bold; text-transform: uppercase; color: var(--text-1800); font-family: var(--font-serif);">Phone Number</label>
                        <input type="tel" id="phone" placeholder="+971..." style="padding: 12px; border: 1px solid var(--text-1800); background: #ffffff; border-radius: 0; font-family: var(--font-serif); font-size: 0.95rem; outline: none;">
                    </div>
                    <div style="flex: 1; min-width: 280px; display: flex; flex-direction: column; gap: 8px;">
                        <label for="service" style="font-size: 0.85rem; font-weight: bold; text-transform: uppercase; color: var(--text-1800); font-family: var(--font-serif);">Service Needed</label>
                        <select id="service" style="padding: 12px; border: 1px solid var(--text-1800); background: #ffffff; border-radius: 0; font-family: var(--font-serif); font-size: 0.95rem; outline: none; cursor: pointer;">
                            <option value="interior">Interior Design</option>
                            <option value="turnkey">Turnkey Execution</option>
                            <option value="renovation">Renovation</option>
                            <option value="consultation">Design Consultation</option>
                        </select>
                    </div>
                </div>
                
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <label for="message" style="font-size: 0.85rem; font-weight: bold; text-transform: uppercase; color: var(--text-1800); font-family: var(--font-serif);">Your Message</label>
                    <textarea id="message" rows="5" required placeholder="Describe your project, spatial design needs or ideas..." style="padding: 12px; border: 1px solid var(--text-1800); background: #ffffff; border-radius: 0; font-family: var(--font-serif); font-size: 0.95rem; outline: none; resize: vertical;"></textarea>
                </div>
                
                <div style="text-align: center; margin-top: 15px;">
                    <button type="submit" style="padding: 14px 40px !important; font-family: var(--font-serif) !important; font-size: 1.1rem !important; background: transparent; border: 1px solid var(--text-1800); color: var(--text-1800); box-shadow: 4px 4px 0px var(--text-1800); cursor: pointer; text-transform: uppercase; letter-spacing: 1px; transition: all 0.2s;" onmouseenter="this.style.background='var(--text-1800)'; this.style.color='var(--bg-1800)'; this.style.transform='translate(2px, 2px)'; this.style.boxShadow='2px 2px 0px var(--text-1800)'" onmouseleave="this.style.background='transparent'; this.style.color='var(--text-1800)'; this.style.transform='translate(0, 0)'; this.style.boxShadow='4px 4px 0px var(--text-1800)'">Submit Request</button>
                </div>
            </form>
        </div>
    </div>
</main>

<!-- Custom Styles and Three.js / GSAP Library CDNs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/controls/OrbitControls.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>

<style>
    /* 3D Split Screen Canvas Explorer layout (Luxury White Glassmorphism Theme) */
    #canvas-container {
        position: relative;
        width: 100%;
        height: 780px;
        background: #f8fafc;
        border: 2px solid var(--text-1800);
        border-radius: 0;
        overflow: hidden;
        margin: 40px 0;
        box-shadow: 8px 8px 0px var(--text-1800);
        display: flex;
        flex-direction: row;
    }
    #canvas-wrapper {
        position: relative;
        width: 100%;
        height: 100%;
        transition: width 0.6s cubic-bezier(0.16, 1, 0.3, 1);
    }
    #canvas-wrapper.is-split {
        width: 55%;
    }
    #three-canvas {
        width: 100%;
        height: 100%;
        display: block;
    }
    #ui-overlay {
        position: absolute;
        top: 20px;
        left: 20px;
        display: flex;
        flex-direction: column;
        gap: 15px;
        pointer-events: none;
        max-width: 300px;
        z-index: 10;
    }
    .instructions-card, .room-selector-widget {
        pointer-events: auto;
        background: rgba(255, 253, 245, 0.9);
        backdrop-filter: blur(12px);
        border: 1px solid var(--text-1800);
        border-radius: 0;
        padding: 16px;
        box-shadow: 4px 4px 0px var(--text-1800);
        color: var(--text-1800);
    }
    .instructions-card h3 {
        font-family: var(--font-serif);
        font-size: 1.1rem;
        margin-bottom: 6px;
        color: var(--text-1800);
        font-weight: bold;
        display: flex;
        align-items: center;
        text-transform: uppercase;
    }
    .hud-action-btn {
        width: 100%;
        background: #ffffff;
        border: 1px solid var(--text-1800);
        padding: 8px 12px;
        font-family: var(--font-serif);
        font-size: 0.8rem;
        font-weight: bold;
        color: var(--text-1800);
        border-radius: 0;
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 8px;
        transition: all 0.2s ease;
        box-shadow: 2px 2px 0px var(--text-1800);
    }
    .hud-action-btn:hover {
        background: var(--text-1800);
        color: var(--bg-1800);
        transform: translate(1px, 1px);
        box-shadow: 1px 1px 0px var(--text-1800);
    }
    .room-selector-widget {
        display: flex;
        flex-direction: column;
        gap: 5px;
        padding: 12px 8px;
    }
    .room-btn {
        background: transparent;
        border: none;
        padding: 8px 10px;
        text-align: left;
        font-family: var(--font-serif);
        font-size: 0.88rem;
        font-weight: bold;
        border-radius: 0;
        cursor: pointer;
        transition: all 0.2s ease;
        color: var(--text-1800);
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .room-btn:hover {
        background: rgba(140, 42, 42, 0.05);
        color: #8c2a2a;
    }
    .room-btn.active {
        background: #8c2a2a;
        color: #ffffff !important;
    }
    .room-btn i {
        font-size: 0.85rem;
        width: 16px;
    }
    
    /* Right Pane: Reality Match Showcase Panel in White Glassmorphism */
    #reality-panel {
        width: 0%;
        height: 100%;
        display: none;
        flex-direction: column;
        background: rgba(255, 253, 245, 0.92);
        backdrop-filter: blur(20px);
        border-left: 2px solid var(--text-1800);
        overflow-y: auto;
        transition: width 0.6s cubic-bezier(0.16, 1, 0.3, 1);
        color: var(--text-1800);
        box-sizing: border-box;
        position: relative;
    }
    #reality-panel.is-visible {
        width: 45%;
        display: flex;
        padding: 24px;
    }
    
    .reality-panel-content {
        display: flex;
        flex-direction: column;
        height: 100%;
    }
    
    .close-card-btn {
        position: absolute;
        top: 18px;
        right: 18px;
        background: transparent;
        border: none;
        font-size: 1.25rem;
        cursor: pointer;
        color: #64748B;
        transition: color 0.2s;
        padding: 5px;
        z-index: 12;
    }
    .close-card-btn:hover {
        color: var(--text-1800);
    }
    
    /* Reality Image and Hotspot layers */
    #reality-image-container {
        position: relative;
        width: 100%;
        aspect-ratio: 16/10;
        border: 1px solid var(--text-1800);
        background: #e2e8f0;
        overflow: hidden;
        margin-bottom: 20px;
    }
    #reality-image-container img {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }
    
    .photo-hotspot {
        position: absolute;
        transform: translate(-50%, -50%);
        cursor: pointer;
        z-index: 15;
    }
    .hotspot-dot {
        width: 12px;
        height: 12px;
        background: #8c2a2a;
        border: 2px solid #ffffff;
        border-radius: 50%;
        box-shadow: 0 0 8px rgba(140, 42, 42, 0.6);
        transition: transform 0.25s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .photo-hotspot:hover .hotspot-dot, .photo-hotspot.active .hotspot-dot {
        transform: scale(1.35);
        background: #00E676;
        box-shadow: 0 0 10px rgba(0, 230, 118, 0.9);
    }
    .hotspot-pulse {
        position: absolute;
        top: -9px;
        left: -9px;
        width: 30px;
        height: 30px;
        border: 2px solid rgba(140, 42, 42, 0.4);
        border-radius: 50%;
        animation: pulse-ring 2.0s infinite;
        pointer-events: none;
    }
    .photo-hotspot:hover .hotspot-pulse, .photo-hotspot.active .hotspot-pulse {
        border-color: rgba(0, 230, 118, 0.5);
    }
    @keyframes pulse-ring {
        0% { transform: scale(0.4); opacity: 1; }
        100% { transform: scale(1.4); opacity: 0; }
    }
    .hotspot-tooltip {
        position: absolute;
        bottom: 20px;
        left: 50%;
        transform: translateX(-50%) translateY(10px);
        background: rgba(15, 23, 42, 0.95);
        backdrop-filter: blur(8px);
        color: #ffffff;
        padding: 5px 10px;
        border-radius: 4px;
        font-size: 0.7rem;
        font-weight: bold;
        white-space: nowrap;
        opacity: 0;
        visibility: hidden;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        border: 1px solid rgba(255,255,255,0.08);
        transition: all 0.25s cubic-bezier(0.16, 1, 0.3, 1);
        pointer-events: none;
        font-family: sans-serif;
    }
    .photo-hotspot:hover .hotspot-tooltip, .photo-hotspot.active .hotspot-tooltip {
        opacity: 1;
        visibility: visible;
        transform: translateX(-50%) translateY(0);
    }
    
    /* Camera Perspective Match button */
    .camera-sync-btn {
        width: 100%;
        background: rgba(0, 0, 0, 0.03);
        border: 1px solid var(--text-1800);
        color: var(--text-1800);
        padding: 11px 16px;
        font-size: 0.8rem;
        font-weight: bold;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        border-radius: 0;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        transition: all 0.2s ease;
        margin-bottom: 20px;
        font-family: sans-serif;
        box-shadow: 2px 2px 0px var(--text-1800);
    }
    .camera-sync-btn:hover {
        background: var(--text-1800);
        color: var(--bg-1800);
        transform: translate(1px, 1px);
        box-shadow: 1px 1px 0px var(--text-1800);
    }
    
    /* Swatch Item styling */
    .swatch-item {
        background: rgba(0, 0, 0, 0.03);
        padding: 8px 12px;
        border-radius: 0;
        cursor: pointer;
        border: 1px solid rgba(0, 0, 0, 0.08);
        transition: all 0.2s;
    }
    .swatch-item:hover {
        background: rgba(0, 0, 0, 0.06);
        border-color: var(--text-1800);
    }
    
    @media (max-width: 768px) {
        #canvas-container {
            flex-direction: column;
            height: 60vh;
            min-height: 500px;
        }
        #canvas-wrapper.is-split {
            width: 100%;
            height: 40%;
        }
        #reality-panel.is-visible {
            width: 100%;
            height: 60%;
            border-left: none;
            border-top: 2px solid var(--text-1800);
        }
        /* Mobile UI optimizations */
        .room-selector-widget {
            flex-direction: row;
            overflow-x: auto;
            bottom: 20px;
            right: auto;
            left: 50%;
            transform: translateX(-50%);
            width: 90%;
            justify-content: center;
        }
        .instructions-card {
            display: none !important; /* Hide popup blocking mobile view */
        }
        #ui-overlay {
            pointer-events: none; /* Let touches pass through except on buttons */
        }
        #ui-overlay > * {
            pointer-events: auto;
        }
    }
</style>

<!-- 3D Interactive Floor Plan WebGL Script -->
<script>
    // Procedural Texture Generator
    const textures = {
        // Ivory/Sage Boucle Texture
        createBoucleTexture(baseColorHex) {
            const canvas = document.createElement('canvas');
            canvas.width = 256;
            canvas.height = 256;
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = baseColorHex;
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Draw tiny curly boucle loops to simulate loops
            ctx.strokeStyle = 'rgba(255,255,255,0.35)';
            ctx.lineWidth = 1.2;
            for (let i = 0; i < 4000; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                const r = 1 + Math.random() * 2.2;
                ctx.beginPath();
                ctx.arc(x, y, r, 0, Math.PI * (1 + Math.random()));
                ctx.stroke();
            }
            ctx.strokeStyle = 'rgba(0,0,0,0.06)';
            ctx.lineWidth = 1.0;
            for (let i = 0; i < 3000; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                const r = 0.8 + Math.random() * 1.5;
                ctx.beginPath();
                ctx.arc(x, y, r, 0, Math.PI * (1 + Math.random()));
                ctx.stroke();
            }
            
            const texture = new THREE.CanvasTexture(canvas);
            texture.wrapS = THREE.RepeatWrapping;
            texture.wrapT = THREE.RepeatWrapping;
            texture.repeat.set(2, 2);
            return texture;
        },
        
        // Grayscale Bump Map for Boucle
        createBoucleBumpTexture() {
            const canvas = document.createElement('canvas');
            canvas.width = 128;
            canvas.height = 128;
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = '#808080';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            ctx.fillStyle = '#ffffff';
            for (let i = 0; i < 2500; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                const r = 1 + Math.random() * 1.5;
                ctx.beginPath();
                ctx.arc(x, y, r, 0, Math.PI * 2);
                ctx.fill();
            }
            ctx.fillStyle = '#000000';
            for (let i = 0; i < 1800; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                const r = 0.6 + Math.random() * 1.0;
                ctx.beginPath();
                ctx.arc(x, y, r, 0, Math.PI * 2);
                ctx.fill();
            }
            
            const texture = new THREE.CanvasTexture(canvas);
            texture.wrapS = THREE.RepeatWrapping;
            texture.wrapT = THREE.RepeatWrapping;
            texture.repeat.set(4, 4);
            return texture;
        },
        
        // Travertine Texture
        createTravertineTexture() {
            const canvas = document.createElement('canvas');
            canvas.width = 512;
            canvas.height = 512;
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = '#E4DEC6'; // travertine cream
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Horizontal pore structures / layered sediment lines
            for (let y = 0; y < canvas.height; y += 4 + Math.random() * 8) {
                ctx.fillStyle = Math.random() > 0.5 ? '#C7C0A6' : '#FAF6E6';
                ctx.fillRect(0, y, canvas.width, 1 + Math.random() * 3);
            }
            
            // Small organic sediment noise spots
            ctx.fillStyle = 'rgba(125, 117, 95, 0.25)';
            for (let i = 0; i < 5000; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                const w = 1 + Math.random() * 5;
                const h = 1 + Math.random() * 2;
                ctx.fillRect(x, y, w, h);
            }
            
            const texture = new THREE.CanvasTexture(canvas);
            texture.wrapS = THREE.RepeatWrapping;
            texture.wrapT = THREE.RepeatWrapping;
            return texture;
        },
        
        // Quartzite / Marble Texture
        createQuartziteTexture() {
            const canvas = document.createElement('canvas');
            canvas.width = 1024;
            canvas.height = 1024;
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = '#F8FAFC'; // soft quartzite base
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Elegant long veining bezier lines
            ctx.lineWidth = 1.8;
            const veinColors = ['rgba(148,163,184,0.14)', 'rgba(212,175,55,0.08)', 'rgba(100,116,139,0.08)'];
            for (let k = 0; k < 18; k++) {
                ctx.strokeStyle = veinColors[Math.floor(Math.random() * veinColors.length)];
                ctx.beginPath();
                ctx.moveTo(Math.random() * canvas.width, 0);
                ctx.bezierCurveTo(
                    Math.random() * canvas.width, canvas.height * 0.3,
                    Math.random() * canvas.width, canvas.height * 0.7,
                    Math.random() * canvas.width, canvas.height
                );
                ctx.stroke();
            }
            
            const texture = new THREE.CanvasTexture(canvas);
            return texture;
        },
        
        // Leather Grain Texture
        createLeatherTexture(baseColorHex) {
            const canvas = document.createElement('canvas');
            canvas.width = 256;
            canvas.height = 256;
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = baseColorHex;
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Add grain noise
            ctx.fillStyle = 'rgba(0,0,0,0.06)';
            for (let i = 0; i < 20000; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                ctx.fillRect(x, y, 1.2, 1.2);
            }
            ctx.fillStyle = 'rgba(255,255,255,0.04)';
            for (let i = 0; i < 15000; i++) {
                const x = Math.random() * canvas.width;
                const y = Math.random() * canvas.height;
                ctx.fillRect(x, y, 1.2, 1.2);
            }
            
            const texture = new THREE.CanvasTexture(canvas);
            texture.wrapS = THREE.RepeatWrapping;
            texture.wrapT = THREE.RepeatWrapping;
            texture.repeat.set(2, 2);
            return texture;
        },
        
        createLeatherBumpTexture() {
            const canvas = document.createElement('canvas');
            canvas.width = 128;
            canvas.height = 128;
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = '#808080';
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Random thin cell splits
            ctx.strokeStyle = 'rgba(0,0,0,0.12)';
            ctx.lineWidth = 0.5;
            for (let i = 0; i < 60; i++) {
                ctx.beginPath();
                ctx.moveTo(Math.random() * canvas.width, Math.random() * canvas.height);
                ctx.lineTo(Math.random() * canvas.width, Math.random() * canvas.height);
                ctx.stroke();
            }
            
            const texture = new THREE.CanvasTexture(canvas);
            texture.wrapS = THREE.RepeatWrapping;
            texture.wrapT = THREE.RepeatWrapping;
            texture.repeat.set(4, 4);
            return texture;
        },
        
        // Walnut Wood Grain Texture
        createWalnutTexture() {
            const canvas = document.createElement('canvas');
            canvas.width = 512;
            canvas.height = 512;
            const ctx = canvas.getContext('2d');
            ctx.fillStyle = '#4E342E'; // warm walnut base
            ctx.fillRect(0, 0, canvas.width, canvas.height);
            
            // Parallel wood growth ring wavy bezier paths
            ctx.lineWidth = 2.0;
            for (let i = -100; i < canvas.width + 100; i += 14 + Math.random() * 8) {
                ctx.strokeStyle = Math.random() > 0.5 ? '#3D261C' : '#5D4037';
                ctx.beginPath();
                ctx.moveTo(i, 0);
                ctx.bezierCurveTo(
                    i + 50, canvas.height * 0.25,
                    i - 50, canvas.height * 0.75,
                    i + 20, canvas.height
                );
                ctx.stroke();
            }
            
            const texture = new THREE.CanvasTexture(canvas);
            texture.wrapS = THREE.RepeatWrapping;
            texture.wrapT = THREE.RepeatWrapping;
            return texture;
        }
    };

    // Material references
    const roomMaterials = {
        living: [
            { id: 'boucle', name: 'Ivory Boucle Sectional', color: '#F5F2EB', desc: 'Curved, soft modular boucle fabric upholstery' },
            { id: 'travertine', name: 'Alabaster Travertine', color: '#E4DEC6', desc: 'Solid organic limestone slab coffee table' },
            { id: 'sage-green', name: 'Sage Green Boucle', color: '#828F7A', desc: 'Muted forest-toned accent swivel armchair' }
        ],
        bedroom: [
            { id: 'walnut', name: 'Fluted Walnut Wall Panels', color: '#4E342E', desc: 'Architectural vertical wooden headboard slats' },
            { id: 'sage-green', name: 'Sage Linen Sheets', color: '#98A996', desc: 'Washed European natural organic linen' },
            { id: 'leather', name: 'Cognac Saddle Leather', color: '#8C4F2D', desc: 'Buttery aniline leather lounge seat hide' }
        ],
        office: [
            { id: 'walnut', name: 'Solid Walnut L-Desk', color: '#5D4037', desc: 'Premium workspace hardwood surface slab' },
            { id: 'steel', name: 'Anodized Black Steel', color: '#1E293B', desc: 'Powder-coated frame supports and wall shelving tracks' },
            { id: 'foliage', name: 'Broad Ficus Leaves', color: '#2E5A36', desc: 'Broad leafy biophilic accents (Fiddle Fig tree)' }
        ],
        kitchen: [
            { id: 'quartzite', name: 'Taj Mahal Quartzite Countertop', color: '#F8FAFC', desc: 'Polished white quartzite slab waterfall island face' },
            { id: 'leather', name: 'Cognac Saddle Leather Seats', color: '#7E523A', desc: 'Fine saddle hide stitched bar stool seats' },
            { id: 'brass', name: 'Satin Brass Frame Accents', color: '#D4AF37', desc: 'Polished golden frame tubing and light mounts' }
        ]
    };

    const elementMaterials = {
        'living-sofa': 'boucle',
        'living-table': 'travertine',
        'living-chair': 'sage-green',
        'bedroom-bed': 'sage-green',
        'bedroom-wall': 'walnut',
        'bedroom-chair': 'leather',
        'office-desk': 'walnut',
        'office-chair': 'steel',
        'office-plant': 'foliage',
        'kitchen-island': 'quartzite',
        'kitchen-stools': 'leather',
        'kitchen-lights': 'brass'
    };

    // Realistic images matching each space
    const rooms = {
        living: {
            title: "Warm Contemporary Living Room",
            desc: "A spacious layout structured around a travertine fireplace and custom modular sectional configurations, matching our real-life design catalog perfectly.",
            image: "images/sofa_ivory_lshape.png",
            style: "Warm Boucle Contemporary",
            status: "Active Showcase",
            specs: [
                "<strong>Furniture:</strong> Modular Ivory L-Shape Boucle sectional",
                "<strong>Centerpiece:</strong> Honed cylindrical Travertine block coffee table",
                "<strong>Accent:</strong> Curved organic Sage Green boucle chair",
                "<strong>Area Size:</strong> 42 sq.m spatial footprint"
            ],
            camPos: { x: 10, y: 5, z: 12 },
            camTarget: { x: -4, y: 0.5, z: 4 }
        },
        bedroom: {
            title: "Master Bedroom Suite Sanctuary",
            desc: "A boutique suite design utilizing floor-to-ceiling fluted wood wall panels, natural linen sheets, and warm alabaster lighting globes.",
            image: "images/slider_1.png",
            style: "Biophilic Luxury",
            status: "Featured Design",
            specs: [
                "<strong>Panelling:</strong> Floor-to-ceiling vertical fluted walnut wood slats",
                "<strong>Linens:</strong> Organic Sage Green duvet with crisp white pillows",
                "<strong>Seating:</strong> High-back Cognac leather lounge chair",
                "<strong>Lighting:</strong> Alabaster spheres on gold brass mounts"
            ],
            camPos: { x: 2, y: 5, z: -2 },
            camTarget: { x: 4, y: 0.5, z: -4 }
        },
        office: {
            title: "Creative Executive Home Office",
            desc: "An ergonomic high-focus workspace maximizing vertical storage space with anodized black tracking shelves and warm walnut wood slabs.",
            image: "images/slider_2.png",
            style: "Industrial Office Scribe",
            status: "Visualized Concept",
            specs: [
                "<strong>Work Desk:</strong> Walnut L-Desk with black powder-coated steel legs",
                "<strong>Shelving:</strong> Floating black track shelves holding accessories",
                "<strong>Biophilic:</strong> Large detailed broad-leaf Fiddle Leaf Fig tree",
                "<strong>Display:</strong> Slimline widescreen display screen"
            ],
            camPos: { x: -10, y: 5, z: -2 },
            camTarget: { x: -4, y: 0.5, z: -4 }
        },
        kitchen: {
            title: "Minimalist Kitchen & Cocktail Bar",
            desc: "A sleek modern culinary island layout using Taj Mahal quartzite stone countertop slabs and custom cognac leather saddle stools with brass legs.",
            image: "images/project_chairs.png",
            style: "Sleek Quartzite Minimalist",
            status: "Built Portfolio",
            specs: [
                "<strong>Island Base:</strong> Charcoal carbon wood cabinets with a waterfall quartzite top",
                "<strong>Bar Stools:</strong> Saddle cognac leather seats on brass frames",
                "<strong>Lighting:</strong> Three gold brass cone pendant lamps with frosted bulbs",
                "<strong>Cabinetry:</strong> Flush handleless matte black cabinetry panels"
            ],
            camPos: { x: 12, y: 5, z: 10 },
            camTarget: { x: 4, y: 0.5, z: 4 }
        }
    };

    // Camera sync positions matching the actual images
    const cameraSyncData = {
        living: { pos: { x: -0.8, y: 1.8, z: 8.8 }, target: { x: -4.5, y: 0.8, z: 5.8 } },
        bedroom: { pos: { x: 4.5, y: 1.5, z: -0.6 }, target: { x: 4.5, y: 1.0, z: -4.5 } },
        office: { pos: { x: -1.6, y: 1.8, z: -4.1 }, target: { x: -4.5, y: 1.1, z: -4.5 } },
        kitchen: { pos: { x: 8.2, y: 1.9, z: 4.8 }, target: { x: 4.5, y: 1.1, z: 4.5 } }
    };

    // Hotspot coordinates overlaying the photos
    const photoHotspotsData = {
        living: [
            { name: 'living-sofa', label: 'Ivory Boucle L-Sectional', x: 55, y: 64 },
            { name: 'living-table', label: 'Travertine Pedestal Coffee Table', x: 42, y: 52 },
            { name: 'living-chair', label: 'Sage Green Boucle Swivel Chair', x: 80, y: 58 }
        ],
        bedroom: [
            { name: 'bedroom-bed', label: 'Sage Green Bed Sheets & Duvet', x: 52, y: 56 },
            { name: 'bedroom-wall', label: 'Vertical Fluted Walnut Wood Panel Wall', x: 48, y: 28 },
            { name: 'bedroom-chair', label: 'Cognac Leather Lounge Armchair', x: 18, y: 72 }
        ],
        office: [
            { name: 'office-desk', label: 'Floating Walnut L-Desk Surface', x: 48, y: 65 },
            { name: 'office-chair', label: 'High-Back Ergonomic Office Seat', x: 68, y: 74 },
            { name: 'office-plant', label: 'Broad Fiddle Leaf Fig Plant', x: 15, y: 52 }
        ],
        kitchen: [
            { name: 'kitchen-island', label: 'Waterfall Quartzite Island Countertop', x: 52, y: 50 },
            { name: 'kitchen-stools', label: 'Cognac Saddle Leather Stools', x: 38, y: 78 },
            { name: 'kitchen-lights', label: 'Satin Brass Cone Pendant Lights', x: 50, y: 18 }
        ]
    };

    let scene, camera, renderer, controls;
    let hotspots = [];
    let hoveredObject = null;
    let defaultCamPos = { x: 22, y: 18, z: 22 };
    let currentFocus = "all";
    let roomLights = {};
    let interactiveElements = [];

    // Helper: Register 3D group into raycaster tracking list
    function registerInteractive(obj, name) {
        obj.traverse(child => {
            if (child.isMesh) {
                child.userData.interactiveName = name;
                interactiveElements.push(child);
            }
        });
    }

    function init3DExplorer() {
        const container = document.getElementById('canvas-container');
        const wrapper = document.getElementById('canvas-wrapper');
        const width = wrapper.clientWidth;
        const height = wrapper.clientHeight;

        // Create Scene (Light luxury white theme background)
        scene = new THREE.Scene();
        scene.background = new THREE.Color(0xf8fafc);
        scene.fog = new THREE.FogExp2(0xf8fafc, 0.005);

        // Camera
        camera = new THREE.PerspectiveCamera(35, width / height, 0.1, 1000);
        camera.position.set(defaultCamPos.x, defaultCamPos.y, defaultCamPos.z);

        // Renderer
        renderer = new THREE.WebGLRenderer({ canvas: document.getElementById('three-canvas'), antialias: true });
        renderer.setSize(width, height);
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2));
        renderer.shadowMap.enabled = true;
        renderer.shadowMap.type = THREE.PCFSoftShadowMap;

        // Controls
        controls = new THREE.OrbitControls(camera, renderer.domElement);
        controls.enableDamping = true;
        controls.dampingFactor = 0.05;
        controls.maxPolarAngle = Math.PI / 2 - 0.05;
        controls.minDistance = 6;
        controls.maxDistance = 60;
        controls.target.set(0, 0, 0);

        // Ambient Lighting
        const ambientLight = new THREE.AmbientLight(0xffffff, 0.7);
        scene.add(ambientLight);

        // Sun light (Directional)
        const sunLight = new THREE.DirectionalLight(0xfffdf4, 0.95);
        sunLight.position.set(25, 30, 15);
        sunLight.castShadow = true;
        sunLight.shadow.mapSize.width = 2048;
        sunLight.shadow.mapSize.height = 2048;
        sunLight.shadow.camera.near = 0.5;
        sunLight.shadow.camera.far = 80;
        const d = 16;
        sunLight.shadow.camera.left = -d;
        sunLight.shadow.camera.right = d;
        sunLight.shadow.camera.top = d;
        sunLight.shadow.camera.bottom = -d;
        sunLight.shadow.bias = -0.0002;
        scene.add(sunLight);

        // Soft indirect blue fill light
        const indirectLight = new THREE.DirectionalLight(0xa6c5f7, 0.35);
        indirectLight.position.set(-25, 15, -15);
        scene.add(indirectLight);

        // Generate Light Oak Wood Floor Texture Procedurally to avoid CORS
        const floorCanvas = document.createElement('canvas');
        floorCanvas.width = 512; floorCanvas.height = 512;
        const ctxFloor = floorCanvas.getContext('2d');
        ctxFloor.fillStyle = '#E5D3B3'; // Light Oak Base
        ctxFloor.fillRect(0, 0, 512, 512);
        ctxFloor.lineWidth = 1;
        for (let y = 0; y < 512; y += 32) {
            ctxFloor.strokeStyle = 'rgba(0,0,0,0.1)';
            ctxFloor.beginPath(); ctxFloor.moveTo(0, y); ctxFloor.lineTo(512, y); ctxFloor.stroke();
            for(let x=0; x < 512; x+=128) {
                let offset = (y/32)%2===0 ? x : x+64;
                ctxFloor.beginPath(); ctxFloor.moveTo(offset, y); ctxFloor.lineTo(offset, y+32); ctxFloor.stroke();
            }
        }
        for(let i=0; i<300; i++) {
            ctxFloor.strokeStyle = 'rgba(139,69,19,0.05)';
            ctxFloor.beginPath();
            ctxFloor.moveTo(Math.random()*512, Math.random()*512);
            ctxFloor.lineTo(Math.random()*512, Math.random()*512);
            ctxFloor.stroke();
        }
        const woodTexture = new THREE.CanvasTexture(floorCanvas);
        woodTexture.wrapS = THREE.RepeatWrapping;
        woodTexture.wrapT = THREE.RepeatWrapping;
        woodTexture.repeat.set(8, 8);

        // 3D House Assembly
        buildRealisticHouse(woodTexture);

        // Add Glowing Hotspot Rings
        createHotspot(new THREE.Vector3(-4.5, 0.6, 4.5), 'living');
        createHotspot(new THREE.Vector3(4.5, 0.6, -4.5), 'bedroom');
        createHotspot(new THREE.Vector3(-4.5, 0.6, -4.5), 'office');
        createHotspot(new THREE.Vector3(4.5, 0.6, 4.5), 'kitchen');

        // Events
        window.addEventListener('resize', onWindowResize);
        
        const raycaster = new THREE.Raycaster();
        const mouse = new THREE.Vector2();
        let currentHoveredInteractiveName = null;

        wrapper.addEventListener('mousemove', (e) => {
            const rect = renderer.domElement.getBoundingClientRect();
            mouse.x = ((e.clientX - rect.left) / rect.width) * 2 - 1;
            mouse.y = -((e.clientY - rect.top) / rect.height) * 2 + 1;

            raycaster.setFromCamera(mouse, camera);
            
            // Check hotspots first
            const hotspotIntersects = raycaster.intersectObjects(hotspots);
            if (hotspotIntersects.length > 0) {
                document.body.style.cursor = 'pointer';
                if (hoveredObject !== hotspotIntersects[0].object) {
                    if (hoveredObject) shrinkHotspot(hoveredObject);
                    hoveredObject = hotspotIntersects[0].object;
                    growHotspot(hoveredObject);
                }
                return;
            } else {
                if (hoveredObject) {
                    shrinkHotspot(hoveredObject);
                    hoveredObject = null;
                }
            }

            // Check element hover sync
            const intersects = raycaster.intersectObjects(interactiveElements);
            if (intersects.length > 0) {
                const name = intersects[0].object.userData.interactiveName;
                if (currentHoveredInteractiveName !== name) {
                    currentHoveredInteractiveName = name;
                    document.body.style.cursor = 'pointer';
                    
                    // Highlight 3D element
                    highlight3DElement(name, true);
                    
                    // Highlight image hotspot
                    document.querySelectorAll('.photo-hotspot').forEach(el => {
                        if (el.getAttribute('data-name') === name) {
                            el.classList.add('active');
                        } else {
                            el.classList.remove('active');
                        }
                    });
                }
            } else {
                if (currentHoveredInteractiveName !== null) {
                    currentHoveredInteractiveName = null;
                    document.body.style.cursor = 'default';
                    highlight3DElement(null, false);
                    
                    document.querySelectorAll('.photo-hotspot').forEach(el => {
                        el.classList.remove('active');
                    });
                }
            }
        });

        wrapper.addEventListener('click', (e) => {
            if (e.target.tagName !== 'CANVAS') return;
            const rect = renderer.domElement.getBoundingClientRect();
            mouse.x = ((e.clientX - rect.left) / rect.width) * 2 - 1;
            mouse.y = -((e.clientY - rect.top) / rect.height) * 2 + 1;

            raycaster.setFromCamera(mouse, camera);
            const intersects = raycaster.intersectObjects(hotspots);

            if (intersects.length > 0) {
                const roomKey = intersects[0].object.userData.room;
                focusRoom(roomKey);
            }
        });

        // Animation loop
        const clock = new THREE.Clock();
        function animate() {
            requestAnimationFrame(animate);
            
            const elapsedTime = clock.getElapsedTime();
            
            // Pulse Hotspots
            hotspots.forEach(h => {
                const ring = h.children[0];
                if (ring) {
                    ring.scale.setScalar(1.2 + Math.sin(elapsedTime * 5) * 0.2);
                    ring.material.opacity = 0.85 - Math.sin(elapsedTime * 5) * 0.4;
                }
            });

            controls.update();
            renderer.render(scene, camera);
        }
        animate();
    }

    function buildRealisticHouse(woodTexture) {
        // Procedural Textures Generation
        const ivoryBoucleTexture = textures.createBoucleTexture('#F6F4F0');
        const sageBoucleTexture = textures.createBoucleTexture('#828F7A');
        const boucleBump = textures.createBoucleBumpTexture();

        const travertineTexture = textures.createTravertineTexture();
        const quartziteTexture = textures.createQuartziteTexture();

        const cognacLeatherTexture = textures.createLeatherTexture('#8C4F2D');
        const saddleLeatherTexture = textures.createLeatherTexture('#7E523A');
        const leatherBump = textures.createLeatherBumpTexture();

        const walnutTexture = textures.createWalnutTexture();

        // Upgraded Materials matching reference photos
        const ivoryFabric = new THREE.MeshStandardMaterial({ 
            map: ivoryBoucleTexture,
            bumpMap: boucleBump,
            bumpScale: 0.035,
            roughness: 0.85,
            name: 'boucle' 
        });

        const woodSlatMat = new THREE.MeshStandardMaterial({ 
            map: walnutTexture,
            roughness: 0.55,
            metalness: 0.05,
            name: 'walnut' 
        });

        const travertineMat = new THREE.MeshStandardMaterial({ 
            map: travertineTexture,
            roughness: 0.35,
            name: 'travertine' 
        });

        const sageGreenMat = new THREE.MeshStandardMaterial({ 
            map: sageBoucleTexture,
            bumpMap: boucleBump,
            bumpScale: 0.035,
            roughness: 0.85,
            name: 'sage-green' 
        });

        const cognacLeather = new THREE.MeshStandardMaterial({ 
            map: cognacLeatherTexture,
            bumpMap: leatherBump,
            bumpScale: 0.02,
            roughness: 0.45,
            metalness: 0.1,
            name: 'leather' 
        });

        const saddleLeatherMat = new THREE.MeshStandardMaterial({ 
            map: saddleLeatherTexture,
            bumpMap: leatherBump,
            bumpScale: 0.02,
            roughness: 0.45,
            metalness: 0.1,
            name: 'leather' 
        });

        const quartziteMat = new THREE.MeshStandardMaterial({ 
            map: quartziteTexture,
            roughness: 0.12,
            metalness: 0.08,
            name: 'quartzite' 
        });

        const brassMat = new THREE.MeshStandardMaterial({ 
            color: 0xD4AF37, 
            metalness: 0.95, 
            roughness: 0.1, 
            name: 'brass' 
        });

        const darkCabinetMat = new THREE.MeshStandardMaterial({ color: 0x1E293B, roughness: 0.55 });
        const glassMat = new THREE.MeshStandardMaterial({ color: 0xE2E8F0, roughness: 0.05, metalness: 0.95, transparent: true, opacity: 0.22 });
        const frameMat = new THREE.MeshStandardMaterial({ color: 0x1E293B, roughness: 0.6 });

        // Bed light bulb/globe materials (FIX: Declare globeGeo and globeMat globally in buildRealisticHouse scope)
        const globeGeo = new THREE.SphereGeometry(0.18, 16, 16);
        const globeMat = new THREE.MeshBasicMaterial({ color: 0xFFFDE7 });

        // Floor Slab (Solid wood tile herringbone layout)
        const floorGeo = new THREE.BoxGeometry(20, 0.3, 20);
        const floor = new THREE.Mesh(floorGeo, new THREE.MeshStandardMaterial({ map: woodTexture, roughness: 0.4, metalness: 0.05 }));
        floor.position.y = -0.15;
        floor.receiveShadow = true;
        scene.add(floor);

        // Drywall partitions
        const wallMat = new THREE.MeshStandardMaterial({ color: 0xF1F3F5, roughness: 0.75 });
        const walls = [
            { size: [20.4, 3.2, 0.4], pos: [0, 1.6, -10] }, // Back-Left Wall
            { size: [0.4, 3.2, 20], pos: [-10, 1.6, 0] },  // Back-Right Wall
            { size: [20, 3.2, 0.3], pos: [0, 1.6, 0] },    // Horizontal divider
            { size: [0.3, 3.2, 20], pos: [0, 1.6, 0] }     // Vertical divider
        ];

        walls.forEach(w => {
            const wallGeo = new THREE.BoxGeometry(w.size[0], w.size[1], w.size[2]);
            const wallMesh = new THREE.Mesh(wallGeo, wallMat);
            wallMesh.position.set(w.pos[0], w.pos[1], w.pos[2]);
            wallMesh.castShadow = true;
            wallMesh.receiveShadow = true;
            scene.add(wallMesh);
        });

        // Sliding Glass panel divider
        const glassPartition = new THREE.Mesh(new THREE.BoxGeometry(7.0, 3.2, 0.1), glassMat);
        glassPartition.position.set(4.5, 1.6, 0);
        scene.add(glassPartition);

        const topFrame = new THREE.Mesh(new THREE.BoxGeometry(7.2, 0.1, 0.15), frameMat);
        topFrame.position.set(4.5, 3.15, 0);
        scene.add(topFrame);


        // ==========================================
        // ROOM 1: LIVING ROOM (Bottom-Left Area)
        // ==========================================
        const lrRugGeo = new THREE.BoxGeometry(7.6, 0.04, 7.6);
        const lrRugMat = new THREE.MeshStandardMaterial({ color: 0xE5E1D7, roughness: 0.95 }); // Soft Ivory Boucle Rug
        const lrRug = new THREE.Mesh(lrRugGeo, lrRugMat);
        lrRug.position.set(-4.5, 0.02, 4.5);
        lrRug.receiveShadow = true;
        scene.add(lrRug);

        // CUSTOM SOFA (sofa_ivory_lshape.png Match: L-Shape modular sectional)
        const lrSofa = new THREE.Group();
        const sofaBaseMat = new THREE.MeshStandardMaterial({ color: 0x3E2D25, roughness: 0.6 }); // Oak Plinth
        
        // Wood plinth bases
        const baseLong = new THREE.Mesh(new THREE.BoxGeometry(4.2, 0.14, 1.45), sofaBaseMat);
        baseLong.position.set(0.1, 0.07, 0.3);
        baseLong.castShadow = true;
        lrSofa.add(baseLong);

        const baseChaise = new THREE.Mesh(new THREE.BoxGeometry(1.45, 0.14, 2.6), sofaBaseMat);
        baseChaise.position.set(-1.275, 0.07, 0.875);
        baseChaise.castShadow = true;
        lrSofa.add(baseChaise);

        // Accent Furniture (Ivory Boucle)
        const cushionLong = new THREE.Mesh(new THREE.BoxGeometry(2.8, 0.38, 1.35), ivoryFabric);
        cushionLong.position.set(0.8, 0.33, 0.25);
        cushionLong.castShadow = true;
        lrSofa.add(cushionLong);

        const cushionChaise = new THREE.Mesh(new THREE.BoxGeometry(1.35, 0.38, 2.5), ivoryFabric);
        cushionChaise.position.set(-1.275, 0.33, 0.825);
        cushionChaise.castShadow = true;
        lrSofa.add(cushionChaise);

        // Curved low backrests
        const backLong = new THREE.Mesh(new THREE.BoxGeometry(4.15, 0.45, 0.28), ivoryFabric);
        backLong.position.set(0.075, 0.725, -0.45);
        backLong.castShadow = true;
        lrSofa.add(backLong);

        const backChaise = new THREE.Mesh(new THREE.BoxGeometry(0.28, 0.45, 1.35), ivoryFabric);
        backChaise.position.set(-1.81, 0.725, 0.25);
        backChaise.castShadow = true;
        lrSofa.add(backChaise);

        // Cushioned throw pillows (Sage Green and Terracotta)
        const pillow1 = new THREE.Mesh(new THREE.BoxGeometry(0.65, 0.65, 0.18), new THREE.MeshStandardMaterial({ color: 0x828F7A, roughness: 0.9 })); // Sage
        pillow1.position.set(-0.8, 0.55, -0.1);
        pillow1.rotation.y = 0.2;
        lrSofa.add(pillow1);

        const pillow2 = new THREE.Mesh(new THREE.BoxGeometry(0.65, 0.65, 0.18), new THREE.MeshStandardMaterial({ color: 0xB05C3C, roughness: 0.9 })); // Rust
        pillow2.position.set(0.9, 0.55, -0.2);
        pillow2.rotation.y = -0.15;
        lrSofa.add(pillow2);

        lrSofa.position.set(-4.5, 0, 5.8);
        lrSofa.rotation.y = Math.PI;
        scene.add(lrSofa);
        registerInteractive(lrSofa, 'living-sofa');

        // COFFEE TABLE (Round Travertine pedestal coffee table)
        const lrTable = new THREE.Group();
        
        const tableBase = new THREE.Mesh(new THREE.CylinderGeometry(0.7, 0.7, 0.5, 32), travertineMat);
        tableBase.position.y = 0.25;
        tableBase.castShadow = true;
        lrTable.add(tableBase);

        const tableTop = new THREE.Mesh(new THREE.CylinderGeometry(1.4, 1.4, 0.12, 32), travertineMat);
        tableTop.position.y = 0.56;
        tableTop.castShadow = true;
        lrTable.add(tableTop);

        lrTable.position.set(-4.5, 0, 3.8);
        scene.add(lrTable);
        registerInteractive(lrTable, 'living-table');

        // SAGE BOUCLE ARMCHAIR (chair_sage_boucle.png Match: curved boucle armchair)
        const lrChair = new THREE.Group();
        
        const chairBase = new THREE.Mesh(new THREE.CylinderGeometry(0.85, 0.85, 0.35, 32), sageGreenMat);
        chairBase.position.y = 0.175;
        chairBase.castShadow = true;
        lrChair.add(chairBase);

        const chairBack = new THREE.Mesh(new THREE.CylinderGeometry(0.85, 0.85, 0.65, 32, 1, true, -Math.PI*0.6, Math.PI*1.2), sageGreenMat);
        chairBack.position.y = 0.525;
        chairBack.castShadow = true;
        lrChair.add(chairBack);

        const seatCushion = new THREE.Mesh(new THREE.CylinderGeometry(0.68, 0.68, 0.15, 32), sageGreenMat);
        seatCushion.position.y = 0.35;
        lrChair.add(seatCushion);

        lrChair.position.set(-1.8, 0, 3.2);
        lrChair.rotation.y = -Math.PI / 4;
        scene.add(lrChair);
        registerInteractive(lrChair, 'living-chair');

        // Photo Frame Wall Art showing living photo
        const lrArtFrame = createWallArt('images/sofa_ivory_lshape.png', new THREE.Vector3(-9.78, 1.6, 4.5), new THREE.Vector3(0, Math.PI/2, 0), [3.5, 2.0]);
        scene.add(lrArtFrame);

        // Spotlight
        const lrLight = new THREE.PointLight(0xFFD54F, 0.7, 12);
        lrLight.position.set(-4.5, 2.8, 4.5);
        lrLight.castShadow = true;
        scene.add(lrLight);
        roomLights['living'] = lrLight;


        // ==========================================
        // ROOM 2: MASTER SUITE (Top-Right Area)
        // ==========================================
        const bedSuite = new THREE.Group();
        
        // Bed platform frame
        const bedFrame = new THREE.Mesh(new THREE.BoxGeometry(4.8, 0.38, 5.2), woodSlatMat);
        bedFrame.position.y = 0.19;
        bedFrame.castShadow = true;
        bedSuite.add(bedFrame);

        // Bed Linens (slider_1.png Match: Sage Green Bedding, White Pillows)
        const mattress = new THREE.Mesh(new THREE.BoxGeometry(4.4, 0.48, 4.6), new THREE.MeshStandardMaterial({ color: 0x98A996, roughness: 0.9 })); // Sage Sheets
        mattress.position.set(0, 0.62, 0.2);
        mattress.castShadow = true;
        bedSuite.add(mattress);

        const throwBlanket = new THREE.Mesh(new THREE.BoxGeometry(4.42, 0.06, 1.8), new THREE.MeshStandardMaterial({ color: 0xF5F5F7, roughness: 0.95 })); // Folded white throw
        throwBlanket.position.set(0, 0.88, 1.5);
        throwBlanket.castShadow = true;
        bedSuite.add(throwBlanket);

        const brPillowMat = new THREE.MeshStandardMaterial({ color: 0xF8FAFC, roughness: 0.95 }); // White Pillows
        const pillowL = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.22, 1.0), brPillowMat);
        pillowL.position.set(-1.1, 0.8, -1.4);
        pillowL.rotation.x = -0.15;
        bedSuite.add(pillowL);

        const pillowR = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.22, 1.0), brPillowMat);
        pillowR.position.set(1.1, 0.8, -1.4);
        pillowR.rotation.x = -0.15;
        bedSuite.add(pillowR);

        // Nightstands with globe lamps
        const standL = new THREE.Mesh(new THREE.BoxGeometry(0.8, 0.55, 0.8), woodSlatMat);
        standL.position.set(-2.8, 0.275, -2.0);
        standL.castShadow = true;
        bedSuite.add(standL);

        const standR = new THREE.Mesh(new THREE.BoxGeometry(0.8, 0.55, 0.8), woodSlatMat);
        standR.position.set(2.8, 0.275, -2.0);
        standR.castShadow = true;
        bedSuite.add(standR);

        const lampL = new THREE.Mesh(globeGeo, globeMat);
        lampL.position.set(-2.8, 0.8, -2.0);
        bedSuite.add(lampL);

        const lampR = new THREE.Mesh(globeGeo, globeMat);
        lampR.position.set(2.8, 0.8, -2.0);
        bedSuite.add(lampR);

        bedSuite.position.set(4.5, 0, -4.5);
        scene.add(bedSuite);
        registerInteractive(bedSuite, 'bedroom-bed');

        // FLUTED WALL PANELS (slider_1.png Match: Vertical wood slats behind bed)
        const headboardGroup = new THREE.Group();
        const slatGeo = new THREE.BoxGeometry(0.12, 2.2, 0.08);
        for(let i = 0; i < 26; i++) {
            const slat = new THREE.Mesh(slatGeo, woodSlatMat);
            slat.position.set(-2.38 + i*0.19, 1.1, -2.54);
            slat.castShadow = true;
            headboardGroup.add(slat);
        }
        headboardGroup.position.set(4.5, 0, -4.5);
        scene.add(headboardGroup);
        registerInteractive(headboardGroup, 'bedroom-wall');

        // COGNAC LEATHER LOUNGE CHAIR (chair_cognac_recliner.png Match)
        const cognacChair = new THREE.Group();
        const brassLegsMat = new THREE.MeshStandardMaterial({ color: 0xD4AF37, metalness: 0.9, roughness: 0.15 });
        
        const seatBlock = new THREE.Mesh(new THREE.BoxGeometry(1.1, 0.18, 1.1), cognacLeather);
        seatBlock.position.y = 0.38;
        seatBlock.castShadow = true;
        cognacChair.add(seatBlock);

        const backBlock = new THREE.Mesh(new THREE.BoxGeometry(1.1, 0.85, 0.24), cognacLeather);
        backBlock.position.set(0, 0.8, -0.42);
        backBlock.rotation.x = -0.15;
        backBlock.castShadow = true;
        cognacChair.add(backBlock);

        const armrestL = new THREE.Mesh(new THREE.BoxGeometry(0.18, 0.42, 1.1), cognacLeather);
        armrestL.position.set(-0.54, 0.58, 0);
        armrestL.castShadow = true;
        cognacChair.add(armrestL);

        const armrestR = new THREE.Mesh(new THREE.BoxGeometry(0.18, 0.42, 1.1), cognacLeather);
        armrestR.position.set(0.54, 0.58, 0);
        armrestR.castShadow = true;
        cognacChair.add(armrestR);

        // Thin brass metal support base
        const chairBasePole = new THREE.Mesh(new THREE.CylinderGeometry(0.06, 0.06, 0.28, 8), brassLegsMat);
        chairBasePole.position.y = 0.14;
        cognacChair.add(chairBasePole);

        const ringLegs = new THREE.Mesh(new THREE.CylinderGeometry(0.5, 0.5, 0.05, 16, 1, true), brassLegsMat);
        ringLegs.position.y = 0.025;
        cognacChair.add(ringLegs);

        cognacChair.position.set(8.2, 0, -2.4);
        cognacChair.rotation.y = -Math.PI / 5;
        scene.add(cognacChair);
        registerInteractive(cognacChair, 'bedroom-chair');

        // Wall Art Frame
        const brArtFrame = createWallArt('images/slider_1.png', new THREE.Vector3(4.5, 1.8, -9.78), new THREE.Vector3(0, 0, 0), [3.0, 1.8]);
        scene.add(brArtFrame);

        // Bed suite lighting
        const brLight = new THREE.PointLight(0xFFD54F, 0.7, 10);
        brLight.position.set(4.5, 2.5, -4.5);
        brLight.castShadow = true;
        scene.add(brLight);
        roomLights['bedroom'] = brLight;


        // ==========================================
        // ROOM 3: CREATIVE OFFICE (Top-Left Area)
        // ==========================================
        const officeDesk = new THREE.Group();
        const metalFrameMat = new THREE.MeshStandardMaterial({ color: 0x1E293B, metalness: 0.8, roughness: 0.25 }); // Charcoal metal
        
        // Solid Walnut L-Desk Surface (slider_2.png Match)
        const deskTopMain = new THREE.Mesh(new THREE.BoxGeometry(4.4, 0.12, 1.6), woodSlatMat);
        deskTopMain.position.set(0, 1.05, 0);
        deskTopMain.castShadow = true;
        officeDesk.add(deskTopMain);

        const deskTopReturn = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.12, 2.2), woodSlatMat);
        deskTopReturn.position.set(-1.4, 1.05, 1.2);
        deskTopReturn.castShadow = true;
        officeDesk.add(deskTopReturn);

        // Thin black steel support framing legs
        const deskLegL = new THREE.Mesh(new THREE.BoxGeometry(0.12, 1.05, 1.4), metalFrameMat);
        deskLegL.position.set(2.0, 0.525, 0);
        deskLegL.castShadow = true;
        officeDesk.add(deskLegL);

        const deskLegR = new THREE.Mesh(new THREE.BoxGeometry(0.12, 1.05, 1.4), metalFrameMat);
        deskLegR.position.set(-2.0, 0.525, 1.8);
        deskLegR.castShadow = true;
        officeDesk.add(deskLegR);

        // Widescreen monitor setup
        const monitorStand = new THREE.Mesh(new THREE.BoxGeometry(0.4, 0.6, 0.12), metalFrameMat);
        monitorStand.position.set(0.6, 1.36, -0.3);
        officeDesk.add(monitorStand);

        const monitorScreen = new THREE.Mesh(new THREE.BoxGeometry(1.6, 0.65, 0.05), new THREE.MeshBasicMaterial({ color: 0x0A84FF })); // glowing display
        monitorScreen.position.set(0.6, 1.66, -0.25);
        officeDesk.add(monitorScreen);

        officeDesk.position.set(-4.5, 0, -4.5);
        scene.add(officeDesk);
        registerInteractive(officeDesk, 'office-desk');

        // OFFICE TASK CHAIR
        const officeChair = new THREE.Group();
        
        const ocSeat = new THREE.Mesh(new THREE.BoxGeometry(1.0, 0.12, 1.0), metalFrameMat);
        ocSeat.position.y = 0.65;
        ocSeat.castShadow = true;
        officeChair.add(ocSeat);

        const ocBack = new THREE.Mesh(new THREE.BoxGeometry(1.0, 1.0, 0.1), metalFrameMat);
        ocBack.position.set(0, 1.2, 0.45);
        ocBack.castShadow = true;
        officeChair.add(ocBack);

        const ocBase = new THREE.Mesh(new THREE.CylinderGeometry(0.05, 0.05, 0.5, 8), metalFrameMat);
        ocBase.position.y = 0.25;
        officeChair.add(ocBase);

        officeChair.position.set(-3.6, 0, -3.2);
        officeChair.rotation.y = Math.PI / 4;
        scene.add(officeChair);
        registerInteractive(officeChair, 'office-chair');

        // BIOPHILIC FIG TREE (slider_2.png Match: Fiddle Fig planter)
        const figTree = new THREE.Group();
        const potMat = new THREE.MeshStandardMaterial({ color: 0xF1F3F5, roughness: 0.85 }); // ceramic pot
        
        const treePot = new THREE.Mesh(new THREE.CylinderGeometry(0.5, 0.38, 0.95, 16), potMat);
        treePot.position.y = 0.475;
        treePot.castShadow = true;
        figTree.add(treePot);

        const treeTrunk = new THREE.Mesh(new THREE.CylinderGeometry(0.07, 0.09, 2.3, 8), new THREE.MeshStandardMaterial({ color: 0x4D3627, roughness: 0.95 })); // bark
        treeTrunk.position.y = 1.5;
        treeTrunk.castShadow = true;
        figTree.add(treeTrunk);

        const figLeafMat = new THREE.MeshStandardMaterial({ color: 0x22552b, roughness: 0.85 }); // broad fig leaves
        const leafGeo = new THREE.SphereGeometry(0.38, 8, 8);
        const leafPositions = [
            { x: -0.28, y: 1.8, z: 0.1 },
            { x: 0.28, y: 2.0, z: -0.1 },
            { x: -0.1, y: 2.3, z: -0.28 },
            { x: 0.1, y: 2.4, z: 0.28 },
            { x: 0, y: 2.6, z: 0 }
        ];

        leafPositions.forEach(pos => {
            const leaf = new THREE.Mesh(leafGeo, figLeafMat);
            leaf.scale.set(1.4, 0.08, 0.85); // flatten and stretch into a broad fig leaf
            leaf.position.set(pos.x, pos.y, pos.z);
            leaf.rotation.x = Math.random() * 0.4;
            leaf.rotation.z = Math.random() * 0.3;
            figTree.add(leaf);
        });

        figTree.position.set(-2.8, 0, -1.6);
        scene.add(figTree);
        registerInteractive(figTree, 'office-plant');

        // Wall Art Frame
        const ofArtFrame = createWallArt('images/slider_2.png', new THREE.Vector3(-9.78, 1.8, -4.5), new THREE.Vector3(0, Math.PI/2, 0), [3.0, 1.8]);
        scene.add(ofArtFrame);

        // Office lighting
        const ofLight = new THREE.PointLight(0xD1EAF7, 0.6, 11);
        ofLight.position.set(-4.5, 2.6, -4.5);
        ofLight.castShadow = true;
        scene.add(ofLight);
        roomLights['office'] = ofLight;


        // ==========================================
        // ROOM 4: KITCHEN & DINING (Bottom-Right Area)
        // ==========================================
        const kitchenIsland = new THREE.Group();
        
        // Island Cabinet Base (Charcoal Carbon laminate)
        const islandBase = new THREE.Mesh(new THREE.BoxGeometry(4.8, 1.12, 1.7), darkCabinetMat);
        islandBase.position.set(0.5, 0.56, 0.5);
        islandBase.castShadow = true;
        kitchenIsland.add(islandBase);

        // Quartzite waterfall countertop slab (project_chairs.png Match)
        const quartziteTop = new THREE.Mesh(new THREE.BoxGeometry(5.02, 0.1, 1.92), quartziteMat);
        quartziteTop.position.set(0.5, 1.17, 0.5);
        quartziteTop.castShadow = true;
        kitchenIsland.add(quartziteTop);

        const waterfallL = new THREE.Mesh(new THREE.BoxGeometry(0.1, 1.12, 1.92), quartziteMat);
        waterfallL.position.set(2.96, 0.56, 0.5);
        waterfallL.castShadow = true;
        kitchenIsland.add(waterfallL);

        kitchenIsland.position.set(4.5, 0, 4.5);
        scene.add(kitchenIsland);
        registerInteractive(kitchenIsland, 'kitchen-island');

        // BAR STOOLS (project_chairs.png Match: Cognac saddle stools, brass legs)
        const kitchenStools = new THREE.Group();
        
        const saddleSeatGeo = new THREE.CylinderGeometry(0.42, 0.42, 0.09, 32);
        const stoolLegGeo = new THREE.CylinderGeometry(0.035, 0.035, 0.82, 8);
        
        for(let j = 0; j < 3; j++) {
            const stool = new THREE.Group();
            
            // Curved saddle seat
            const seat = new THREE.Mesh(saddleSeatGeo, saddleLeatherMat);
            seat.position.y = 0.81;
            seat.scale.set(1.2, 1.0, 0.9);
            seat.castShadow = true;
            stool.add(seat);

            // Stool legs (Golden brass frame)
            for(let i = 0; i < 4; i++) {
                const angle = (i * Math.PI) / 2;
                const leg = new THREE.Mesh(stoolLegGeo, brassMat);
                leg.position.set(Math.cos(angle)*0.28, 0.41, Math.sin(angle)*0.28);
                leg.rotation.z = Math.cos(angle)*0.1;
                leg.rotation.x = -Math.sin(angle)*0.1;
                leg.castShadow = true;
                stool.add(leg);
            }
            // Add a horizontal brass footrest ring
            const footrest = new THREE.Mesh(new THREE.CylinderGeometry(0.26, 0.26, 0.03, 16, 1, true), brassMat);
            footrest.position.y = 0.28;
            stool.add(footrest);

            stool.position.set(-1.1 + j*1.3, 0, 1.9);
            kitchenStools.add(stool);
        }
        kitchenStools.position.set(4.5, 0, 4.5);
        scene.add(kitchenStools);
        registerInteractive(kitchenStools, 'kitchen-stools');

        // PENDANT LAMPS (Three gold cones with hanging wires)
        const kitchenLights = new THREE.Group();
        const wireGeo = new THREE.CylinderGeometry(0.015, 0.015, 1.5, 8);
        const shadeGeo = new THREE.ConeGeometry(0.38, 0.44, 16);
        
        for(let i = 0; i < 3; i++) {
            const pendant = new THREE.Group();
            
            const wire = new THREE.Mesh(wireGeo, brassMat);
            wire.position.y = 2.15;
            pendant.add(wire);

            const shade = new THREE.Mesh(shadeGeo, brassMat);
            shade.position.y = 1.35;
            shade.rotation.x = Math.PI;
            shade.castShadow = true;
            pendant.add(shade);

            const bulb = new THREE.Mesh(globeGeo, globeMat);
            bulb.position.y = 1.1;
            pendant.add(bulb);

            pendant.position.set(-1.1 + i*1.3, 0, 0.5);
            kitchenLights.add(pendant);
        }
        kitchenLights.position.set(4.5, 0, 4.5);
        scene.add(kitchenLights);
        registerInteractive(kitchenLights, 'kitchen-lights');

        // Wall Art Frame
        const kitArtFrame = createWallArt('images/project_chairs.png', new THREE.Vector3(9.78, 1.8, 4.5), new THREE.Vector3(0, -Math.PI/2, 0), [3.0, 1.8]);
        scene.add(kitArtFrame);

        // Point Light
        const kitLight = new THREE.PointLight(0xFFF9C4, 0.7, 10);
        kitLight.position.set(5.0, 1.2, 5.0);
        kitLight.castShadow = true;
        scene.add(kitLight);
        roomLights['kitchen'] = kitLight;
    }

    // Helper: Create Photo Frame Wall Art Mesh mapped with procedural canvas art (Avoids CORS on local files)
    function createWallArt(imageSrc, pos, rot, size) {
        const artGroup = new THREE.Group();
        artGroup.position.copy(pos);
        artGroup.rotation.copy(rot);

        // Frame back border (Black/Wood)
        const frameGeo = new THREE.BoxGeometry(size[0] + 0.15, size[1] + 0.15, 0.08);
        const frameMat = new THREE.MeshStandardMaterial({ color: 0x1A1E24, roughness: 0.5 });
        const frameMesh = new THREE.Mesh(frameGeo, frameMat);
        frameMesh.castShadow = true;
        artGroup.add(frameMesh);

        // Inner Canvas Image (Procedural Modern Art)
        const canvas = document.createElement('canvas');
        canvas.width = 512;
        canvas.height = Math.floor(512 * (size[1] / size[0]));
        const ctx = canvas.getContext('2d');
        
        // Abstract art background
        const grad = ctx.createLinearGradient(0, 0, canvas.width, canvas.height);
        grad.addColorStop(0, '#f1f5f9');
        grad.addColorStop(1, '#e2e8f0');
        ctx.fillStyle = grad;
        ctx.fillRect(0, 0, canvas.width, canvas.height);
        
        // Abstract shapes based on imageSrc string hash (pseudo-random)
        let hash = 0;
        for (let i = 0; i < imageSrc.length; i++) hash = imageSrc.charCodeAt(i) + ((hash << 5) - hash);
        const rand = (seed) => { let t = Math.sin(seed) * 10000; return t - Math.floor(t); };
        
        ctx.globalAlpha = 0.6;
        for (let i = 0; i < 5; i++) {
            ctx.fillStyle = ['#cbd5e1', '#94a3b8', '#64748b', '#cbd5e1'][Math.floor(rand(hash + i) * 4)];
            ctx.beginPath();
            ctx.arc(rand(hash + i*2) * canvas.width, rand(hash + i*3) * canvas.height, rand(hash + i*4) * 150 + 50, 0, Math.PI * 2);
            ctx.fill();
        }

        const artTexture = new THREE.CanvasTexture(canvas);
        const canvasGeo = new THREE.PlaneGeometry(size[0], size[1]);
        const canvasMat = new THREE.MeshBasicMaterial({ map: artTexture, side: THREE.DoubleSide });
        const canvasMesh = new THREE.Mesh(canvasGeo, canvasMat);
        canvasMesh.position.z = 0.055; // Slightly outward from frame
        artGroup.add(canvasMesh);

        return artGroup;
    }

    function createHotspot(pos, roomName) {
        const hGroup = new THREE.Group();
        hGroup.position.copy(pos);

        // Inner glowing sphere
        const sphereGeo = new THREE.SphereGeometry(0.24, 16, 16);
        const sphereMat = new THREE.MeshBasicMaterial({ color: 0x8c2a2a });
        const sphere = new THREE.Mesh(sphereGeo, sphereMat);
        hGroup.add(sphere);

        // Outer pulsing ring
        const ringGeo = new THREE.RingGeometry(0.38, 0.54, 32);
        const ringMat = new THREE.MeshBasicMaterial({ 
            color: 0x8c2a2a, 
            side: THREE.DoubleSide,
            transparent: true,
            opacity: 0.7
        });
        const ring = new THREE.Mesh(ringGeo, ringMat);
        ring.rotation.x = Math.PI / 2; // Flat on floor plan
        hGroup.add(ring);

        // Target reference for raycasting
        const targetGeo = new THREE.SphereGeometry(0.6, 8, 8);
        const targetMat = new THREE.MeshBasicMaterial({ visible: false });
        const target = new THREE.Mesh(targetGeo, targetMat);
        target.userData.room = roomName;
        hGroup.add(target);

        scene.add(hGroup);
        hotspots.push(target); // Push transparent target outer boundary
    }

    function growHotspot(obj) {
        gsap.to(obj.parent.scale, { x: 1.35, y: 1.35, z: 1.35, duration: 0.25, ease: 'back.out(2.5)' });
        obj.parent.children[0].material.color.setHex(0x00E676); // change color to green on hover
        obj.parent.children[1].material.color.setHex(0x00E676);
    }

    function shrinkHotspot(obj) {
        gsap.to(obj.parent.scale, { x: 1.0, y: 1.0, z: 1.0, duration: 0.25 });
        obj.parent.children[0].material.color.setHex(0x8c2a2a);
        obj.parent.children[1].material.color.setHex(0x8c2a2a);
    }

    // Bidirectional raycaster highlights
    let currentGlowObjects = [];
    function highlight3DElement(name, glow = true) {
        currentGlowObjects.forEach(obj => {
            if (obj.material && obj.material.emissive) {
                obj.material.emissive.setHex(0x000000);
            }
        });
        currentGlowObjects = [];

        if (!glow || !name) return;

        scene.traverse(child => {
            if (child.isMesh && child.userData.interactiveName === name) {
                if (child.material && child.material.emissive) {
                    child.material.emissive.setHex(0x221111); // deep red glow matching the brand
                    currentGlowObjects.push(child);
                }
            }
        });
    }

    function focusRoom(roomKey) {
        currentFocus = roomKey;
        
        // Update Selector UI buttons active states
        document.querySelectorAll('.room-btn').forEach(btn => {
            if (btn.getAttribute('data-room') === roomKey) {
                btn.classList.add('active');
            } else {
                btn.classList.remove('active');
            }
        });

        const container = document.getElementById('canvas-container');
        const wrapper = document.getElementById('canvas-wrapper');
        const panel = document.getElementById('reality-panel');

        if (roomKey === 'all') {
            // Reset to default isometric view
            gsap.to(camera.position, { x: defaultCamPos.x, y: defaultCamPos.y, z: defaultCamPos.z, duration: 1.5, ease: 'power2.inOut' });
            gsap.to(controls.target, { x: 0, y: 0, z: 0, duration: 1.5, ease: 'power2.inOut' });
            
            // Shrink panel smoothly
            wrapper.classList.remove('is-split');
            panel.classList.remove('is-visible');
            
            setTimeout(onWindowResize, 600); // trigger three.js resize after panel transitions out
            return;
        }

        const room = rooms[roomKey];
        if (!room) return;

        // Fly Camera smoothly to room coordinates
        gsap.to(camera.position, {
            x: room.camPos.x,
            y: room.camPos.y,
            z: room.camPos.z,
            duration: 1.5,
            ease: 'power3.inOut'
        });

        gsap.to(controls.target, {
            x: room.camTarget.x,
            y: room.camTarget.y,
            z: room.camTarget.z,
            duration: 1.5,
            ease: 'power3.inOut'
        });

        // Set up Reality panel details
        document.getElementById('room-title').innerText = room.title;
        document.getElementById('room-image').src = room.image;
        document.getElementById('room-description').innerText = room.desc;

        const specsContainer = document.getElementById('room-specs');
        specsContainer.innerHTML = '';
        room.specs.forEach(s => {
            const li = document.createElement('li');
            li.innerHTML = s;
            specsContainer.appendChild(li);
        });

        // Inquire button setup
        const text = `Hello Smartzone! I am exploring your interactive contact showroom map and would like to inquire about the: *${room.title}* (${room.style}).`;
        document.getElementById('whatsapp-inquire-btn').href = `https://wa.me/971547787867?text=${encodeURIComponent(text)}`;

        // Populate hotspots overlay on photo
        updatePhotoHotspots(roomKey);

        // Populate material swatches board
        updateMaterialBoard(roomKey);

        // Trigger split screen transition
        wrapper.classList.add('is-split');
        panel.classList.add('is-visible');
        
        setTimeout(onWindowResize, 600); // resize three.js render canvas after transition
    }

    // Match 3D camera to photo perspective
    function matchPerspective() {
        if (currentFocus === 'all') return;
        const sync = cameraSyncData[currentFocus];
        if (!sync) return;
        
        controls.enabled = false;
        
        gsap.to(camera.position, {
            x: sync.pos.x,
            y: sync.pos.y,
            z: sync.pos.z,
            duration: 1.8,
            ease: 'power2.inOut'
        });
        
        gsap.to(controls.target, {
            x: sync.target.x,
            y: sync.target.y,
            z: sync.target.z,
            duration: 1.8,
            ease: 'power2.inOut',
            onComplete: () => {
                controls.enabled = true;
            }
        });
    }

    // Dynamic photo hotspots injection
    function updatePhotoHotspots(roomKey) {
        const overlay = document.getElementById('photo-hotspots-overlay');
        overlay.innerHTML = '';
        
        const spots = photoHotspotsData[roomKey];
        if (!spots) return;
        
        spots.forEach(spot => {
            const div = document.createElement('div');
            div.className = 'photo-hotspot';
            div.style.left = spot.x + '%';
            div.style.top = spot.y + '%';
            div.setAttribute('data-name', spot.name);
            
            div.innerHTML = `
                <div class="hotspot-pulse"></div>
                <div class="hotspot-dot"></div>
                <div class="hotspot-tooltip">${spot.label}</div>
            `;
            
            // Sync hover from photo to 3D scene
            div.addEventListener('mouseenter', () => {
                highlight3DElement(spot.name, true);
                div.classList.add('active');
            });
            div.addEventListener('mouseleave', () => {
                highlight3DElement(spot.name, false);
                div.classList.remove('active');
            });
            
            overlay.appendChild(div);
        });
    }

    // Dynamic material board swatches
    function updateMaterialBoard(roomKey) {
        const container = document.getElementById('material-swatches');
        container.innerHTML = '';
        
        const mats = roomMaterials[roomKey];
        if (!mats) return;
        
        mats.forEach(mat => {
            const div = document.createElement('div');
            div.className = 'swatch-item';
            div.style.display = 'flex';
            div.style.alignItems = 'center';
            div.style.gap = '10px';
            
            div.innerHTML = `
                <div class="swatch-color" style="width: 20px; height: 20px; border-radius: 50%; background: ${mat.color}; border: 1px solid rgba(0,0,0,0.15);"></div>
                <div style="display: flex; flex-direction: column;">
                    <span style="font-size: 0.78rem; font-weight: 700; color: var(--text-1800); font-family: sans-serif;">${mat.name}</span>
                    <span style="font-size: 0.65rem; color: #64748B; font-family: sans-serif;">${mat.desc}</span>
                </div>
            `;
            
            // Sync material swatches to 3D scene & Photo hotspots
            div.addEventListener('mouseenter', () => {
                Object.keys(elementMaterials).forEach(elName => {
                    if (elementMaterials[elName] === mat.id && elName.startsWith(roomKey)) {
                        highlight3DElement(elName, true);
                        document.querySelectorAll('.photo-hotspot').forEach(hotspot => {
                            if (hotspot.getAttribute('data-name') === elName) {
                                hotspot.classList.add('active');
                            }
                        });
                    }
                });
            });
            
            div.addEventListener('mouseleave', () => {
                highlight3DElement(null, false);
                document.querySelectorAll('.photo-hotspot').forEach(hotspot => {
                    hotspot.classList.remove('active');
                });
            });
            
            container.appendChild(div);
        });
    }

    // Toggle lighting configurations
    function toggleAllLights() {
        Object.keys(roomLights).forEach(roomKey => {
            const light = roomLights[roomKey];
            const targetIntensity = light.intensity > 0 ? 0 : 0.7;
            gsap.to(light, { intensity: targetIntensity, duration: 0.6, ease: 'power1.inOut' });
        });
    }

    // Cinematic overview rotation sweep
    function startCinematicTour() {
        // close panel
        focusRoom('all');
        const tourSequence = [
            { room: 'living', duration: 4.0 },
            { room: 'office', duration: 4.0 },
            { room: 'bedroom', duration: 4.0 },
            { room: 'kitchen', duration: 4.0 },
            { room: 'all', duration: 3.0 }
        ];

        let timeOffset = 0;
        tourSequence.forEach(step => {
            setTimeout(() => {
                focusRoom(step.room);
            }, timeOffset * 1000);
            timeOffset += step.duration;
        });
    }

    // FIX: Variable typo in buildRealisticHouse cushionLong was cushionLong but referred to cushionLong.position, let's make sure it is correct
    // (Wait, cushionLong.position.set is correct)

    function onWindowResize() {
        const wrapper = document.getElementById('canvas-wrapper');
        const width = wrapper.clientWidth;
        const height = wrapper.clientHeight;
        camera.aspect = width / height;
        camera.updateProjectionMatrix();
        renderer.setSize(width, height);
    }

    function handleContactSubmit(event) {
        event.preventDefault();
        
        const name = document.getElementById('name').value;
        const email = document.getElementById('email').value;
        const phone = document.getElementById('phone').value;
        const service = document.getElementById('service').value;
        const msg = document.getElementById('message').value;

        const text = `Hello Smartzone! I would like to request an interior consultation.\n\n*Name:* ${name}\n*Email:* ${email}\n*Phone:* ${phone}\n*Service:* ${service}\n*Message:* ${msg}`;
        const encodedText = encodeURIComponent(text);
        const whatsappUrl = `https://wa.me/971547787867?text=${encodedText}`;
        
        window.open(whatsappUrl, '_blank');
    }

    // Init page binding events
    window.addEventListener('load', () => {
        init3DExplorer();

        // Bind selector buttons
        document.querySelectorAll('.room-btn').forEach(btn => {
            btn.addEventListener('click', () => {
                const room = btn.getAttribute('data-room');
                focusRoom(room);
            });
        });
    });
</script>
'@

$finalHtml = $headerHtml + $explorerHtml + $footerHtml
$finalHtml = $finalHtml.Replace('#contact', 'contact.html')

Set-Content -Path .\contact.html -Value $finalHtml -Encoding UTF8
Write-Host "Successfully compiled premium contact.html with white theme and realistic textures!"
