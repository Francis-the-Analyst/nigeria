param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'

function Get-Text {
    param([object]$Value)
    if ($null -eq $Value) { return '' }
    if ($Value -is [System.Array]) { return (($Value | ForEach-Object { [string]$_ }) -join '; ') }
    return ([string]$Value).Trim()
}

function Get-Count {
    param([object]$Value)
    if ($null -eq $Value) { return 0 }
    if ($Value -is [System.Array]) { return @($Value).Count }
    if ((Get-Text $Value) -eq '') { return 0 }
    return 1
}

function Contains-Any {
    param(
        [string]$Value,
        [string[]]$Needles
    )
    $haystack = (Get-Text $Value).ToLowerInvariant()
    foreach ($needle in $Needles) {
        if ($haystack.Contains($needle.ToLowerInvariant())) { return $true }
    }
    return $false
}

function Resolve-Profile {
    param([object]$Row)
    $typology = Get-Text $Row.typology
    $hybrid = Get-Text $Row.hybrid_detail
    $combined = ($typology + ' ' + $hybrid).ToLowerInvariant()

    if (Contains-Any $Row.channel @('Proyectos')) {
        if ($combined -match 'developer|real estate|property|estate') { return 'Developer' }
        if ($combined -match 'contractor|construction|builder|quantity surveyor') { return 'Contractor' }
        if ($combined -match 'architect') { return 'Architecture Studio' }
        if ($combined -match 'interior') { return 'Interior Designer' }
        return 'Especificador Técnico'
    }

    if ($combined -match 'kitchen|bath|showroom') { return 'Kitchen & Bath Showroom' }
    if ($combined -match 'natural stone|stone distributor|distributor') { return 'Distribuidor Piedra Natural' }
    if ($combined -match 'marmol|marble|fabricat|transform|processor|countertop') { return 'Marmolista/Transformador' }
    if ($combined -match 'interior') { return 'Interior Designer' }
    if ($combined -match 'architect') { return 'Architecture Studio' }
    return $typology
}

function Resolve-EntryAngle {
    param([string]$Profile, [string]$Channel)
    switch ($Profile) {
        'Developer' { return 'Acuerdo de especificación para próximos desarrollos y muestras de proyecto.' }
        'Contractor' { return 'Abrir vía procurement: homologación, ficha técnica y suministro por obra.' }
        'Architecture Studio' { return 'Kit de muestras y prescripción temprana para memorias y acabados.' }
        'Interior Designer' { return 'Presentación de superficies y biblioteca de muestras para proyectos premium.' }
        'Kitchen & Bath Showroom' { return 'Exposición compacta con muestras de alto impacto y formación comercial.' }
        'Distribuidor Piedra Natural' { return 'Auditar cobertura, almacén y capacidad de distribución antes de acordar canal.' }
        'Marmolista/Transformador' { return 'Auditar taller, CNC, instalación y capacidad de transformar formatos grandes.' }
        'Especificador Técnico' { return 'Formación técnica y acompañamiento de especificación en proyectos complejos.' }
        default { return 'Validar encaje comercial y diseñar un piloto de muestras.' }
    }
}

function Resolve-Confidence {
    param([object]$Row)
    $raw = Get-Text $Row.raw_notes
    $source = Get-Text $Row.source_channel
    $urls = Get-Count $Row.source_urls
    if (Contains-Any $raw @('pendiente', 'snippet', 'no se pudo verificar', 'unverified', 'needs verification', 'por confirmar')) {
        return 'Baja'
    }
    if (($source -match 'Web propia|LinkedIn') -and $urls -gt 0 -and ((Get-Text $Row.website) -ne '' -or (Get-Text $Row.address) -ne '' -or (Get-Text $Row.phone) -ne '')) {
        return 'Alta'
    }
    if ($urls -gt 0 -or $source -match 'Varios|Google Business') { return 'Media' }
    return 'Baja'
}

