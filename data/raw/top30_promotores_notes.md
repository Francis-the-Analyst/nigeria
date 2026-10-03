# Notas de investigación — Top 30 promotores inmobiliarios de Nigeria (canal Proyectos)

Fecha: 2026-10-02
Entregable: `data/top30_promotores.json` (30/30 registros completados)

## Qué se hizo

1. Se leyó `prompt.md` (brief completo del cliente) y los datasets ya existentes de canal Proyectos de Lagos y Abuja (`data/projects_lagos.json`, `data/projects_abuja.json`) para identificar qué promotores ya estaban documentados y no duplicar investigación.
2. Se identificaron 11 promotores (typology "Developer") ya presentes en esos datasets:
   - Lagos: Palton Morgan Holdings, Strongmas Development, Chagoury Group/Eko Atlantic City, Sujimoto Construction.
   - Abuja: Cosgrove Investment, Brains and Hammers, 7-Fifteen Capital, Ariel Realty, UPDC, Urban Shelter, Mshel Homes.
   Estos se incluyen en el top 30 con `already_in_city_dataset: true` y sin repetir WebFetch — solo se referenciaron sus fichas existentes (ids citados en `raw_notes`).
3. Se completaron los 19 registros restantes mediante WebSearch (para identificar candidatos y datos agregados de rankings) y WebFetch (para contactos/proyectos en webs propias cuando fue posible).

## Fuentes principales usadas

