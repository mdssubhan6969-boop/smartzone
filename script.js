// Intro Loader Logic
window.addEventListener('DOMContentLoaded', () => {
    const loader = document.getElementById('intro-loader');
    
    // Reduced delay for faster entry
    setTimeout(() => {
        loader.classList.add('fade-out');
        
        // Remove from DOM after fade to keep things clean
        setTimeout(() => {
            loader.remove();
            startHeroLoop(); // Start the hero text loop after loader is gone
        }, 1000);
    }, 2500);
});

function startHeroLoop() {
    const heroTitle = document.getElementById('hero-title-dynamic');
    if (!heroTitle) return;
    const span = heroTitle.querySelector('span');
    if (!span) return;

    const phrases = [
        "Website Production House,",
        "Born Dubai"
    ];
    let index = 0;

    setInterval(() => {
        // Slide out Up
        span.classList.add('slide-out');
        
        setTimeout(() => {
            index = (index + 1) % phrases.length;
            span.textContent = phrases[index];
            
            // Prepare for Slide in from Bottom
            span.classList.remove('slide-out');
            span.classList.add('slide-in');
            
            // Force a reflow
            void span.offsetWidth;
            
            // Slide in
            span.classList.remove('slide-in');
        }, 800); // Match CSS transition duration
    }, 3000); // 3s per phrase (2s visible + 1s animation)
}

