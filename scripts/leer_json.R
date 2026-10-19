# leer_json.R — Cargar el reporte JSON de la API (R)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   Rscript scripts/leer_json.R

# TODO 1: carga data/ventas.json con jsonlite::fromJSON
# TODO 2: convierte el resultado en data.frame si hace falta
# TODO 3: imprime las dimensiones (dim) y las primeras filas (head)
library(jsonlite)
ventas <- fromJSON("data/ventas.json")
print(class(ventas))    
print(head(ventas))
# Imprimir las dimensiones
print("Dimensiones")
print(dim(ventas))
# Imprimir los tipos de columna
print("Tipo de datos")
str(ventas)