- Nairametrics — "Top 10 property developers in Nigeria in 2026 based on completed portfolios, scale of delivery" (ranking nacional por unidades completadas: Mixta Nigeria #1, Brains and Hammers #2, Foreshore Waters #3-4, Landwey #5, UPDC #8, Landmark Africa #10).
- Fortren & Company — "Nigeria's Top 10 Real Estate Developers in 2026".
- Estate Intel — directorios y perfiles de developers (Foreshore Waters, Mixta Nigeria, Churchgate Tower II, Alaro City, Rainbow Town).
- Webs corporativas propias (WebFetch directo): paltonmorgan.com, strongmasresidence.com, sujimotonig.com, 7fifteen.ng, ariel-luxury-dev.lovable.app, landwey.ng, veritasihomes.com, dukiyang.com, pwangroup.com, lekkigardens.com, eximiarealty.com, suncitygarden.org, nemterradevelopers.com, grandtowersco.com, churchgate.com, landmarkafrica.com, phgardens.org, rendeavour.com, novare.com, adronhomes.com.
- Prensa sectorial: Guardian Nigeria, Vanguard, ThisDay, Tribune, Leadership, BusinessDay — para proyectos y perfiles de Dukiya Investments, Rainbow Town, Eximia Realty, Port Harcourt Gardens, Novare malls.
- Directorios de terceros (9jadirectory, amapha.com, businessconnect.com.ng) — para shortlisting de developers de Port Harcourt y validación cruzada de rankings nacionales.

## Incidencias / limitaciones encontradas (documentadas también en `raw_notes` de cada registro afectado)

- **mixtaafrica.com** y **dukiyainvestments.com** no resolvieron por DNS; se usaron los dominios correctos `mixtafrica.com` y `dukiyang.com` respectivamente.
- **adronhomesproperties.com** redirige a `adronhomes.com` (dominio correcto usado).
- **churchgategroup.com** devolvió por error el contenido de una empresa inmobiliaria del Reino Unido no relacionada (Berkshire/Hampshire/Surrey); se verificó y usó el dominio correcto `churchgate.com` vía búsqueda independiente.
- **landmarkafricagroup.com** no resolvió por DNS; dominio correcto es `landmarkafrica.com`.
- **Posible contaminación de contenido entre Foreshore Waters Limited y Lekki Gardens**: el WebFetch a `lekkigardens.com/about` devolvió una lista de proyectos (Insignia, Riverside Apartments, Banana Island) idéntica a la de Foreshore Waters Limited (confirmada de forma independiente vía fwl.ng y estateintel.com). Se decidió conservar en la ficha de Lekki Gardens (rank 15) solo los datos de contacto propios verificados y marcar los nombres de proyecto como no fiables, con advertencia explícita en `raw_notes`. Se recomienda revalidar ambas fichas en una sesión futura con un fetch limpio.
- **Grand Towers Limited/Plc**: su web actual (grandtowersco.com) ya no menciona el proyecto de mall de Abuja en su homepage (ahora se presenta como holding diversificado); el dato del Grand Towers Abuja Mall proviene de fuentes de 2012-2017 (skyscrapercity, prensa). Pendiente confirmar en campo si el mall sigue operado bajo esta marca.
- **Nemterra Developers** (rank 30, Port Harcourt): ficha menos verificada de la lista — no se pudo obtener email/teléfono ni proyectos insignia concretos desde su web. Se sugieren alternativas no investigadas en profundidad por límite de presupuesto: Boing Luxury Estates y Landmark Corporate Realty Ltd (ambos mencionados en amapha.com como developers relevantes de Port Harcourt).
- **Rendeavour / Jigna (Abuja)**: solo se confirmó el nombre y posicionamiento genérico ("nature-led new city"); no se pudo determinar escala, estado de obra ni contacto local específico en esta pasada.
- **Novare Real Estate Nigeria**: en 2023 su inversor institucional puso en venta varios de sus malls (Lekki Mall, Gateway Mall, Apo Mall, Novare Central); no se confirmó si Novare sigue siendo el gestor/developer activo o si ha cambiado de propietario — validar antes de prospectar comercialmente.
- Varios registros (Mixta Nigeria, Adron Homes, RevolutionPlus, Grand Towers) tienen contenido de web corporativa fuertemente dinámico/JS, por lo que WebFetch no devolvió datos de contacto o proyecto completos; se complementó con WebSearch pero persisten campos `null` o "No determinable", documentados caso por caso.

## Cobertura geográfica lograda

- Lagos: 13 promotores (Chagoury/Eko Atlantic, Sujimoto, Palton Morgan, Mixta Nigeria, Landwey, Foreshore Waters, Veritasi Homes, Landmark Africa, Rendeavour/Alaro City, PWAN, Adron Homes, Dukiya, Lekki Gardens, RevolutionPlus, Strongmas, Eximia Realty, Churchgate — varios con presencia multi-ciudad).
- Abuja: Brains and Hammers, UPDC, Grand Towers, Novare (Gateway/Apo/Central malls), Mshel Homes, 7-Fifteen Capital, Cosgrove Investment, Ariel Realty, Urban Shelter, Rendeavour/Jigna, Veritasi Homes (Malibu Hills), PWAN, Adron Homes, Churchgate (WTC Abuja).
- Port Harcourt: Mixta Nigeria (The Enclave), PWAN (vía Cedarwood Luxury Homes), Rainbow Town Development, Suncity Gardens Estate, Port Harcourt Gardens Limited, Nemterra Developers.

Las 3 ciudades prioritarias del cliente (Lagos, Abuja, Port Harcourt) quedan todas representadas en el top 30, sin excluir otros estados cuando los developers tienen alcance nacional (PWAN, Adron Homes, Dukiya, Rendeavour).

## Próximos pasos recomendados (si se retoma esta tarea)

1. Revalidar con fetch limpio las fichas de Foreshore Waters y Lekki Gardens para resolver la posible contaminación de contenido detectada.
2. Completar campos vacíos de contacto directo (email/teléfono) para: Mixta Nigeria, Chagoury Group, Eko Atlantic, Grand Towers, Rainbow Town Development, UPDC, Cosgrove Investment, Urban Shelter, Rendeavour, Nemterra Developers — vía llamada telefónica directa o LinkedIn Sales Navigator, dado que varias webs corporativas no exponen contacto de compras/procurement en texto plano.
3. Identificar explícitamente un `purchasing_contact` (responsable de compras/especificación técnica) para cada promotor — en esta pasada solo se consiguió para Novare (CEO Ayotunde Adesulu); el resto requiere contacto directo o búsqueda en LinkedIn por cargo ("procurement", "head of construction", "technical director").
4. Confirmar si Novare sigue gestionando sus malls en Nigeria tras la venta de activos anunciada en 2023.
5. Sustituir o verificar en profundidad Nemterra Developers (rank 30) frente a alternativas de Port Harcourt no exploradas (Boing Luxury Estates, Landmark Corporate Realty Ltd).
6. Cruzar este listado con el futuro "top 20 estudios de arquitectura" para evitar duplicados en los casos híbridos developer+constructor+diseño (p. ej. Dutum Group, JECCL, ya en datasets de ciudad).