const translations = {
    en: {
        nav_work: "→ WORK",
        nav_manifesto: "MANIFESTO",
        nav_souls: "SKIDS SOULS",
        nav_team: "TEAM",
        nav_contact: "CONTACT",
        nav_results: "RESULTS",
        hero_title: "Website Production House,",
        feat_integrate: "INTEGRATE",
        feat_collaborate: "COLLABORATE",
        feat_challenge: "CHALLENGE",
        integrate_desc: "Born in Gulf, raised by the world — skids is the global fulcrum between East and West. We blur boundaries of difference, creating design that stands the test of time.",
        collaborate_desc: "Collaboration over competition — Creativity, for skids media, is like having a nabe with friends where we combine the creativity that sets us apart. Through collaborative initiative, we bring your visions to fruition.",
        challenge_desc: "We create to evoke — We start where others stop, we question the norms, we refuse to be redundant, skids media seeks to deliver original creative solutions.",
        trust_title: "They trust us",
        manifesto_text: "WE BUILD, WE SCALE AND YOU GROW.",
        projects_title: "Selected Works",
        cat_adv: "Advertising",
        cat_tech: "Tech Repair",
        cat_beauty: "Beauty & Salon",
        cat_transport: "Luxury Transport",
        cat_edu: "Education & Training",
        cat_gaming: "Gaming & Leisure",
        p1_title: "Funoon Advertising",
        p1_desc: "A vibrant presence for a leading advertising agency in the UAE.",
        p2_title: "Banbury iRepairs",
        p2_desc: "Modern service platform for professional device repairs.",
        p3_title: "Asrar Salon",
        p3_desc: "Elegant digital experience for a luxury beauty destination.",
        p4_title: "Classy Ride Limousine",
        p4_desc: "Premium booking platform for high-end transportation services.",
        p5_title: "Al Shamsi Driving School",
        p5_desc: "Comprehensive digital platform for a leading driving institution in the UAE.",
        p6_title: "DNA Board Games",
        p6_desc: "Immersive online portal for board game enthusiasts and cafe visitors.",
        contact_title: "Get In Touch",
        contact_desc: "Ready to start your next project? Let's connect and build something extraordinary together.",
        contact_btn: "Email Us",
        team_manifesto_1: "From ajman to dubai,",
        team_manifesto_2: "We come from all",
        team_manifesto_3: "over the world",
        team_jibran_role: "MARKETING",
        team_hamza_role: "MARKETING",
        team_subhan_role: "WEBSITE DEVELOPMENT",
        nav_services: "SERVICES",
        nav_packages: "PACKAGES",
        nav_team: "TEAM",
        nav_contact: "CONTACT",
        services_title: "Our Services",
        service_web: "Website Development",
        service_app: "App Development",
        service_social: "Social Media Management",
        service_db: "Database Setup",
        nav_process: "PROCESS",
        services_more: "EXPLORE OTHER SERVICES",
        other_services_hero: "Extended Services",
        other_services_sub: "Deep specialized support for your digital growth.",
        packages_title: "Website Development Packages",
        p_startup_title: "Startup Website",
        p_prof_title: "Professional Website",
        p_elite_title: "Elite Website",
        p_interactive_title: "Interactive High-End",
        p_php_title: "Custom PHP Website",
        p_lms_title: "Enterprise LMS",
        nav_social_packages: "SOCIAL PACKAGES",
        social_packages_title: "Social Media Management",
        inquiry_title: "Ready to scale?",
        inquiry_sub: "Send us a brief and we'll get back to you with a strategy.",
        form_name: "Full Name",
        form_email: "Email Address",
        form_service: "Interested In",
        form_message: "Tell us about your project",
        form_submit: "SEND MESSAGE",
        service_other: "Other Inquiry",
        contact_keep_in_touch: "Keep in touch",
        contact_start_conv: "Start a conversation",
        contact_offices: "Our offices :",
        contact_office_loc: "COMING IN RAMADA BLACK SQUARE SOON, STAY TUNED!",
        nav_results: "RESULTS"
    },
    ur: {
        nav_work: "کام ←",
        nav_manifesto: "منشور",
        nav_souls: "سکیڈز روحیں",
        nav_team: "ٹیم",
        nav_contact: "رابطہ",
        hero_title: "ویب سائٹ پروڈکشن ہاؤس،",
        feat_integrate: "انضمام",
        feat_collaborate: "تعاون",
        feat_challenge: "چیلنج",
        integrate_desc: "خلیج میں پیدا ہوئے، دنیا کے ذریعے پروان چڑھے — سکیڈز مشرق اور مغرب کے درمیان عالمی محور ہے۔ ہم فرق کی حدود کو دھندلا دیتے ہیں، ایسا ڈیزائن بناتے ہیں جو وقت کی کسوٹی پر پورا اترتا ہے۔",
        collaborate_desc: "مقابلے پر تعاون — سکیڈز میڈیا کے لیے تخلیقی صلاحیتیں دوستوں کے ساتھ نابی رکھنے جیسی ہیں جہاں ہم اس تخلیقی صلاحیت کو یکجا کرتے ہیں جو ہمیں الگ کرتی ہے۔ باہمی تعاون کے اقدام کے ذریعے، ہم آپ کے وژن کو عملی جامہ پہناتے ہیں۔",
        challenge_desc: "ہم ابھارنے کے لیے تخلیق کرتے ہیں — ہم وہاں سے شروع کرتے ہیں جہاں دوسرے رک جاتے ہیں، ہم اصولوں پر سوال اٹھاتے ہیں، ہم ضرورت سے زیادہ ہونے سے انکار کرتے ہیں، سکیڈز میڈیا اصل تخلیقی حل فراہم کرنے کی کوشش کرتا ہے۔",
        trust_title: "وہ ہم پر بھروسہ کرتے ہیں",
        manifesto_text: "ہم تعمیر کرتے ہیں، ہم پیمانہ بڑھاتے ہیں اور آپ ترقی کرتے ہیں۔",
        projects_title: "منتخب کام",
        cat_adv: "اشتہارات",
        cat_tech: "ٹیک ریپیئر",
        cat_beauty: "بیوٹی اور سیلون",
        cat_transport: "لگژری ٹرانسپورٹ",
        cat_edu: "تعلیم اور تربیت",
        cat_gaming: "گیمنگ اور تفریح",
        p1_title: "فنون ایڈورٹائزنگ",
        p1_desc: "متحدہ عرب امارات میں ایک معروف ایڈورٹائزنگ ایجنسی کے لیے ایک متحرک موجودگی۔",
        p2_title: "بینبری آئی ریپیئرز",
        p2_desc: "پیشہ ورانہ آلہ کی مرمت کے لیے جدید سروس پلیٹ فارم۔",
        p3_title: "اسرار سیلون",
        p3_desc: "ایک لگژری بیوٹی ڈیسٹینیشن کے لیے خوبصورت ڈیجیٹل تجربہ۔",
        p4_title: "کلاسی رائڈ لیموزین",
        p4_desc: "اعلی درجے کی نقل و حمل کی خدمات کے لیے پریمیم بکنگ پلیٹ فارم۔",
        p5_title: "الشامسی ڈرائیونگ سکول",
        p5_desc: "متحدہ عرب امارات میں ڈرائیونگ کے ایک معروف ادارے کے لیے جامع ڈیجیٹل پلیٹ فارم۔",
        p6_title: "ڈی این اے بورڈ گیمز",
        p6_desc: "بورڈ گیم کے شائقین اور کیفے کے زائرین کے لیے عمیق آن لائن پورٹل۔",
        contact_title: "رابطہ کریں",
        contact_desc: "اپنا اگلا پروجیکٹ شروع کرنے کے لیے تیار ہیں؟ آئیے جڑیں اور مل کر کچھ غیر معمولی بنائیں۔",
        contact_btn: "ہمیں ای میل کریں",
        team_manifesto_1: "عجمان سے دبئی تک،",
        team_manifesto_2: "ہم سب سے آتے ہیں",
        team_manifesto_3: "پوری دنیا میں",
        team_jibran_role: "MARKETING",
        team_hamza_role: "MARKETING",
        team_subhan_role: "WEBSITE DEVELOPMENT",
        contact_keep_in_touch: "رابطے میں رہیں",
        contact_start_conv: "گفتگو شروع کریں",
        contact_offices: "ہمارے دفاتر:",
        contact_office_loc: "جلد ہی رمادا بلیک اسکوائر میں آرہا ہے۔",
        nav_other_services: "توسیع شدہ خدمات"
    },
    ar: {
        nav_work: "الأعمال ←",
        nav_manifesto: "البيان",
        nav_souls: "أرواح سكيدز",
        nav_team: "الفريق",
        nav_contact: "اتصل بنا",
        hero_title: "دار إنتاج مواقع إلكترونية،",
        feat_integrate: "دمج",
        feat_collaborate: "تعاون",
        feat_challenge: "تحدي",
        integrate_desc: "وُلدت في الخليج، وتربت على يد العالم - سكيدز هي المحور العالمي بين الشرق والغرب. نحن نمحو حدود الاختلاف، ونصنع تصميمًا يصمد أمام اختبار الزمن.",
        collaborate_desc: "التعاون فوق المنافسة - الإبداع، بالنسبة لـ سكيدز ميديا، يشبه تناول 'نابي' مع الأصدقاء حيث نجمع بين الإبداع الذي يميزنا. من خلال المبادرة التعاونية، نحول رؤاكم إلى واقع ملموس.",
        challenge_desc: "نحن نبدع لنثير المشاعر - نبدأ من حيث يتوقف الآخرون، ونشكك في المعايير، ونرفض التكرار، تسعى سكيدز ميديا لتقديم حلول إبداعية أصلية.",
        trust_title: "يثقون بنا",
        manifesto_text: "نحن نبني، نحن نطور، وأنت تنمو.",
        projects_title: "أعمال مختارة",
        cat_adv: "إعلانات",
        cat_tech: "إصلاح تقني",
        cat_beauty: "جمال وصالون",
        cat_transport: "نقل فاخر",
        cat_edu: "التعليم والتدريب",
        cat_gaming: "الألعاب والترفيه",
        p1_title: "فنون للإعلان",
        p1_desc: "حضور حيوي لوكالة إعلانية رائدة في الإمارات العربية المتحدة.",
        p2_title: "بانبري لإصلاح الأجهزة",
        p2_desc: "منصة خدمة حديثة لإصلاح الأجهزة باحترافية.",
        p3_title: "صالون أسرار",
        p3_desc: "تجربة رقمية أنيقة لوجهة جمال فاخرة.",
        p4_title: "كلاسي رايد ليموزين",
        p4_desc: "منصة حجز متميزة لخدمات النقل الراقية.",
        p5_title: "مدرسة الشامسي لتعليم قيادة السيارات",
        p5_desc: "منصة رقمية شاملة لمؤسسة رائدة لتعليم القيادة في الإمارات العربية المتحدة.",
        p6_title: "دي إن إيه لألعاب الطاولة",
        p6_desc: "بوابة غامرة عبر الإنترنت لعشاق ألعاب الطاولة وزوار المقاهي.",
        contact_title: "تواصل معنا",
        contact_desc: "هل أنت مستعد لبدء مشروعك القادم؟ فلنتواصل ونبني شيئًا استثنائيًا معًا.",
        contact_btn: "راسلنا",
        team_manifesto_1: "من عجمان إلى دبي،",
        team_manifesto_2: "نحن نأتي من جميع",
        team_manifesto_3: "أنحاء العالم",
        team_jibran_role: "MARKETING",
        team_hamza_role: "MARKETING",
        team_subhan_role: "WEBSITE DEVELOPMENT",
        contact_keep_in_touch: "ابق على تواصل",
        contact_start_conv: "ابدأ محادثة",
        contact_offices: "مكاتبنا:",
        contact_office_loc: "قريباً في رمادا بلاك سكوير",
        nav_other_services: "خدمات موسعة"
    },
    hi: {
        nav_work: "→ काम",
        nav_manifesto: "घोषणापत्र",
        nav_souls: "स्किड्स सोल्स",
        nav_team: "टीम",
        nav_contact: "संपर्क",
        hero_title: "वेबसाइट प्रोडक्शन हाउस,",
        feat_integrate: "एकीकृत",
        feat_collaborate: "सहयोग",
        feat_challenge: "चुनौती",
        integrate_desc: "खाड़ी में जन्मे, दुनिया द्वारा पाले गए - स्किड्स पूर्व और पश्चिम के बीच वैश्विक धुरी है। हम अंतर की सीमाओं को धुंधला करते हैं, ऐसा डिज़ाइन बनाते हैं जो समय की कसौटी पर खरा उतरता है।",
        collaborate_desc: "प्रतिस्पर्धा पर सहयोग - स्किड्स मीडिया के लिए रचनात्मकता दोस्तों के साथ 'नाबे' खाने जैसी है जहां हम उस रचनात्मकता को जोड़ते हैं जो हमें अलग बनाती है। सहयोगी पहल के माध्यम से, हम आपके विज़न को साकार करते हैं।",
        challenge_desc: "हम प्रेरित करने के लिए निर्माण करते हैं - हम वहां से शुरू करते हैं जहां दूसरे रुक जाते हैं, हम मानदंडों पर सवाल उठाते हैं, हम निरर्थक होने से इनकार करते हैं, स्किड्स मीडिया मूल रचनात्मक समाधान देने का प्रयास करता है।",
        trust_title: "वे हम पर भरोसा करते हैं",
        manifesto_text: "हम निर्माण करते हैं, हम विस्तार करते हैं और आप बढ़ते हैं।",
        projects_title: "चयनित कार्य",
        cat_adv: "विज्ञापन",
        cat_tech: "टेक रिपेयर",
        cat_beauty: "ब्यूटी और सैलून",
        cat_transport: "लक्जरी परिवहन",
        cat_edu: "शिक्षा और प्रशिक्षण",
        cat_gaming: "गेमिंग और मनोरंजन",
        p1_title: "फुनून विज्ञापन",
        p1_desc: "संयुक्त अरब अमीरात में एक प्रमुख विज्ञापन एजेंसी के लिए एक जीवंत उपस्थिति।",
        p2_title: "बनबरी आई-रिपेयर्स",
        p2_desc: "पेशेवर डिवाइस मरम्मत के लिए आधुनिक सेवा मंच।",
        p3_title: "असरार सैलون",
        p3_desc: "एक लक्जरी सौंदर्य गंतव्य के लिए सुरुचिपूर्ण डिजिटल अनुभव।",
        p4_title: "क्लासी राइड लिमोसिन",
        p4_desc: "उच्च-स्तरीय परिवहन सेवाओं के लिए प्रीमियम बुकिंग मंच।",
        p5_title: "अल शमसी ड्राइविंग स्कूल",
        p5_desc: "संयुक्त अरब अमीरात में एक प्रमुख ड्राइविंग संस्थान के लिए व्यापक डिजिटल मंच।",
        p6_title: "डीएनए बोर्ड गेम्स",
        p6_desc: "बोर्ड गेम के शौकीनों और कैफे के आगंतुकों के लिए इमर्सिव ऑनलाइन पोर्टल।",
        contact_title: "संपर्क करें",
        contact_desc: "अपना अगला प्रोजेक्ट शुरू करने के लिए तैयार हैं? आइए जुड़ें और साथ मिलकर कुछ असाधारण बनाएं।",
        contact_btn: "हमें ईमेल करें",
        showcase_title: "दुबई और डिजिटल शिल्प",
        cat_dubai: "दुबई",
        cat_dev: "विकास",
        cat_local: "स्थानीय भावना",
        cat_agency: "एजेंसी जीवन",
        showcase_1_title: "प्रतिष्ठित वास्तुकला",
        showcase_1_desc: "दुनिया की सबसे महत्वाकांक्षी स्काईलाइन से प्रेरणा लेना।",
        showcase_2_title: "कला के रूप में कोड",
        showcase_2_desc: "स्वच्छ, स्केलेबल और उच्च-प्रदर्शन वाले डिजिटल समाधान तैयार करना।",
        showcase_3_title: "सामुदायिक जड़ें",
        showcase_3_desc: "वैश्विक डिजिटल उपस्थिति के साथ स्थानीय व्यवसायों को सशक्त बनाना।",
        showcase_4_title: "नाइट विजन",
        showcase_4_desc: "जहां शहर कभी नहीं सोता, और रचनात्मकता कभी नहीं रुकती।",
        showcase_5_title: "सटीक उपकरण",
        showcase_5_desc: "भविष्य के निर्माण के लिए अत्याधुनिक तकनीक का उपयोग करना।",
        showcase_6_title: "रचनात्मक केंद्र",
        showcase_6_desc: "एक ऐसी जगह जहाँ विचार पैदा होते हैं और सीमाओं को आगे बढ़ाया जाता है।",
        team_manifesto_1: "अजमान से दुबई तक,",
        team_manifesto_2: "हम सब से आते हैं",
        team_manifesto_3: "पूरी दुनिया में",
        team_jibran_role: "MARKETING",
        team_hamza_role: "MARKETING",
        team_subhan_role: "WEBSITE DEVELOPMENT",
        contact_keep_in_touch: "संपर्क में रहें",
        contact_start_conv: "बातचीत शुरू करें",
        contact_offices: "हमारे कार्यालय:",
        contact_office_loc: "जल्द ही रमाडा ब्लैक स्क्वायर में आ रहा है",
        nav_other_services: "विस्तारित सेवाएँ",
        story_title: "हमारी कहानी",
        story_text: "स्किड्स का जन्म एक पहाड़ी राजमार्ग पर जीवन के वास्तविक सबक से हुआ था। कड़ाके की ठंड की एक रात में ड्राइविंग करते समय, मेरी कार काली बर्फ के एक टुकड़े से टकरा गई और किनारे की ओर अनियंत्रित होकर घूमने लगी। उस महत्वपूर्ण क्षण में, टायरों ने अचानक डामर को पकड़ लिया, जिससे एक जोरदार 'स्किड' पैदा हुआ जिसने पकड़ वापस पा ली और कार को रोक दिया। उस स्किड ने मेरी जान बचाई। टायरों के उन निशानों को पीछे मुड़कर देखते हुए, मुझे एहसास हुआ कि व्यवसाय चलाना बिल्कुल एक खतरनाक पहाड़ी सड़क पर चलने जैसा है। बाजार में एक अप्रत्याशित बदलाव किसी कंपनी की पकड़ खोने, फिसलने और विफल होने का कारण बन सकता है। इसीलिए मैंने स्किड्स की स्थापना की। जब जमीन हिलती है, तो हम आपके व्यवसाय के लिए आवश्यक पकड़ (traction) के रूप में कार्य करते हैं। हमारा मिशन उद्यमियों को अनियंत्रित होने से रोकने, नियंत्रण वापस पाने और सुरक्षित रूप से अपने व्यवसाय को बढ़ाने के लिए रणनीतिक सहायता, स्थिरता और गति प्रदान करना है।"
    }
};

