# Seguimiento 2: Análisis de Grafos de Artículos Científicos

## Objetivo

Construir y analizar un **grafo dirigido ponderado** de artículos científicos donde los nodos representan artículos y las aristas representan relaciones de similitud basadas en autores compartidos, keywords comunes y similitud semántica de títulos usando SBERT.

## Descripción General

Este módulo implementa un sistema completo de análisis de grafos aplicado a literatura científica, incluyendo:
- Construcción de grafo basado en múltiples criterios de similitud
- Algoritmo de Dijkstra para caminos mínimos
- Algoritmo de Kosaraju para componentes fuertemente conexos
- Visualización de subgrafos

---

# Documentación Técnica

## 1. Lectura y parsing del archivo `.bib`

* Se cargaron los artículos desde un archivo BibTeX (`consolidado.bib`).
* Se extrajeron los siguientes campos por artículo:
  * `title` → para identificar el artículo y calcular similitud de títulos.
  * `author` → para comparar coincidencias de autores.
  * `keywords` → para medir similitud temática.
  * `year` → opcional, útil para análisis temporal.
* Los artículos se almacenaron como  **lista de diccionarios** .

**Limitante de prueba:**

* Inicialmente se tomó un **subconjunto de los primeros 100 artículos** para pruebas de desarrollo y optimización de algoritmos.

## 2. Nodos del grafo

* Cada artículo corresponde a un  **nodo** .
* Identificador del nodo:
  * Se usa un nombre genérico: `"Articulo_0"`, `"Articulo_1"`, etc.
  * Si existiera DOI único, podría usarse como ID.
* Información almacenada en el nodo:
  * `title` (título original)
  * `author_list` (lista de autores separados)
  * `keywords_list` (lista de palabras clave)
  * `year` (año de publicación)

## 3. Aristas del grafo

* Como el `.bib`  **no tiene citaciones explícitas** , las relaciones se infieren.
* **Reglas para definir aristas (peso)** :

1. **Coincidencia de autores** : +1 por cada autor en común.
2. **Coincidencia de palabras clave** : +1 por cada palabra clave compartida.
3. **Similitud de títulos** :
   * Se calculó usando  **SBERT (`all-MiniLM-L6-v2`)** .
   * Similitud de coseno ≥ 0.5 → +1 al peso (puede sumarse proporcionalmente si se desea).

* **Dirección de la arista:** arbitraria, siempre de `i → j` según el orden de los nodos.
* **Arista solo se crea si el peso total > 0** .
* **Limitante de prueba:**
  * Para evitar que SBERT demorara demasiado, se tomó un **subconjunto de los primeros 500 artículos** para calcular embeddings y similitudes.

## 4. Pesos de aristas

* El peso refleja la “fuerza” de la relación:
  * +1 por autor en común
  * +1 por cada palabra clave compartida
  * +1 por similitud alta de título
* Esto permite diferenciar relaciones  **fuertes vs débiles** .

## 5. Construcción del grafo

* Se creó un diccionario `grafo_dict`:

<pre class="overflow-visible!" data-start="2340" data-end="2416"><div class="contain-inline-size rounded-2xl relative bg-token-sidebar-surface-primary"><div class="sticky top-9"><div class="absolute end-0 bottom-0 flex h-9 items-center pe-2"><div class="bg-token-bg-elevated-secondary text-token-text-secondary flex items-center gap-4 rounded-sm px-2 font-sans text-xs"></div></div></div><div class="overflow-y-auto p-4" dir="ltr"><code class="whitespace-pre! language-python"><span><span>grafo_dict = {
    nodo_id: {vecino_id: peso, ...}, 
    ...
}
</span></span></code></div></div></pre>

* Conserva  **dirección y peso de aristas** .
* Permite aplicar algoritmos clásicos de grafos como:
  * Caminos mínimos
  * Detección de componentes conexas

**Tamaño real en datos completos:**

* Nodos: 10,226
* Aristas: 49,662

## 6. Análisis de la red

### a) Caminos mínimos

* Se implementó **Dijkstra manual** para calcular rutas de menor peso entre dos artículos.
* Esto permite ver cómo se conecta un artículo con otro a través de relaciones temáticas o de autoría.

### b) Componentes fuertemente conexos

