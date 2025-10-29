# Requerimiento 1: Consolidación y Limpieza de Datos BibTeX

## Objetivo

Consolidar múltiples archivos BibTeX descargados de diferentes fuentes (IEEE, ScienceDirect, Taylor & Francis) en un único archivo limpio, eliminando duplicados y normalizando los campos.

## Descripción del Proceso

### 1. Lectura de Archivos BibTeX

El sistema lee todos los archivos `.bib` de las carpetas:
- `descargas/ieee/`
- `descargas/science/`
- `descargas/taylor/`

**Librería utilizada**: `pybtex`
- Más robusta que `bibtexparser` para archivos grandes
- Mejor manejo de caracteres especiales
- Soporte para múltiples formatos de entrada

### 2. Detección de Duplicados

Se implementan **tres métodos** de detección:

#### Método 1: Por DOI
```python
# Comparación exacta de DOI
if doi1 == doi2:
    # Es duplicado
```
- **Ventaja**: 100% preciso
- **Limitación**: No todos los artículos tienen DOI

#### Método 2: Por Título (Hash MD5)
```python
# Normalización y hash del título
titulo_normalizado = titulo.lower().strip()
hash_titulo = hashlib.md5(titulo_normalizado.encode()).hexdigest()
```
- **Ventaja**: Rápido y eficiente
- **Limitación**: Sensible a pequeñas variaciones

#### Método 3: Por Similitud de Título
```python
# Usando natsort para ordenamiento natural
# Comparación de títulos similares
```
- **Ventaja**: Detecta variaciones menores
- **Limitación**: Más lento

### 3. Normalización de Campos

Se estandarizan los siguientes campos:

| Campo Original | Campo Normalizado | Acción |
|---------------|-------------------|--------|
| `author` | `author` | Formato: "Apellido, Nombre" |
| `title` | `title` | Eliminar caracteres especiales |
| `year` | `year` | Validar rango 1900-2025 |
| `doi` | `doi` | Formato estándar |
| `abstract` | `abstract` | Limpiar espacios |
| `keywords` | `keywords` | Separar por punto y coma |

### 4. Generación de Salida

**Archivo generado**: `consolidado.bib`

Características:
- Formato BibTeX estándar
- Ordenado alfabéticamente por título
- Sin duplicados
- Campos normalizados

## Estructura del Código

```python
# 1. Importar librerías
import pybtex
from natsort import natsorted
import hashlib

# 2. Leer archivos BibTeX
def process_bibtex_file(file_path):
    # Leer y parsear archivo
    
# 3. Detectar duplicados
def detect_duplicates(entries):
    # Aplicar métodos de detección
    
# 4. Normalizar campos
def normalize_entry(entry):
    # Estandarizar formato
    
# 5. Escribir archivo consolidado
def write_consolidated_bib(entries, output_path):
    # Generar archivo final
```

## Uso

### Ejecución del Notebook

```bash
jupyter notebook Requerimiento1.ipynb
```

### Parámetros Configurables

```python
# Rutas de entrada
INPUT_FOLDERS = [
    "../descargas/ieee/",
    "../descargas/science/",
    "../descargas/taylor/"
]

# Ruta de salida
OUTPUT_FILE = "../consolidado.bib"

# Umbral de similitud para títulos
SIMILARITY_THRESHOLD = 0.9
```

## Resultados Esperados

### Estadísticas Típicas

```
📊 Estadísticas de Consolidación:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Archivos procesados:        45
Entradas totales leídas:    12,500
Duplicados detectados:      2,274
Entradas únicas:            10,226
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Duplicados por método:
  - Por DOI:                1,850
  - Por hash de título:     324
  - Por similitud:          100
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Validaciones

El sistema verifica:
- ✅ Todos los artículos tienen título
- ✅ Todos los artículos tienen autor
- ✅ Los años están en rango válido
- ✅ No hay duplicados en el archivo final
- ✅ Formato BibTeX válido

## Dependencias

```python
pybtex==0.24.0
natsort==8.4.0
```

## Problemas Comunes y Soluciones

### Error: "Unable to parse BibTeX file"

**Causa**: Archivo BibTeX corrupto o con formato inválido

**Solución**:
```python
# Usar modo de recuperación
parser = bibtex_input.Parser()
parser.parse_file(file_path, bib_format='bibtex')
```

### Warning: "Duplicate entry detected"

**Causa**: Normal, es parte del proceso de limpieza

**Acción**: Ninguna, el sistema maneja automáticamente

### Error: "Memory error"

**Causa**: Demasiados archivos para procesar simultáneamente

**Solución**:
```python
# Procesar en lotes
BATCH_SIZE = 10
for batch in chunks(files, BATCH_SIZE):
    process_batch(batch)
```

## Salidas Generadas

### Archivo Principal
- `consolidado.bib` - Base de datos consolidada

### Archivos de Log (opcionales)
- `duplicates_log.txt` - Lista de duplicados detectados
- `normalization_log.txt` - Cambios aplicados
- `errors_log.txt` - Errores encontrados

## Métricas de Calidad

El sistema reporta:
- **Tasa de duplicación**: % de entradas duplicadas
- **Cobertura de campos**: % de artículos con cada campo
- **Integridad de datos**: % de campos completos

## Tiempo de Ejecución

| Cantidad de Archivos | Tiempo Estimado |
|---------------------|-----------------|
| 10 archivos         | ~30 segundos    |
| 50 archivos         | ~2 minutos      |
| 100 archivos        | ~5 minutos      |

## Notas Importantes

⚠️ **Antes de ejecutar**:
- Verificar que existan las carpetas de entrada
- Asegurar espacio en disco (mínimo 100 MB)
- Cerrar el archivo de salida si está abierto

✅ **Después de ejecutar**:
- Verificar el archivo `consolidado.bib`
- Revisar las estadísticas de consolidación
- Validar que no haya errores en el log

## Próximos Pasos

Una vez generado `consolidado.bib`, se puede proceder con:
- **Requerimiento 2**: Análisis de similitud
- **Requerimiento 3**: Análisis de frecuencias
- **Requerimiento 4**: Clustering
- **Requerimiento 5**: Análisis geográfico
