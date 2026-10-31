# Revisión de las últimas 55 categorías — 29/10/2026

Se recorrieron las 55 pendientes y se aplicaron cambios en 25 fichas: 23 categorías, cuatro beneficios vacíos recuperados y correcciones de atribución. Acumulado: 494 fichas modificadas; 491 categorías corregidas, de las cuales 490 estaban desconocidas y una era incorrecta. Se recuperaron siete beneficios vacíos entre todos los lotes. Las 528 fichas siguen visibles; no se eliminó ninguna.

## Correcciones sustantivas

- Cunco (14): la ficha incluía el pago de $100.000 y condiciones de Villa Alegre. La fuente propia de Cunco no publica un importe individual. Se corrigieron enlace, beneficio, descripción, requisitos documentados y calendario: 6–30 de abril de 2026. Continúa cerrada. No se inventó NEM ni porcentaje RSH. Fuente: [folleto oficial](https://www.municunco.cl/wp-content/uploads/2026/03/FOLLETO-BECA-MUNICIPAL-2026-OK.pdf).
- San Pedro de la Paz (490): el original sí pertenece a esa comuna; la revisión previa utilizó fuentes de San Pedro de Melipilla. Se retiró el enlace cruzado y se publicó una advertencia. La identidad del beneficio específico sigue sin quedar resuelta; no se trasladaron reglas entre comunas ni se declaró falsa la beca.
- Punitaqui (182), Los Vilos (186), PAI UAH (274) y Coltauco (419): se recuperó el beneficio ya acreditado en sus expedientes. Se conservaron las modalidades y los importes desconocidos.
- Dalcahue (86): tenía confirmación completa, no esencial; se consultó ese expediente y se clasificó el aporte monetario. No se cambió el importe ni su calendario.
- UDD y ULagos: se completaron tipos conforme al alcance específico que sí consta en el expediente anterior. Esto no equivale a una nueva lectura de todas las convocatorias actuales.

## Lo que sigue sin determinar

No quedan filas de esta tanda sin revisar, pero **32 fichas conservan categoría desconocida**. No son 32 becas descartadas ni falsas. Siete agrupan finalidades distintas: 52, 229, 265, 274, 282, 336 y 432. Dos requieren una categoría distinta a las actuales: convalidación EMTP (123) y admisión directa UDD (468). Una tiene contradicción de identidad (490). En las otras 22 no consta un destino del beneficio suficiente para elegir arancel, mantención u otra categoría sin suponerlo.

Cada resolución está en `lote_10.json` y `lote_10.csv`. La información aún no determinada permanece en `pendientes_tipo.csv`: no se vació la cola artificialmente. Estas carencias requieren evidencia adicional o una decisión sobre la taxonomía; no se presentan como resueltas.

## Comprobación

Respaldo previo y restauración aislada de las 14 tablas comprobados. SQL transaccional con controles de UUID, categoría, versión e inventario. Conciliadas las 528 filas: 25 cambios limitados a los campos previstos, sin activaciones ni eliminaciones. Se comprobaron las 528 entradas públicas y los 55 detalles de esta tanda, incluidas las fechas de Cunco y la retirada del enlace incorrecto. Estados conservados: siete abiertas, 58 cerradas, 264 con fechas por confirmar y 199 en revisión. Los SQL ya fueron aplicados; no repetirlos.

Esta entrega termina el recorrido de las 55 categorías, no la investigación de vigencia ni la corrección de todos los campos del proyecto. No se iniciaron P13/P14.