* Algoritmo  **Kosaraju** :
  * Cada componente incluye nodos donde todos se pueden alcanzar entre sí siguiendo la dirección de aristas


## Dependencias principales

* bibtexparser==1.4.3
* sentence-transformers==3.3.1
* torch==2.6.0
* networkx==3.5
* matplotlib==3.10.5
* numpy==2.2.6
* transformers==4.48.3
* tqdm==4.67.1

### Para instalar todas las dependencias:

```bash
cd /home/yep/Documentos/proyectoAnalisisAlgoritmos
pip install -r requirements.txt
```

---

# Guía de Uso

## Ejecución del Notebook

```bash
jupyter notebook sr1.ipynb
```

## Configuración de Parámetros

### 1. Tamaño de Muestra

```python
# Número de artículos a procesar (para pruebas)
max_nodos = 500  # Reducir para pruebas rápidas

# Para procesar todos los artículos
max_nodos = len(nodos)  # ~10,000 artículos
```

**⚠️ Importante**: 
- Con 500 artículos: ~10 segundos para embeddings
- Con 10,000 artículos: ~10-15 minutos para embeddings

### 2. Umbrales de Similitud

```python
# Ajustar según necesidad de conectividad
umbral_sbert = 0.5           # Similitud de títulos (0.0-1.0)
min_shared_keywords = 2      # Mínimo de keywords compartidas
min_shared_authors = 1       # Mínimo de autores compartidos
```

**Recomendaciones**:
- **Grafo denso** (muchas conexiones): Bajar umbrales
- **Grafo disperso** (pocas conexiones): Subir umbrales
- **Balance**: `umbral_sbert=0.5, keywords=2, authors=1`

### 3. Modelo SBERT

```python
# Modelo por defecto (recomendado)
model = SentenceTransformer('all-MiniLM-L6-v2')

# Alternativas:
# model = SentenceTransformer('all-mpnet-base-v2')  # Más preciso, más lento
# model = SentenceTransformer('paraphrase-MiniLM-L3-v2')  # Más rápido, menos preciso
```

## Estructura del Código

### Flujo de Ejecución

```
1. Cargar artículos desde .bib
   ↓
2. Crear nodos del grafo
   ↓
3. Preprocesar campos (autores, keywords, títulos)
   ↓
4. Generar embeddings con SBERT
   ↓
5. Calcular matriz de similitud
   ↓
6. Crear aristas según reglas
   ↓
7. Construir grafo con NetworkX
   ↓
8. Filtrar componente más grande
   ↓
9. Visualizar subgrafo
   ↓
10. Ejecutar Dijkstra
   ↓
11. Ejecutar Kosaraju
```

## Análisis de Resultados

### Interpretación del Grafo

```python
print(f"Nodos: {G.number_of_nodes()}")
print(f"Aristas: {G.number_of_edges()}")
print(f"Densidad: {nx.density(G):.4f}")
```

**Métricas clave**:
- **Densidad**: Proporción de aristas existentes vs posibles
  - `< 0.1`: Grafo disperso
  - `0.1-0.3`: Densidad media
  - `> 0.3`: Grafo denso

### Componentes Conexos

```python
# Número de componentes débiles
weak_components = list(nx.weakly_connected_components(G))
print(f"Componentes débiles: {len(weak_components)}")

# Tamaño del componente más grande
largest = max(weak_components, key=len)
print(f"Componente más grande: {len(largest)} nodos")
```

**Interpretación**:
- **Muchos componentes pequeños**: Artículos muy especializados
- **Un componente grande**: Tema bien conectado
- **Varios componentes medianos**: Subtemas diferenciados

### Caminos Mínimos (Dijkstra)

```python
# Ejemplo de uso
inicio = 'Articulo_0'
destino = 'Articulo_100'

distancias, previos = dijkstra_manual(grafo_dict, inicio)
camino = reconstruir_camino(previos, inicio, destino)

print(f"Camino: {' → '.join(camino)}")
print(f"Costo total: {distancias[destino]:.2f}")
```

**Interpretación del costo**:
- **Costo bajo (< 5)**: Artículos muy relacionados
- **Costo medio (5-10)**: Relacionados indirectamente
- **Costo alto (> 10)**: Poca relación temática

