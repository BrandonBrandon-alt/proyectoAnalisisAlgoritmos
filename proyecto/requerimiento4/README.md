# Requerimiento 4: Clustering Jerárquico de Artículos

## Objetivo

Agrupar artículos científicos en clusters temáticos utilizando **clustering jerárquico aglomerativo** basado en la similitud de sus abstracts, y visualizar los resultados mediante dendrogramas.

## Descripción General

Este módulo aplica técnicas de clustering no supervisado para descubrir grupos naturales de artículos con contenido similar, permitiendo identificar subtemas y áreas de investigación dentro del dominio de Inteligencia Artificial Generativa.

## Fundamentos Teóricos

### Clustering Jerárquico Aglomerativo

**Algoritmo**:
1. Iniciar con cada artículo como un cluster individual
2. Calcular distancias entre todos los pares de clusters
3. Fusionar los dos clusters más cercanos
4. Repetir hasta tener un único cluster (o alcanzar criterio de parada)

**Ventajas**:
- ✅ No requiere especificar número de clusters a priori
- ✅ Genera estructura jerárquica completa
- ✅ Visualizable mediante dendrogramas
- ✅ Determinístico (mismo resultado en cada ejecución)

**Desventajas**:
- ❌ Complejidad O(n³) - lento para grandes datasets
- ❌ No puede deshacer fusiones incorrectas
- ❌ Sensible a outliers

## Proceso de Clustering

### 1. Preparación de Datos

```python
import bibtexparser
import nltk
from nltk.corpus import stopwords

# Cargar abstracts
with open("consolidado.bib") as f:
    bib_database = bibtexparser.load(f)

abstracts = [entry.get('abstract', '') for entry in bib_database.entries]
```

**Preprocesamiento**:
- Limpieza de texto
- Eliminación de stopwords
- Normalización (minúsculas, sin puntuación)

### 2. Vectorización TF-IDF

```python
from sklearn.feature_extraction.text import TfidfVectorizer

vectorizer = TfidfVectorizer(
    max_features=5000,        # Top 5000 términos más importantes
    stop_words='english',     # Eliminar stopwords
    ngram_range=(1, 2),       # Unigramas y bigramas
    min_df=2,                 # Mínimo 2 documentos
    max_df=0.8                # Máximo 80% de documentos
)

tfidf_matrix = vectorizer.fit_transform(abstracts)
```

**Parámetros TF-IDF**:

| Parámetro | Valor | Descripción |
|-----------|-------|-------------|
| `max_features` | 5000 | Número máximo de términos |
| `stop_words` | 'english' | Eliminar palabras comunes |
| `ngram_range` | (1, 2) | Palabras individuales y pares |
| `min_df` | 2 | Frecuencia mínima en documentos |
| `max_df` | 0.8 | Frecuencia máxima (80%) |

**Resultado**: Matriz dispersa de dimensiones `(n_artículos, 5000)`

### 3. Cálculo de Distancias

```python
from scipy.spatial.distance import pdist

# Calcular distancias entre todos los pares
distances = pdist(tfidf_matrix.toarray(), metric='cosine')
```

**Métricas de distancia disponibles**:

| Métrica | Descripción | Uso Recomendado |
|---------|-------------|-----------------|
| `cosine` | 1 - similitud coseno | **Textos (recomendado)** |
| `euclidean` | Distancia euclidiana | Datos numéricos |
| `manhattan` | Distancia Manhattan | Datos dispersos |
| `jaccard` | Similitud de Jaccard | Datos binarios |

**Selección**: `cosine` es óptima para vectores TF-IDF

### 4. Clustering Jerárquico

```python
from scipy.cluster.hierarchy import linkage, dendrogram

# Realizar clustering
Z = linkage(distances, method='ward')
```

**Métodos de enlace (linkage)**:

| Método | Descripción | Características |
|--------|-------------|-----------------|
| `ward` | Minimiza varianza intra-cluster | **Recomendado** - clusters compactos |
| `complete` | Máxima distancia entre clusters | Clusters esféricos |
| `average` | Promedio de distancias | Balanceado |
| `single` | Mínima distancia | Sensible a outliers |

**Selección**: `ward` produce los clusters más coherentes

### 5. Visualización - Dendrograma

```python
import matplotlib.pyplot as plt

plt.figure(figsize=(15, 8))
dendrogram(
    Z,
    labels=titulos,           # Etiquetas de artículos
    leaf_rotation=90,         # Rotar etiquetas
    leaf_font_size=8,         # Tamaño de fuente
    truncate_mode='lastp',    # Mostrar últimos p clusters
    p=30                      # Número de clusters a mostrar
)
plt.title('Dendrograma de Clustering Jerárquico')
plt.xlabel('Artículos')
plt.ylabel('Distancia')
plt.tight_layout()
plt.savefig('outputs/dendrograma.png', dpi=300)
plt.show()
```

