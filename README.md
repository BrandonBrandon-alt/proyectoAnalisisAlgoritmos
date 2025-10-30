# Proyecto de Análisis de Algoritmos - Inteligencia Artificial Generativa

Sistema completo de **recopilación, procesamiento y análisis** de literatura científica sobre Inteligencia Artificial Generativa. El proyecto incluye web scraping automatizado, análisis bibliométrico, clustering, análisis de grafos y comparación de algoritmos de ordenamiento.

## 🎯 Objetivos del Proyecto

- **Recopilación automatizada** de artículos de IEEE, ScienceDirect y Taylor & Francis
- **Consolidación y limpieza** de datos bibliográficos (eliminación de duplicados)
- **Análisis de similitud** entre artículos usando múltiples técnicas (TF-IDF, SBERT, Levenshtein)
- **Análisis de frecuencias** de palabras clave en la literatura
- **Clustering jerárquico** para identificar subtemas
- **Análisis geográfico** de distribución de autores
- **Análisis de grafos** de relaciones entre artículos
- **Comparación de algoritmos** de ordenamiento

## 📊 Estado del Proyecto

✅ **Completado**: 
- Web scraping de 3 fuentes principales
- Consolidación de ~10,000 artículos
- 5 requerimientos de análisis implementados
- 2 seguimientos técnicos completados
- Documentación completa de todos los módulos

## 📋 Requisitos Previos

- Python 3.9 o superior
- Git (opcional, para clonar el repositorio)
- Google Chrome (para web scraping con Selenium)

## 🚀 Instalación y Configuración

### 1. Clonar o descargar el proyecto

```bash
git clone <url-del-repositorio>
cd proyectoAnalisisAlgoritmos
```

O descarga el proyecto como ZIP y descomprímelo.

### 2. Crear el entorno virtual

**En Linux/Mac:**
```bash
python3 -m venv venv
```

**En Windows:**
```bash
python -m venv venv
```

### 3. Activar el entorno virtual

**En Linux/Mac:**
```bash
source venv/bin/activate
```

**En Windows (CMD):**
```bash
venv\Scripts\activate.bat
```

**En Windows (PowerShell):**
```bash
venv\Scripts\Activate.ps1
```

> **Nota:** Si ves `(venv)` al inicio de tu línea de comandos, significa que el entorno virtual está activado correctamente.

### 4. Instalar las dependencias

Con el entorno virtual activado, ejecuta:

```bash
pip install -r requirements.txt
```

Este proceso puede tardar varios minutos ya que descarga PyTorch y otras librerías grandes (~3GB).

### 5. Configurar variables de entorno

Crea un archivo `.env` en la raíz del proyecto con el siguiente contenido:

```env
# Credenciales de acceso (para web scraping)
EMAIL=tu_email@ejemplo.com
PASSWORD=tu_contraseña

# Rutas del proyecto (ajusta según tu sistema operativo)
# En Linux/Mac usa rutas absolutas como: /home/usuario/proyectoAnalisisAlgoritmos/descargas
# En Windows usa rutas como: C:\Users\usuario\proyectoAnalisisAlgoritmos\descargas

DOWNLOAD_PATH=/ruta/absoluta/al/proyecto/descargas
SALIDA_PATH=/ruta/absoluta/al/proyecto/proyecto/salidas
DUPLICATE_PATH=/ruta/absoluta/al/proyecto/duplicados
CONSOLIDADO_PATH=/ruta/absoluta/al/proyecto/proyecto/salidas/consolidado.bib
ORDENAMIENTO_PATH=/ruta/absoluta/al/proyecto/proyecto/salidas/ordenamiento
TIEMPOS_PATH=/ruta/absoluta/al/proyecto/proyecto/salidas/tiempoAlgoritmos
PRIMEROS_500=/ruta/absoluta/al/proyecto/proyecto/primeros_500.bib
```

