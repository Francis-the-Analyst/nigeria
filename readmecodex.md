Eres uno de varios agentes de investigación trabajando en paralelo para un proyecto de inteligencia de mercado de Cosentino (superficies premium: Silestone, Dekton, Sensa, Piedra Natural) en Nigeria. Tu ciudad asignada es PORT HARCOURT. Otros agentes cubren Lagos y Abuja en paralelo (ya completados) — no te preocupes por esas ciudades.

CONTEXTO DEL PROYECTO: lee primero estos 2 archivos de la carpeta de trabajo (nigeria/):
- prompt.md — brief completo del cliente y alcance de fase 1.
- data/SCHEMA.md — esquema JSON exacto que debes producir.

Distribuidor actual de Cosentino en Nigeria: Stone Depot by Impacto, Lagos, zona Lekki. Port Harcourt no tiene cobertura directa todavía — tenlo en cuenta en logística (distancia/coste/tiempo desde Lagos) y en el plan de entrada comercial.

HERRAMIENTAS: usa tu buscador/navegador web nativo (no Firecrawl, no está disponible en este proyecto). Si una página necesita interacción (JS, paginación), omítela y anótalo en raw_notes en vez de fallar.

IDIOMA DE BÚSQUEDA: inglés.

TU TAREA para Port Harcourt:

1. CANAL RETAIL: busca marmolistas/transformadores, showrooms de cocinas y baños, distribuidores de piedra natural/cuarzo/granito, estudios de diseño de interiores en Port Harcourt. Mínimo 15-20 resultados distintos, segmento medium-to-high end.

2. CANAL PROYECTOS: busca promotores inmobiliarios de lujo, constructoras premium, estudios de arquitectura/ingeniería, especificadores técnicos con proyectos >2.000 m² de superficie aplicable (encimeras+fachadas+suelos+revestimientos) en Port Harcourt (es un hub petrolero, con alto nivel adquisitivo — búscalo también en relación a ese sector). Mínimo 10-15 resultados.

3. Para cada resultado, rellena EXACTAMENTE el esquema JSON de data/SCHEMA.md (extrae el contenido completo de cada web/perfil antes de rellenar la ficha; no inventes datos, usa null/"No determinable" si falta algo).

4. Además, redacta el bloque de análisis A-F del brief (prompt.md) específico para Port Harcourt: A. Potencial de mercado, B. Ecosistema de transformación, C. Canales de venta, D. Competencia (marcas internacionales presentes: Caesarstone, Quartzforms, Compac, Laminam, Neolith, etc.), E. Logística (desde Lagos), F. Plan de entrada comercial.

ENTREGABLES (guárdalos exactamente en estas rutas, dentro de la carpeta de trabajo nigeria/):
- data/retail_port_harcourt.json — array JSON con los registros de canal retail (esquema SCHEMA.md).
- data/projects_port_harcourt.json — array JSON con los registros de canal proyectos (esquema SCHEMA.md).
- data/raw/port_harcourt/notes.md — qué buscaste, qué URLs visitaste, qué descartaste y por qué (para que otro agente pueda retomar sin repetir trabajo).
- analisis_port_harcourt.md en la raíz del proyecto — el bloque A-F redactado para Port Harcourt.

Si te quedas sin margen de tokens/contexto antes de terminar, guarda lo que tengas hasta ese momento en esos mismos archivos (aunque estén incompletos) y añade al final de data/raw/port_harcourt/notes.md una sección "PENDIENTE" explicando qué falta. No reportes éxito si el trabajo quedó incompleto — dilo explícitamente.
