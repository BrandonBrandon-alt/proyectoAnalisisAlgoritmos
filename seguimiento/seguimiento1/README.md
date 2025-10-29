# Seguimiento 1: Algoritmos de Ordenamiento

## Objetivo

Implementar, analizar y comparar el rendimiento de **múltiples algoritmos de ordenamiento** aplicados a datos bibliográficos reales, midiendo tiempos de ejecución y evaluando su eficiencia en diferentes escenarios.

## Descripción General

Este módulo implementa y compara **10+ algoritmos de ordenamiento** diferentes, desde los más básicos (Bubble Sort, Selection Sort) hasta los más avanzados (Merge Sort, Quick Sort, Heap Sort), aplicándolos a campos de artículos científicos como títulos, autores, años y keywords.

## Algoritmos Implementados

### 1. Algoritmos Básicos (O(n²))

#### Bubble Sort
```python
def bubble_sort(arr):
    n = len(arr)
    for i in range(n):
        for j in range(0, n-i-1):
            if arr[j] > arr[j+1]:
                arr[j], arr[j+1] = arr[j+1], arr[j]
    return arr
```
- **Complejidad**: O(n²)
- **Estable**: Sí
- **In-place**: Sí
- **Uso**: Didáctico, listas muy pequeñas

#### Selection Sort
```python
def selection_sort(arr):
    n = len(arr)
    for i in range(n):
        min_idx = i
        for j in range(i+1, n):
            if arr[j] < arr[min_idx]:
                min_idx = j
        arr[i], arr[min_idx] = arr[min_idx], arr[i]
    return arr
```
- **Complejidad**: O(n²)
- **Estable**: No
- **In-place**: Sí
- **Uso**: Listas pequeñas, minimizar swaps

#### Insertion Sort
```python
def insertion_sort(arr):
    for i in range(1, len(arr)):
        key = arr[i]
        j = i-1
        while j >= 0 and key < arr[j]:
            arr[j+1] = arr[j]
            j -= 1
        arr[j+1] = key
    return arr
```
- **Complejidad**: O(n²) peor caso, O(n) mejor caso
- **Estable**: Sí
- **In-place**: Sí
- **Uso**: Listas casi ordenadas, listas pequeñas

### 2. Algoritmos Avanzados (O(n log n))

#### Merge Sort
```python
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    
    mid = len(arr) // 2
    left = merge_sort(arr[:mid])
    right = merge_sort(arr[mid:])
    
    return merge(left, right)

def merge(left, right):
    result = []
    i = j = 0
    
    while i < len(left) and j < len(right):
        if left[i] <= right[j]:
            result.append(left[i])
            i += 1
        else:
            result.append(right[j])
            j += 1
    
    result.extend(left[i:])
    result.extend(right[j:])
    return result
```
- **Complejidad**: O(n log n) siempre
- **Estable**: Sí
- **In-place**: No (requiere O(n) espacio)
- **Uso**: Datos grandes, estabilidad requerida

#### Quick Sort
```python
def quick_sort(arr):
    if len(arr) <= 1:
        return arr
    
    pivot = arr[len(arr) // 2]
    left = [x for x in arr if x < pivot]
    middle = [x for x in arr if x == pivot]
    right = [x for x in arr if x > pivot]
    
    return quick_sort(left) + middle + quick_sort(right)
```
- **Complejidad**: O(n log n) promedio, O(n²) peor caso
- **Estable**: No (esta implementación)
- **In-place**: Depende de la implementación
- **Uso**: Propósito general, muy rápido en promedio

#### Heap Sort
```python
import heapq

def heap_sort(arr):
    heapq.heapify(arr)
    return [heapq.heappop(arr) for _ in range(len(arr))]
```
- **Complejidad**: O(n log n) siempre
- **Estable**: No
- **In-place**: Sí
- **Uso**: Garantía de O(n log n), memoria limitada

### 3. Algoritmos Especializados

#### Tim Sort (Python's default)
```python
def tim_sort(arr):
    return sorted(arr)  # Implementación nativa de Python
```
- **Complejidad**: O(n log n)
- **Estable**: Sí
- **In-place**: No
- **Uso**: Propósito general (usado por Python)

#### Counting Sort
```python
def counting_sort(arr):
    # Solo para enteros en rango conocido
    max_val = max(arr)
    min_val = min(arr)
    range_val = max_val - min_val + 1
    
    count = [0] * range_val
    output = [0] * len(arr)
    
    for num in arr:
        count[num - min_val] += 1
    
    for i in range(1, len(count)):
        count[i] += count[i-1]
    
    for num in reversed(arr):
        output[count[num - min_val] - 1] = num
        count[num - min_val] -= 1
    
    return output
```
- **Complejidad**: O(n + k) donde k es el rango
- **Estable**: Sí
- **In-place**: No
- **Uso**: Enteros en rango pequeño (ej: años)

