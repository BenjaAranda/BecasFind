# Contraste inicial de 49 candidatos de diez universidades

Revisión del 1 de octubre de 2026. Alcance: identificar fuentes específicas y contrastar denominaciones y naturaleza del beneficio. No certifica convocatorias completas ni modifica la base local. Los 49 candidatos siguen inactivos. La ficha por candidato se incorpora al final; sus nombres históricos se conservan literalmente para trazabilidad.

## Fuentes y límites por institución

- **UV (4):** [becas institucionales](https://admision.uv.cl/becas-y-beneficios). Las dos becas de Honor cubren el 100 % del arancel anual del primer año. Primer Lugar exige el mayor ponderado de la carrera y al menos 750 puntos; Trayectorias exige distinción ministerial. El calendario FUAS de esa página no confirma el cierre de estas becas internas. Apoyo Socioeconómico y Excelencia Deportiva requieren ficha propia.
- **UACh (4):** [alimentación](https://dae.uach.cl/proceso/beca-de-alimentacion/) y [deportistas 2026](https://diario.uach.cl/uach-abre-proceso-de-postulacion-a-beca-para-deportistas-destacados-as-2026/). Alimentación ofrece almuerzo mediante tickets; falta confirmar que corresponda al antiguo «Bono Alimenticio». La convocatoria deportiva existe; falta completar cobertura y documentos. Hogar y Laborancia requieren bases actuales: referencias antiguas no confirman 2026.
- **USM (6):** [becas de admisión](https://usm.cl/admision/becas/) y [admisión especial](https://usm.cl/admision/admision-especial/). Premio Puntaje Máximo presenta coberturas condicionadas al puntaje; no equivale a 100 % universal. Las modalidades deportivas se mantienen separadas. Falta extraer bases y cierre de cada modalidad. La última recarga de la ficha de becas falló; no se interpreta como eliminación del beneficio.
- **UFRO (5):** [becas y beneficios](https://admision.ufro.cl/becas-y-beneficios/). El catálogo distingue beneficios específicos y programa de alimentación. No permite asignar todos sus requisitos a los nombres genéricos del archivo. Falta resolver la identidad de Residencia; Alimentación; Deportiva; Apoyo Socioeconómico y Excelencia. La última recarga tuvo timeout.
- **ULagos (6):** [convocatoria interna 2026](https://www.ulagos.cl/comunicados/becas-internas-2026/) y [financiamiento estudiantil](https://www.ulagos.cl/portal-del-estudiante/financiamiento-estudiantil/). La convocatoria enumera becas específicas y termina el 12 de marzo de 2026. Alimentación Interna utiliza tarjeta; transporte excepcional tiene restricciones de carrera y cohorte. «Interna» y «Apoyo» no identifican una modalidad única. Santander requiere bases específicas y no se equipara automáticamente a mantención.
- **UMAG (6):** [catálogo](https://admision.umag.cl/?page_id=678), [pueblos originarios](https://admision.umag.cl/?page_id=4083) y [deportistas](https://admision.umag.cl/?page_id=3911). Pueblos Originarios es un beneficio de arancel con acreditación CONADI; no declara un porcentaje universal. Deportistas financia total o parcialmente el arancel y exige antecedentes deportivos. Residencia y Mantención no se equiparan a beneficios externos por similitud. Falta completar bases y calendario de Mayor Puntaje y Excelencia.
- **UPLA (5):** [instructivo 2026](https://portal.upla.cl/doc/20260109_admision_instructivodematricula-2026.pdf) y [preguntas frecuentes 2025](https://www.upla.cl/admision/2025/01/21/preguntas-frecuentes-sobre-el-proceso-de-admision-y-matricula-2025/). La documentación histórica no confirma condiciones actuales. Dos variantes de Excelencia siguen separadas; falta su equivalencia y las fichas específicas de Alimentación; Residencia y Deportiva.
- **UBB (5):** [mantención y cuota básica](https://www.ubiobio.cl/admision/BECAS_DE_MANTENCION_Y_CUOTA_BASICA/) y [asignación interna 2026](https://dde.ubiobio.cl/nomina-de-asignacion-becas-internas-ubb-2026/). El proceso institucional existe; la consulta directa del catálogo devuelve 502. No se confirma importe ni cierre individual con esa respuesta. Las dos variantes de Excelencia y de escritura institucional requieren conciliación; no se fusionan.
- **UdeC (3):** [beneficios de admisión](https://admision.udec.cl/beneficios/). La fuente distingue becas como Enrique Molina y Residencia Doctor Virginio Gómez. Los nombres genéricos Arancel; Excelencia y Residencia del archivo no bastan para heredar esas condiciones. No se convierten UTM a pesos ni se asigna el calendario de una beca diferente.
- **PUCV (5):** [beneficios institucionales](https://www.pucv.cl/pucv/noticias/destacadas/pucv-ofrece-una-amplia-gama-de-becas-y-beneficios-para-sus-estudiantes) y [apoyos de residencia y alimentación](https://www.daepucv.cl/post/postulaci%C3%B3n-a-becas-de-apoyo-institucionales-residencia-estudio-y-alimentaci%C3%B3n). Las referencias describen apoyos; falta verificar convocatoria 2026 y modalidad exacta. Excelencia podría referirse a mantención y no a descuento de arancel. No se presume importe fijo para Residencia ni identidad de Apoyo Socioeconómico.

## Pendiente de este lote

Completar documentos y cierres con bases oficiales; resolver nombres genéricos y variantes. Este informe registra contraste inicial, incluso cuando el resultado es identidad no resuelta o fuente inaccesible. No indica que las 49 becas estén listas para publicación.

### Corrección posterior de cinco registros

Se aplicaron campos concretos de las dos becas de Honor UV; Pueblos Originarios y Deportistas UMAG; Transporte Excepcional ULagos. [Campos y fuentes](procesados/correcciones_regionales_49.json), [CSV importado](procesados/correcciones_regionales_49.csv) y [resultado local](procesados/CORRECCION_REGIONALES_49_LOCAL.json). Las cinco siguen inactivas; cierre y condiciones completas siguen pendientes. La declaración de alcance inicial describe el primer contraste documental; esta corrección posterior sí modifica esos cinco registros.

La base conserva 573 becas; otras 568 idénticas. Respaldo restaurado antes de importar; búsqueda y catálogo públicos iguales antes/después. Sin mojibake detectado en nombres y descripciones mediante conversión UTF-8/hex de PostgreSQL. Porcentajes exactos de UV: 100.00; UMAG conserva cobertura variable como texto y ULagos conserva importe desconocido. No se infieren RSH; NEM ni fechas.

La primera importación se rechazó completa por dos URLs oficiales de UMAG cuyo identificador está en `?page_id=…`. Se corrigió el validador para admitir un único identificador positivo; dominios raíz e identificadores inválidos o repetidos siguen rechazados. La segunda importación creó cero y actualizó cinco sin errores.

## Registro individual

| Candidato | Nombre histórico | Contraste y pendiente |
|---|---|---|
| `8b7291409cb313971ff5ef8b6505394ba190caf70d9f4704d86333736393c735` | Beca de Excelencia Académica PUCV | Confirmar si corresponde a mantención por excelencia; no asumir rebaja de arancel. |
| `c066649684c96f6f79937d4ad4d2be7874fdd1fd3aa3cc843dc7815b9d035e1c` | Beca de Alimentación PUCV | Contrastar apoyo alimentario con convocatoria 2026; importe y cierre pendientes. |
| `32b114d0e9475a61bc05472195e5541bc5acdc62f600de3bdc246e65cf8de88a` | Beca de Apoyo Socioeconomico PUCV | Denominación genérica: identificar modalidad institucional. |
| `70699bc9ed88bac846b5399646c77d71c8027a40a10a5a2d46ec72db13e327f6` | Beca Deportiva PUCV | Obtener bases deportivas actuales; referencias antiguas no confirman 2026. |
| `d29199f891c0f665cd931e2f6e2e0e0a8bf08be8552355af44b6f37f64494793` | Beca de Residencia PUCV | Confirmar aporte para alojamiento y convocatoria; no asumir residencia gratuita. |
| `70cc47ac438139cde0dc4476cdde18108e009db8b9036d6db48c57d0f58a58e4` | Hogar Estudiantil UACh | Obtener bases actuales del hogar y requisitos de sede. |
| `5eefb13006944f6b566d2c4aba3290a3d8d28ec8a5a6ef23936c74c468a5e618` | Bono Alimenticio UACh | Verificar equivalencia con Beca de Alimentación; no trasladar calendario por alias. |
| `4946711a55eee8c339ebd283c3c50940c4bed4e571f2138b2f54c48b085cf753` | Laborancia UACh | Obtener bases actuales de laborancia; no heredar condiciones de 2020. |
| `97cf306bd5f0270ad05574df2a299517fa001e2236a4b829f73f14d23a5e5bfd` | Beca Deportiva UACh | Convocatoria deportiva 2026 localizada; completar cobertura y documentos. |
| `795ecb1745d45294aac3defc740c3992abf826901fa0ea33e1d5432d5790e2fe` | Beca de Excelencia Académica UBB | Conciliar con variante sin de y distinto nombre institucional; bases pendientes. |
| `baa2c616c9df714d61ba845947461ee7739b1b1d2d7c72b9d122bcb3608b3b90` | Beca de Alimentación UBB | Catálogo con fallo de acceso; falta modalidad y cobertura individual. |
| `c76ee0b52bafce77c6bfc9e7525367cfca0a4bc604ba169e47ec69add0474b5f` | Beca de Residencia UBB | Confirmar naturaleza del aporte; no asumir alojamiento en especie. |
| `2b84c516a23ac208988c6ee20a88511eed4a2b565bbbadec9756b1d5f2aa755a` | Beca Deportiva UBB | Completar bases deportivas; asignación general no prueba porcentaje. |
| `cfb90f338bf474a6fd91fba28d38420f6cc7ae5a338cf3383d0ff54b6e0c7598` | Beca de Arancel UdeC | Nombre genérico: no equiparar a Enrique Molina. |
| `eb3131c5f603c2fd6a2c622cd438316e0b7209aeec659094ecd19c8ae4dbac17` | Beca Excelencia Académica UdeC | Identificar beca concreta; no heredar requisitos de otra modalidad. |
| `7ca08d1ca442a3a99c402e817bcce7c62de546f0893d07bbdb3d3a6f27768bc9` | Beca de Residencia UdeC | No equiparar automáticamente a Residencia Doctor Virginio Gómez. |
| `3fa8612380b4ad51b8c44464c5131318bed480987ec58b5611d0566484a82a0e` | Beca de Residencia UFRO | Identificar programa de residencia y bases específicas. |
| `e32478188248c1e8d179052cb8d9f6ff40b424a6bd0eff7637228ce064656933` | Beca de Alimentación UFRO | Contrastar con programa de alimentación; no presumir importe monetario. |
| `8be893cd6d836b64c8865febc653653af6cb1fed5a4a7180a542d316dc5a9967` | Beca Deportiva UFRO | Obtener ficha deportiva específica y cobertura. |
| `d5f97ce59d9fba8b7820cfa630c6cc9e8c257564e04394118a9bd49d43dae997` | Beca de Apoyo Socioeconomico UFRO | Nombre genérico: identificar fondo de apoyo concreto. |
| `a183d08a238734f518bbd4cced586d1793a5a966dbfbaba4b33fb62fa984e423` | Aporte Excepcional de Transporte ULagos | Transporte excepcional restringido por carrera y cohorte; importe pendiente. |
| `c62193606762c6068d1f3429aabfc3ec8e862f6f6f38c358225ec7fea9267477` | Beca Interna ULagos | Interna agrupa varias becas; identificar modalidad antes de asignar campos. |
| `b9037d3b4fadd7a3798ff419d5d38a649213e718f74743612ccaaf3da1c5755d` | Beca Santander ULagos | Identificar convocatoria Santander y comparar finalidad; no asumir mantención. |
| `8410987d565134f941ddc876ceb40e692058bfaedab903e4d99e05ebbbadd960` | Beca de Alimentación ULagos | Contrastar con Alimentación Interna mediante tarjeta; calendario 2026 localizado. |
| `67619de59c7379d92be87cbfd2d42f95bb606486f872d80b8f8a7a8eb22a6857` | Beca Mayor Puntaje PAES UMAG | Ficha enlazada desde catálogo; completar cobertura y calendario propios. |
| `e12a1e8532b17861b3766394ad198755e7135a7652079be51dd9dd82eedb72e8` | Beca Pueblos Originarios Magallanes UMAG | Arancel y acreditación CONADI respaldados; porcentaje y cierre pendientes. |
| `0589b551c3bc86f9bfe9d90288448c9d1b343b950160006e06a3fcfdcfca665b` | Beca Deportistas Destacados UMAG | Arancel total o parcial; no fijar 100 por ciento para todos los casos. |
| `e1d0b2f915b494c0070072f2f718c974c447c643651879791b821f58bdd20b00` | Beca de Residencia UMAG | Identidad interna pendiente; no equiparar a residencia indígena externa. |
| `f43b0040acd2914489f6b344a0e588582de5c297915978a8f4832fd14e0770a1` | Beca de Excelencia Académica UPLA | Posible variante del otro candidato Excelencia; conservar ambos hasta conciliar. |
| `68f9c2b1bf2aaf92ca59b1903cf03046310091d29f81533e1475abce2c88b4b3` | Beca de Alimentación UPLA | Obtener bases actuales; no extrapolar condiciones de 2025. |
| `329107086a1ae9bdd602e66bcc8067941be5b9d5aef977702c312e2e1a7eaccd` | Beca de Residencia UPLA | Obtener ficha de residencia específica y convocatoria actual. |
| `387d29807e757a9dd151309e6d1053d3751f720135ca326c26da6fc9afef2d46` | Beca Deportiva UPLA | Completar bases deportivas 2026; no fijar porcentaje sin fuente. |
| `85508df152226f5c39238b0ab17a19c2df41dab5bab96d13354c047581b0d613` | Premio Puntaje Maximo PAES | Coberturas condicionadas por puntaje; no asignar 100 por ciento universal. |
| `a2dc0a9c95fbc43d84d981777e36027c8f7f466db01e2118f6d5a97e31d6dcc9` | Premio a la Excelencia Primer Ano | Completar condiciones y cobertura de Premio Primer Año. |
| `b483efa25dc0e7e60fa0ab18d54295bc33e11a51478b4db0106dffecc487bb74` | Beca Propedéutico Ex Umbra in Solem | Completar bases Propedéutico; no heredar condiciones de premio PAES. |
| `09d21a3ca74f166c00b3b1642f8855e144b2ecaf731de79889df42d1cb9ec149` | Beca Deportista Destacado USM | Mantener modalidad Deportista Destacado separada; bases pendientes. |
| `342a0694ec0aaa174acbe0685e25dbe5ccf3f070537cb5f0ed1fdcdaa9796705` | Beca Deportista en Formación Elite | Mantener modalidad Formación Elite separada; bases pendientes. |
| `70b5d9a68ae20d45e593e6d44d1c5b349bbefaf592798944509eb5d906bda746` | Beca Deportista Elite USM | Mantener modalidad Elite separada; bases pendientes. |
| `33ec94d4fb3a968b3de117432023d23c16f0f8309478f65c576115e780cf56a9` | Beca de Apoyo Socioeconomico UV | La ficha de Honor no confirma este apoyo genérico. |
| `158fa6c0e34a3b1f8f489fa60a20a1ea6769d03e7bf360488de39eb31cd4079a` | Beca de Honor Primer Lugar de Matrícula | 100 por ciento del arancel del primer año; cierre interno no confirmado. |
| `12efd20e2ebeb5752e26afb9feca068226f4d893ef47a4f473c118ca68f8e020` | Beca de Honor Distincion Trayectorias Educativas | 100 por ciento del arancel del primer año; distinción ministerial; cierre pendiente. |
| `8dbb7049d6aeb6617fc578fc19cd4be0d45510a6849fb2f70301818de51a9870` | Beca de Excelencia Deportiva UV | Obtener ficha deportiva propia; no heredar requisitos de Honor. |
| `5546b3441fc2b5f4a989c3a3bbb4a424824e18e518ed887a950d1fab9e9df5df` | Beca Excelencia Académica UPLA | Conciliar variante Excelencia con y sin de; no fusionar aún. |
| `6bf3c78dce1940fc9e9473a15a9b076b1ba04e71b75a270d684a718621f23225` | Beca Excelencia Académica UFRO | Nombre genérico: identificar beneficio de excelencia concreto. |
| `305155ba36aa3c6648b576c3988442b004222a2c5a3d0e3d080eb6d9a3a9da8c` | Beca Excelencia Académica UBB | Conciliar con variante Bío-Bío y con de; no fusionar aún. |
| `ec336267e6863dc06ee5e692b4fba940673ba7c826abf8eb150a800d87e0940c` | Beca de Mantención UMAG | Identidad pendiente; no asignar manutención de beneficios externos. |
| `e04fa641938cb4c684feb0a2e5519a074ab36c60e0314679147b8b2bb49f49d6` | Beca Excelencia Académica ULagos | Identificar modalidad; Trayectoria Formativa no se presume equivalente. |
| `3f37ad439dfcc5e03f7525917c6b7b82bbb00c9615ce7f31ea22ac0d80d691b2` | Beca de Apoyo ULagos | Nombre genérico: identificar apoyo concreto antes de asignar importe. |
| `eca3a961c94b847ef1e8f6c0c119a377bd1f91968ba7ab68d0a3f2808d318677` | Beca Excelencia Académica UMAG | Completar ficha y calendario propios; no extrapolar Mayor Puntaje. |
