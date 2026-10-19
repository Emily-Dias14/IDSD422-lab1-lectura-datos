# inspeccion.py — Tipos, columna derivada e indicadores (Python)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   python scripts/inspeccion.py

# TODO 1: carga data/ventas.csv
# TODO 2: imprime los tipos (dtypes) de cada columna
# TODO 3: crea la columna derivada "ticket" = ventas / clientes
# TODO 4: calcula e imprime:
#         - venta promedio por sucursal
#         - ticket promedio (ventas totales / clientes totales)
#         - sucursal con mayor y menor venta
#         - región con mayor venta total
import pandas as pd

# TODO 1: cargar data/ventas.csv
ventas = pd.read_csv("data/ventas.csv")

print("Tipos de datos:")
print(ventas.dtypes)

ventas["ticket"] = ventas["ventas"] / ventas["clientes"]
print("Tabla con ticket:")
print(ventas)

# venta promedio por sucursal
print("Venta promedio por sucursal:")
print(ventas.groupby("sucursal")["ventas"].mean())

# ticket promedio (ventas totales / clientes totales)
ticket_promedio = ventas["ventas"].sum() / ventas["clientes"].sum()
print("Ticket promedio:", round(ticket_promedio, 2))

# sucursal con mayor y menor venta
print("Sucursal con mayor venta:", ventas.loc[ventas["ventas"].idxmax(), "sucursal"])
print("Sucursal con menor venta:", ventas.loc[ventas["ventas"].idxmin(), "sucursal"])

# región con mayor venta total
por_region = ventas.groupby("region")["ventas"].sum()
print("\nVenta total por región:")
print(por_region)
print("Región con mayor venta total:", por_region.idxmax())