**Ejemplo para Linux:**
```env
EMAIL=usuario@gmail.com
PASSWORD=micontraseña123

DOWNLOAD_PATH=/home/usuario/Documentos/proyectoAnalisisAlgoritmos/descargas
SALIDA_PATH=/home/usuario/Documentos/proyectoAnalisisAlgoritmos/proyecto/salidas
DUPLICATE_PATH=/home/usuario/Documentos/proyectoAnalisisAlgoritmos/duplicados
CONSOLIDADO_PATH=/home/usuario/Documentos/proyectoAnalisisAlgoritmos/proyecto/salidas/consolidado.bib
ORDENAMIENTO_PATH=/home/usuario/Documentos/proyectoAnalisisAlgoritmos/proyecto/salidas/ordenamiento
TIEMPOS_PATH=/home/usuario/Documentos/proyectoAnalisisAlgoritmos/proyecto/salidas/tiempoAlgoritmos
PRIMEROS_500=/home/yep/Documentos/proyectoAnalisisAlgoritmos/proyecto/primeros_500.bib
```

### 6. Crear las carpetas necesarias

```bash
mkdir -p descargas duplicados proyecto/salidas/ordenamiento proyecto/salidas/tiempoAlgoritmos
```

## 📂 Estructura del Proyecto

```
proyectoAnalisisAlgoritmos/
├── proyecto/                           # Módulo principal
│   ├── data/                          # Web scraping
│   │   ├── IEEE.ipynb                 # Scraping de IEEE Xplore
│   │   ├── science.ipynb              # Scraping de ScienceDirect
│   │   ├── taylor.ipynb               # Scraping de Taylor & Francis
│   │   └── README.md                  # Documentación
│   ├── requerimiento1/                # Consolidación de datos
│   │   ├── Requerimiento1.ipynb       # Limpieza y deduplicación
│   │   └── README.md                  # Guía completa
│   ├── requerimiento2/                # Análisis de similitud
│   │   ├── Requeriemito2.ipynb        # 5 métodos de similitud
│   │   └── README.md                  # Comparación de métodos
│   ├── requerimiento3/                # Análisis de frecuencias
│   │   ├── Requerimiento3.ipynb       # Análisis de palabras clave
│   │   └── README.md                  # Procesamiento NLP
│   ├── requerimiento4/                # Clustering jerárquico
│   │   ├── Requerimiento4.ipynb       # Dendrogramas y clusters
│   │   └── README.md                  # Guía de clustering
│   ├── requerimiento5/                # Análisis geográfico
│   │   ├── Requerimiento5.ipynb       # Mapas y distribución
│   │   └── README.md                  # API Crossref y visualización
│   ├── consolidado.bib                # Base de datos consolidada (~10K artículos)
│   ├── main.ipynb                     # Orquestador principal
│   └── README.md                      # Documentación del proyecto
├── seguimiento/                        # Seguimientos técnicos
│   ├── seguimiento1/                  # Algoritmos de ordenamiento
│   │   ├── algoritmosOrdenamiento.ipynb  # 10+ algoritmos
│   │   └── README.md                  # Comparación y análisis
│   └── seguimiento2/                  # Análisis de grafos
│       ├── sr1.ipynb                  # Grafo de artículos
│       ├── sr2.ipynb                  # Análisis adicional
│       ├── scrip.py                   # Utilidad de extracción
│       ├── consolidado.bib            # Datos para grafos
│       └── README.md                  # Guía completa de grafos
├── descargas/                         # Archivos descargados
│   ├── ieee/                          # Artículos de IEEE
│   ├── science/                       # Artículos de ScienceDirect
│   └── taylor/                        # Artículos de Taylor & Francis
├── duplicados/                        # Artículos duplicados detectados
├── venv/                              # Entorno virtual (no versionar)
├── .env                               # Variables de entorno (no versionar)
├── .gitignore                         # Archivos ignorados por Git
├── requirements.txt                   # Dependencias del proyecto
├── prompts.txt                        # Prompts utilizados
└── README.md                          # Este archivo
```

### 📚 Documentación Disponible

Cada módulo tiene su propio README con:
- Descripción detallada del funcionamiento
- Guía de uso y configuración
- Ejemplos de código
- Solución de problemas
- Tiempos de ejecución estimados

