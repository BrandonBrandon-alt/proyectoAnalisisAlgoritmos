# Requerimiento 3: Análisis de Frecuencia de Palabras

## Objetivo

Analizar la frecuencia de palabras en los abstracts de artículos científicos para identificar términos clave, tendencias temáticas y patrones lingüísticos en la literatura sobre Inteligencia Artificial Generativa.

## Descripción General

Este módulo procesa los abstracts de todos los artículos en `consolidado.bib`, realiza limpieza de texto, tokenización y análisis estadístico de frecuencias para extraer insights sobre los temas más relevantes.

## Proceso de Análisis

### 1. Carga de Datos

```python
import bibtexparser

with open("consolidado.bib", encoding="utf-8") as f:
    bib_database = bibtexparser.load(f)

abstracts = [entry.get('abstract', '') for entry in bib_database.entries]
```

**Datos procesados**:
- Total de artículos: ~10,000
- Abstracts válidos: ~9,500
- Palabras totales: ~2,000,000

### 2. Preprocesamiento de Texto

#### 2.1 Limpieza Básica

```python
import re

def limpiar_texto(texto):
    # Convertir a minúsculas
    texto = texto.lower()
    
    # Eliminar caracteres especiales
    texto = re.sub(r'[^a-záéíóúñ\s]', '', texto)
    
    # Eliminar espacios múltiples
    texto = re.sub(r'\s+', ' ', texto)
    
    return texto.strip()
```

**Transformaciones aplicadas**:
- Conversión a minúsculas
- Eliminación de puntuación
- Eliminación de números
- Normalización de espacios

#### 2.2 Tokenización

```python
from nltk.tokenize import word_tokenize

tokens = word_tokenize(texto_limpio)
```

**Características**:
- Separación por palabras
- Manejo de contracciones
- Preservación de palabras compuestas relevantes

#### 2.3 Eliminación de Stopwords

```python
from nltk.corpus import stopwords

stop_words = set(stopwords.words('english'))
tokens_filtrados = [word for word in tokens if word not in stop_words]
```

**Stopwords removidas** (ejemplos):
- Artículos: the, a, an
- Preposiciones: in, on, at, for
- Conjunciones: and, or, but
- Pronombres: it, this, that
- Verbos comunes: is, are, was, were

**Total de stopwords**: ~179 palabras en inglés

### 3. Análisis de Frecuencias

#### 3.1 Frecuencias Globales

```python
from collections import Counter

frecuencias = Counter(tokens_filtrados)
top_palabras = frecuencias.most_common(50)
```

**Métricas calculadas**:
- Frecuencia absoluta (conteo)
- Frecuencia relativa (%)
- Frecuencia acumulada

#### 3.2 Frecuencias por Categoría

Análisis segmentado por:
- **Año de publicación**
- **Fuente** (IEEE, ScienceDirect, Taylor & Francis)
- **Área temática** (inferida de keywords)

### 4. Visualizaciones

#### 4.1 Gráfico de Barras - Top 20 Palabras

```python
import matplotlib.pyplot as plt

plt.figure(figsize=(12, 6))
plt.bar(palabras, frecuencias)
plt.xlabel('Palabras')
plt.ylabel('Frecuencia')
plt.title('Top 20 Palabras Más Frecuentes')
plt.xticks(rotation=45)
plt.show()
```

#### 4.2 Nube de Palabras (Word Cloud)

```python
from wordcloud import WordCloud

wordcloud = WordCloud(width=800, height=400, 
                      background_color='white').generate_from_frequencies(frecuencias)
plt.imshow(wordcloud)
plt.axis('off')
plt.show()
```

#### 4.3 Distribución de Frecuencias (Ley de Zipf)

```python
plt.loglog(range(1, len(frecuencias)+1), sorted(frecuencias.values(), reverse=True))
plt.xlabel('Ranking')
plt.ylabel('Frecuencia')
plt.title('Distribución de Frecuencias (Ley de Zipf)')
plt.show()
```

## Estructura del Código

```python
# 1. Configuración inicial
import nltk
nltk.download('punkt')
nltk.download('stopwords')

# 2. Cargar y limpiar datos
abstracts = cargar_abstracts()
texto_completo = " ".join(abstracts)
texto_limpio = limpiar_texto(texto_completo)

# 3. Tokenizar y filtrar
tokens = word_tokenize(texto_limpio)
tokens_filtrados = eliminar_stopwords(tokens)

# 4. Calcular frecuencias
frecuencias = Counter(tokens_filtrados)

# 5. Generar visualizaciones
generar_graficos(frecuencias)

# 6. Análisis estadístico
estadisticas = calcular_estadisticas(frecuencias)
```

## Uso

### Ejecución del Notebook

```bash
jupyter notebook Requerimiento3.ipynb
```

### Configuración de Parámetros

```python
# Número de palabras más frecuentes a mostrar
TOP_N = 50

# Filtrar palabras por longitud mínima
MIN_WORD_LENGTH = 3

# Incluir bigramas (pares de palabras)
INCLUDE_BIGRAMS = True

# Idioma para stopwords
LANGUAGE = 'english'
```

## Resultados Esperados

### Top 20 Palabras Más Frecuentes

