# Revisión editorial: cinco registros MINEDUC

Fuentes oficiales consultadas el 30 de septiembre de 2026. Se contrastaron Gratuidad, Bicentenario, Nuevo Milenio I/II y Juan Gómez Millas del inventario en cuarentena. Este informe conserva evidencia parcial; no modifica originales, no importa datos ni libera registros para publicación.

## Calendario común y año de beneficio

El [portal oficial FUAS](https://postulacion.beneficiosestudiantiles.cl/fuas/index.php) incluye estos beneficios en el formulario común y publica el primer periodo del **1 al 22 de octubre de 2026**, con asignación el 10 de marzo de 2027. Es una convocatoria para el ingreso 2027: al consultar el 30 de septiembre todavía no está abierta. Separar el año académico del año de postulación. Estas fechas no corresponden a renovaciones automáticas ni validan el cierre histórico 2026-12-31.

## Campos contrastados

| Registro | Cobertura confirmada | Requisito académico y alcance |
|---|---|---|
| Gratuidad | Matrícula y arancel durante la duración nominal; sin importe fijo confirmado. | No asignar NEM ni PAES mínimos genéricos. Exige institución adscrita y pregrado presencial, con condiciones y excepciones propias. |
| Beca Bicentenario | Arancel de referencia anual; no convertirlo en una cifra fija. | Nuevos: promedio PAES obligatorio mínimo 510, escala 100–1000, con excepción PACE. Antiguos: reglas de prueba de ingreso y avance académico diferenciadas. |
| Beca Nuevo Milenio I | Hasta 600000 CLP del arancel anual. | NEM mínimo 5,0. Elegibilidad de institución/carrera y condiciones adicionales; estudiantes antiguos deben cumplir avance académico. |
| Beca Nuevo Milenio II | Hasta 860000 CLP del arancel anual. | NEM mínimo 5,0; ingreso a primer año e institución con al menos tres años de acreditación según la ficha. No fusionar esta modalidad con la I. |
| Beca Juan Gómez Millas | Hasta 1150000 CLP del arancel anual. | Nuevos: promedio PAES obligatorio mínimo 510, escala 100–1000, con excepción PACE. Antiguos: prueba de ingreso y avance académico diferenciados. Corregir la tilde de «Gómez» al preparar una fila nueva, conservando trazabilidad del nombre histórico. |

Fuentes individuales: [Gratuidad](https://portal.beneficiosestudiantiles.cl/gratuidad), [Bicentenario](https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-bicentenario-bb), [Nuevo Milenio I/II](https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-nuevo-milenio-bnm), [Juan Gómez Millas](https://portal.beneficiosestudiantiles.cl/becas-y-creditos/beca-juan-gomez-millas-bjgm).

## Límites que impiden importar como catálogo certificado

- El criterio socioeconómico publicado es población de menores ingresos: 60 % en Gratuidad, 70 % en Bicentenario/Juan Gómez Millas/Nuevo Milenio I y 50 % en Nuevo Milenio II. No equivale automáticamente a un tramo del Registro Social de Hogares. Mantener `rsh_maximo` desconocido sin equivalencia oficial.
- Bicentenario y Juan Gómez Millas combinan acreditación institucional al 31 de diciembre de 2026 con acreditación de algunas carreras al 31 de enero de 2026. Registrar la inconsistencia; no corregir el año por deducción. Confirmar las bases/listas institucionales correspondientes al ingreso 2027.
- Un promedio PAES no es NEM ni un puntaje de una sola prueba. No convertir escalas antiguas PSU/PDT a PAES ni reducir condiciones de estudiantes antiguos a un mínimo único.
- La acreditación socioeconómica institucional es condicional. No inventar una lista universal de documentos obligatorios ni transformar el certificado RSH para arancel reajustado en requisito general de Gratuidad.
- La cobertura verificada de Nuevo Milenio ya tiene dos filas propuestas en `cobertura_verificada.csv`; no añadir otras dos copias ni actualizar originales mediante nombres parecidos. Su revisión parcial anterior se amplía aquí, no se cuenta como nuevos registros adicionales.

## Próximo paso del lote

Confirmar bases y listas 2027, resolver las fechas contradictorias y documentar condiciones/documentos aplicables por modalidad. Después preparar filas corregidas con referencias individuales, validar duplicados y CSV, y revisar su publicación. Las cinco filas siguen en cuarentena; la fecha FUAS verificada no certifica todos los demás campos ni autoriza modificar la base local.
