# Esquema de datos — Cosentino Nigeria (retail + proyectos)

Cada agente de investigación debe producir un array JSON de registros (uno por punto de venta/actor) con EXACTAMENTE estos campos:

```json
{
  "id": "slug-unico-legible, ej: lagos-kitchen-studio-x",
  "business_name": "string",
  "city": "Lagos | Abuja | Port Harcourt | Benin City | Kano | Ibadan | Enugu | Onitsha/Awka",
  "typology": "Marmolista/Transformador | Kitchen & Bath Showroom | Interior Designer | Architecture Studio | Contractor | Developer | Distribuidor Piedra Natural | Especificador Técnico | Híbrido",
  "hybrid_detail": "string o null — qué combina si typology=Híbrido",
  "channel": "Retail | Proyectos",
  "project_name": "string o null — solo si channel=Proyectos y el desarrollo tiene nombre comercial identificable",
  "project_volume_note": "string o null — evidencia/estimación de volumen (m², nº unidades, fases) si channel=Proyectos. Umbral de referencia: >2.000 m² de superficie aplicable combinando todas las categorías Cosentino (encimeras, fachadas, suelos, revestimientos)",
  "physical_exposure": "Sí | No | No determinable",
  "physical_exposure_evidence": "string — cita textual o descripción de la evidencia (fotos del local, dirección física, mención explícita de showroom/exhibition)",
  "price_range_estimate": "Bajo | Medio | Alto | No determinable",
  "service_breadth": "Solo diseño | Diseño+instalación+suministro | Diseño+construcción+promoción | No determinable",
  "estimated_revenue": "string o null — estimación de facturación si se detecta/infiera",
  "estimated_employees": "string o null",
  "purchasing_contact": "string o null — nombre/cargo del responsable de compras si se identifica",
  "email": "string o null",
  "phone": "string o null",
  "address": "string o null",
  "website": "string o null",
  "source_channel": "Web propia | LinkedIn | Instagram | Facebook | Google Business | Varios",
  "content_language": "Inglés | Otro",
  "source_urls": ["url1", "url2"],
  "competitor_brands_mentioned": "string o null — ej. Caesarstone, Quartzforms, Compac, Laminam, Neolith, granito/mármol local, etc.",
  "key_messages": ["mensaje 1", "mensaje 2", "mensaje 3 (opcional)"],
  "raw_notes": "string — resumen libre de lo extraído, en español, para uso del analista"
}
```

Reglas:
- Usa `WebSearch` para localizar candidatos (consultas en inglés — ver `prompt.md`) y `WebFetch` para extraer el contenido de cada web/perfil antes de rellenar la ficha. **No usar Firecrawl.** No inventes datos: si un campo no se puede determinar, usa `null` o "No determinable" según corresponda.
- Prioriza segmento medium-to-high end (no ferreterías genéricas ni distribuidores de gama baja).
- Clasifica `channel` según el umbral de >2.000 m² de superficie aplicable combinando todas las categorías Cosentino; si no es un actor de obra sino un punto de venta/estudio, va a Retail salvo que trabaje predominantemente a nivel de especificación de proyecto de gran volumen.
- Guarda el resultado final como un único archivo JSON válido (array de objetos) en la ruta indicada en tu tarea (`data/retail_<ciudad>.json` y `data/projects_<ciudad>.json`, separados por canal). No incluyas texto fuera del JSON en esos archivos.
- Guarda también las notas/búsquedas crudas en `data/raw/<ciudad>/notes.md` (qué buscaste, qué URLs visitaste, qué descartaste y por qué) para que otro agente pueda retomar el trabajo sin repetir búsquedas.
- Si una fuente no se puede acceder completamente (muro de login, bloqueo), usa lo disponible en el snippet de búsqueda / perfil público y dilo en `raw_notes`.