function translateDigits(text, lang) {
    if (typeof text !== 'string') return text;
    if (lang === 'ar') return text.replace(/\d/g, d => '٠١٢٣٤٥٦٧٨٩'[d]);
    if (lang === 'ur') return text.replace(/\d/g, d => '۰۱۲۳۴۵۶۷۸۹'[d]);
    if (lang === 'hi') return text.replace(/\d/g, d => '०१२३४५६७८९'[d]);
    return text;
}

function setLanguage(lang) {
    const elements = document.querySelectorAll('[data-i18n]');
    elements.forEach(el => {
        const key = el.getAttribute('data-i18n');
        if (translations[lang] && translations[lang][key]) {
            el.textContent = translateDigits(translations[lang][key], lang);
        }
    });

    if (!window.originalTextNodes) {
        window.originalTextNodes = new Map();
        const walk = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, {
            acceptNode: function(node) {
                if (node.parentNode && node.parentNode.closest('[data-i18n]')) return NodeFilter.FILTER_REJECT;
                const tag = node.parentNode ? node.parentNode.tagName : '';
                if (tag === 'SCRIPT' || tag === 'STYLE' || tag === 'NOSCRIPT') return NodeFilter.FILTER_REJECT;
                return NodeFilter.FILTER_ACCEPT;
            }
        });
        let n;
        while(n = walk.nextNode()) {
            if (n.nodeValue.trim() !== '') {
                window.originalTextNodes.set(n, n.nodeValue);
            }
        }
    }
    
    window.originalTextNodes.forEach((orig, node) => {
        if (node.parentNode) {
            node.nodeValue = translateDigits(orig, lang);
        }
    });

    if (lang === 'ur' || lang === 'ar') {
        document.body.classList.add('rtl');
    } else {
        document.body.classList.remove('rtl');
    }

    document.querySelectorAll('.lang-selector span').forEach(btn => {
        btn.classList.remove('active');
        if (btn.getAttribute('data-lang') === lang) {
            btn.classList.add('active');
        }
    });
}

