const fs = require('fs');
const path = require('path');

const servicesPath = path.join(__dirname, 'services.html');
const indexPath = path.join(__dirname, 'index.html');
const projectsPath = path.join(__dirname, 'projects.html');
const learnPath = path.join(__dirname, 'learn.html');
const blogPath = path.join(__dirname, 'blog.html');
const privacyPath = path.join(__dirname, 'privacy-policy.html');

// 1. Read services.html
let servicesHtml = fs.readFileSync(servicesPath, 'utf8');

// Extract footer
const footerMatch = servicesHtml.match(/<footer[\s\S]*?<\/footer>/);
if (!footerMatch) {
    console.error("Could not find footer in services.html");
    process.exit(1);
}
let footerHtml = footerMatch[0];

// Refactor footer contact info
// Replace calling phone number with the new one from the screenshot
footerHtml = footerHtml.replace(/0547787867/g, '+971 052 777 3352');
// Replace email address with the one from the screenshot
footerHtml = footerHtml.replace(/info@smartzoneuae.com/g, 'info@arthouseinterior.co');
footerHtml = footerHtml.replace(/mailto:info@smartzoneuae.com/g, 'mailto:info@arthouseinterior.co');

console.log("Extracted and refactored footer HTML.");

// List of target files that need the footer added/updated
const targets = [
    { name: 'projects.html', path: projectsPath },
    { name: 'learn.html', path: learnPath },
    { name: 'blog.html', path: blogPath }
];

targets.forEach(target => {
    let html = fs.readFileSync(target.path, 'utf8');
    
    // Check if footer already exists
    if (html.includes('<footer') || html.includes('</footer')) {
        console.log(`${target.name} already contains a footer. Replacing it...`);
        html = html.replace(/<footer[\s\S]*?<\/footer>/, footerHtml);
    } else {
        // Find insert position (before FOOTER SCRIPTS comment)
        const insertMatch = html.match(/<!--\s*={5,}\s*FOOTER SCRIPTS\s*={5,}\s*-->/) || 
                            html.match(/<!--\s*FOOTER SCRIPTS\s*-->/) ||
                            html.match(/<!--\s*={5,}\s*[\s\S]*?FOOTER SCRIPTS[\s\S]*?={5,}\s*-->/);
        
        if (insertMatch) {
            console.log(`Inserting footer into ${target.name} before comment: "${insertMatch[0].replace(/\n/g, ' ')}"`);
            const index = html.indexOf(insertMatch[0]);
            html = html.substring(0, index) + footerHtml + '\n\n' + html.substring(index);
        } else {
            console.warn(`Could not find footer scripts comment in ${target.name}. Appending before first script tag...`);
            // Fallback: insert before first script tag at the bottom
            const index = html.lastIndexOf('<script');
            if (index !== -1) {
                html = html.substring(0, index) + footerHtml + '\n\n' + html.substring(index);
            } else {
                console.error(`Could not find insert point in ${target.name}`);
            }
        }
    }
    
    // Make sure contact details inside the rest of the page (in case there's any) are also updated
    html = html.replace(/info@smartzoneuae.com/g, 'info@arthouseinterior.co');
    html = html.replace(/mailto:info@smartzoneuae.com/g, 'mailto:info@arthouseinterior.co');
    
    fs.writeFileSync(target.path, html, 'utf8');
    console.log(`Updated ${target.name}`);
});

// Update index.html and services.html footers
let indexHtml = fs.readFileSync(indexPath, 'utf8');
indexHtml = indexHtml.replace(/<footer[\s\S]*?<\/footer>/, footerHtml);
indexHtml = indexHtml.replace(/info@smartzoneuae.com/g, 'info@arthouseinterior.co');
indexHtml = indexHtml.replace(/mailto:info@smartzoneuae.com/g, 'mailto:info@arthouseinterior.co');
fs.writeFileSync(indexPath, indexHtml, 'utf8');
console.log("Updated index.html");

servicesHtml = servicesHtml.replace(/<footer[\s\S]*?<\/footer>/, footerHtml);
servicesHtml = servicesHtml.replace(/info@smartzoneuae.com/g, 'info@arthouseinterior.co');
servicesHtml = servicesHtml.replace(/mailto:info@smartzoneuae.com/g, 'mailto:info@arthouseinterior.co');
fs.writeFileSync(servicesPath, servicesHtml, 'utf8');
console.log("Updated services.html");

// Update privacy-policy.html email
let privacyHtml = fs.readFileSync(privacyPath, 'utf8');
privacyHtml = privacyHtml.replace(/info@smartzoneuae.com/g, 'info@arthouseinterior.co');
privacyHtml = privacyHtml.replace(/mailto:info@smartzoneuae.com/g, 'mailto:info@arthouseinterior.co');
fs.writeFileSync(privacyPath, privacyHtml, 'utf8');
console.log("Updated privacy-policy.html");

console.log("All files updated successfully!");