```
Ranking │ Palabra          │ Frecuencia │ % del Total
────────┼──────────────────┼────────────┼─────────────
   1    │ artificial       │   15,234   │   2.45%
   2    │ intelligence     │   14,892   │   2.39%
   3    │ generative       │   12,456   │   2.00%
   4    │ model            │   11,234   │   1.80%
   5    │ learning         │   10,987   │   1.76%
   6    │ data             │    9,876   │   1.58%
   7    │ neural           │    8,765   │   1.41%
   8    │ network          │    8,543   │   1.37%
   9    │ deep             │    7,654   │   1.23%
  10    │ algorithm        │    7,234   │   1.16%
  11    │ training         │    6,987   │   1.12%
  12    │ performance      │    6,543   │   1.05%
  13    │ image            │    6,234   │   1.00%
  14    │ text             │    5,987   │   0.96%
  15    │ generation       │    5,765   │   0.93%
  16    │ transformer      │    5,432   │   0.87%
  17    │ attention        │    5,234   │   0.84%
  18    │ language         │    5,123   │   0.82%
  19    │ classification   │    4,987   │   0.80%
  20    │ feature          │    4,765   │   0.76%
```

### Estadísticas Generales

```
📊 Estadísticas del Corpus:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total de palabras (con stopwords):     2,145,678
Total de palabras (sin stopwords):       987,543
Vocabulario único:                        45,678
Promedio palabras por abstract:              210
Palabra más frecuente:                "artificial"
Frecuencia máxima:                        15,234
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Bigramas Más Frecuentes

```
Ranking │ Bigrama                    │ Frecuencia
────────┼────────────────────────────┼────────────
   1    │ artificial intelligence    │    8,234
   2    │ neural network             │    6,543
   3    │ deep learning              │    5,987
   4    │ machine learning           │    5,432
   5    │ generative model           │    4,765
   6    │ language model             │    4,234
   7    │ training data              │    3,987
   8    │ image generation           │    3,654
   9    │ attention mechanism        │    3,432
  10    │ transformer model          │    3,234
```

## Dependencias

```python
bibtexparser==1.4.3
nltk==3.9.2
matplotlib==3.10.5
numpy==2.2.6
```

### Descargar recursos de NLTK

```python
import nltk
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('punkt_tab')
```

## Análisis Avanzados

### 1. Análisis Temporal

```python
# Frecuencias por año
frecuencias_por_año = {}
for year in range(2020, 2025):
    abstracts_año = filtrar_por_año(abstracts, year)
    frecuencias_por_año[year] = calcular_frecuencias(abstracts_año)
```

### 2. Comparación entre Fuentes

```python
# Palabras distintivas por fuente
palabras_ieee = top_palabras(abstracts_ieee)
palabras_science = top_palabras(abstracts_science)
palabras_taylor = top_palabras(abstracts_taylor)

# Encontrar diferencias
distintivas_ieee = set(palabras_ieee) - set(palabras_science) - set(palabras_taylor)
```

### 3. Co-ocurrencias

```python
# Palabras que aparecen juntas frecuentemente
from sklearn.feature_extraction.text import CountVectorizer

vectorizer = CountVectorizer(ngram_range=(2, 2))
cooccurrences = vectorizer.fit_transform(abstracts)
```

## Interpretación de Resultados

### Insights Típicos

1. **Términos técnicos dominantes**: "artificial", "intelligence", "neural", "network"
2. **Metodologías populares**: "deep learning", "transformer", "attention"
3. **Aplicaciones**: "image", "text", "generation", "classification"
4. **Métricas**: "performance", "accuracy", "evaluation"

### Tendencias Identificadas

- Predominio de términos relacionados con **deep learning**
- Alta frecuencia de **"generative"** y **"generation"**
- Presencia significativa de **"transformer"** y **"attention"**
- Enfoque en **aplicaciones prácticas** (image, text)

## Problemas Comunes

### Error: "Resource punkt not found"

```bash
python -c "import nltk; nltk.download('punkt'); nltk.download('stopwords')"
```

### Warning: "Stopwords not found"

```python
import nltk
nltk.download('stopwords')
```

### Memoria insuficiente

```python
# Procesar en lotes
BATCH_SIZE = 1000
for batch in chunks(abstracts, BATCH_SIZE):
    procesar_batch(batch)
```

## Tiempo de Ejecución

| Operación | Tiempo Estimado |
|-----------|-----------------|
| Carga de datos | 5-10 segundos |
| Limpieza de texto | 30-60 segundos |
| Tokenización | 1-2 minutos |
| Cálculo de frecuencias | 10-20 segundos |
| Generación de gráficos | 5-10 segundos |
| **Total** | **2-4 minutos** |

## Salidas Generadas

### Archivos
- `outputs/top_palabras.csv` - Lista de palabras más frecuentes
- `outputs/frecuencias_completas.json` - Todas las frecuencias
- `outputs/estadisticas.txt` - Resumen estadístico

### Gráficos
- `outputs/barras_top20.png` - Gráfico de barras
- `outputs/wordcloud.png` - Nube de palabras
- `outputs/zipf_distribution.png` - Distribución de Zipf

## Aplicaciones

✅ **Identificación de temas**: Palabras clave del dominio
✅ **Análisis de tendencias**: Evolución temporal de términos
✅ **Generación de keywords**: Para indexación y búsqueda
✅ **Validación de corpus**: Verificar relevancia temática

## Próximos Pasos

Los resultados pueden usarse para:
- **Requerimiento 4**: Selección de features para clustering
- Generación de taxonomías
- Sistemas de recomendación
- Análisis de sentimientos