## Estructura del Código

```python
# 1. Importar librerías
import bibtexparser
import nltk
from sklearn.feature_extraction.text import TfidfVectorizer
from scipy.spatial.distance import pdist
from scipy.cluster.hierarchy import linkage, dendrogram
import matplotlib.pyplot as plt
import numpy as np

# 2. Cargar y preprocesar datos
abstracts = cargar_abstracts()
abstracts_limpios = preprocesar_textos(abstracts)

# 3. Vectorizar con TF-IDF
vectorizer = TfidfVectorizer(...)
tfidf_matrix = vectorizer.fit_transform(abstracts_limpios)

# 4. Calcular distancias
distances = pdist(tfidf_matrix.toarray(), metric='cosine')

# 5. Clustering jerárquico
Z = linkage(distances, method='ward')

# 6. Visualizar dendrograma
plot_dendrogram(Z, labels=titulos)

# 7. Extraer clusters
clusters = extraer_clusters(Z, n_clusters=5)

# 8. Analizar clusters
analizar_clusters(clusters, abstracts)
```

## Uso

### Ejecución del Notebook

```bash
jupyter notebook Requerimiento4.ipynb
```

### Configuración de Parámetros

```python
# Vectorización
MAX_FEATURES = 5000
NGRAM_RANGE = (1, 2)
MIN_DF = 2
MAX_DF = 0.8

# Clustering
LINKAGE_METHOD = 'ward'
DISTANCE_METRIC = 'cosine'

# Visualización
N_CLUSTERS_DISPLAY = 30
FIGURE_SIZE = (15, 8)
DPI = 300

# Corte del dendrograma (para extraer clusters)
DISTANCE_THRESHOLD = 0.7  # Ajustar según dendrograma
```

## Interpretación del Dendrograma

### Elementos del Dendrograma

```
                    │
                    ├─────┐
                    │     │
              ┌─────┤     ├─────┐
              │     │     │     │
         ┌────┤     │     │     ├────┐
         │    │     │     │     │    │
        Art1 Art2  Art3  Art4  Art5 Art6
```

**Componentes**:
- **Hojas**: Artículos individuales (abajo)
- **Nodos**: Fusiones de clusters (arriba)
- **Altura**: Distancia a la que se fusionan
- **Ramas**: Grupos de artículos similares

### Cómo Leer el Dendrograma

1. **Altura de fusión**: Mayor altura = menor similitud
2. **Clusters naturales**: Ramas que se separan tarde
3. **Outliers**: Artículos que se fusionan muy arriba
4. **Subclusters**: Divisiones dentro de ramas principales

### Determinar Número Óptimo de Clusters

```python
from scipy.cluster.hierarchy import fcluster

# Método 1: Corte a distancia específica
clusters = fcluster(Z, t=0.7, criterion='distance')

# Método 2: Número fijo de clusters
clusters = fcluster(Z, t=5, criterion='maxclust')

# Método 3: Método del codo (elbow method)
last_merges = Z[-10:, 2]
plt.plot(range(1, 11), last_merges[::-1])
plt.xlabel('Número de clusters')
plt.ylabel('Distancia de fusión')
plt.show()
```

## Resultados Esperados

### Ejemplo de Clusters Identificados

```
📊 Resumen de Clustering:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Total de artículos:              10,226
Número de clusters:                   5
Método de enlace:                  ward
Métrica de distancia:            cosine
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Cluster 1 (2,345 artículos):
  Tema principal: Generación de imágenes con GANs
  Palabras clave: image, generation, GAN, adversarial
  
Cluster 2 (1,987 artículos):
  Tema principal: Modelos de lenguaje (LLMs)
  Palabras clave: language, model, GPT, transformer
  
Cluster 3 (2,156 artículos):
  Tema principal: Aplicaciones médicas
  Palabras clave: medical, diagnosis, healthcare, clinical
  
Cluster 4 (1,876 artículos):
  Tema principal: Computer Vision
  Palabras clave: vision, detection, recognition, CNN
  
Cluster 5 (1,862 artículos):
  Tema principal: Procesamiento de audio
  Palabras clave: audio, speech, voice, synthesis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Análisis de Clusters

Para cada cluster, se calcula:

```python
# Palabras más representativas (TF-IDF promedio)
def palabras_cluster(cluster_docs, vectorizer):
    cluster_tfidf = tfidf_matrix[cluster_docs].mean(axis=0)
    top_indices = cluster_tfidf.argsort()[0, -10:]
    return vectorizer.get_feature_names_out()[top_indices]

