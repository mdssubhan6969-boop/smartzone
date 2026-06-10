$files = @("index.html", "services.html", "projects.html", "learn.html", "blog.html")

$mapping = @{
    'apartment' = 'apartment'
    'villa' = 'villa'
    'living area' = 'living-area'
    'living room' = 'living-area'
    'dining area' = 'dining-area'
    'dining room' = 'dining-area'
    'kitchen' = 'kitchen'
    'powder room' = 'powder-room'
    'bathroom' = 'bathroom'
    'masterbed room' = 'masterbed-room'
    'masterbedroom' = 'masterbed-room'
    'masterbed' = 'masterbed-room'
    'guest room' = 'guest-room'
    'guestroom' = 'guest-room'
    'study room' = 'study-room'
    'studyroom' = 'study-room'
    'theater room' = 'theater-room'
    'theaterroom' = 'theater-room'
    'holiday homes' = 'holiday-homes'
    'holidayhomes' = 'holiday-homes'
    'airbnb' = 'holiday-homes'
    'landscape' = 'landscape'
    'pool' = 'pool'
    'commercial' = 'commercial'
    'office spaces' = 'office-spaces'
    'officespaces' = 'office-spaces'
    'office space' = 'office-spaces'
    'retail showroom' = 'retail-showroom'
    'retail/ showroom' = 'retail-showroom'
    'restaurant' = 'restaurant'
    'exhibition' = 'exhibition'
    'spa' = 'spa'
    'reception area' = 'reception-area'
    'receptionarea' = 'reception-area'
    'conference room' = 'conference-room'
    'conferenceroom' = 'conference-room'
    'manager room' = 'manager-room'
    'managerroom' = 'manager-room'
}

$pattern1 = '(?i)<a\s+([^>]*?)href=["'']services\.html["'']([^>]*?)>([\s\S]*?<span\s+class=["'']elementor-icon-list-text["''][\s\S]*?<\/span>[\s\S]*?)<\/a>'
$pattern2 = '(?i)<a\s+([^>]*?)href=["''](?:#|#home/?)["'']([^>]*?)>([\s\S]*?<span\s+class=["'']e-n-menu-title-text["''][\s\S]*?Spaces[\s\S]*?<\/span>[\s\S]*?)<\/a>'

foreach ($file in $files) {
    if (-not (Test-Path $file)) {
        Write-Host "File not found: $file"
        continue
    }
    
    Write-Host "Updating links in $file..."
    $content = [System.IO.File]::ReadAllText((Resolve-Path $file))
    
    # 1. Update dropdown items
    $evaluator1 = [System.Text.RegularExpressions.MatchEvaluator]{
        param($match)
        $fullTag = $match.Value
        $attrsBefore = $match.Groups[1].Value
        $attrsAfter = $match.Groups[2].Value
        $innerHtml = $match.Groups[3].Value
        
        # Extract plain text
        $rawText = [System.Text.RegularExpressions.Regex]::Replace($innerHtml, '<[^>]+>', '').Trim()
        
        # Normalize text for lookup
        $normText = $rawText.ToLower() -replace '[^a-z0-9]+', ' '
        $normText = $normText.Trim()
        
        if ($mapping.ContainsKey($normText)) {
            $category = $mapping[$normText]
            return "<a $($attrsBefore)href=`"spaces.html?category=$($category)`"$($attrsAfter)>$($innerHtml)</a>"
        }
        
        return $fullTag
    }
    
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern1, $evaluator1)
    
    # 2. Update top-level "Spaces" header link
    $evaluator2 = [System.Text.RegularExpressions.MatchEvaluator]{
        param($match)
        $attrsBefore = $match.Groups[1].Value
        $attrsAfter = $match.Groups[2].Value
        $innerHtml = $match.Groups[3].Value
        return "<a $($attrsBefore)href=`"spaces.html`"$($attrsAfter)>$($innerHtml)</a>"
    }
    
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, $pattern2, $evaluator2)
    
    [System.IO.File]::WriteAllText((Resolve-Path $file), $content)
    Write-Host "Links successfully updated in $file!"
}

Write-Host "All menu links successfully updated!"
