# Informe técnico — Consolidación de reportes de ventas

**Para:** Gerencia de RetailAndina S.A. · **De:** Equipo de Business Intelligence
**Fecha:** 19/10/2026 · **Asunto:** Primer análisis de los reportes de ventas (semana 39)

---

## Resumen ejecutivo

*Escribe 3–4 líneas para gerencia: qué reportes recibiste, qué confirmaste y qué recomienda el equipo.*
Recibimos el reporte semanal de ventas en tres formatos (CSV del ERP, JSON de la API de fidelización y Excel de Finanzas). Los tres tienen 5 filas y 4 columnas y los mismos valores, por lo que la información coincide. La venta semanal total fue de 60 040, con un ticket promedio de 38,07. Guayaquil Centro vendió más y Cuenca menos; la Sierra superó a la Costa. Recomendamos usar cualquiera de los tres formatos como fuente y validar los tipos de datos al cargarlos.

## 1. ¿Los tres formatos contienen la misma información?

*Carga los tres archivos (CSV, JSON y Excel) en Python y en R, y compara dimensiones y estructura. Completa la tabla:*

 Formato | Origen | Filas | Columnas | Lectura en código |
|---|---|---|---|---|
| CSV | ERP de sucursales | 5 | 4 | `pd.read_csv()` / `read_csv()` |
| JSON | API de fidelización | 5 | 4 | `json.load()` + `pd.json_normalize()` / `fromJSON()` |
| Excel | Consolidado de finanzas | 5 | 4 | `pd.read_excel(sheet_name=)` / `read_excel(sheet=)` |
*Responde: ¿la estructura interna del archivo (texto plano, anidada, binaria) cambia el contenido?*
No. La estructura interna (texto plano, anidada o binaria) solo cambia cómo hay que leer el archivo, no su contenido. Los tres dieron 5 filas × 4 columnas (sucursal, region, ventas, clientes) con los mismos valores.
## 2. Tipos de datos y calidad

*Inspecciona los tipos que infiere cada lenguaje. Completa la tabla y comenta si los tipos son los esperados para cada variable:*

| Variable | Tipo inferido (Python) | Tipo inferido (R) | Interpretación |
|---|---|---|---|
| `ventas` | int64 | num/dbl (CSV y Excel), int (JSON) | Numérica, esperada |
| `clientes` | int64 | num/dbl (CSV y Excel), int (JSON) | Numérica, esperada |
| `sucursal` | object | chr | Texto, esperado |
| `region` | object | chr | Categórica guardada como texto |

*¿Qué habría indicado un dato sucio si, por ejemplo, `ventas` llegara como texto?*
Si `ventas` hubiera llegado como texto (`object` o `chr`), habría indicado un dato sucio: símbolos como `$`, separadores de miles, espacios o valores como "N/A". Con texto no se podría sumar ni promediar.

## 3. Particularidades técnicas encontradas

*Anota qué encontraste al leer cada formato (una nota por formato): ¿el JSON llegó como tabla? ¿hubo que indicar una hoja en el Excel? ¿cómo se expresan las categóricas en cada lenguaje?*


- **CSV:** Se leyó directo, con tipos inferidos automáticamente. En R, `read_csv()` sin el argumento del archivo dio error (`argument "file" is missing`). En Python, una ruta sin `data/` dio `FileNotFoundError`.
- **JSON:** No llegó como tabla. En Python, `json.load()` devolvió una estructura de Python (confirma con `print(type(datos))`; en mi caso: lista) y hubo que aplanarla con `json_normalize()`. En R, `fromJSON()` ya devolvió un `data.frame`.
- **Excel:** Hubo que indicar la hoja (`sheet_name="ventas"` / `sheet = "ventas"`), porque un libro puede tener varias hojas. Python necesitó `openpyxl` y R el paquete `readxl`.
- **Categóricas:** `region` y `sucursal` llegaron como `object` en Python y como `chr` (no factor) en R.


## 4. Indicadores para la reunión del lunes

*Calcula los indicadores con los datos consolidados y completa la tabla:*


| Indicador | Valor |
|---|---|
| Venta promedio por sucursal | 12 008 |
| Ticket promedio (ventas ÷ clientes) | 38,07 (60 040 ÷ 1 577 clientes) |
| Sucursal con mayor venta | Guayaquil Centro (15 200) |
| Sucursal con menor venta | Cuenca (8 540) |
| Región con mayor venta total | Sierra (30 860 frente a 29 180 de Costa) |

## 5. Conclusiones y recomendación

1. Los tres formatos contienen la misma información (5 filas × 4 columnas, mismos valores); solo cambia la forma de leerlos.
2. Los tipos inferidos fueron los esperados: `ventas` y `clientes` numéricos, `sucursal` y `region` texto.
3. En la semana analizada, la Sierra vendió más que la Costa (30 860 frente a 29 180), Guayaquil Centro fue la sucursal líder (15 200) y el ticket promedio fue 38,07. Con solo 5 sucursales y una semana, esto describe el período y no proyecta. Recomendamos validar los tipos de datos al cargar cada reporte.