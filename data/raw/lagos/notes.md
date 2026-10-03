# Notas de investigación — Lagos (Cosentino Nigeria)

Fecha: 2026-10-02. Agente: Lagos (fase 1, 3 ciudades en paralelo). Herramientas: WebSearch + WebFetch nativos (sin Firecrawl, sin playwright).

## Resumen de cobertura

- Canal Retail: 20 registros en `data/retail_lagos.json` (incluye a Stone Depot by Impacto como referencia/distribuidor actual, no como hueco de mercado).
- Canal Proyectos: 12 registros en `data/projects_lagos.json`.
- Análisis A-F: `analisis_lagos.md` (raíz del proyecto).

## Búsquedas realizadas (WebSearch)

1. `marble granite quartz countertop fabricator Lagos Nigeria` → listados de marmolistas (Samsonite Homes, Bluestar, Jeuton, Maldini, MarbleBros, Auxxdsson).
2. `kitchen and bath showroom Lagos Nigeria luxury` → IL Bagno Nigeria, Luxe Bathwares, Alneli, Oniks365, Baron Bathrooms.
3. `natural stone distributor Lagos Nigeria quartz slabs` → Kaluk Furniture Systems, Bezalil HouseSolutions, Tarstone, Maldini.
4. `interior design studio Lagos Nigeria high end residential` → Vivabella Designs, DESIOD Interior, Maison Consulting, Decor Nigeria, JECCL, Adeola Interiors.
5. `luxury real estate developer Lagos Nigeria premium residential development` → Palton Morgan/Grenadines Homes, Dayspring Property, Strongmas Development, Eko Pearl Towers, Deluxe Residences.
6. `premium construction company Lagos Nigeria high-rise residential commercial` → Elalan, ITB Nigeria, Cappa & D'Alberto, Julius Berger.
7. `architecture firm Lagos Nigeria commercial residential projects` → FMA Architects, NLÉ Architects, cmDesign Atelier, James Cubbitt Architects, The Building Practice Ltd.
8. `Caesarstone distributor Nigeria` → sin resultado específico de Nigeria (ver sección "Competencia" abajo).
9. `Neolith Laminam Compac Nigeria distributor dealer` → sin resultado específico de Nigeria.
10. `"Stone Depot" Impacto Lagos Cosentino Lekki` → confirma Stone Depot by Impacto como distribuidor oficial de Cosentino, dirección y contacto.
11. `Sujimoto Construction Lagos luxury real estate Ikoyi` → Sujimoto, developer ultra-lujo en Ikoyi/Banana Island.

## URLs visitadas con WebFetch (contenido extraído y volcado a las fichas JSON)

- https://www.stonedepotng.com/about-us/ y /contact-us/ — distribuidor actual Cosentino.
- https://auxxdsson.com/update/marble-granite-and-quartz-slabs-and-tiles/1615666
- https://www.finelib.com/cities/lagos/business/construction/building/building-materials/marble-and-granite — directorio de 18 empresas de mármol/granito en Coker-Orile (zona mayorista, mayoría segmento medio/bajo, no premium).
- https://www.topnaijabiz.com/best-granite-suppliers-in-lagos/ — ranking de 10 proveedores con clasificación de segmento (premium/medio).
- https://www.ilbagnonigeria.com/services/our-showrooms — showroom multimarca premium (Duravit, Hansgrohe, etc.), contacto nominal (Michael).
- https://oakandteak.com/interior-designers-in-lagos/ — poco contenido extraíble (solo cabecera).
- https://teal-harmony.com/luxury-home-interior-design-companies-in-lagos/ — 5 estudios de interiorismo de lujo, solo Teal-Harmony con contacto completo.
- https://alneli.com.ng/ — showroom de grifería/sanitarios en Lekki Phase 1.
- https://bathrooms365.com.ng/ (Oniks365) — e-commerce de grifería/sanitarios.
- https://housesolutions.com.ng/tiling-natural-stone/ (Bezalil HouseSolutions) — contratista + distribuidor de piedra natural.
- https://paltonmorgan.com/ — developer de lujo, ficha completa.
- https://strongmasresidence.com/ — developer de lujo, ficha completa.
- https://www.elalan.com/post/construction-companies-lagos — Elalan + resumen de ITB Nigeria, Julius Berger, Craneburg, Sujimoto.
- https://en.wikipedia.org/wiki/Chagoury_Group — Eko Atlantic City.
- https://en.wikipedia.org/wiki/FMA_Architects — estudio de arquitectura de referencia.

## Descartado / no verificado en profundidad (pendiente si se retoma)

