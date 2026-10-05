# UPC Grupo 04 - TB1

## Objetivo
Analizar y preparar el dataset **Hotel Bookings** mediante un proceso reproducible de limpieza y análisis exploratorio de datos, generando archivos de datos preparados y visualizaciones para el TB1.

## Integrantes
### Grupo: 04
#### Integrantes: 
- Jose Luis Sancho Navarro
- Raul Tomas Bustamante Cruzado
- Jacobo Emmanuel Díaz Beatriz 

## Descripción del dataset
El dataset contiene **119,390 registros originales y 32 variables** relacionadas con reservas de hoteles. Incluye información del tipo de hotel, cancelaciones, anticipación de la reserva, fechas de llegada, duración de la estancia, características del huésped, canal de distribución, tipo de depósito, tarifa diaria (ADR), solicitudes especiales y estado de la reserva.

## Preparación de datos
El script `code/upc-grupo04-tb1-codigo.R`:
1. Importa el CSV original.
2. Revisa valores faltantes y duplicados.
3. Reemplaza valores faltantes de `children` por 0.
4. Reemplaza valores faltantes de `country` por `Unknown`.
5. Reemplaza valores faltantes de `agent` y `company` por 0, interpretándolo como ausencia de agente/empresa registrada.
6. Elimina registros duplicados exactos.
7. Excluye registros con valores negativos en variables donde no son válidos (`lead_time`, `adr` y noches de estancia).
8. Exporta `data/hotel_bookings_preparado.csv`.
9. Genera las gráficas de `output/graficos/`.

## Resultados de la preparación
- Registros originales: 119,390
- Duplicados exactos eliminados: 31,994
- Registros con valores inválidos negativos eliminados: 1
- Registros finales: 87,395
- Tasa global de cancelación: 27.49%

## Conclusiones preliminares
El dataset permite estudiar el comportamiento de las reservas y las cancelaciones en dos tipos de hoteles. La variable de cancelación muestra una proporción importante de reservas canceladas, por lo que puede utilizarse como variable objetivo para análisis posteriores. La preparación reduce problemas de calidad de datos y deja un archivo reproducible para análisis exploratorio.

## Licencia
Para fines académicos del curso. Si el docente exige una licencia específica, reemplazar esta sección por la indicada en la rúbrica.
