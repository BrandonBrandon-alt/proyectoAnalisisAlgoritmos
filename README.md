# Proyecto de Análisis de Algoritmos

Este proyecto realiza web scraping de artículos científicos, procesamiento de archivos BibTeX, análisis de similitud textual y aplicación de algoritmos de ordenamiento.

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
```

### 6. Crear las carpetas necesarias

```bash
mkdir -p descargas duplicados proyecto/salidas/ordenamiento proyecto/salidas/tiempoAlgoritmos
```

## 📂 Estructura del Proyecto

```
proyectoAnalisisAlgoritmos/
├── proyecto/
│   ├── data/                    # Notebooks de web scraping
│   │   ├── IEEE.ipynb
│   │   ├── science.ipynb
│   │   └── taylor.ipynb
│   ├── requerimiento1/          # Limpieza de archivos BibTeX
│   │   └── Requerimiento1.ipynb
│   ├── requerimiento2/          # Algoritmos de similitud textual
│   │   └── Requeriemito2.ipynb
│   ├── requerimiento3/          # Análisis de frecuencias
│   │   └── Requerimiento3.ipynb
│   ├── salidas/                 # Archivos de salida
│   └── main.ipynb               # Notebook principal
├── seguimiento/
│   ├── seguimiento1/            # Algoritmos de ordenamiento
│   │   └── algoritmosOrdenamiento.ipynb
│   └── seguimiento2/            # Grafos y análisis
│       ├── sr1.ipynb
│       ├── sr2.ipynb
│       └── scrip.py
├── descargas/                   # Archivos descargados (.bib)
├── duplicados/                  # Artículos duplicados
├── venv/                        # Entorno virtual (no subir a git)
├── .env                         # Variables de entorno (no subir a git)
├── .gitignore
├── requirements.txt             # Dependencias del proyecto
└── README.md
```

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

1. **Web Scraping** (opcional si ya tienes archivos .bib):
   - `proyecto/data/IEEE.ipynb`
   - `proyecto/data/science.ipynb`
   - `proyecto/data/taylor.ipynb`

2. **Procesamiento de datos**:
   - `proyecto/requerimiento1/Requerimiento1.ipynb` - Limpieza y consolidación

3. **Análisis**:
   - `proyecto/requerimiento2/Requeriemito2.ipynb` - Similitud textual
   - `proyecto/requerimiento3/Requerimiento3.ipynb` - Análisis de frecuencias
   - `seguimiento/seguimiento1/algoritmosOrdenamiento.ipynb` - Ordenamiento
   - `seguimiento/seguimiento2/sr1.ipynb` - Grafos

## 📦 Dependencias Principales

- **selenium**: Web scraping automatizado
- **bibtexparser / pybtex**: Procesamiento de archivos BibTeX
- **pandas**: Manipulación de datos
- **numpy**: Operaciones numéricas
- **matplotlib / seaborn**: Visualización
- **scikit-learn**: Algoritmos de ML (TF-IDF, coseno)
- **nltk**: Procesamiento de lenguaje natural
- **sentence-transformers**: Embeddings SBERT
- **transformers**: Modelos de IA (Cross-Encoder)
- **torch**: Framework de deep learning
- **networkx**: Análisis de grafos
- **Levenshtein**: Similitud de cadenas

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

## 📝 Notas Importantes

- **No subas el archivo `.env`** a repositorios públicos (ya está en `.gitignore`)
- **El entorno virtual `venv/`** tampoco debe subirse (ya está en `.gitignore`)
- **Los archivos descargados** pueden ocupar mucho espacio
- **PyTorch** descarga ~3GB, asegúrate de tener espacio suficiente

## 👥 Contribuidores

[Agrega aquí los nombres de los contribuidores del proyecto]

## 📄 Licencia

[Especifica la licencia del proyecto]

<!--- install bibtexparser scikit-learn scipy matplotlib nltk --->
