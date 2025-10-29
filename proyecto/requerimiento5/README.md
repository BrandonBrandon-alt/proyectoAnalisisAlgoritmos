# Requerimiento 5: Análisis Geográfico de Autores

## Objetivo

Identificar la distribución geográfica de los autores de artículos científicos mediante el enriquecimiento de datos bibliográficos con información de afiliaciones institucionales y países, utilizando APIs externas (Crossref) y técnicas de fuzzy matching.

## Descripción General

Este módulo extrae información de autores desde `consolidado.bib`, enriquece los datos con afiliaciones y países consultando la API de Crossref mediante DOIs, y genera visualizaciones geográficas (mapas de calor) de la distribución de publicaciones por país.

## Proceso de Análisis

### 1. Extracción de Datos Bibliográficos

```python
import bibtexparser
import pandas as pd

def parse_bib_to_df(bib_path, max_entries=None):
    with open(bib_path, encoding='utf-8') as f:
        bib_db = bibtexparser.load(f)
    
    entries = bib_db.entries[:max_entries] if max_entries else bib_db.entries
    
    df = pd.DataFrame([{
        'title': e.get('title', ''),
        'author': e.get('author', ''),
        'doi': e.get('doi', ''),
        'year': e.get('year', ''),
        'keywords': e.get('keywords', '')
    } for e in entries])
    
    return df
```

**Campos extraídos**:
- `title`: Título del artículo
- `author`: Lista de autores
- `doi`: Digital Object Identifier (clave para enriquecimiento)
- `year`: Año de publicación
- `keywords`: Palabras clave

### 2. Procesamiento de Autores

```python
import re

def extract_first_author(author_string):
    """Extrae el primer autor de la cadena de autores"""
    if not author_string:
        return None
    
    # Separar por 'and' o comas
    parts = re.split(r'\s+and\s+|,', author_string, flags=re.IGNORECASE)
    
    if parts:
        first_author = parts[0].strip()
        return first_author
    
    return None
```

**Normalización**:
- Separación de autores por "and" o comas
- Extracción del primer autor
- Limpieza de caracteres especiales
- Normalización de formato (Apellido, Nombre)

### 3. Enriquecimiento con API de Crossref

```python
import requests
from tqdm import tqdm
import time

def get_affiliation_from_doi(doi, cache=None):
    """Consulta Crossref para obtener afiliación del primer autor"""
    
    # Verificar cache
    if cache and doi in cache:
        return cache[doi]
    
    # Consultar API
    url = f"https://api.crossref.org/works/{doi}"
    
    try:
        response = requests.get(url, timeout=10)
        
        if response.status_code == 200:
            data = response.json()
            
            # Extraer afiliación del primer autor
            authors = data.get('message', {}).get('author', [])
            
            if authors and len(authors) > 0:
                first_author = authors[0]
                affiliations = first_author.get('affiliation', [])
                
                if affiliations:
                    affiliation_name = affiliations[0].get('name', '')
                    
                    # Guardar en cache
                    if cache is not None:
                        cache[doi] = affiliation_name
                    
                    return affiliation_name
        
        time.sleep(0.1)  # Rate limiting
        
    except Exception as e:
        print(f"Error consultando DOI {doi}: {e}")
    
    return None
```

**Características de la API**:
- **Endpoint**: `https://api.crossref.org/works/{doi}`
- **Rate limit**: ~50 peticiones/segundo (se recomienda 0.1s entre peticiones)
- **Datos disponibles**: Autores, afiliaciones, referencias, métricas
- **Gratuita**: No requiere API key (pero se recomienda usar una)

**Sistema de Cache**:
```python
import json

# Cargar cache existente
def load_cache(cache_file='cache_crossref.json'):
    try:
        with open(cache_file, 'r') as f:
            return json.load(f)
    except:
        return {}

# Guardar cache
def save_cache(cache, cache_file='cache_crossref.json'):
    with open(cache_file, 'w') as f:
        json.dump(cache, f, indent=2)
```

### 4. Extracción de País desde Afiliación