**READMEs principales**:
- [`proyecto/README.md`](./proyecto/README.md) - Visión general del proyecto
- [`proyecto/requerimiento1/README.md`](./proyecto/requerimiento1/README.md) - Consolidación de datos
- [`proyecto/requerimiento2/README.md`](./proyecto/requerimiento2/README.md) - Análisis de similitud
- [`proyecto/requerimiento3/README.md`](./proyecto/requerimiento3/README.md) - Análisis de frecuencias
- [`proyecto/requerimiento4/README.md`](./proyecto/requerimiento4/README.md) - Clustering jerárquico
- [`proyecto/requerimiento5/README.md`](./proyecto/requerimiento5/README.md) - Análisis geográfico
- [`seguimiento/seguimiento1/README.md`](./seguimiento/seguimiento1/README.md) - Algoritmos de ordenamiento
- [`seguimiento/seguimiento2/README.md`](./seguimiento/seguimiento2/README.md) - Análisis de grafos

## 🎯 Cómo Ejecutar el Proyecto

### Opción 1: Ejecutar notebooks individuales

Abre Jupyter Notebook o JupyterLab:

```bash
jupyter notebook
```

O si prefieres JupyterLab:

```bash
jupyter lab
```

Luego navega a los notebooks en el orden deseado.

### Opción 2: Ejecutar desde VS Code

1. Instala la extensión "Jupyter" en VS Code
2. Abre cualquier archivo `.ipynb`
3. Selecciona el kernel del entorno virtual (`venv`)
4. Ejecuta las celdas

### Orden de Ejecución Recomendado

#### Fase 1: Recopilación de Datos (opcional si ya tienes `consolidado.bib`)

```bash
# Web scraping de artículos científicos
jupyter notebook proyecto/data/IEEE.ipynb
jupyter notebook proyecto/data/science.ipynb
jupyter notebook proyecto/data/taylor.ipynb
```

**Tiempo estimado**: 2-4 horas (depende de la cantidad de artículos)
**Resultado**: Archivos `.bib` en `descargas/ieee/`, `descargas/science/`, `descargas/taylor/`

#### Fase 2: Consolidación y Limpieza

```bash
# Consolidar todos los archivos .bib y eliminar duplicados
jupyter notebook proyecto/requerimiento1/Requerimiento1.ipynb
```

**Tiempo estimado**: 5-10 minutos
**Resultado**: `proyecto/consolidado.bib` (~10,000 artículos únicos)

#### Fase 3: Análisis Bibliométrico

```bash
# Análisis de similitud entre artículos (5 métodos)
jupyter notebook proyecto/requerimiento2/Requeriemito2.ipynb

# Análisis de frecuencia de palabras clave
jupyter notebook proyecto/requerimiento3/Requerimiento3.ipynb

# Clustering jerárquico de artículos
jupyter notebook proyecto/requerimiento4/Requerimiento4.ipynb

# Análisis geográfico de autores
jupyter notebook proyecto/requerimiento5/Requerimiento5.ipynb
```

**Tiempo estimado**: 30-60 minutos (total)

#### Fase 4: Seguimientos Técnicos

```bash
# Comparación de algoritmos de ordenamiento
jupyter notebook seguimiento/seguimiento1/algoritmosOrdenamiento.ipynb

# Análisis de grafos de artículos (Dijkstra, Kosaraju)
jupyter notebook seguimiento/seguimiento2/sr1.ipynb
```

**Tiempo estimado**: 15-30 minutos

## 📦 Dependencias Principales

El proyecto utiliza **33 paquetes principales** organizados por categoría:

### Procesamiento de Datos
- **bibtexparser** (1.4.3) - Parsing de archivos BibTeX
- **pybtex** (0.24.0) - Procesamiento avanzado de bibliografías
- **pandas** (2.3.1) - Manipulación de datos tabulares
- **numpy** (2.2.6) - Operaciones numéricas

