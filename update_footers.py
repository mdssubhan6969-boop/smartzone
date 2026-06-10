import os
import re

dir_path = os.path.dirname(os.path.abspath(__file__))

services_path = os.path.join(dir_path, 'services.html')
index_path = os.path.join(dir_path, 'index.html')
projects_path = os.path.join(dir_path, 'projects.html')
learn_path = os.path.join(dir_path, 'learn.html')
blog_path = os.path.join(dir_path, 'blog.html')
privacy_path = os.path.join(dir_path, 'privacy-policy.html')

# Read services.html
with open(services_path, 'r', encoding='utf-8') as f:
    services_html = f.read()

# Extract footer
footer_match = re.search(r'<footer[\s\S]*?</footer>', services_html)
if not footer_match:
    print("Could not find footer in services.html")
    exit(1)
footer_html = footer_match.group(0)

# Refactor footer info:
# Replace call number with the screenshot call number
footer_html = footer_html.replace('0547787867', '+971 052 777 3352')
# Replace email address with the screenshot email address
footer_html = footer_html.replace('info@smartzoneuae.com', 'info@arthouseinterior.co')

print("Extracted and refactored footer HTML.")

targets = [
    ('projects.html', projects_path),
    ('learn.html', learn_path),
    ('blog.html', blog_path)
]

for name, path in targets:
    with open(path, 'r', encoding='utf-8') as f:
        html = f.read()
    
    if '<footer' in html or '</footer' in html:
        print(f"{name} already contains a footer. Replacing it...")
        html = re.sub(r'<footer[\s\S]*?</footer>', footer_html, html)
    else:
        # Find insert position (before FOOTER SCRIPTS comment)
        insert_match = (
            re.search(r'<!--\s*={5,}\s*FOOTER SCRIPTS\s*={5,}\s*-->', html) or
            re.search(r'<!--\s*FOOTER SCRIPTS\s*-->', html) or
            re.search(r'<!--\s*={5,}\s*[\s\S]*?FOOTER SCRIPTS[\s\S]*?={5,}\s*-->', html)
        )
        
        if insert_match:
            print(f"Inserting footer into {name} before comment.")
            index = html.find(insert_match.group(0))
            html = html[:index] + footer_html + '\n\n' + html[index:]
        else:
            print(f"Could not find comment in {name}. Finding last script tag.")
            index = html.rfind('<script')
            if index != -1:
                html = html[:index] + footer_html + '\n\n' + html[index:]
            else:
                print(f"Could not find insert point in {name}")
                
    # Update emails in target file
    html = html.replace('info@smartzoneuae.com', 'info@arthouseinterior.co')
    
    with open(path, 'w', encoding='utf-8') as f:
        f.write(html)
    print(f"Updated {name}")

# Update index.html and services.html
with open(index_path, 'r', encoding='utf-8') as f:
    index_html = f.read()
index_html = re.sub(r'<footer[\s\S]*?</footer>', footer_html, index_html)
index_html = index_html.replace('info@smartzoneuae.com', 'info@arthouseinterior.co')
with open(index_path, 'w', encoding='utf-8') as f:
    f.write(index_html)
print("Updated index.html")

services_html = re.sub(r'<footer[\s\S]*?</footer>', footer_html, services_html)
services_html = services_html.replace('info@smartzoneuae.com', 'info@arthouseinterior.co')
with open(services_path, 'w', encoding='utf-8') as f:
    f.write(services_html)
print("Updated services.html")

# Update privacy-policy.html
with open(privacy_path, 'r', encoding='utf-8') as f:
    privacy_html = f.read()
privacy_html = privacy_html.replace('info@smartzoneuae.com', 'info@arthouseinterior.co')
with open(privacy_path, 'w', encoding='utf-8') as f:
    f.write(privacy_html)
print("Updated privacy-policy.html")

print("All files updated successfully!")