```python
import pycountry
from rapidfuzz import fuzz, process

def extract_country_from_affiliation(affiliation_text):
    """Extrae el país de la cadena de afiliación usando fuzzy matching"""
    
    if not affiliation_text:
        return None
    
    # Lista de países
    countries = [country.name for country in pycountry.countries]
    
    # Buscar coincidencia con fuzzy matching
    match = process.extractOne(
        affiliation_text,
        countries,
        scorer=fuzz.partial_ratio,
        score_cutoff=80  # Umbral de similitud
    )
    
    if match:
        country_name = match[0]
        # Obtener código ISO
        country = pycountry.countries.get(name=country_name)
        return {
            'name': country_name,
            'iso2': country.alpha_2,
            'iso3': country.alpha_3
        }
    
    return None
```

**Técnicas de Matching**:

| Método | Descripción | Uso |
|--------|-------------|-----|
| `fuzz.ratio` | Similitud exacta | Nombres completos |
| `fuzz.partial_ratio` | Similitud parcial | **Afiliaciones (recomendado)** |
| `fuzz.token_sort_ratio` | Ignora orden | Variaciones de nombre |

**Ejemplo**:
```
Afiliación: "Department of Computer Science, University of California, Berkeley, USA"
País detectado: "United States" (USA, US)
```

### 5. Normalización de Países

```python
def normalize_country_code(country_info):
    """Normaliza códigos de país a ISO-3166"""
    
    # Mapeo manual de casos especiales
    special_cases = {
        'UK': 'GB',
        'USA': 'US',
        'Korea': 'KR',
        'Taiwan': 'TW'
    }
    
    # Aplicar normalización
    # ...
    
    return normalized_code
```

### 6. Visualización Geográfica

```python
import plotly.express as px

def create_choropleth_map(country_counts):
    """Genera mapa de calor por país"""
    
    # Preparar datos
    df = pd.DataFrame(list(country_counts.items()), 
                     columns=['country_iso3', 'count'])
    
    # Crear mapa
    fig = px.choropleth(
        df,
        locations='country_iso3',
        color='count',
        hover_name='country_iso3',
        color_continuous_scale='Viridis',
        title='Distribución Geográfica de Publicaciones'
    )
    
    fig.update_layout(
        geo=dict(
            showframe=False,
            showcoastlines=True,
            projection_type='natural earth'
        )
    )
    
    return fig
```

**Opciones de visualización**:
- **Choropleth**: Mapa de calor por país
- **Scatter geo**: Puntos por ubicación
- **Bubble map**: Tamaño según cantidad

## Estructura del Código

```python
# 1. Cargar datos
df = parse_bib_to_df('consolidado.bib')

# 2. Extraer primer autor
df['first_author'] = df['author'].apply(extract_first_author)

# 3. Cargar cache
cache = load_cache()

# 4. Enriquecer con Crossref
affiliations = []
for doi in tqdm(df['doi']):
    aff = get_affiliation_from_doi(doi, cache)
    affiliations.append(aff)

df['affiliation'] = affiliations

# 5. Guardar cache
save_cache(cache)

# 6. Extraer países
df['country'] = df['affiliation'].apply(extract_country_from_affiliation)

# 7. Contar por país
country_counts = df['country'].value_counts()

# 8. Visualizar
fig = create_choropleth_map(country_counts)
fig.show()

# 9. Guardar resultados
fig.write_html('outputs/mapa_paises.html')
fig.write_image('outputs/mapa_paises.png')
```

## Uso

### Ejecución del Notebook

```bash
jupyter notebook Requerimiento5.ipynb
```

### Configuración de Parámetros

```python
# Procesamiento
MAX_ENTRIES = None  # None para todos, o número específico
USE_CACHE = True
CACHE_FILE = 'cache_crossref.json'

# API Crossref
REQUEST_TIMEOUT = 10  # segundos
RATE_LIMIT_DELAY = 0.1  # segundos entre peticiones
EMAIL = "tu_email@ejemplo.com"  # Para Crossref (opcional pero recomendado)

# Fuzzy matching
SIMILARITY_THRESHOLD = 80  # 0-100

# Visualización
COLOR_SCALE = 'Viridis'  # Viridis, Blues, Reds, etc.
MAP_PROJECTION = 'natural earth'  # natural earth, mercator, etc.
```