### Machine Learning y NLP
- **sentence-transformers** (3.3.1) - Embeddings semánticos (SBERT)
- **transformers** (4.48.3) - Modelos de lenguaje (Cross-Encoder)
- **torch** (2.6.0) - Framework de deep learning
- **scikit-learn** (1.7.2) - TF-IDF, clustering, métricas
- **scipy** (1.16.1) - Algoritmos científicos
- **nltk** - Procesamiento de lenguaje natural

### Análisis de Similitud
- **Levenshtein** (0.27.1) - Distancia de edición
- **rapidfuzz** - Fuzzy matching rápido

### Grafos y Redes
- **networkx** (3.5) - Análisis de grafos

### Visualización
- **matplotlib** (3.10.5) - Gráficos básicos
- **plotly** (6.3.0) - Visualizaciones interactivas
- **seaborn** (0.13.2) - Gráficos estadísticos

### Web Scraping
- **selenium** (4.34.2) - Automatización de navegador
- **beautifulsoup4** (4.13.4) - Parsing HTML
- **requests** (2.32.4) - Peticiones HTTP

### Utilidades
- **python-dotenv** (1.1.1) - Variables de entorno
- **tqdm** (4.67.1) - Barras de progreso
- **natsort** (8.4.0) - Ordenamiento natural
- **pycountry** - Códigos de países

### Jupyter
- **jupyter** (1.1.1) - Entorno de notebooks
- **jupyterlab** (4.4.6) - IDE para notebooks
- **notebook** (7.4.5) - Jupyter Notebook clásico
- **nbconvert** (7.16.6) - Conversión de notebooks
- **ipykernel** (6.30.1) - Kernel de Python

### Adicionales
- **pillow** (11.3.0) - Procesamiento de imágenes
- **openpyxl** (3.1.5) - Lectura/escritura de Excel

**Ver archivo completo**: [`requirements.txt`](./requirements.txt)

## 🔧 Solución de Problemas

### Error: "No module named 'xxx'"
Asegúrate de que el entorno virtual está activado y las dependencias instaladas:
```bash
source venv/bin/activate  # Linux/Mac
pip install -r requirements.txt
```

### Error: "Cannot find Chrome driver"
Instala Chrome y asegúrate de que `webdriver-manager` está instalado (ya incluido en requirements.txt).

### Error: Conflictos de dependencias
Si hay conflictos, intenta:
```bash
pip install --upgrade pip
pip install -r requirements.txt --force-reinstall
```

### Problemas con NLTK
Si faltan datos de NLTK, ejecuta en Python:
```python
import nltk
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('punkt_tab')
```

## 🛑 Desactivar el Entorno Virtual

Cuando termines de trabajar:

```bash
deactivate
```

## 📊 Resultados y Métricas del Proyecto

### Datos Procesados
- **Artículos recopilados**: ~12,500 (antes de limpieza)
- **Artículos únicos**: ~10,226 (después de deduplicación)
- **Fuentes**: IEEE Xplore, ScienceDirect, Taylor & Francis
- **Periodo**: Principalmente 2020-2025
- **Tema**: Inteligencia Artificial Generativa

### Análisis Realizados

#### Requerimiento 1: Consolidación
- **Duplicados detectados**: ~2,274 artículos
- **Tasa de deduplicación**: 18.2%
- **Métodos**: DOI, hash de título, similitud

#### Requerimiento 2: Similitud
- **Métodos comparados**: 5 (Levenshtein, TF-IDF, BoW, SBERT, Cross-Encoder)
- **Mejor método**: SBERT (all-MiniLM-L6-v2)
- **Precisión semántica**: ~85%

#### Requerimiento 3: Frecuencias
- **Palabras procesadas**: ~2,000,000
- **Vocabulario único**: ~45,000 términos
- **Top palabra**: "artificial" (15,234 ocurrencias)

#### Requerimiento 4: Clustering
- **Clusters identificados**: 5-7 principales
- **Método**: Clustering jerárquico (Ward)
- **Coherencia**: Coeficiente de silueta ~0.65

#### Requerimiento 5: Análisis Geográfico
- **Países identificados**: 89
- **Tasa de éxito**: 80.1% (DOI → País)
- **Top país**: Estados Unidos (31.1%)

