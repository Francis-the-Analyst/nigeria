# Prompt — Identificación de puntos de venta retail y proyectos en Nigeria (Cosentino)

## GESTIÓN DE SESIÓN Y CHECKPOINTS (leer antes de empezar)

Si durante la ejecución de esta tarea alcanzas el 95% de los tokens disponibles en la sesión actual (o el agente/modelo que estés usando — Claude Code, Codex u otro — avisa de que se está agotando el presupuesto), detente inmediatamente (no intentes terminar el bloque en curso a toda prisa) y actualiza el archivo `checkpoint.md` de esta misma carpeta con:
- Todos los resultados ya recopilados hasta ese momento, en tabla completa, con todos los campos extraídos por punto de venta/actor/ciudad.
- Qué ciudades, bloques (A-F del brief, canal retail o canal proyectos) y listados (top 50 marmolistas, top 30 promotores, top 20 estudios de arquitectura, matriz de priorización, plan comercial 12 meses, ranking final) ya se han completado y cuáles quedan pendientes.
- El análisis ya elaborado hasta ese punto (segmentación, matriz de priorización, ranking de ciudades), si se ha empezado.
- Un resumen claro de "próximos pasos" que indique exactamente por dónde continuar, sin repetir búsquedas ya hechas.

Al reanudar la tarea en otra sesión o con otro agente de IA, léase primero `checkpoint.md` y úsese como punto de partida: no repetir búsquedas ni scrapes ya hechos, no perder el trabajo avanzado (datos ya guardados en `data/`), y continuar completando únicamente lo pendiente hasta finalizar el informe ejecutivo y la web completos.

**HERRAMIENTAS — IMPORTANTE:** Este proyecto NO usa Firecrawl. En Claude Code, usa las herramientas nativas de búsqueda/scraping (`WebSearch`, `WebFetch`) y, si una página requiere interacción (JS, paginación, clics), `playwright-cli`. Si se trabaja con Codex u otro agente, usar el equivalente nativo de esa herramienta (su propio buscador/navegador), nunca Firecrawl. Guarda cada tanda de resultados crudos en `data/raw/` (JSON o markdown) antes de normalizar, para no perder trabajo si se corta la sesión.

> Nota de contexto: distribuidor actual de Cosentino en Nigeria = **Stone Depot by Impacto**, Lagos (zona Lekki). Toda la investigación debe situarse en relación con esta base: qué cubre ya Stone Depot, qué ciudades/segmentos quedan sin cobertura, y dónde tendría sentido un sub-distribuidor o partner adicional.

## FASE 1 (decidido 2026-10-02) — alcance de esta tanda

- **Ciudades de esta fase**: Lagos, Abuja y Port Harcourt (las 3 de mayor prioridad del cliente). El resto del brief (Benin City, Kano, Ibadan, Enugu, Onitsha/Awka) queda para una Fase 2 futura — no se investigan todavía, pero el prompt de ejecución de más abajo se conserva íntegro con las 8 ciudades para no tener que reescribirlo cuando se aborde la Fase 2.
- **Orquestación**: un agente/sesión por ciudad (3 agentes en paralelo para esta fase — p. ej. Claude Code para una ciudad, Codex para otra, etc.), cada uno guardando sus resultados crudos en `data/raw/<ciudad>/` antes de normalizar. Un agente orquestador (o el usuario) fusiona después los 3 resultados en el dataset único (`data/dataset_final.json`/`.csv`) y en los listados transversales (top 50 marmolistas, top 30 promotores, top 20 estudios — estos sí cubren todo el país, no solo las 3 ciudades de fase 1, en la medida en que la información se encuentre).
- **Umbral canal proyectos**: >2.000 m² de superficie aplicable combinando todas las categorías de producto Cosentino (mismo criterio que Rusia). Ajustar solo si durante la investigación se ve claramente que no encaja con la realidad del mercado nigeriano.
- **Entregable web**: dos dashboards separados, igual que Rusia — uno de canal Retail y otro de canal Proyectos, cada uno con filtros por ciudad/tipología/prioridad (Artifact + HTML standalone, mismo patrón que `dashboard_retail.html`/`dashboard_projects.html` de Rusia). Más el informe ejecutivo en PDF.

---

## Prompt de ejecución

