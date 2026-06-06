/* ==========================================================================
   SmartZone Atelier Custom Script - Multi-Page Core
   ========================================================================== */

document.addEventListener('DOMContentLoaded', () => {

    /* ==========================================
       Scroll Transitions & Header Stylings
       ========================================== */
    const header = document.querySelector('.header');
    const navLinks = document.querySelectorAll('.nav-link');

    const handleScroll = () => {
        if (!header) return;
        const scrollTop = window.scrollY;
        
        // Sticky Header styling transitions on scroll (White transparent blur)
        if (scrollTop > 50) {
            header.style.padding = '14px 0';
            header.style.boxShadow = '0 15px 40px rgba(17, 17, 17, 0.05)';
            header.style.backgroundColor = 'rgba(255, 255, 255, 0.98)';
        } else {
            header.style.padding = '24px 0';
            header.style.boxShadow = 'none';
            header.style.backgroundColor = 'rgba(255, 255, 255, 0.96)';
        }
    };

    window.addEventListener('scroll', handleScroll);
    handleScroll(); // Initial run on load

    // Highlight current nav item based on filename
    const currentPath = window.location.pathname.split("/").pop();
    navLinks.forEach(link => {
        link.classList.remove('active');
        const linkPath = link.getAttribute('href');
        
        // Handle direct matches
        if (currentPath === linkPath || (currentPath === '' && linkPath === 'index.html')) {
            link.classList.add('active');
        }
    });


    /* ==========================================
       Mobile Navigation Sidebar Trigger
       ========================================== */
    const mobileToggle = document.getElementById('mobile-toggle');
    const navMenu = document.getElementById('nav-menu');

    if (mobileToggle && navMenu) {
        mobileToggle.addEventListener('click', () => {
            const isOpen = navMenu.classList.toggle('open');
            mobileToggle.setAttribute('aria-expanded', isOpen);
            
            // Toggle hamburger icon animation
            const bars = mobileToggle.querySelectorAll('.bar');
            if (isOpen) {
                bars[0].style.transform = 'translateY(7.5px) rotate(45deg)';
                bars[1].style.opacity = '0';
                bars[2].style.transform = 'translateY(-7.5px) rotate(-45deg)';
            } else {
                bars[0].style.transform = 'none';
                bars[1].style.opacity = '1';
                bars[2].style.transform = 'none';
            }
        });

        // Close sidebar menu when links are clicked
        navLinks.forEach(link => {
            link.addEventListener('click', () => {
                navMenu.classList.remove('open');
                mobileToggle.setAttribute('aria-expanded', 'false');
                const bars = mobileToggle.querySelectorAll('.bar');
                if (bars.length >= 3) {
                    bars[0].style.transform = 'none';
                    bars[1].style.opacity = '1';
                    bars[2].style.transform = 'none';
                }
            });
        });
    }


    /* ==========================================
       Accordion Component (Renovations & FAQ pages)
       ========================================== */
    const accordions = document.querySelectorAll('.accordion-item');

    accordions.forEach(item => {
        const trigger = item.querySelector('.accordion-trigger');
        
        if (trigger) {
            trigger.addEventListener('click', () => {
                const isOpen = item.classList.contains('active');
                
                // Close all other accordions in the same container
                const siblingGroup = item.parentElement.querySelectorAll('.accordion-item');
                siblingGroup.forEach(sibling => {
                    sibling.classList.remove('active');
                    const siblingTrigger = sibling.querySelector('.accordion-trigger');
                    if (siblingTrigger) {
                        siblingTrigger.setAttribute('aria-expanded', 'false');
                        const icon = siblingTrigger.querySelector('.accordion-icon');
                        if (icon) icon.textContent = '+';
                    }
                });

                // Open/Close this one
                if (!isOpen) {
                    item.classList.add('active');
                    trigger.setAttribute('aria-expanded', 'true');
                    const icon = trigger.querySelector('.accordion-icon');
                    if (icon) icon.textContent = '-';
                }
            });
        }
    });


    /* ==========================================
       Dynamic Reviews & Testimonials System
       ========================================== */
    const initialReviews = [
        {
            name: "A. R. Mahmood",
            meta: "Penthouse Owner, Belgravia",
            rating: 5,
            text: "SmartZone Atelier transformed our raw concrete shell into a spectacular travertine and linen sanctuary. Their remote coordination, materials logistics, and structural finish were exceptional. Direct partner execution saved us from any site disputes."
        },
        {
            name: "Sofia Jenkins",
            meta: "Art Curator, Chelsea",
            rating: 5,
            text: "Securing marble detailing and bespoke lighting under tight municipal clearances was seamless. SmartZone manages high-end custom millwork with ultimate precision."
        },
        {
            name: "Tariq Qureshi",
            meta: "Private Investor, Knightsbridge",
            rating: 5,
            text: "Their cost schedule reports and architectural blueprints are absolute perfection. A transparent, high-end contracting team that justifies every dollar of their commission."
        }
    ];

    const reviewsContainer = document.getElementById('reviews-container');
    const reviewModal = document.getElementById('review-modal-overlay');
    const btnAddReview = document.getElementById('btn-add-review');
    const btnCloseReview = document.getElementById('btn-close-review-modal');
    const reviewForm = document.getElementById('client-review-form');
    const reviewSuccess = document.getElementById('review-form-success');

    const renderReviews = () => {
        if (!reviewsContainer) return;
        reviewsContainer.innerHTML = '';
        
        initialReviews.forEach(review => {
            const stars = '★'.repeat(review.rating) + '☆'.repeat(5 - review.rating);
            const card = document.createElement('div');
            card.className = 'testimonial-card';
            card.innerHTML = `
                <div class="testimonial-rating">${stars}</div>
                <p class="testimonial-text">"${review.text}"</p>
                <div class="testimonial-meta">
                    <h4 style="font-family: var(--font-heading); font-weight: 400;">${review.name}</h4>
                    <p style="font-family: var(--font-body); font-weight: 300;">${review.meta}</p>
                </div>
            `;
            reviewsContainer.appendChild(card);
        });
    };

    renderReviews(); // Initial render

    if (btnAddReview && reviewModal) {
        btnAddReview.addEventListener('click', () => {
            reviewModal.style.display = 'flex';
            setTimeout(() => {
                reviewModal.classList.add('active');
            }, 10);
        });
    }

    const closeReviewModal = () => {
        if (!reviewModal) return;
        reviewModal.classList.remove('active');
        setTimeout(() => {
            reviewModal.style.display = 'none';
            if (reviewForm) {
                reviewForm.reset();
                reviewForm.style.display = 'block';
            }
            if (reviewSuccess) reviewSuccess.style.display = 'none';
        }, 300);
    };

    if (btnCloseReview) {
        btnCloseReview.addEventListener('click', closeReviewModal);
    }
    
    if (reviewModal) {
        reviewModal.addEventListener('click', (e) => {
            if (e.target === reviewModal) closeReviewModal();
        });
    }

    if (reviewForm) {
        reviewForm.addEventListener('submit', (e) => {
            e.preventDefault();
            
            const name = document.getElementById('review-name').value;
            const meta = document.getElementById('review-meta').value;
            const rating = parseInt(document.getElementById('review-rating').value);
            const text = document.getElementById('review-text').value;

            // Add new review to array and re-render
            initialReviews.unshift({ name, meta, rating, text });
            renderReviews();

            // Success Transition
            reviewForm.style.display = 'none';
            if (reviewSuccess) reviewSuccess.style.display = 'block';

            // Auto Close modal after delay
            setTimeout(() => {
                closeReviewModal();
            }, 1500);
        });
    }


    /* ==========================================
       Stats Counter Animation (Observer - About Page)
       ========================================== */
    const stats = document.querySelectorAll('.stat-number');
    let hasAnimated = false;

    const animateStats = () => {
        stats.forEach(stat => {
            const target = +stat.getAttribute('data-target');
            const increment = target / 50; // Controls speed of increments
            
            let count = 0;
            const updateCount = () => {
                count += increment;
                if (count < target) {
                    stat.textContent = Math.ceil(count);
                    setTimeout(updateCount, 20);
                } else {
                    stat.textContent = target + (stat.getAttribute('data-target') === '98' ? '%' : '+');
                }
            };
            updateCount();
        });
    };

    const statsSection = document.querySelector('.stats-section');
    if (statsSection && stats.length > 0) {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting && !hasAnimated) {
                    animateStats();
                    hasAnimated = true;
                }
            });
        }, { threshold: 0.3 });
        
        observer.observe(statsSection);
    }


    /* ==========================================
       Consultation Page Form Submission Logic
       ========================================== */
    const consultationPageForm = document.getElementById('consultation-page-form');
    const consultationPageSuccess = document.getElementById('consultation-page-success');
    const btnResetPageConsult = document.getElementById('btn-reset-page-consult');

    if (consultationPageForm && consultationPageSuccess) {
        consultationPageForm.addEventListener('submit', (e) => {
            e.preventDefault();
            consultationPageForm.style.display = 'none';
            consultationPageSuccess.style.display = 'block';
        });

        if (btnResetPageConsult) {
            btnResetPageConsult.addEventListener('click', () => {
                consultationPageForm.reset();
                consultationPageSuccess.style.display = 'none';
                consultationPageForm.style.display = 'block';
            });
        }
    }


    /* ==========================================
       Cookie Consent Banner & preferences
       ========================================== */
    const cookieOverlay = document.getElementById('cookie-banner-overlay');
    const cookieCompact = document.getElementById('cookie-compact');
    const cookiePrefs = document.getElementById('cookie-preferences');
    
    // Cookie Buttons
    const btnAccept = document.getElementById('btn-cookie-accept');
    const btnReject = document.getElementById('btn-cookie-reject');
    const btnManage = document.getElementById('btn-cookie-manage');
    
    // Modal buttons
    const btnModalClose = document.getElementById('btn-cookie-close-modal');
    const btnModalAccept = document.getElementById('btn-modal-accept');
    const btnModalReject = document.getElementById('btn-modal-reject');
    const btnModalManage = document.getElementById('btn-modal-manage');
    
    // Footer Link
    const footerManageCookies = document.getElementById('footer-manage-cookies');
    const openCookiePreferences = document.getElementById('open-cookie-preferences');

    // Show cookie banner if not consented previously
    if (cookieOverlay && !localStorage.getItem('cookie-consented')) {
        cookieOverlay.style.display = 'block';
        setTimeout(() => {
            cookieOverlay.classList.add('active');
        }, 500);
    }

    const saveConsent = (status) => {
        localStorage.setItem('cookie-consented', status);
        if (cookieOverlay) {
            cookieOverlay.classList.remove('active');
            setTimeout(() => {
                cookieOverlay.style.display = 'none';
            }, 300);
        }
    };

    if (btnAccept) btnAccept.addEventListener('click', () => saveConsent('accepted'));
    if (btnReject) btnReject.addEventListener('click', () => saveConsent('rejected'));
    if (btnModalAccept) btnModalAccept.addEventListener('click', () => saveConsent('accepted'));
    if (btnModalReject) btnModalReject.addEventListener('click', () => saveConsent('rejected'));

    // Manage Preferences transition
    const showPreferencesModal = (e) => {
        if (e) e.preventDefault();
        if (cookieOverlay && cookieCompact && cookiePrefs) {
            cookieOverlay.classList.add('modal-open');
            cookieOverlay.style.display = 'flex';
            setTimeout(() => {
                cookieOverlay.classList.add('active');
            }, 10);
            cookieCompact.style.display = 'none';
            cookiePrefs.style.display = 'block';
        }
    };

    if (btnManage) btnManage.addEventListener('click', showPreferencesModal);
    if (btnModalManage) btnModalManage.addEventListener('click', () => saveConsent('managed'));
    
    if (footerManageCookies) footerManageCookies.addEventListener('click', showPreferencesModal);
    if (openCookiePreferences) openCookiePreferences.addEventListener('click', showPreferencesModal);

    if (btnModalClose) {
        btnModalClose.addEventListener('click', () => {
            if (cookieOverlay && cookieCompact && cookiePrefs) {
                // If they already consented, just close. If not, go back to compact view.
                if (localStorage.getItem('cookie-consented')) {
                    cookieOverlay.classList.remove('active');
                    setTimeout(() => {
                        cookieOverlay.style.display = 'none';
                    }, 300);
                } else {
                    cookieOverlay.classList.remove('modal-open');
                    cookiePrefs.style.display = 'none';
                    cookieCompact.style.display = 'block';
                }
            }
        });
    }
});