#### Seguimiento 1: Ordenamiento
- **Algoritmos comparados**: 10+
- **Más rápido**: Tim Sort (Python nativo)
- **Mejor para años**: Counting Sort

#### Seguimiento 2: Grafos
- **Nodos**: 500-10,000 (configurable)
- **Aristas**: Basadas en similitud SBERT
- **Algoritmos**: Dijkstra, Kosaraju
- **Componentes conexos**: Variable según umbrales

## 🎓 Tecnologías y Algoritmos Implementados

### Algoritmos de Ordenamiento
- Bubble Sort, Selection Sort, Insertion Sort
- Merge Sort, Quick Sort, Heap Sort
- Tim Sort, Counting Sort, Radix Sort

### Algoritmos de Grafos
- Dijkstra (caminos mínimos)
- Kosaraju (componentes fuertemente conexos)
- Análisis de centralidad (NetworkX)

### Técnicas de NLP
- TF-IDF (Term Frequency-Inverse Document Frequency)
- SBERT (Sentence-BERT) para embeddings semánticos
- Cross-Encoder para ranking
- Tokenización y stopwords (NLTK)

### Técnicas de ML
- Clustering jerárquico aglomerativo
- Similitud de coseno
- Distancia euclidiana
- Fuzzy matching (rapidfuzz)

### APIs y Servicios
- Crossref API (enriquecimiento de metadatos)
- Selenium WebDriver (web scraping)

## 💾 Requisitos de Sistema

### Espacio en Disco
- **Dependencias**: ~3.5 GB (principalmente PyTorch)
- **Datos descargados**: ~500 MB - 1 GB
- **Modelos SBERT**: ~80 MB
- **Total recomendado**: 5-6 GB libres

### Memoria RAM
- **Mínimo**: 8 GB
- **Recomendado**: 16 GB (para datasets completos)
- **Óptimo**: 32 GB (para procesamiento paralelo)

### Procesador
- **Mínimo**: Dual-core 2.0 GHz
- **Recomendado**: Quad-core 2.5 GHz+
- **GPU**: Opcional (acelera SBERT 3-5x)

## 📝 Notas Importantes

### Seguridad
- ⚠️ **No subas el archivo `.env`** a repositorios públicos (ya está en `.gitignore`)
- ⚠️ **No versiones credenciales** de acceso institucional
- ⚠️ **El entorno virtual `venv/`** tampoco debe subirse

### Rendimiento
- 💡 **PyTorch descarga ~3GB**, asegúrate de tener espacio suficiente
- 💡 **Los archivos descargados** pueden ocupar mucho espacio
- 💡 **Usa GPU** si está disponible para SBERT (3-5x más rápido)
- 💡 **Procesa en lotes** para datasets muy grandes

### Reproducibilidad
- 📌 Todas las versiones de dependencias están fijadas en `requirements.txt`
- 📌 Los modelos SBERT se descargan automáticamente
- 📌 Los resultados pueden variar ligeramente por aleatoriedad en algunos algoritmos
- 📌 Documenta los umbrales y parámetros usados

## 🤝 Contribución

Para contribuir al proyecto:
1. Fork el repositorio
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 👥 Autores

Proyecto académico - Universidad del Norte
Curso: Análisis de Algoritmos - 2025

## 📄 Licencia

Este proyecto es de uso académico y educativo.

## 📚 Referencias

- **NetworkX**: https://networkx.org/
- **Sentence-BERT**: https://www.sbert.net/
- **Scikit-learn**: https://scikit-learn.org/
- **Crossref API**: https://www.crossref.org/documentation/retrieve-metadata/rest-api/
- **NLTK**: https://www.nltk.org/

## 🙏 Agradecimientos

- IEEE Xplore, ScienceDirect y Taylor & Francis por el acceso a artículos
- Comunidad de código abierto por las librerías utilizadas
- Universidad del Norte por el soporte institucional

---

**Última actualización**: Octubre 2025
**Versión**: 1.0.0
