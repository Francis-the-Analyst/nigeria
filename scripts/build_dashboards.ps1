param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$dataPath = Join-Path $Root 'data/dataset_final.json'
$templatePath = Join-Path $Root 'web/dashboard_runtime_template.html'
if (!(Test-Path -LiteralPath $dataPath)) { throw 'Falta data/dataset_final.json; ejecuta build_phase1_dataset.ps1 primero.' }
if (!(Test-Path -LiteralPath $templatePath)) { throw 'Falta web/dashboard_runtime_template.html.' }

$dataJson = Get-Content -Raw -Encoding UTF8 -LiteralPath $dataPath
$data = @(ConvertFrom-Json -InputObject $dataJson | ForEach-Object { $_ })
$template = Get-Content -Raw -Encoding UTF8 -LiteralPath $templatePath
$utf8Bom = New-Object System.Text.UTF8Encoding($true)

function Write-Utf8 {
    param([string]$Path, [string]$Content)
    [System.IO.File]::WriteAllText($Path, $Content, $utf8Bom)
}

function Build-Dashboard {
    param(
        [string]$Scope,
        [string]$Title,
        [string]$Filename
    )
    $scopeRows = @($data | Where-Object { $_.segment -eq $Scope })
    $json = ConvertTo-Json -InputObject $scopeRows -Depth 12 -Compress
    $json = $json.Replace('</script', '<\/script')
    $html = $template.Replace('__SCOPE__', $Scope).Replace('__TITLE__', $Title).Replace('__SUMMARY_LINK__', 'resumen_ejecutivo_nigeria_fase1.html').Replace('__DATA_JSON__', $json)
    Write-Utf8 (Join-Path $Root $Filename) $html
    Write-Output ($Filename + ': ' + $scopeRows.Count + ' records embedded')
}

Build-Dashboard 'Retail' 'Retail / puntos de venta y canal' 'dashboard_retail.html'
Build-Dashboard 'Proyectos' 'Proyectos / especificación y obra' 'dashboard_projects.html'

$cityMeta = @{
    'Lagos' = @{ score = 90; reading = 'Hub de Stone Depot, puerto y mayor profundidad premium.' }
    'Abuja' = @{ score = 76; reading = 'Mercado compacto, alto poder adquisitivo y distritos prime.' }
    'Port Harcourt' = @{ score = 72; reading = 'Oil & gas, EPC, hospitality y estates.' }
}
$cityCards = New-Object System.Text.StringBuilder
foreach ($city in @('Lagos','Abuja','Port Harcourt')) {
    $rows = @($data | Where-Object { $_.city -eq $city })
    $retail = @($rows | Where-Object { $_.segment -eq 'Retail' }).Count
    $projects = @($rows | Where-Object { $_.segment -eq 'Proyectos' }).Count
    $meta = $cityMeta[$city]
    [void]$cityCards.Append('<article class="city"><div class="cityScore">' + $meta.score + '/100</div><h3>' + $city + '</h3><p>' + $meta.reading + '</p><div class="counts"><span>' + $retail + ' Retail</span><span>' + $projects + ' Proyectos</span></div></article>')
}

