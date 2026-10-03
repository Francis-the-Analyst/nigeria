# Notas de investigación — Top 20 estudios de arquitectura e interiorismo (Nigeria, país completo)

## Estado: COMPLETO (20/20 identificados)

## Metodología
1. Se leyeron primero `prompt.md`, `data/retail_lagos.json`, `data/projects_lagos.json`, `data/retail_abuja.json` y `data/projects_abuja.json` para no duplicar trabajo ya hecho en esos bloques.
2. Se identificaron los estudios de arquitectura/interiorismo ya presentes en esos 4 ficheros (Lagos y Abuja) y se marcaron con `"already_in_city_dataset": true` en el JSON final, reusando sus datos ya extraídos sin volver a scrapear.
3. Se usó `WebSearch` (herramienta nativa, sin Firecrawl) con queries en inglés para:
   - Rankings sectoriales de firmas de arquitectura de Nigeria 2025/2026 (Building Practice Ltd, archgyan.com, elalan.com, kashgain.net).
   - Listados de estudios de interiorismo de lujo de Nigeria (teal-harmony.com, teeinteriordesigner.com, ensun.io).
   - Verificación individual de contacto/web para cada firma nueva no presente en los datasets de ciudad (Design Group Nigeria, AD Consulting, Chronos Studeos, ACCL, Interstate Architects, CPMS Limited, UCA, DO.II Designs, Bianco Val Interiors, Patrickwaheed Design Consultancy, James Cubitt Architects).
4. No se usó WebFetch directo a las webs propias en esta pasada (se priorizó cubrir los 20 nombres con datos de snippets de WebSearch, que en varios casos ya incluían contacto/dirección/web verificables de forma cruzada en 2-3 fuentes). Pendiente para una siguiente pasada: WebFetch directo a cada website propio para confirmar datos y buscar contacto de compras nominal (casi ninguna firma de arquitectura nigeriana publica un contacto de "compras" explícito — es un patrón consistente con lo ya observado en Lagos/Abuja).

## Composición del listado final (20)
- **Ya presentes en datasets de ciudad (8)**: James Cubitt Architects, FMA Architects, The Building Practice Ltd, JECCL, cmDesign Atelier, Teal-Harmony Designs, DESIOD Interior, Vivabella Designs, Shades of Seven. (Son 9, no 8 — ver lista completa abajo.)
  - Lagos (projects_lagos.json): James Cubitt Architects, FMA Architects, The Building Practice Ltd, cmDesign Atelier.
  - Lagos (retail_lagos.json): Teal-Harmony Designs, DESIOD Interior, Vivabella Designs.
  - Abuja (projects_abuja.json): JECCL.
  - Abuja (retail_abuja.json): Shades of Seven.
- **Nuevos, investigados en esta pasada (11)**: Design Group Nigeria, AD Consulting Limited (AdConsulting), Adeniyi Coker Consultants Limited (ACCL), Chronos Studeos, Interstate Architects Ltd, CPMS Limited, Urban & Contemporary Architects (UCA), DO.II Designs Limited, Bianco Val' Interiors, Patrickwaheed Design Consultancy Ltd, ACC Archons.

## Cobertura geográfica
El listado es deliberadamente de alcance país (no solo Lagos/Abuja), aunque la inmensa mayoría de las sedes principales de estudios de arquitectura/interiorismo de referencia están en Lagos (consistente con ser el centro económico y de diseño del país). Solo Shades of Seven tiene sede confirmada en Abuja. No se identificó ningún estudio de arquitectura/interiorismo de relevancia nacional con sede en Port Harcourt, Kano, Ibadan, Enugu o Benin City en esta pasada — varias de las firmas (Design Group Nigeria, AD Consulting) declaran cobertura multi-ciudad (Lagos+Abuja+Ibadan+Port Harcourt) desde su sede en Lagos, lo cual es el patrón de mercado observado: el talento de diseño de alta gama se concentra en Lagos y viaja/opera remotamente para proyectos en otras ciudades.

## Calidad de los datos y limitaciones
- **Ningún estudio** de los 20 tiene un "purchasing_contact" (responsable de compras) nominal verificado, salvo los casos donde el fundador/a es también el contacto de negocio público (Olajumoke Adenowo en AD Consulting, Ifeyinwa Ighodalo en DO.II Designs, Cynthia Patrick en Bianco Val). Esto es consistente con el patrón ya observado en los datasets de Lagos/Abuja: los estudios de arquitectura/interiorismo no publican un rol de "compras" como lo haría un distribuidor — el contacto relevante para Cosentino sería el socio/fundador o el equipo técnico de especificación de materiales, no un comprador.
- Varios registros (ACC Archons, DESIOD, Vivabella, cmDesign Atelier) carecen de web/email/teléfono propio verificable tras varias búsquedas — se documenta explícitamente en `raw_notes` de cada uno. Esto refleja una limitación real del mercado (muchos estudios boutique de alta gama en Nigeria operan principalmente vía redes sociales/relaciones personales, no webs corporativas robustas), no una falta de esfuerzo de búsqueda.
- El ranking (`rank`) combina: (a) relevancia/tamaño/trayectoria para canal Proyectos (arquitectura institucional/comercial de gran escala) en los puestos 1-12, y (b) relevancia para canal Retail de alto nivel (interiorismo de lujo para cliente final) en los puestos 13-19, cerrando con un registro de menor confianza de datos (ACC Archons) en el puesto 20 para completar las 20 fichas solicitadas.

## Fuentes principales usadas
- buildingpractice.biz (ranking propio "Top 10 Architecture Firms in Nigeria 2025" — fuente primaria para 6 de los 11 registros nuevos)
- archgyan.com/top-10-exceptional-architecture-firms-in-nigeria/
- teal-harmony.com/luxury-home-interior-design-companies-in-lagos/ (fuente primaria para el bloque de interiorismo de lujo)
- Webs propias de cada firma cuando se localizaron (jamescubittarchitects.com, adconsultinglimited.com, chronos-studeos.com, interstatearchitects.com, cpmslimited.com, uca.ng, biancovalinterior.com, patrickwaheed.com)
- Fuentes de terceros/directorios (businessday.ng, archdaily.com, estateintel.com, zoominfo.com) para verificación cruzada de contacto

## Pendiente / próximos pasos recomendados (no bloqueante, el listado de 20 está completo)
1. WebFetch directo a cada website propio nuevo (11 firmas) para confirmar datos de contacto exactos y buscar nombres de socios/directores de diseño (más relevantes que "compras" para este sector).
2. Buscar perfiles de LinkedIn/Instagram de cada estudio para contacto directo de decisión (muchos estudios boutique nigerianos gestionan el negocio vía Instagram antes que vía web).
3. Si se aborda la Fase 2 (Benin City, Kano, Ibadan, Enugu, Onitsha/Awka), repetir una búsqueda específica de estudios de arquitectura/interiorismo con sede en esas ciudades — en esta pasada no se encontró ninguno con sede confirmada fuera de Lagos/Abuja, lo cual en sí mismo es un dato relevante para el informe (concentración de la oferta de diseño de alta gama en Lagos).
3. No se consultó la ciudad de Port Harcourt (data/retail_port_harcourt.json existe pero no se usó como fuente en esta tarea, ya que el encargo solo mencionaba explícitamente retail_lagos.json, projects_lagos.json, retail_abuja.json y projects_abuja.json como datasets ya existentes a reutilizar). Si retail_port_harcourt.json contiene estudios de arquitectura/interiorismo no capturados aquí, revisar en una pasada de consolidación.