function Resolve-Priority {
    param([object]$Row)
    $score = 0
    $channel = Get-Text $Row.channel
    $profile = Resolve-Profile $Row
    $source = Get-Text $Row.source_channel
    $raw = Get-Text $Row.raw_notes

    if ($channel -eq 'Proyectos') { $score += 42 } else { $score += 28 }
    if ($profile -match 'Developer|Contractor') { $score += 18 }
    if ($profile -match 'Showroom|Marmolista|Distribuidor') { $score += 14 }
    if ((Get-Text $Row.physical_exposure) -match 'Sí|Yes|Alta|Showroom|Taller') { $score += 12 }
    if ((Get-Text $Row.project_name) -ne '') { $score += 7 }
    if ((Get-Text $Row.price_range_estimate) -ne '' -and (Get-Text $Row.price_range_estimate) -notmatch 'N/D|Unknown|No verificado') { $score += 4 }
    if ((Get-Text $Row.website) -ne '') { $score += 3 }
    if ((Get-Text $Row.email) -ne '') { $score += 3 }
    if ((Get-Text $Row.phone) -ne '') { $score += 2 }
    $score += [Math]::Min(8, (Get-Count $Row.source_urls) * 2)
    if ($source -match 'Web propia|LinkedIn') { $score += 6 }
    if ($source -match 'Google Business') { $score += 2 }
    if (Contains-Any $raw @('pendiente', 'snippet', 'no se pudo verificar', 'por confirmar')) { $score -= 14 }

    $score = [Math]::Max(0, [Math]::Min(100, $score))
    if ($score -ge 78) { return 'Alta' }
    if ($score -ge 58) { return 'Media' }
    return 'Watch'
}

function Resolve-Score {
    param([object]$Row)
    $score = 0
    $profile = Resolve-Profile $Row
    $source = Get-Text $Row.source_channel
    $raw = Get-Text $Row.raw_notes
    if ((Get-Text $Row.channel) -eq 'Proyectos') { $score += 42 } else { $score += 28 }
    if ($profile -match 'Developer|Contractor|Showroom|Marmolista|Distribuidor') { $score += 18 }
    if ((Get-Text $Row.physical_exposure) -match 'Sí|Yes|Alta|Showroom|Taller') { $score += 12 }
    if ((Get-Text $Row.project_name) -ne '') { $score += 7 }
    if ((Get-Text $Row.website) -ne '') { $score += 3 }
    if ((Get-Text $Row.email) -ne '') { $score += 3 }
    if ((Get-Text $Row.phone) -ne '') { $score += 2 }
    $score += [Math]::Min(8, (Get-Count $Row.source_urls) * 2)
    if ($source -match 'Web propia|LinkedIn') { $score += 6 }
    if (Contains-Any $raw @('pendiente', 'snippet', 'no se pudo verificar', 'por confirmar')) { $score -= 14 }
    return [Math]::Max(0, [Math]::Min(100, $score))
}

$sourceFiles = @(
    'data/retail_lagos.json',
    'data/retail_abuja.json',
    'data/retail_port_harcourt.json',
    'data/projects_lagos.json',
    'data/projects_abuja.json',
    'data/projects_port_harcourt.json'
)

$cityMeta = @{
    'Lagos' = @{ score = 90; rank = 1; x = 0.82; y = 0.74 }
    'Abuja' = @{ score = 76; rank = 2; x = 0.53; y = 0.40 }
    'Port Harcourt' = @{ score = 72; rank = 3; x = 0.30; y = 0.63 }
}

$records = New-Object 'System.Collections.Generic.List[object]'
$sourceCounts = [ordered]@{}
foreach ($relative in $sourceFiles) {
    $full = Join-Path $Root $relative
    if (!(Test-Path -LiteralPath $full)) { throw "Falta la fuente: $relative" }
    $rows = Get-Content -Raw -Encoding UTF8 -LiteralPath $full | ConvertFrom-Json
    $sourceCounts[$relative] = @($rows).Count
    foreach ($row in @($rows)) { [void]$records.Add($row) }
}

$finalRows = New-Object 'System.Collections.Generic.List[object]'
$seen = @{}
$duplicates = New-Object 'System.Collections.Generic.List[string]'
foreach ($row in $records) {
    $id = Get-Text $row.id
    if ($id -eq '') { throw 'Registro sin id detectado.' }
    if ($seen.ContainsKey($id)) { [void]$duplicates.Add($id); continue }
    $seen[$id] = $true

    $city = Get-Text $row.city
    if (!$cityMeta.ContainsKey($city)) { throw "Ciudad fuera del alcance Fase 1: $city" }
    $meta = $cityMeta[$city]
    $profile = Resolve-Profile $row
    $score = Resolve-Score $row
    $base = [ordered]@{}
    foreach ($property in $row.PSObject.Properties) { $base[$property.Name] = $property.Value }
    $base['country'] = 'Nigeria'
    $base['segment'] = Get-Text $row.channel
    $base['profile'] = $profile
    $base['priority'] = Resolve-Priority $row
    $base['entry_angle'] = Resolve-EntryAngle $profile (Get-Text $row.channel)
    $base['confidence'] = Resolve-Confidence $row
    $base['city_score'] = $meta.score
    $base['city_rank'] = $meta.rank
    $base['map'] = [ordered]@{ city = $city; x = $meta.x; y = $meta.y; score = $meta.score; rank = $meta.rank }
    [void]$finalRows.Add([pscustomobject]$base)
}