- **Dayspring Property Development Company** — WebFetch dio timeout (60s). No se reintentó por límite de tiempo/tokens. Candidato a developer de lujo, pendiente de verificar en una siguiente pasada (`https://www.dayspringproperty.com/`).
- **Deluxe Residences** — mencionado en snippet (18 proyectos, 44% en Oniru) pero no se hizo WebFetch; pendiente.
- **Vivabella Designs, DESIOD Interior, Maison Consulting, Decor Nigeria** — solo snippets de búsqueda (vía jeccl.com y teal-harmony.com); no se pudo verificar website propio, dirección ni contacto directo. Incluidos en el dataset con campos `null`/"No determinable" marcados explícitamente.
- **Kaluk Furniture Systems** — solo snippet vía exporthub.com; sin verificación directa de web propia.
- **Cappa & D'Alberto, Julius Berger, The Building Practice, Craneburg Construction, James Cubbitt Architects, ITB Nigeria** — solo snippets agregados (vía elalan.com, cceonlinenews.com, wikipedia); no se visitó su web corporativa propia directamente por límite de tiempo. Direcciones/contacto no verificados.
- **Caesarstone, Neolith, Laminam, Compac** — no se encontró ningún distribuidor/dealer específico para Nigeria en búsquedas directas. Conclusión preliminar: estas marcas NO tienen presencia formal de distribución local en Nigeria (a diferencia de Cosentino vía Stone Depot). La "competencia" real detectada en Lagos es más bien: granito/mármol natural importado genérico (India, Turquía, Brasil) vendido por los marmolistas de Coker-Orile, y marcas de sanitarios/mobiliario (Duravit, Hansgrohe, Siematic, Laufen, Polystar) en los showrooms de baño — no superficies de cuarzo/sinterizado de marca.
- **jiji.ng y otros marketplaces** (clasificados tipo "Amazon nigeriano") — se omitieron como fichas individuales porque son plataformas de anuncios P2P, no empresas identificables con ficha propia; se usaron solo como señal de precios de referencia (₦35,000-90,000+/m² para granito/cuarzo).
- **Oak & Teak lista de 18 interioristas** — la página no cargó contenido completo vía WebFetch (solo cabecera); no se profundizó por límite de tiempo. Pendiente si se quiere ampliar el listado de interioristas más allá de los 5-6 ya capturados.

## Zonas geográficas identificadas (relevante para mapa de calor del dashboard)

- **Clúster mayorista de piedra**: Coker-Orile / Olaniyonu Marble Market / Badagry Expressway / Alaba-Suru / Apapa (zona industrial/portuaria, segmento medio, alta concentración de marmolistas).
- **Clúster retail/showroom premium**: Lekki Phase 1, Lekki Peninsula II, Victoria Island, Ikoyi (zona donde está Stone Depot, IL Bagno, Alneli, Teal-Harmony, Palton Morgan, Strongmas).
- **Clúster de desarrollo de lujo**: Banana Island, Ikoyi, Victoria Island, Eko Atlantic City, Lekki Phase 1/Ikota GRA.

## PENDIENTE (si se retoma esta investigación)

1. Verificar con WebFetch directo: Dayspring Property, Deluxe Residences, Vivabella Designs, DESIOD Interior, Maison Consulting, Decor Nigeria, Kaluk Furniture Systems, Cappa & D'Alberto, Julius Berger Nigeria, The Building Practice, Craneburg Construction, James Cubbitt Architects, ITB Nigeria — para completar dirección, contacto y evidencia de proyecto donde hoy aparece "No determinable".
2. Ampliar el listado de interioristas de Lagos con la lista completa de oakandteak.com (18 nombres) — el WebFetch inicial solo devolvió la cabecera.
3. Confirmar si existe representación local (aunque sea informal/importador no oficial) de Caesarstone, Neolith, Laminam o Compac en Nigeria — no se encontró en esta pasada, pero merece una búsqueda específica adicional en español/con nombre de distribuidor regional (p. ej. distribuidores de Sudáfrica o Dubái que cubran Nigeria sin oficina local).
4. No se usó playwright-cli; no se identificaron páginas que lo requirieran de forma crítica, salvo paginación de directorios (finelib, jiji.ng) que se resolvió leyendo solo la primera página — si se requiere exhaustividad total del clúster de Coker-Orile, se podría paginar más.
5. El análisis A-F en `analisis_lagos.md` está completo para Lagos; no se ha tocado la matriz de priorización de 8 ciudades, el plan comercial de 12 meses ni el ranking final (eso corresponde al agente orquestador que fusione las 3 ciudades de fase 1).

## Estado final

Trabajo de Lagos completado dentro del alcance encomendado (retail + proyectos + análisis A-F + notas). No se alcanzó el límite de tokens; la sesión se cerró de forma ordenada tras cubrir los mínimos solicitados (20 retail / 12 proyectos) y documentar los huecos pendientes arriba.