### Componentes Fuertemente Conexos (Kosaraju)

```python
scc = componentes_fuertemente_conexos(grafo_dict)
print(f"Componentes fuertemente conexas: {len(scc)}")

# Componentes grandes (> 1 artículo)
grandes = [c for c in scc if len(c) > 1]
print(f"Clusters temáticos: {len(grandes)}")
```

**Interpretación**:
- **Muchas componentes individuales**: Artículos únicos
- **Pocas componentes grandes**: Temas bien definidos
- **Componente gigante**: Core del tema de investigación

## Optimización y Rendimiento

### Para Datasets Grandes (> 5,000 artículos)

#### 1. Procesar en Lotes

```python
BATCH_SIZE = 1000

for i in range(0, len(titulos), BATCH_SIZE):
    batch = titulos[i:i+BATCH_SIZE]
    batch_embeddings = model.encode(batch, batch_size=64)
    # Procesar batch
```

#### 2. Usar GPU (si disponible)

```python
import torch

# Verificar GPU
if torch.cuda.is_available():
    print(f"GPU disponible: {torch.cuda.get_device_name(0)}")
    model = SentenceTransformer('all-MiniLM-L6-v2', device='cuda')
else:
    print("Usando CPU")
    model = SentenceTransformer('all-MiniLM-L6-v2')
```

#### 3. Reducir Dimensionalidad

```python
# Usar modelo más pequeño
model = SentenceTransformer('paraphrase-MiniLM-L3-v2')  # 384 → 128 dims
```

#### 4. Filtrar Artículos

```python
# Solo artículos recientes
articulos_filtrados = [a for a in articulos if int(a.get('year', 0)) >= 2020]
```

## Problemas Comunes y Soluciones

### 1. Error: "CUDA out of memory"

**Causa**: GPU sin suficiente memoria

**Solución**:
```python
# Reducir batch size
embeddings = model.encode(titulos, batch_size=16)  # Default: 32

# O usar CPU
model = SentenceTransformer('all-MiniLM-L6-v2', device='cpu')
```

### 2. Warning: "Grafo vacío o sin aristas"

**Causa**: Umbrales muy altos

**Solución**:
```python
# Bajar umbrales
umbral_sbert = 0.3  # En lugar de 0.5
min_shared_keywords = 1  # En lugar de 2
```

### 3. Error: "No hay camino entre nodos"

**Causa**: Nodos en componentes diferentes

**Solución**:
```python
# Verificar conectividad
if nx.has_path(G, inicio, destino):
    camino = nx.shortest_path(G, inicio, destino)
else:
    print("Nodos no conectados")
```

### 4. Visualización muy densa

**Causa**: Demasiados nodos/aristas

**Solución**:
```python
# Reducir número de nodos a visualizar
subgrafo_nodos = list(G.nodes())[:10]  # Solo 10 nodos
G_sub = G.subgraph(subgrafo_nodos)
```

## Tiempo de Ejecución

| Operación | 500 artículos | 5,000 artículos | 10,000 artículos |
|-----------|---------------|-----------------|------------------|
| Carga de datos | 1s | 5s | 10s |
| Preprocesamiento | 2s | 15s | 30s |
| Embeddings SBERT (CPU) | 10s | 2min | 5min |
| Embeddings SBERT (GPU) | 3s | 20s | 45s |
| Cálculo de similitud | 5s | 3min | 15min |
| Creación de aristas | 10s | 5min | 20min |
| Construcción grafo | 1s | 5s | 10s |
| Dijkstra | <1s | 1s | 2s |
| Kosaraju | <1s | 2s | 5s |
| **Total (CPU)** | **30s** | **11min** | **41min** |
| **Total (GPU)** | **23s** | **9min** | **36min** |

## Archivos Generados

### Datos
- `primeros_500.bib` - Subconjunto de artículos (generado por `scrip.py`)
- `grafo_dict.pkl` - Grafo serializado (opcional)
- `embeddings.npy` - Embeddings guardados (opcional)

### Visualizaciones
- Gráficos de NetworkX en el notebook
- Subgrafos visualizados

### Logs
- Salida de Dijkstra con caminos
- Estadísticas de componentes conexos

## Casos de Uso

### 1. Encontrar Artículos Relacionados

