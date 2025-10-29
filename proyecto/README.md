# Proyecto de Análisis de Algoritmos

## Descripción General

Este proyecto implementa un sistema completo de **web scraping, procesamiento y análisis de artículos científicos** sobre Inteligencia Artificial Generativa. El sistema recopila artículos de múltiples bases de datos académicas (IEEE, ScienceDirect, Taylor & Francis), los procesa y realiza diversos análisis bibliométricos.

## Estructura del Proyecto

```
proyecto/
├── data/                    # Scripts de web scraping
│   ├── IEEE.ipynb          # Scraping de IEEE Xplore
│   ├── science.ipynb       # Scraping de ScienceDirect
│   └── taylor.ipynb        # Scraping de Taylor & Francis
├── requerimiento1/         # Consolidación y limpieza de datos
├── requerimiento2/         # Análisis de similitud entre artículos
├── requerimiento3/         # Análisis de frecuencia de palabras
├── requerimiento4/         # Clustering jerárquico
├── requerimiento5/         # Análisis geográfico de autores
├── main.ipynb              # Orquestador principal
└── consolidado.bib         # Base de datos consolidada
```

## Requisitos Previos

### 1. Dependencias
Instalar todas las dependencias desde la raíz del proyecto:
```bash
pip install -r requirements.txt
```

### 2. Variables de Entorno
Crear un archivo `.env` en la raíz del proyecto con:
```env
EMAIL=tu_email@ejemplo.com
PASSWORD=tu_contraseña
DOWNLOAD_PATH=/ruta/absoluta/a/carpeta/descargas
```

### 3. Configuración de Selenium
- Tener Google Chrome instalado
- El driver de Chrome se gestiona automáticamente con Selenium 4+

## Módulos del Proyecto

### 📥 Data Collection (carpeta `data/`)

Scripts de web scraping para recopilar artículos científicos:

#### **IEEE.ipynb**
- **Fuente**: IEEE Xplore
- **Búsqueda**: "generative artificial intelligence"
- **Formato**: BibTeX con abstract
- **Paginación**: Automática (100 resultados por página)
- **Salida**: `descargas/ieee/ieee_generative_ai_page_*.bib`

#### **science.ipynb**
- **Fuente**: ScienceDirect
- **Búsqueda**: "generative artificial intelligence"
- **Formato**: BibTeX con abstract
- **Salida**: `descargas/science/science_generative_ai_page_*.bib`

#### **taylor.ipynb**
- **Fuente**: Taylor & Francis
- **Búsqueda**: "generative artificial intelligence"
- **Formato**: BibTeX con abstract
- **Salida**: `descargas/taylor/taylor_generative_ai_page_*.bib`

**⚠️ Importante**: 
- Los scripts requieren autenticación institucional
- El proceso puede tardar varios minutos
- Se recomienda ejecutar en horarios de baja carga

### 📊 Análisis y Procesamiento

Ver READMEs individuales en cada carpeta de requerimiento:
- [Requerimiento 1](./requerimiento1/README.md) - Consolidación y limpieza
- [Requerimiento 2](./requerimiento2/README.md) - Análisis de similitud
- [Requerimiento 3](./requerimiento3/README.md) - Frecuencia de palabras
- [Requerimiento 4](./requerimiento4/README.md) - Clustering jerárquico
- [Requerimiento 5](./requerimiento5/README.md) - Análisis geográfico

## Flujo de Trabajo

### Opción 1: Ejecución Manual
Ejecutar cada notebook en orden:
1. `data/IEEE.ipynb` → Descargar artículos de IEEE
2. `data/science.ipynb` → Descargar artículos de ScienceDirect
3. `data/taylor.ipynb` → Descargar artículos de Taylor & Francis
4. `requerimiento1/Requerimiento1.ipynb` → Consolidar y limpiar
5. `requerimiento2/Requeriemito2.ipynb` → Análisis de similitud
6. `requerimiento3/Requerimiento3.ipynb` → Análisis de frecuencias
7. `requerimiento4/Requerimiento4.ipynb` → Clustering
8. `requerimiento5/Requerimiento5.ipynb` → Análisis geográfico

### Opción 2: Ejecución Automática
Usar el orquestador principal:
```bash
jupyter notebook main.ipynb
```

## Datos Generados

### Archivos de Entrada
- Archivos `.bib` descargados de cada fuente
- Total aproximado: 10,000+ artículos

### Archivos de Salida
- `consolidado.bib` - Base de datos unificada
- `outputs/` - Gráficos, tablas y análisis
- Archivos JSON con metadatos procesados

## Características Principales

✅ **Web Scraping Automatizado**
- Manejo de paginación
- Gestión de cookies y autenticación
- Reintentos automáticos

✅ **Procesamiento Robusto**
- Detección y eliminación de duplicados
- Normalización de campos
- Validación de datos

✅ **Análisis Avanzados**
- Similitud semántica con SBERT
- Clustering jerárquico
- Análisis geográfico con APIs

✅ **Visualizaciones**
- Dendrogramas
- Mapas de calor
- Gráficos de frecuencia

## Solución de Problemas

### Error de autenticación
- Verificar credenciales en `.env`
- Confirmar acceso institucional activo

### Selenium no encuentra elementos
- Actualizar selectores XPath/CSS
- Verificar que Chrome esté actualizado
- Aumentar tiempos de espera

### Memoria insuficiente
- Procesar en lotes más pequeños
- Cerrar aplicaciones innecesarias
- Usar subconjuntos de datos para pruebas

## Notas Técnicas

- **Tiempo de ejecución**: 2-4 horas (completo)
- **Espacio en disco**: ~500 MB para datos completos
- **RAM recomendada**: 8 GB mínimo
- **Python**: 3.8+

## Autores y Licencia

Proyecto académico - Universidad del Norte
Análisis de Algoritmos - 2025
