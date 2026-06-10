# Read services.html
$services = Get-Content -Raw -Path 'services.html' -Encoding utf8
$footerRegex = '(?s)<footer.*?>.*?</footer>'
if ($services -match $footerRegex) {
    $footerHtml = $Matches[0]
} else {
    Write-Error "Footer not found in services.html"
    exit
}

# Refactor footer details:
# 1. Replace the old direct calling phone number
$footerHtml = $footerHtml -replace '0547787867', '+971 052 777 3352'
# 2. Replace old email with info@arthouseinterior.co
$footerHtml = $footerHtml -replace 'info@smartzoneuae.com', 'info@arthouseinterior.co'

Write-Host "Extracted and refactored footer HTML."

# Define pages that need the footer added/updated
$targets = @('projects.html', 'learn.html', 'blog.html')

foreach ($t in $targets) {
    if (Test-Path $t) {
        $content = Get-Content -Raw -Path $t -Encoding utf8
        if ($content -match '(?s)<footer.*?>.*?</footer>') {
            Write-Host "$t already has a footer. Replacing it..."
            $content = $content -replace '(?s)<footer.*?>.*?</footer>', $footerHtml
        } else {
            # Find insert point before scripts
            $commentRegex = '(?s)<!--\s*={5,}\s*FOOTER SCRIPTS\s*={5,}\s*-->'
            $commentRegexSimple = '(?s)<!--\s*FOOTER SCRIPTS\s*-->'
            
            if ($content -match $commentRegex) {
                Write-Host "Inserting footer in $t before standard comment..."
                $insert = $Matches[0]
                $content = $content.Replace($insert, "$footerHtml`n`n$insert")
            } elseif ($content -match $commentRegexSimple) {
                Write-Host "Inserting footer in $t before simple comment..."
                $insert = $Matches[0]
                $content = $content.Replace($insert, "$footerHtml`n`n$insert")
            } else {
                # Fallback: insert before last script tag
                Write-Host "Inserting footer in $t before last script tag..."
                $idx = $content.LastIndexOf('<script')
                if ($idx -ne -1) {
                    $content = $content.Substring(0, $idx) + $footerHtml + "`n`n" + $content.Substring($idx)
                } else {
                    Write-Warning "Could not find insert point in $t"
                }
            }
        }
        
        # Replace old emails in this page
        $content = $content -replace 'info@smartzoneuae.com', 'info@arthouseinterior.co'
        
        [System.IO.File]::WriteAllText((Get-Item $t).FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $t"
    } else {
        Write-Warning "$t not found."
    }
}

# Update index.html
if (Test-Path 'index.html') {
    $index = Get-Content -Raw -Path 'index.html' -Encoding utf8
    $index = $index -replace '(?s)<footer.*?>.*?</footer>', $footerHtml
    $index = $index -replace 'info@smartzoneuae.com', 'info@arthouseinterior.co'
    [System.IO.File]::WriteAllText((Get-Item 'index.html').FullName, $index, [System.Text.Encoding]::UTF8)
    Write-Host "Updated index.html"
}

# Update services.html
$services = $services -replace '(?s)<footer.*?>.*?</footer>', $footerHtml
$services = $services -replace 'info@smartzoneuae.com', 'info@arthouseinterior.co'
[System.IO.File]::WriteAllText((Get-Item 'services.html').FullName, $services, [System.Text.Encoding]::UTF8)
Write-Host "Updated services.html"

# Update privacy-policy.html
if (Test-Path 'privacy-policy.html') {
    $privacy = Get-Content -Raw -Path 'privacy-policy.html' -Encoding utf8
    $privacy = $privacy -replace 'info@smartzoneuae.com', 'info@arthouseinterior.co'
    [System.IO.File]::WriteAllText((Get-Item 'privacy-policy.html').FullName, $privacy, [System.Text.Encoding]::UTF8)
    Write-Host "Updated privacy-policy.html"
}

Write-Host "All operations completed successfully!"