```python
# Dado un artículo, encontrar los más similares
articulo_origen = 'Articulo_0'

# Calcular distancias desde el origen
distancias, _ = dijkstra_manual(grafo_dict, articulo_origen)

# Ordenar por distancia
relacionados = sorted(distancias.items(), key=lambda x: x[1])[:10]

print("Artículos más relacionados:")
for art, dist in relacionados[1:]:  # Excluir el mismo
    print(f"{art}: {dist:.2f}")
```

### 2. Identificar Clusters Temáticos

```python
# Usar componentes fuertemente conexas
scc = componentes_fuertemente_conexos(grafo_dict)

# Analizar cada cluster
for i, cluster in enumerate(scc):
    if len(cluster) > 5:  # Solo clusters grandes
        print(f"\nCluster {i}: {len(cluster)} artículos")
        
        # Extraer títulos del cluster
        titulos_cluster = [nodos[art]['title'] for art in cluster]
        print(titulos_cluster[:3])  # Primeros 3
```

### 3. Análisis de Centralidad

```python
# Artículos más "centrales" o importantes
import networkx as nx

# Centralidad de grado
degree_centrality = nx.degree_centrality(G)
top_degree = sorted(degree_centrality.items(), key=lambda x: x[1], reverse=True)[:10]

print("Artículos más conectados:")
for art, score in top_degree:
    print(f"{art}: {score:.3f}")

# Centralidad de intermediación
betweenness = nx.betweenness_centrality(G)
top_between = sorted(betweenness.items(), key=lambda x: x[1], reverse=True)[:10]

print("\nArtículos más 'puente':")
for art, score in top_between:
    print(f"{art}: {score:.3f}")
```

## Extensiones Posibles

### 1. Análisis Temporal

```python
# Evolución del grafo por año
for year in range(2020, 2025):
    articulos_año = [a for a in articulos if a.get('year') == str(year)]
    # Construir grafo para ese año
    # Analizar métricas
```

### 2. Detección de Comunidades

```python
from networkx.algorithms import community

# Louvain algorithm
communities = community.louvain_communities(G.to_undirected())

print(f"Comunidades detectadas: {len(communities)}")
for i, comm in enumerate(communities):
    print(f"Comunidad {i}: {len(comm)} artículos")
```

### 3. Análisis de Influencia

```python
# PageRank para identificar artículos influyentes
pagerank = nx.pagerank(G)
top_influential = sorted(pagerank.items(), key=lambda x: x[1], reverse=True)[:10]

print("Artículos más influyentes:")
for art, score in top_influential:
    print(f"{art}: {score:.4f}")
```

## Notas Importantes

### ⚠️ Limitaciones

1. **Memoria**: Matriz de similitud requiere O(n²) espacio
2. **Tiempo**: SBERT es el cuello de botella principal
3. **Calidad**: Depende de la calidad de los metadatos (autores, keywords)
4. **Direccionalidad**: El grafo es dirigido pero las relaciones son simétricas

### ✅ Buenas Prácticas

1. **Empezar con muestra pequeña** (500 artículos) para ajustar parámetros
2. **Guardar embeddings** para evitar recalcular
3. **Usar cache** para resultados intermedios
4. **Validar manualmente** algunos caminos y clusters
5. **Documentar umbrales** usados para reproducibilidad

### 🔧 Mantenimiento

- **Actualizar modelo SBERT** periódicamente
- **Revisar umbrales** si cambia el dataset
- **Limpiar datos** antes de procesar (duplicados, campos vacíos)

## Referencias

- **NetworkX**: https://networkx.org/
- **Sentence-BERT**: https://www.sbert.net/
- **Algoritmo de Dijkstra**: https://en.wikipedia.org/wiki/Dijkstra%27s_algorithm
- **Algoritmo de Kosaraju**: https://en.wikipedia.org/wiki/Kosaraju%27s_algorithm

## Aplicaciones

✅ **Sistemas de recomendación**: Sugerir artículos relacionados
✅ **Análisis bibliométrico**: Identificar temas y tendencias
✅ **Detección de plagio**: Encontrar artículos muy similares
✅ **Mapeo de conocimiento**: Visualizar estructura de un campo
✅ **Identificación de gaps**: Áreas poco conectadas
prueba.