# Coherencia intra-cluster
def coherencia_cluster(cluster_docs, distances):
    cluster_distances = distances[cluster_docs][:, cluster_docs]
    return cluster_distances.mean()
```

## Dependencias

```python
bibtexparser==1.4.3
nltk==3.9.2
scikit-learn==1.7.2
scipy==1.16.1
numpy==2.2.6
matplotlib==3.10.5
```

## Métricas de Evaluación

### 1. Coeficiente de Silueta

```python
from sklearn.metrics import silhouette_score

score = silhouette_score(tfidf_matrix, cluster_labels, metric='cosine')
```

**Interpretación**:
- `0.7 - 1.0`: Excelente separación
- `0.5 - 0.7`: Buena separación
- `0.25 - 0.5`: Separación débil
- `< 0.25`: Clusters mal definidos

### 2. Índice de Davies-Bouldin

```python
from sklearn.metrics import davies_bouldin_score

score = davies_bouldin_score(tfidf_matrix.toarray(), cluster_labels)
```

**Interpretación**: Valores más bajos = mejor clustering

### 3. Índice de Calinski-Harabasz

```python
from sklearn.metrics import calinski_harabasz_score

score = calinski_harabasz_score(tfidf_matrix.toarray(), cluster_labels)
```

**Interpretación**: Valores más altos = mejor clustering

## Optimización

### Para Datasets Grandes (> 10,000 artículos)

```python
# Opción 1: Usar muestra representativa
sample_size = 5000
sample_indices = np.random.choice(len(abstracts), sample_size, replace=False)
abstracts_sample = [abstracts[i] for i in sample_indices]

# Opción 2: Clustering en dos etapas
# 1. K-means para pre-agrupar
# 2. Jerárquico dentro de cada grupo

# Opción 3: Mini-batch TF-IDF
from sklearn.feature_extraction.text import TfidfVectorizer
vectorizer = TfidfVectorizer(max_features=1000)  # Reducir features
```

## Problemas Comunes

### Error: "Memory Error"

```python
# Reducir dimensionalidad
from sklearn.decomposition import TruncatedSVD

svd = TruncatedSVD(n_components=100)
tfidf_reduced = svd.fit_transform(tfidf_matrix)
```

### Warning: "Dendrograma muy denso"

```python
# Usar truncamiento
dendrogram(Z, truncate_mode='lastp', p=30)
```

### Clusters poco coherentes

```python
# Ajustar parámetros TF-IDF
vectorizer = TfidfVectorizer(
    min_df=5,      # Aumentar frecuencia mínima
    max_df=0.5,    # Reducir frecuencia máxima
    max_features=3000  # Reducir features
)
```

## Tiempo de Ejecución

| Operación | 1,000 docs | 5,000 docs | 10,000 docs |
|-----------|------------|------------|-------------|
| Vectorización TF-IDF | 2s | 10s | 25s |
| Cálculo de distancias | 5s | 2min | 10min |
| Clustering jerárquico | 3s | 45s | 5min |
| Generación dendrograma | 1s | 3s | 8s |
| **Total** | **11s** | **3min** | **15min** |

## Salidas Generadas

### Archivos
- `outputs/dendrograma.png` - Visualización del dendrograma
- `outputs/clusters.json` - Asignación de clusters
- `outputs/cluster_analysis.txt` - Análisis de cada cluster
- `outputs/top_terms_per_cluster.csv` - Términos representativos

### Datos
```python
# Guardar resultados
import json

resultados = {
    'n_clusters': n_clusters,
    'cluster_labels': cluster_labels.tolist(),
    'cluster_sizes': cluster_sizes,
    'top_terms': top_terms_per_cluster
}

with open('outputs/resultados_clustering.json', 'w') as f:
    json.dump(resultados, f, indent=2)
```

## Aplicaciones

✅ **Organización de literatura**: Agrupar artículos por tema
✅ **Descubrimiento de subtemas**: Identificar áreas emergentes
✅ **Sistemas de recomendación**: Sugerir artículos similares
✅ **Análisis de tendencias**: Evolución de clusters en el tiempo

## Próximos Pasos

Los clusters pueden usarse para:
- Análisis temporal de temas
- Identificación de gaps de investigación
- Generación de taxonomías
- Sistemas de navegación temática
