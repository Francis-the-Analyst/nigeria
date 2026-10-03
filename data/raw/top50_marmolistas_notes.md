# Notas de investigación — Top 50 marmolistas/transformadores de Nigeria

Fecha: 2026-10-02. Herramientas usadas: `WebSearch` y `WebFetch` nativos (sin Firecrawl), idioma de búsqueda inglés.

## Resultado

`data/top50_marmolistas.json` contiene **50 registros** completos (campo `rank` 1-50). Objetivo cumplido en número de empresas identificadas; el nivel de detalle por empresa es desigual (ver sección "Calidad de datos" abajo), tal y como anticipaba el prompt ("es aceptable que no todas tengan todos los campos rellenos").

## Punto de partida

Se leyeron primero `data/retail_lagos.json`, `data/retail_abuja.json` y `data/retail_port_harcourt.json` (estos dos últimos no mencionados explícitamente en el encargo pero ya existentes en `data/`, por lo que se usaron igual como base para no duplicar trabajo). De esos tres ficheros se extrajeron los registros cuya tipología es específicamente "Marmolista/Transformador" o "Distribuidor Piedra Natural" (se excluyeron deliberadamente "Interior Designer" y "Kitchen & Bath Showroom" de esas listas, salvo que combinaran fabricación/distribución de piedra, porque el encargo pide marmolistas/transformadores, no todo el canal retail).

Marcados `already_in_city_dataset: true` (23 registros, ya investigados en otro bloque de trabajo, no se repitió investigación):
- Lagos (10): Stone Depot by Impacto, Auxxdsson Global Resources, Maldini Granites & Marbles, Samsonite Homes, Bluestar Marbles, Jeuton Finishing, MarbleBros, Tarstone Company, Bezalil HouseSolutions, Kaluk Furniture Systems.
- Abuja (6 usados de 8 disponibles): OFL Marble & Granite, CIBI Nigeria, Natural Stone Industries, OGB Tiles 'N' Marbles, Bluestar Finishing Company (fusionada con Bluestar Marbles de Lagos como una sola entidad nacional). Se descartaron del top 50 "Ebo9 Tiles & Marble" y "Success Marble Company" (datos demasiado débiles/sin verificar) y "Dei-Dei Market generic" (es un mercado/clúster, no una empresa).
- Port Harcourt (5): Rocciano Marbles, UCHE Estates, Nigerstone, Crushed Rock Industries, Castremineo Nig Ltd (distribuidor de Caesarstone — competidor internacional directo).

## Investigación nueva realizada (27 empresas nuevas)

Búsquedas ejecutadas (todas en inglés):
1. "largest marble and granite company Nigeria fabrication factory" → OFL, Premium Marbles & Granite (PMG), Giovanni Marbles and Granites, CIBI (confirmación).
2. "granite and marble company Benin City Nigeria" → Crystal Dave Marble And Granite Company, Jerasi Nigeria Company.
3. "marble granite tiles company Kano Nigeria" → UBSS Group Nig Ltd (único hallazgo específico de Kano; posible señal de vacío de oferta premium en esa ciudad, útil para el informe).
4. "marble granite company Ibadan Nigeria supplier" → Filade Marble Works, Mighty Marble And Granite Works, Excel Integrated Marble and Granite Tiles, Claudianne Marble and Interior Decor, Fatab Nig. Enterprise.
5. "marble granite company Enugu Nigeria" → confirmación de Maldini (posible sucursal Enugu, sin verificar), Crystal Dave, Farad Contractors.
6. "marble granite company Onitsha Awka Anambra Nigeria" → confirmación Giovanni (sucursales Onitsha/Nnewi), PMG, OFL.
7. "Caesarstone Nigeria distributor dealer" → sin resultado directo (resuelto después vía Castremineo, ya conocido de PH).
8. "Neolith Nigeria distributor Compac Laminam Quartzforms Nigeria" → sin distribuidor específico identificado en Nigeria para estas marcas (hueco de mercado relevante para el bloque D de competencia del brief general).
9. WebFetch a `topnaijabiz.com/best-granite-suppliers-in-lagos` → 10 empresas de Lagos con rango de precio por m².
10. WebFetch a `finelib.com` directorio Lagos marble/granite → 18 empresas adicionales de Lagos (mercado de Coker-Orile/Olaniyonu principalmente).
11. WebFetch a Giovanni Marbles, PMG (about-us), intento a OFL (error 500) y PMG contacto (404).
12. WebSearch de verificación de contacto para Zanetti, ASADA, Farad Contractors, Castremineo.

## Calidad de datos / limitaciones

- **Facturación estimada y nº de empleados**: no se pudo determinar para ninguna empresa (ninguna publica cifras financieras ni de plantilla verificables; solo CIBI declara "+75 empleados" y Castremineo aparece como "11-50" en LinkedIn).
- **Capacidad de transformación (m2/día)**: solo verificada para 2 empresas (OFL >3.000 m2/día combinando fuentes, PMG >1.500 m2/día) — son probablemente las dos mayores fabricantes indígenas del país por este criterio.
- Para ~20 empresas del tramo final del ranking (principalmente el clúster mayorista de Coker-Orile/Olaniyonu en Lagos, vía finelib), solo se dispone de nombre, dirección aproximada y teléfono — sin email ni web propia. Esto es representativo del mercado real: la mayoría de "marmolistas" de Nigeria son pequeños negocios de mercado mayorista sin presencia digital, no empresas con web corporativa.
- `website` y `email` quedaron en `null` en 2 de las 3 fuentes grandes citadas en varias búsquedas (PMG: sin contacto directo verificado, la página /contact-us devolvió 404; Zanetti: WebFetch a stonecontact.com bloqueado con 403).
- No se encontró un distribuidor claro de Neolith, Compac, Laminam o Quartzforms en Nigeria — dato relevante para el bloque de competencia (D) del brief general, a reportar al orquestador.

## Pendiente si se retoma en otra sesión

1. Reintentar WebFetch directo a `oflmarbleandgranite.com` (dio error 500 en esta sesión y en la sesión de Abuja) y a `pmg.ng` para obtener contacto de compras verificado de los dos mayores fabricantes.
2. Verificar con llamada/formulario la sucursal de Maldini en Enugu y las sucursales de Giovanni en Onitsha/Nnewi/Abuja (relevante para Fase 2).
3. Profundizar en Kano: solo se encontró 1 empresa (UBSS Group) — merece una segunda pasada de búsqueda específica (ej. "Kano building materials market marble granite", directorios locales) antes de concluir que es un vacío real de mercado.
4. Buscar específicamente distribuidores/showrooms de Caesarstone, Neolith, Compac y Laminam en Nigeria con queries más específicas (ej. sitio de cada marca con "distributor locator Nigeria/Africa"), ya que esta pasada no dio resultado concluyente más allá de Castremineo-Caesarstone.
5. Verificar segmento y capacidad exacta de ASADA Granite & Marble (Abuja) — la web dio error 500 en el único intento de WebFetch de esta sesión.

## Archivos entregados

- `data/top50_marmolistas.json` — 50 registros, formato acordado.
- `data/raw/top50_marmolistas_notes.md` — este documento.