#### Radix Sort
```python
def radix_sort(arr):
    # Implementación para enteros
    max_val = max(arr)
    exp = 1
    
    while max_val // exp > 0:
        counting_sort_by_digit(arr, exp)
        exp *= 10
    
    return arr
```
- **Complejidad**: O(d * n) donde d es número de dígitos
- **Estable**: Sí
- **In-place**: No
- **Uso**: Enteros, strings de longitud fija

## Estructura del Código

```python
# 1. Importar librerías
import os
import time
import random
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from pathlib import Path
from dotenv import load_dotenv

# 2. Cargar datos bibliográficos
load_dotenv()
BIBTEX_PATH = os.getenv("BIBTEX_PATH", "consolidado.bib")

# 3. Extraer campos para ordenar
def extract_bibtex_fields(bib_path):
    # Extraer títulos, autores, años, keywords
    pass

# 4. Implementar algoritmos de ordenamiento
algorithms = {
    'Bubble Sort': bubble_sort,
    'Selection Sort': selection_sort,
    'Insertion Sort': insertion_sort,
    'Merge Sort': merge_sort,
    'Quick Sort': quick_sort,
    'Heap Sort': heap_sort,
    'Tim Sort': tim_sort,
    'Counting Sort': counting_sort
}

# 5. Medir tiempos de ejecución
timings = {}
for field, values in fields.items():
    timings[field] = {}
    for name, algorithm in algorithms.items():
        # Copiar datos para cada prueba
        data_copy = values.copy()
        
        # Medir tiempo
        start = time.time()
        algorithm(data_copy)
        end = time.time()
        
        timings[field][name] = end - start

# 6. Generar visualizaciones
plot_performance_comparison(timings)

# 7. Análisis estadístico
analyze_results(timings)
```

## Uso

### Ejecución del Notebook

```bash
jupyter notebook algoritmosOrdenamiento.ipynb
```

### Configuración

```python
# Archivo BibTeX a procesar
BIBTEX_PATH = "consolidado.bib"

# Campos a ordenar
FIELDS_TO_SORT = ['title', 'author', 'year', 'keywords']

# Tamaños de muestra para pruebas
SAMPLE_SIZES = [100, 500, 1000, 5000, 10000]

# Número de repeticiones para promediar
N_REPETITIONS = 5

# Algoritmos a comparar
ALGORITHMS_TO_TEST = [
    'Bubble Sort',
    'Selection Sort', 
    'Insertion Sort',
    'Merge Sort',
    'Quick Sort',
    'Heap Sort',
    'Tim Sort'
]
```

## Resultados Esperados

### Tabla de Tiempos de Ejecución

```
Ordenamiento de 10,000 títulos:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Algoritmo          │ Tiempo (s) │ Complejidad │ Estable
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Bubble Sort        │   45.234   │   O(n²)     │   Sí
Selection Sort     │   38.567   │   O(n²)     │   No
Insertion Sort     │   32.891   │   O(n²)     │   Sí
Merge Sort         │    0.234   │ O(n log n)  │   Sí
Quick Sort         │    0.189   │ O(n log n)  │   No
Heap Sort          │    0.267   │ O(n log n)  │   No
Tim Sort (Python)  │    0.145   │ O(n log n)  │   Sí
Counting Sort*     │    0.098   │   O(n+k)    │   Sí
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
* Solo para años (rango limitado)
```

### Gráficos Generados

#### 1. Comparación de Tiempos
```python
plt.figure(figsize=(12, 6))
for algo in algorithms:
    plt.plot(sample_sizes, times[algo], marker='o', label=algo)
plt.xlabel('Tamaño de entrada (n)')
plt.ylabel('Tiempo (segundos)')
plt.title('Comparación de Algoritmos de Ordenamiento')
plt.legend()
plt.yscale('log')
plt.grid(True)
plt.show()
```

#### 2. Escalabilidad
```python
# Gráfico log-log para verificar complejidad
plt.loglog(sample_sizes, times)
plt.xlabel('log(n)')
plt.ylabel('log(tiempo)')
plt.title('Análisis de Escalabilidad')
plt.show()
```

#### 3. Heatmap de Rendimiento
```python
import seaborn as sns

# Matriz de tiempos: algoritmos x campos
sns.heatmap(timing_matrix, annot=True, fmt='.3f', cmap='YlOrRd')
plt.title('Tiempos de Ejecución por Campo')
plt.show()
```

## Análisis de Campos

### 1. Títulos (Strings largos)
- **Mejor**: Tim Sort, Merge Sort
- **Peor**: Bubble Sort, Selection Sort
- **Observación**: Comparaciones de strings son costosas

### 2. Autores (Strings con formato)
- **Mejor**: Tim Sort (optimizado para strings)
- **Consideración**: Normalización previa mejora rendimiento

### 3. Años (Enteros en rango pequeño)
- **Mejor**: Counting Sort (O(n))
- **Alternativa**: Radix Sort
- **Observación**: Rango limitado (1900-2025)

