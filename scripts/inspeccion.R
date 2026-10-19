# inspeccion.R — Tipos, columna derivada e indicadores (R)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   Rscript scripts/inspeccion.R

# TODO 1: carga data/ventas.csv
# TODO 2: imprime la estructura (str) para ver los tipos
#         (fija si region llegó como character o factor)
# TODO 3: crea la columna derivada "ticket" = ventas / clientes
# TODO 4: calcula e imprime:
#         - venta promedio por sucursal (aggregate o dplyr)
#         - ticket promedio (ventas totales / clientes totales)
#         - sucursal con mayor y menor venta
#         - región con mayor venta total
# inspeccion.R — Tipos, columna derivada e indicadores (R)
library(readr)

# TODO 1: cargar data/ventas.csv
ventas <- read_csv("data/ventas.csv", show_col_types = FALSE)

# TODO 2: imprimir la estructura (str) para ver los tipos
str(ventas)
# region llegó como character (no como factor)
print(class(ventas$region))

# TODO 3: crear la columna derivada "ticket" = ventas / clientes
ventas$ticket <- ventas$ventas / ventas$clientes
print(ventas)

# TODO 4: calcular e imprimir
# - venta promedio por sucursal
print(aggregate(ventas ~ sucursal, data = ventas, FUN = mean))

# - ticket promedio (ventas totales / clientes totales)
ticket_promedio <- sum(ventas$ventas) / sum(ventas$clientes)
cat("Ticket promedio:", round(ticket_promedio, 2), "\n")

# - sucursal con mayor y menor venta
cat("Sucursal con mayor venta:", ventas$sucursal[which.max(ventas$ventas)], "\n")
cat("Sucursal con menor venta:", ventas$sucursal[which.min(ventas$ventas)], "\n")

# - región con mayor venta total
por_region <- aggregate(ventas ~ region, data = ventas, FUN = sum)
print(por_region)
cat("Región con mayor venta total:", por_region$region[which.max(por_region$ventas)], "\n")