function triggerPageTransition(callback) {
    const overlay = document.getElementById('transition-overlay');
    if (!overlay) {
        callback();
        return;
    }

    // 2 Sec Fade Out
    overlay.className = 'active fade-out-transition';
    
    setTimeout(() => {
        callback();
        
        // 0.3 Sec Fade In
        overlay.className = 'active fade-in-transition';
        setTimeout(() => {
            overlay.className = '';
        }, 300);
    }, 2000);
}

document.querySelectorAll('.lang-selector span').forEach(btn => {
    btn.addEventListener('click', () => {
        const lang = btn.getAttribute('data-lang');
        triggerPageTransition(() => setLanguage(lang));
    });
});

// Custom Cursor
const cursor = document.createElement('div');
cursor.className = 'custom-cursor';
document.body.appendChild(cursor);

const cursorFollower = document.createElement('div');
cursorFollower.className = 'cursor-follower';
document.body.appendChild(cursorFollower);

document.addEventListener('mousemove', (e) => {
    cursor.style.transform = `translate3d(${e.clientX}px, ${e.clientY}px, 0)`;
    
    window.requestAnimationFrame(() => {
        cursorFollower.style.transform = `translate3d(${e.clientX}px, ${e.clientY}px, 0)`;
    });
});

const hoverables = document.querySelectorAll('a, button, .cta-button, .lang-selector span, .project-card');
hoverables.forEach(el => {
    el.addEventListener('mouseenter', () => {
        cursorFollower.classList.add('cursor-active');
    });
    el.addEventListener('mouseleave', () => {
        cursorFollower.classList.remove('cursor-active');
    });
});