## Resultados Esperados

### Estadísticas de Enriquecimiento

```
📊 Estadísticas de Enriquecimiento:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total de artículos:                    10,226
Artículos con DOI:                      9,845 (96.3%)
Afiliaciones obtenidas:                 8,234 (80.5%)
Países identificados:                   7,892 (77.2%)
Países únicos:                             89
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Tasa de éxito:
  - DOI → Afiliación:                   83.6%
  - Afiliación → País:                  95.8%
  - DOI → País (total):                 80.1%
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Top 20 Países

```
Ranking │ País                    │ Publicaciones │ % del Total
────────┼─────────────────────────┼───────────────┼─────────────
   1    │ United States           │     2,456     │   31.1%
   2    │ China                   │     1,892     │   24.0%
   3    │ United Kingdom          │       876     │   11.1%
   4    │ Germany                 │       654     │    8.3%
   5    │ Canada                  │       543     │    6.9%
   6    │ France                  │       432     │    5.5%
   7    │ Japan                   │       387     │    4.9%
   8    │ Australia               │       298     │    3.8%
   9    │ South Korea             │       276     │    3.5%
  10    │ Italy                   │       234     │    3.0%
  11    │ Spain                   │       198     │    2.5%
  12    │ Netherlands             │       187     │    2.4%
  13    │ Switzerland             │       165     │    2.1%
  14    │ India                   │       154     │    2.0%
  15    │ Brazil                  │       143     │    1.8%
  16    │ Sweden                  │       132     │    1.7%
  17    │ Singapore               │       121     │    1.5%
  18    │ Israel                  │       109     │    1.4%
  19    │ Belgium                 │        98     │    1.2%
  20    │ Austria                 │        87     │    1.1%
```

### Análisis por Continente

```python
# Agrupar por continente
continents = {
    'North America': ['US', 'CA', 'MX'],
    'Europe': ['GB', 'DE', 'FR', 'IT', 'ES', ...],
    'Asia': ['CN', 'JP', 'KR', 'IN', 'SG', ...],
    'Oceania': ['AU', 'NZ'],
    'South America': ['BR', 'AR', 'CL', ...],
    'Africa': ['ZA', 'EG', ...]
}
```

## Dependencias

```python
bibtexparser==1.4.3
pandas==2.3.1
requests==2.32.4
pycountry==24.6.1
rapidfuzz
plotly==6.3.0
tqdm==4.67.1
pillow==11.3.0  # Para exportar PNG
```

### Instalación de Kaleido (para exportar imágenes)

```bash
pip install kaleido
```

## Optimización y Buenas Prácticas

### 1. Sistema de Cache Robusto

```python
import pickle
from pathlib import Path

class CrossrefCache:
    def __init__(self, cache_file='cache_crossref.pkl'):
        self.cache_file = Path(cache_file)
        self.cache = self.load()
    
    def load(self):
        if self.cache_file.exists():
            with open(self.cache_file, 'rb') as f:
                return pickle.load(f)
        return {}
    
    def save(self):
        with open(self.cache_file, 'wb') as f:
            pickle.dump(self.cache, f)
    
    def get(self, doi):
        return self.cache.get(doi)
    
    def set(self, doi, data):
        self.cache[doi] = data
        if len(self.cache) % 100 == 0:  # Guardar cada 100 entradas
            self.save()
```

### 2. Procesamiento por Lotes

```python
def process_in_batches(dois, batch_size=100):
    """Procesa DOIs en lotes para mejor manejo de errores"""
    
    results = []
    
    for i in range(0, len(dois), batch_size):
        batch = dois[i:i+batch_size]
        
        print(f"Procesando lote {i//batch_size + 1}/{len(dois)//batch_size + 1}")
        
        batch_results = []
        for doi in tqdm(batch):
            result = get_affiliation_from_doi(doi)
            batch_results.append(result)
        
        results.extend(batch_results)
        
        # Guardar progreso
        save_checkpoint(results, f'checkpoint_{i}.pkl')
    
    return results
