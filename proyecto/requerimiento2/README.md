# Requerimiento 2: Análisis de Similitud entre Artículos

## Objetivo

Calcular y comparar la similitud entre pares de artículos científicos utilizando diferentes métricas y algoritmos, desde métodos clásicos hasta modelos de deep learning.

## Descripción General

Este módulo implementa **5 métodos diferentes** para medir similitud entre textos (abstracts de artículos), permitiendo comparar su efectividad y precisión.

## Métodos Implementados

### 1. Distancia de Levenshtein

**Descripción**: Mide el número mínimo de operaciones (inserción, eliminación, sustitución) para transformar un texto en otro.

```python
from Levenshtein import distance

dist = distance(text1, text2)
similarity = 1 - (dist / max(len(text1), len(text2)))
```

**Características**:
- ✅ Simple y rápido
- ✅ Funciona a nivel de caracteres
- ❌ No considera semántica
- ❌ Sensible a orden de palabras

**Interpretación**:
- `1.0` = Textos idénticos
- `0.8-0.9` = Muy similares
- `0.5-0.7` = Moderadamente similares
- `< 0.5` = Poco similares

### 2. TF-IDF + Similitud de Coseno

**Descripción**: Vectoriza textos usando TF-IDF y calcula el coseno del ángulo entre vectores.

```python
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

vectorizer = TfidfVectorizer(stop_words='english')
tfidf_matrix = vectorizer.fit_transform([text1, text2])
similarity = cosine_similarity(tfidf_matrix[0:1], tfidf_matrix[1:2])[0][0]
```

**Características**:
- ✅ Considera importancia de palabras
- ✅ Ignora palabras comunes (stopwords)
- ✅ Independiente de longitud del texto
- ❌ No captura sinónimos

**Interpretación**:
- `> 0.8` = Muy similar (mismo tema)
- `0.5-0.8` = Similar (temas relacionados)
- `0.3-0.5` = Algo similar
- `< 0.3` = Diferentes

### 3. Bag of Words + Distancia Euclidiana

**Descripción**: Representa textos como vectores de frecuencia de palabras y calcula distancia euclidiana.

```python
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import euclidean_distances

vectorizer = CountVectorizer(stop_words='english')
bow_matrix = vectorizer.fit_transform([text1, text2])
distance = euclidean_distances(bow_matrix[0:1], bow_matrix[1:2])[0][0]
```

**Características**:
- ✅ Simple de entender
- ✅ Rápido de calcular
- ❌ Sensible a longitud del texto
- ❌ No normalizado

**Interpretación**:
- Valores más bajos = Mayor similitud
- Depende de la longitud del texto

### 4. SBERT (Sentence-BERT)

**Descripción**: Usa modelos de transformers pre-entrenados para generar embeddings semánticos.

```python
from sentence_transformers import SentenceTransformer, util

model = SentenceTransformer('all-MiniLM-L6-v2')
embeddings = model.encode([text1, text2], convert_to_tensor=True)
similarity = util.pytorch_cos_sim(embeddings[0], embeddings[1]).item()
```

**Características**:
- ✅ Captura significado semántico
- ✅ Detecta sinónimos y paráfrasis
- ✅ Estado del arte en NLP
- ❌ Más lento que métodos clásicos
- ❌ Requiere GPU para grandes volúmenes

**Interpretación**:
- `> 0.7` = Muy similar semánticamente
- `0.5-0.7` = Similar
- `0.3-0.5` = Algo relacionado
- `< 0.3` = Diferentes

**Modelo usado**: `all-MiniLM-L6-v2`
- Tamaño: 80 MB
- Dimensiones: 384
- Velocidad: ~1000 oraciones/segundo (CPU)

### 5. Cross-Encoder

**Descripción**: Modelo que evalúa directamente pares de textos sin generar embeddings intermedios.

```python
from sentence_transformers import CrossEncoder

model = CrossEncoder('cross-encoder/ms-marco-MiniLM-L-6-v2')
score = model.predict([(text1, text2)])[0]
```

**Características**:
- ✅ Mayor precisión que SBERT
- ✅ Entrenado específicamente para ranking
- ❌ Más lento (evalúa cada par)
- ❌ No genera embeddings reutilizables

**Interpretación**:
- Valores más altos = Mayor similitud
- Escala depende del modelo

## Estructura del Código