// Performance-optimized Scroll-Driven Tickers
let lastScrollY = window.pageYOffset;
let ticking = false;

function updateTickers(scrollPos) {
    const ticker = document.querySelector('.ticker');
    const discoverTicker = document.querySelector('.discover-ticker');
    
    if (ticker) {
        ticker.style.transform = `translate3d(${-scrollPos * 0.2}px, 0, 0)`;
    }
    if (discoverTicker) {
        discoverTicker.style.transform = `translate3d(${-scrollPos * 0.5}px, 0, 0)`;
    }
}

window.addEventListener('scroll', () => {
    lastScrollY = window.pageYOffset;
    if (!ticking) {
        window.requestAnimationFrame(() => {
            updateTickers(lastScrollY);
            ticking = false;
        });
        ticking = true;
    }
}, { passive: true });

const observerOptions = {
    threshold: 0.1
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.classList.add('fade-in-visible');
        }
    });
}, observerOptions);

// Mobile Menu Toggle
const mobileMenuBtn = document.getElementById('mobile-menu-btn');
const navLinks = document.querySelector('.nav-links');

if (mobileMenuBtn) {
    mobileMenuBtn.addEventListener('click', () => {
        mobileMenuBtn.classList.toggle('active');
        navLinks.classList.toggle('active');
    });
}

