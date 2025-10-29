# Documentación del Grafo de Artículos

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


## Deprendencias mas importantes

* numpy==2.2.6
* networkx==3.5matplotlib==3.10.5
* torch==2.8.0
* sentence-transformers==5.1.1
* pandas==2.3.1

### Para instalar todas las dependencias:

```
pip install -r requirements.txt
```

### Para descargar el nltk

```
pip install bibtexparser nltk
```