```

### 3. Manejo de Errores

```python
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def safe_api_call(doi, max_retries=3):
    """Llamada a API con reintentos"""
    
    for attempt in range(max_retries):
        try:
            result = get_affiliation_from_doi(doi)
            return result
        
        except requests.exceptions.Timeout:
            logger.warning(f"Timeout para DOI {doi}, reintento {attempt+1}")
            time.sleep(2 ** attempt)  # Backoff exponencial
        
        except Exception as e:
            logger.error(f"Error para DOI {doi}: {e}")
            break
    
    return None
```

## Problemas Comunes

### Error: "Rate limit exceeded"

```python
# Aumentar delay entre peticiones
RATE_LIMIT_DELAY = 0.5  # segundos

# Usar email en headers (aumenta límite)
headers = {
    'User-Agent': 'MiProyecto/1.0 (mailto:tu_email@ejemplo.com)'
}
```

### Error: "Country not found"

```python
# Mapeo manual de casos especiales
COUNTRY_ALIASES = {
    'USA': 'United States',
    'UK': 'United Kingdom',
    'Korea': 'South Korea',
    'Holland': 'Netherlands'
}
```

### Warning: "Low match score"

```python
# Reducir umbral de similitud
SIMILARITY_THRESHOLD = 70  # Más permisivo

# O usar matching manual para casos comunes
```

## Tiempo de Ejecución

| Operación | 1,000 artículos | 10,000 artículos |
|-----------|-----------------|------------------|
| Extracción de autores | 5s | 30s |
| Consultas Crossref (sin cache) | 10min | 100min |
| Consultas Crossref (con cache 80%) | 2min | 20min |
| Extracción de países | 30s | 5min |
| Generación de mapa | 5s | 10s |
| **Total (sin cache)** | **11min** | **106min** |
| **Total (con cache)** | **3min** | **26min** |

## Salidas Generadas

### Archivos
- `outputs/mapa_paises.html` - Mapa interactivo
- `outputs/mapa_paises.png` - Imagen estática (requiere kaleido)
- `outputs/mapa_paises.pdf` - PDF de alta calidad
- `outputs/country_statistics.csv` - Estadísticas por país
- `outputs/enriched_data.csv` - Datos completos enriquecidos
- `cache_crossref.json` - Cache de consultas API

### Datos
```python
# Guardar datos enriquecidos
df.to_csv('outputs/enriched_data.csv', index=False)

# Guardar estadísticas
country_stats = df.groupby('country').agg({
    'title': 'count',
    'year': ['min', 'max', 'mean']
}).reset_index()

country_stats.to_csv('outputs/country_statistics.csv', index=False)
```

## Análisis Avanzados

### 1. Evolución Temporal por País

```python
# Publicaciones por país y año
temporal_analysis = df.groupby(['country', 'year']).size().reset_index(name='count')

# Visualizar
import plotly.express as px
fig = px.line(temporal_analysis, x='year', y='count', color='country')
fig.show()
```

### 2. Colaboraciones Internacionales

```python
# Detectar co-autorías entre países
def detect_collaborations(df):
    # Extraer todos los autores y sus países
    # Identificar artículos con autores de múltiples países
    pass
```

### 3. Análisis de Instituciones

```python
# Top instituciones por país
top_institutions = df.groupby(['country', 'affiliation']).size().sort_values(ascending=False)
```

## Aplicaciones

✅ **Análisis bibliométrico**: Distribución geográfica de investigación
✅ **Identificación de hubs**: Países líderes en IA Generativa
✅ **Colaboraciones**: Redes internacionales de investigación
✅ **Tendencias**: Evolución geográfica de publicaciones

## Notas Importantes

⚠️ **API de Crossref**:
- Respetar rate limits
- Usar cache para evitar peticiones repetidas
- Incluir email en headers para mayor límite

⚠️ **Calidad de datos**:
- No todos los artículos tienen DOI
- No todos los DOIs tienen afiliaciones
- Fuzzy matching puede tener falsos positivos

✅ **Recomendaciones**:
- Ejecutar en horarios de baja carga
- Guardar checkpoints frecuentemente
- Validar manualmente una muestra de resultados