### 4. Keywords (Listas de strings)
- **Mejor**: Tim Sort
- **Consideración**: Requiere función de comparación custom

## Dependencias

```python
numpy==2.2.6
pandas==2.3.1
matplotlib==3.10.5
python-dotenv==1.1.1
```

## Comparación Teórica vs Práctica

| Algoritmo | Complejidad Teórica | Rendimiento Práctico | Razón |
|-----------|---------------------|----------------------|-------|
| Bubble Sort | O(n²) | Muy lento | Muchos swaps |
| Insertion Sort | O(n²) | Lento pero mejor que Bubble | Bueno para datos casi ordenados |
| Merge Sort | O(n log n) | Rápido y consistente | Overhead de memoria |
| Quick Sort | O(n log n) promedio | Más rápido que Merge | Buen uso de cache |
| Tim Sort | O(n log n) | **Más rápido** | Optimizado para datos reales |
| Counting Sort | O(n+k) | **Muy rápido** (años) | Solo para rangos pequeños |

## Casos de Uso Recomendados

### Datos Pequeños (< 100 elementos)
✅ **Insertion Sort**: Simple y eficiente para listas pequeñas

### Datos Medianos (100-10,000 elementos)
✅ **Tim Sort** (sorted()): Mejor opción general
✅ **Quick Sort**: Si memoria es limitada

### Datos Grandes (> 10,000 elementos)
✅ **Tim Sort**: Optimizado para Python
✅ **Merge Sort**: Si estabilidad es crítica

### Casos Especiales
✅ **Counting Sort**: Enteros en rango pequeño (años)
✅ **Radix Sort**: Strings de longitud fija
✅ **Heap Sort**: Garantía de O(n log n) con memoria limitada

## Optimizaciones Implementadas

### 1. Insertion Sort Mejorado
```python
def insertion_sort_optimized(arr):
    # Usar binary search para encontrar posición
    import bisect
    result = []
    for item in arr:
        bisect.insort(result, item)
    return result
```

### 2. Quick Sort con Mediana de Tres
```python
def quick_sort_median(arr):
    # Elegir pivot como mediana de primero, medio y último
    # Reduce probabilidad de peor caso O(n²)
    pass
```

### 3. Hybrid Sort (Tim Sort approach)
```python
def hybrid_sort(arr):
    # Insertion sort para sublistas pequeñas
    # Merge sort para combinar
    MIN_MERGE = 32
    # ...
```

## Problemas Comunes

### Error: "RecursionError: maximum recursion depth exceeded"

**Causa**: Quick Sort o Merge Sort con datos muy grandes

**Solución**:
```python
import sys
sys.setrecursionlimit(10000)

# O usar implementación iterativa
```

### Warning: "MemoryError"

**Causa**: Merge Sort con listas muy grandes

**Solución**:
```python
# Usar Heap Sort o Quick Sort in-place
# O procesar en lotes
```

### Tiempos inconsistentes

**Causa**: Otros procesos en el sistema

**Solución**:
```python
# Repetir mediciones y promediar
N_REPETITIONS = 10
times = []
for _ in range(N_REPETITIONS):
    start = time.time()
    algorithm(data.copy())
    times.append(time.time() - start)

avg_time = np.mean(times)
std_time = np.std(times)
```

## Tiempo de Ejecución del Notebook

| Tamaño de Datos | Tiempo Estimado |
|-----------------|-----------------|
| 1,000 artículos | 2-3 minutos |
| 5,000 artículos | 10-15 minutos |
| 10,000 artículos | 30-45 minutos |

## Salidas Generadas

### Archivos
- `outputs/performance_comparison.png` - Gráfico comparativo
- `outputs/scalability_analysis.png` - Análisis de escalabilidad
- `outputs/timing_results.csv` - Tabla de tiempos
- `outputs/statistical_analysis.txt` - Análisis estadístico

### Datos
```python
# Guardar resultados
results_df = pd.DataFrame(timings)
results_df.to_csv('outputs/timing_results.csv')
```

## Conclusiones Típicas

1. **Tim Sort es el ganador** para propósito general
2. **Counting Sort domina** para datos en rango pequeño (años)
3. **Algoritmos O(n²) son imprácticos** para > 1000 elementos
4. **Merge Sort** es la mejor opción cuando estabilidad es crítica
5. **Quick Sort** es competitivo pero menos estable que Tim Sort

## Aplicaciones

✅ **Ordenamiento de bibliografías**: Por autor, año, título
✅ **Análisis de complejidad**: Verificación empírica
✅ **Educación**: Demostración visual de algoritmos
✅ **Benchmarking**: Comparación de implementaciones

## Próximos Pasos

- Implementar algoritmos paralelos
- Probar con diferentes distribuciones de datos
- Analizar uso de memoria
- Comparar con librerías optimizadas (NumPy, Pandas)