```python
# 1. Cargar datos
import bibtexparser
import pandas as pd

with open("consolidado.bib") as f:
    bib_database = bibtexparser.load(f)
abstracts = [entry.get('abstract', '') for entry in bib_database.entries]

# 2. Seleccionar pares de artículos
pair1 = (abstracts[0], abstracts[1])
pair2 = (abstracts[0], abstracts[100])

# 3. Calcular similitudes con cada método
levenshtein_sim = calcular_levenshtein(pair1)
tfidf_sim = calcular_tfidf_cosine(pair1)
bow_dist = calcular_bow_euclidean(pair1)
sbert_sim = calcular_sbert(pair1)
cross_sim = calcular_cross_encoder(pair1)

# 4. Comparar resultados
comparar_metodos(resultados)
```

## Uso

### Ejecución Básica

```bash
jupyter notebook Requeriemito2.ipynb
```

### Configuración

```python
# Seleccionar artículos a comparar
ARTICLE_INDEX_1 = 0
ARTICLE_INDEX_2 = 1

# Configurar modelos SBERT
SBERT_MODEL = 'all-MiniLM-L6-v2'
CROSS_ENCODER_MODEL = 'cross-encoder/ms-marco-MiniLM-L-6-v2'

# Configurar TF-IDF
TFIDF_MAX_FEATURES = 5000
TFIDF_NGRAM_RANGE = (1, 2)  # Unigramas y bigramas
```

## Resultados Esperados

### Tabla Comparativa

```
╔═══════════════════════════╦═══════════╦═══════════╗
║ Método                    ║ Par 1     ║ Par 2     ║
╠═══════════════════════════╬═══════════╬═══════════╣
║ Levenshtein               ║ 0.45      ║ 0.12      ║
║ TF-IDF + Coseno          ║ 0.78      ║ 0.23      ║
║ BoW + Euclidiana         ║ 45.2      ║ 89.7      ║
║ SBERT                     ║ 0.82      ║ 0.31      ║
║ Cross-Encoder             ║ 8.5       ║ -2.3      ║
╚═══════════════════════════╩═══════════╩═══════════╝
```

### Visualizaciones

El notebook genera:
- 📊 Gráficos de barras comparativos
- 📈 Matrices de similitud (heatmaps)
- 📉 Distribuciones de scores

## Dependencias

```python
bibtexparser==1.4.3
pandas==2.3.1
Levenshtein==0.27.1
scikit-learn==1.7.2
sentence-transformers==3.3.1
numpy==2.2.6
matplotlib==3.10.5
```

## Casos de Uso

### 1. Detección de Plagio
Usar SBERT o Cross-Encoder con umbral alto (> 0.8)

### 2. Recomendación de Artículos
Usar SBERT para encontrar artículos similares

### 3. Clustering
Usar TF-IDF + Coseno para agrupar documentos

### 4. Deduplicación
Combinar Levenshtein + SBERT

## Comparación de Métodos

| Criterio | Levenshtein | TF-IDF | BoW | SBERT | Cross-Encoder |
|----------|-------------|--------|-----|-------|---------------|
| Velocidad | ⚡⚡⚡ | ⚡⚡⚡ | ⚡⚡⚡ | ⚡⚡ | ⚡ |
| Precisión | ⭐⭐ | ⭐⭐⭐ | ⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Semántica | ❌ | ⚠️ | ❌ | ✅ | ✅ |
| Escalabilidad | ✅ | ✅ | ✅ | ⚠️ | ❌ |

## Problemas Comunes

### Error: "Model not found"
```bash
# Descargar modelos manualmente
python -c "from sentence_transformers import SentenceTransformer; SentenceTransformer('all-MiniLM-L6-v2')"
```

### Warning: "CUDA not available"
- Normal en CPU
- Para usar GPU: instalar `torch` con soporte CUDA

### Memoria insuficiente
```python
# Procesar en lotes
BATCH_SIZE = 32
for batch in chunks(texts, BATCH_SIZE):
    embeddings = model.encode(batch)
```

## Tiempo de Ejecución

| Método | 100 pares | 1000 pares | 10000 pares |
|--------|-----------|------------|-------------|
| Levenshtein | 1s | 10s | 2min |
| TF-IDF | 2s | 15s | 3min |
| SBERT | 5s | 45s | 8min |
| Cross-Encoder | 15s | 2.5min | 25min |

## Recomendaciones

✅ **Para análisis exploratorio**: TF-IDF + Coseno
✅ **Para máxima precisión**: SBERT o Cross-Encoder
✅ **Para grandes volúmenes**: TF-IDF
✅ **Para detección de plagio**: Combinar múltiples métodos

## Próximos Pasos

Los resultados de similitud pueden usarse en:
- **Requerimiento 4**: Clustering jerárquico
- Sistemas de recomendación
- Detección de duplicados
- Análisis de tendencias