$dataDir = Join-Path $Root 'data'
$jsonPath = Join-Path $dataDir 'dataset_final.json'
$csvPath = Join-Path $dataDir 'dataset_final.csv'
$json = ConvertTo-Json -InputObject $finalRows -Depth 12
$utf8Bom = New-Object System.Text.UTF8Encoding($true)
[System.IO.File]::WriteAllText($jsonPath, $json, $utf8Bom)

$csvRows = foreach ($row in $finalRows) {
    $flat = [ordered]@{}
    foreach ($property in $row.PSObject.Properties) {
        if ($property.Name -eq 'map') {
            $flat[$property.Name] = ConvertTo-Json -InputObject $property.Value -Compress -Depth 4
        } elseif ($property.Value -is [System.Array]) {
            $flat[$property.Name] = Get-Text $property.Value
        } else {
            $flat[$property.Name] = Get-Text $property.Value
        }
    }
    [pscustomobject]$flat
}
$csv = $csvRows | ConvertTo-Csv -NoTypeInformation
[System.IO.File]::WriteAllLines($csvPath, $csv, $utf8Bom)

$notesPath = Join-Path $dataDir 'raw/phase1_consolidation_notes.md'
$notesDir = Split-Path -Parent $notesPath
New-Item -ItemType Directory -Force -Path $notesDir | Out-Null
$countByCity = $finalRows | Group-Object city | Sort-Object Name
$countByChannel = $finalRows | Group-Object channel | Sort-Object Name
$notes = @(
    '# Notas de consolidación — Nigeria Fase 1',
    '',
    ('Generado: ' + (Get-Date -Format 'yyyy-MM-dd HH:mm')), 
    '',
    '## Fuentes y conteos',
    '',
    '| Fuente | Registros leídos |',
    '|---|---:|'
)
foreach ($key in $sourceCounts.Keys) { $notes += ('| `' + $key + '` | ' + $sourceCounts[$key] + ' |') }
$notes += @('', '## Resultado', '', ('- Registros leídos: ' + $records.Count), ('- Registros únicos publicados: ' + $finalRows.Count), ('- Duplicados excluidos por `id`: ' + $duplicates.Count), ('- Retail: ' + (@($finalRows | Where-Object { $_.channel -eq 'Retail' }).Count)), ('- Proyectos: ' + (@($finalRows | Where-Object { $_.channel -eq 'Proyectos' }).Count)), '')
$notes += @('### Desglose por ciudad', '', '| Ciudad | Registros |', '|---|---:|')
foreach ($group in $countByCity) { $notes += ('| ' + $group.Name + ' | ' + $group.Count + ' |') }
$notes += @('', '### Desglose por canal', '', '| Canal | Registros |', '|---|---:|')
foreach ($group in $countByChannel) { $notes += ('| ' + $group.Name + ' | ' + $group.Count + ' |') }
$notes += @('', '## Decisiones de limpieza', '', '- Se conserva un único registro por `id`; cualquier colisión se registra y se excluye del consolidado.', '- Los campos `profile`, `priority`, `entry_angle`, `confidence`, `city_score`, `city_rank` y `map` son derivados para facilitar priorización y filtros.', '- La puntuación de ciudad es direccional para la Fase 1 y no representa tamaño de mercado ni cuota.', '- Los registros con `raw_notes` que indican snippet, pendiente o verificación incompleta quedan marcados con confianza baja.', '- Los listados nacionales Top 50/30/20 permanecen fuera de este funnel de 102 actores para no mezclar universos analíticos.')
if ($duplicates.Count -gt 0) { $notes += @('', '## IDs duplicados excluidos', '', ('- ' + (($duplicates | Sort-Object -Unique) -join ', '))) }
[System.IO.File]::WriteAllLines($notesPath, $notes, $utf8Bom)

Write-Output ('dataset_final.json: ' + $finalRows.Count + ' records')
Write-Output ('dataset_final.csv: ' + $csvRows.Count + ' rows')
Write-Output ('duplicates excluded: ' + $duplicates.Count)