```
CONTEXTO: Soy Export Sales Manager de Cosentino (superficies premium: Silestone, Dekton, Sensa, Piedra Natural). Nuestro distribuidor actual en Nigeria es Stone Depot by Impacto (Lagos, zona Lekki). El cliente (Cosentino Nigeria) pide un análisis de mercado para priorizar la expansión de puntos de venta en el país, diferenciando dos canales de negocio:

- CANAL RETAIL: marmolistas y transformadores, showrooms de cocinas y baños, distribuidores de piedra natural/cuarzo/granito, estudios de diseño de interiores — venta de encimeras y superficies a medida, exposición física de material.
- CANAL PROYECTOS: promotores inmobiliarios de lujo, constructoras premium, estudios de arquitectura e ingeniería, especificadores técnicos — prescripción de material a gran escala en proyectos residenciales/comerciales/hoteleros premium. (Como referencia de umbral, en otros mercados se usa >2.000 m² de superficie aplicable combinando todas las categorías de producto Cosentino para considerar un actor/obra como canal proyectos; valida si ese umbral tiene sentido en el contexto nigeriano o propone uno ajustado).

IDIOMA DE BÚSQUEDA: Inglés (idioma de negocios en Nigeria).

CIUDADES A ANALIZAR (por orden de prioridad dado por el cliente):
1. Lagos
2. Abuja
3. Port Harcourt
4. Benin City
5. Kano
6. Ibadan
7. Enugu
8. Onitsha/Awka (Anambra State)

PARA CADA CIUDAD, PROPORCIONA:

A. Potencial de mercado
- Tamaño del mercado de construcción residencial y comercial.
- Número estimado de proyectos premium y de lujo.
- Nivel adquisitivo de los clientes.
- Valoración del potencial de venta de superficies premium (1-10).

B. Ecosistema de transformación
- Número estimado de marmolistas y transformadores.
- Principales talleres de fabricación e instalación.
- Empresas especializadas en mármol, cuarzo, granito y superficies técnicas.
- Capacidad productiva y nivel tecnológico.

C. Canales de venta
- Principales distribuidores de piedra natural.
- Showrooms de cocinas y baños.
- Empresas constructoras premium.
- Estudios de arquitectura e interiorismo relevantes.
- Promotores inmobiliarios de lujo.

D. Competencia
- Principales marcas presentes.
- Distribuidores de Caesarstone, Quartzforms, Compac, Laminam, Neolith y otras marcas internacionales.
- Fortalezas y debilidades de cada competidor.

E. Logística
- Distancia y facilidad de suministro desde Lagos (sede del distribuidor actual, Stone Depot by Impacto).
- Costes y tiempos aproximados de transporte interior.
- Disponibilidad de almacenes y centros logísticos.

F. Plan de entrada comercial
- Estrategia recomendada para penetrar el mercado (y si tiene sentido vía Stone Depot, un sub-partner local, o entrada directa).
- Tipo de partner ideal.
- Número de visitas comerciales recomendadas.
- Presupuesto inicial estimado.

CLASIFICA cada punto de venta/actor identificado con el canal al que pertenece (Retail o Proyectos) además de ciudad, tipología, datos de contacto, web y persona responsable de compras — para poder construir después un dataset único filtrable por canal, ciudad y tipología (igual que en los proyectos de otros países).

LISTADOS ADICIONALES:

1. Identifica los 50 mayores marmolistas de Nigeria (canal retail). Clasifica cada empresa según: ciudad, facturación estimada, número de empleados, capacidad de transformación, segmento (lujo/medio/proyecto), datos de contacto, página web, responsable de compras.

2. Identifica los 30 principales promotores inmobiliarios del país (canal proyectos).

3. Identifica los 20 principales estudios de arquitectura e interiorismo (canal proyectos, y también retail cuando trabajen con clientes finales/particulares).

ANÁLISIS FINAL:

4. Matriz de priorización con puntuación sobre 100 para cada una de las 8 ciudades, considerando:
   - Potencial de ventas (30%)
   - Número de marmolistas (25%)
   - Número de proyectos premium (20%)
   - Facilidad logística (15%)
   - Competencia (10%)

5. Plan comercial de 12 meses para Cosentino Nigeria, indicando:
   - Objetivos mensuales.
   - Número de clientes a visitar.
   - Distribuidores prioritarios (incluyendo el rol de Stone Depot by Impacto y posibles sub-partners).
   - Ciudades a visitar cada trimestre.
   - Previsión de ventas por ciudad.
   - Estimación de volumen en m² para Dekton, Silestone y Piedra Natural.

6. Ranking final de las 8 ciudades, de la más a la menos atractiva para inversión comercial de Cosentino, justificando cada posición con datos cuantitativos y cualitativos.

ENTREGA:
- Dataset limpio y normalizado (CSV/JSON), una fila por punto de venta/actor, con columnas consistentes (ciudad, canal [retail/proyectos], tipología, facturación/tamaño estimado, segmento, prioridad, contacto, web, fuente). Debe quedar preparado como fuente de datos para construir un dashboard web interactivo (filtrable por ciudad, canal, tipología y prioridad), igual que en los proyectos de otros países de Cosentino.
- Informe ejecutivo narrativo con todos los puntos anteriores (A-F por ciudad, listados, matriz, plan 12 meses, ranking final).
```

---

## Notas de adaptación respecto al prompt base (Rusia)

- Diferenciación canal retail / canal proyectos añadida explícitamente (el brief original del cliente no la pedía como estructura, pero se incorpora para mantener consistencia con el resto de países y permitir el mismo tipo de dashboard dual retail/proyectos).
- Umbral de m² para canal proyectos: a validar en campo (no viene fijado por el cliente); usar como referencia inicial el de Rusia (>2.000 m²) y ajustar si el mercado nigeriano lo justifica.
- Herramientas: sin Firecrawl — WebSearch/WebFetch nativos de Claude Code (o el equivalente del agente que se use) + playwright-cli si hace falta interacción.
- Idioma de búsqueda: solo inglés (a diferencia de Rusia, que combinó ruso e inglés).
- Contexto de distribuidor existente (Stone Depot by Impacto, Lagos/Lekki) incorporado como punto de referencia en el bloque de logística y en el plan de entrada comercial.
- Entregables finales: informe ejecutivo (PDF) + web tipo dashboard (como en los otros países), a decidir si se aborda por fases dado el volumen (8 ciudades + 100 actores listados).