// Transition for all navigation-style links
document.querySelectorAll('.nav-links a, .btn-back, .cta-link-secondary, .extra-services-btn').forEach(link => {
    link.addEventListener('click', (e) => {
        const href = link.getAttribute('href');
        if (!href) return;

        // Internal hash links
        if (href.startsWith('#')) {
            e.preventDefault();
            triggerPageTransition(() => {
                const targetElement = document.querySelector(href);
                if (targetElement) {
                    targetElement.scrollIntoView({ behavior: 'smooth' });
                }
            });
        } 
        // External page links (like portfolio.html or index.html)
        else if (href.endsWith('.html')) {
            e.preventDefault();
            triggerPageTransition(() => {
                window.location.href = href;
            });
        }
        
        if (mobileMenuBtn) {
            mobileMenuBtn.classList.remove('active');
            navLinks.classList.remove('active');
        }
    });
});

// Cookie Consent Logic
function initCookieBanner() {
    const banner = document.getElementById('cookie-banner');
    const acceptBtn = document.getElementById('accept-cookies');
    
    if (!banner || !acceptBtn) return;

    // Check if user has already accepted
    if (!localStorage.getItem('cookies-accepted')) {
        setTimeout(() => {
            banner.classList.add('show');
        }, 2000);
    }

    acceptBtn.addEventListener('click', () => {
        localStorage.setItem('cookies-accepted', 'true');
        banner.classList.remove('show');
    });
}

document.addEventListener('DOMContentLoaded', () => {
    initCookieBanner();
});

document.querySelectorAll('.project-card, .section-title, .feature-section, .manifesto-section, .team-section, .service-item, .package-card, .add-ons-container, .inquiry-card').forEach(el => {
    el.classList.add('fade-in-hidden');
    observer.observe(el);
});
