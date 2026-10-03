# Notas de consolidación — Nigeria Fase 1

Generado: 2026-10-02 12:53

## Fuentes y conteos

| Fuente | Registros leídos |
|---|---:|
| `data/retail_lagos.json` | 20 |
| `data/retail_abuja.json` | 18 |
| `data/retail_port_harcourt.json` | 20 |
| `data/projects_lagos.json` | 12 |
| `data/projects_abuja.json` | 13 |
| `data/projects_port_harcourt.json` | 19 |

## Resultado

- Registros leídos: 102
- Registros únicos publicados: 102
- Duplicados excluidos por `id`: 0
- Retail: 58
- Proyectos: 44

### Desglose por ciudad

| Ciudad | Registros |
|---|---:|
| Abuja | 31 |
| Lagos | 32 |
| Port Harcourt | 39 |

### Desglose por canal

| Canal | Registros |
|---|---:|
| Proyectos | 44 |
| Retail | 58 |

## Decisiones de limpieza

- Se conserva un único registro por `id`; cualquier colisión se registra y se excluye del consolidado.
- Los campos `profile`, `priority`, `entry_angle`, `confidence`, `city_score`, `city_rank` y `map` son derivados para facilitar priorización y filtros.
- La puntuación de ciudad es direccional para la Fase 1 y no representa tamaño de mercado ni cuota.
- Los registros con `raw_notes` que indican snippet, pendiente o verificación incompleta quedan marcados con confianza baja.
- Los listados nacionales Top 50/30/20 permanecen fuera de este funnel de 102 actores para no mezclar universos analíticos.