$index = @"
<!doctype html>
<html lang="es">
<head>
  <meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Cosentino Nigeria — Phase 1 market map</title>
  <style>
    :root{--bg:#101416;--panel:#1a2024;--line:#354149;--text:#edf1f0;--muted:#a2adb2;--mint:#b8e4cf;--amber:#e7ba72}*{box-sizing:border-box}html{background:var(--bg);color:var(--text);font:15px/1.55 Inter,Segoe UI,Arial,sans-serif}body{margin:0}.wrap{max-width:1220px;margin:auto;padding:25px 24px 60px}a{color:var(--mint)}.top{display:flex;justify-content:space-between;gap:16px;align-items:center;border-bottom:1px solid var(--line);padding-bottom:18px}.brand{font-weight:700;text-transform:uppercase;letter-spacing:.1em;font-size:12px}.brand i{color:var(--mint);font-style:normal}.nav{display:flex;gap:14px;flex-wrap:wrap}.nav a{text-decoration:none;color:var(--muted);font-size:12px}.nav a:hover{color:var(--mint)}.hero{padding:70px 0 48px;max-width:900px}.kicker{color:var(--mint);font-weight:700;font-size:11px;letter-spacing:.18em;text-transform:uppercase}.hero h1{font:700 clamp(42px,7vw,86px)/.9 Georgia,serif;letter-spacing:-.06em;margin:17px 0}.hero p{font-size:20px;color:#d3dcdd;max-width:760px}.hero .meta{font-size:13px;color:var(--muted)}.actions{display:flex;gap:10px;flex-wrap:wrap;margin-top:28px}.btn{border:1px solid var(--mint);border-radius:999px;padding:9px 16px;text-decoration:none;color:var(--text);font-size:13px}.btn:hover{background:var(--mint);color:#122019}.btn.secondary{border-color:var(--line);color:var(--muted)}h2{font:700 29px Georgia,serif;margin:45px 0 16px}.cities{display:grid;grid-template-columns:repeat(3,1fr);gap:14px}.city{background:linear-gradient(150deg,#20292d,#181d20);border:1px solid var(--line);border-radius:16px;padding:19px;min-height:220px}.cityScore{font:700 41px Georgia,serif;color:var(--amber)}.cityScore small{font:16px Georgia,serif;color:var(--muted)}.city h3{font:700 23px Georgia,serif;margin:9px 0 4px}.city p{color:var(--muted);min-height:49px}.counts{display:flex;gap:8px;color:var(--mint);font-size:12px}.channels{display:grid;grid-template-columns:1fr 1fr;gap:14px}.channel{border:1px solid var(--line);border-radius:16px;padding:22px;background:var(--panel)}.channel h3{margin-top:0;font:700 26px Georgia,serif}.channel p{color:var(--muted)}.notice{margin-top:30px;border:1px dashed #765f40;background:#211f1a;border-radius:14px;padding:18px;color:#d3c1a1}.foot{border-top:1px solid var(--line);margin-top:50px;padding-top:17px;color:var(--muted);font-size:12px}@media(max-width:760px){.wrap{padding:17px 14px 40px}.hero{padding:45px 0 32px}.cities,.channels{grid-template-columns:1fr}.top{align-items:start;flex-direction:column}}
  </style>
</head>
<body><main class="wrap">
  <header class="top"><div class="brand">Cosentino <i>/</i> Nigeria</div><nav class="nav"><a href="resumen_ejecutivo_nigeria_fase1.html">Resumen ejecutivo</a><a href="dashboard_retail.html">Retail</a><a href="dashboard_projects.html">Proyectos</a></nav></header>
  <section class="hero"><div class="kicker">Fase 1 · market map</div><h1>Tres ciudades.<br>Un siguiente paso claro.</h1><p>Mapa operativo de oportunidades para Cosentino en Nigeria: Retail y Proyectos separados, con filtros por ciudad, perfil, canal, evidencia y prioridad.</p><p class="meta">Lagos · Abuja · Port Harcourt &nbsp; / &nbsp; $($data.Count) actores urbanos &nbsp; / &nbsp; 58 Retail · 44 Proyectos</p><div class="actions"><a class="btn" href="resumen_ejecutivo_nigeria_fase1.html">Leer resumen ejecutivo →</a><a class="btn secondary" href="dashboard_retail.html">Explorar Retail</a><a class="btn secondary" href="dashboard_projects.html">Explorar Proyectos</a></div></section>
  <section><h2>Scorecard Fase 1</h2><div class="cities">$($cityCards.ToString())</div></section>
  <section><h2>Dos rutas de entrada</h2><div class="channels"><article class="channel"><h3>Retail</h3><p>Showrooms, distribuidores, marmolistas, transformadores y partners de proximidad. Lagos profundiza desde Stone Depot; Abuja busca un showroom/fabricador; Port Harcourt audita un partner técnico sin exclusividad inicial.</p><a href="dashboard_retail.html">Abrir mapa Retail →</a></article><article class="channel"><h3>Proyectos</h3><p>Developers, contractors, arquitectura, interiorismo, hospitality y oil &amp; gas. El modelo es especificación directa, muestras, mock-ups y procurement, con inventario bajo control del hub.</p><a href="dashboard_projects.html">Abrir mapa Proyectos →</a></article></div></section>
  <section class="notice"><strong>Fase 2 pendiente:</strong> Benin City, Kano, Ibadan, Enugu y Onitsha/Awka no participan en este ranking. Quedan reservadas para análisis posterior. La base pública es un mapa de cuentas, no un censo ni un forecast de m².</section>
  <footer class="foot">Fuente de trabajo: investigación urbana y listas nacionales auxiliares del proyecto Nigeria · Fecha de corte: 2 de octubre de 2026</footer>
</main></body></html>
"@
Write-Utf8 (Join-Path $Root 'index.html') $index
Write-Output ('index.html: ' + $data.Count + ' actor scope and 3 city cards')
