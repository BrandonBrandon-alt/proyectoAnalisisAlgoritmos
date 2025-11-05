# Archivos Incluidos para Despliegue en Vercel

## ✅ Resumen de Archivos Agregados

### Configuración de Despliegue
- ✅ `vercel.json` - Configuración de Vercel
- ✅ `.vercelignore` - Archivos a excluir del despliegue
- ✅ `.gitignore` - Actualizado para permitir archivos necesarios
- ✅ `DEPLOY.md` - Guía completa de despliegue
- ✅ `deploy.sh` - Script automatizado de despliegue

### Requerimiento 1 - Consolidación y Duplicados
**Archivos HTML/CSS:**
- ✅ `proyecto/requerimiento1/index.html`
- ✅ `proyecto/requerimiento1/style.css`

**Datos necesarios:**
- ✅ `duplicados/duplicados.bib` (93 KB)

**Estado:** ✅ Completo

---

### Requerimiento 2 - Benchmark de Similitud
**Archivos HTML:**
- ✅ `proyecto/requerimiento2/index.html`

**Datos necesarios:**
- ✅ `proyecto/requerimiento2/outputs/benchmark_results.csv`
- ✅ `proyecto/requerimiento2/outputs/benchmark_results.json`
- ✅ `proyecto/requerimiento2/outputs/benchmark_results.txt`
- ✅ `proyecto/requerimiento2/outputs/benchmark_similarities.png` (62 KB)
- ✅ `proyecto/requerimiento2/outputs/benchmark_times.png` (73 KB)

**Estado:** ✅ Completo

---

### Requerimiento 3 - Análisis de Frecuencias
**Archivos HTML:**
- ✅ `proyecto/requerimiento3/index.html` (ya existía)

**Datos necesarios:**
- ✅ `proyecto/requerimiento3/frecuencia_palabras_categoria.png`
- ✅ `proyecto/requerimiento3/frecuencias_palabras_categoria.csv`
- ✅ `proyecto/requerimiento3/top15_palabras.png`
- ✅ `proyecto/requerimiento3/top15_palabras_frecuentes.csv`

**Estado:** ✅ Completo

---

### Requerimiento 4 - Clustering Jerárquico
**Archivos HTML:**
- ✅ `proyecto/requerimiento4/index.html` (ya existía)

**Datos necesarios:**
- ✅ `proyecto/requerimiento4/dendrograma_average.png`
- ✅ `proyecto/requerimiento4/dendrograma_complete.png`
- ✅ `proyecto/requerimiento4/dendrograma_single.png`

**Estado:** ✅ Completo

---

### Requerimiento 5 - Análisis Geográfico
**Archivos HTML:**
- ✅ `proyecto/requerimiento5/index.html` (ya existía)
- ✅ `proyecto/requerimiento5/style.css` (ya existía)

**Datos necesarios:**
- ✅ `proyecto/requerimiento5/data/country_lookup.csv`
- ✅ `proyecto/requerimiento5/data/records.csv`
- ✅ `proyecto/requerimiento5/outputs/linea_tiempo_by_source.pdf`
- ✅ `proyecto/requerimiento5/outputs/linea_tiempo_by_source.png`
- ✅ `proyecto/requerimiento5/outputs/mapa_paises.pdf`
- ✅ `proyecto/requerimiento5/outputs/mapa_paises.png`
- ✅ `proyecto/requerimiento5/outputs/nube_palabras.pdf`
- ✅ `proyecto/requerimiento5/outputs/nube_palabras.png`
- ✅ `proyecto/requerimiento5/outputs/requerimiento5_report.pdf`

**Estado:** ✅ Completo

---

## 📊 Estadísticas

### Archivos por Tipo
- **HTML:** 5 archivos
- **CSS:** 2 archivos
- **PNG:** 13 imágenes
- **PDF:** 5 documentos
- **CSV:** 6 archivos de datos
- **JSON:** 1 archivo
- **TXT:** 1 archivo
- **BIB:** 1 archivo

### Tamaño Total Aproximado
- Imágenes PNG: ~500 KB
- PDFs: ~2 MB
- Datos (CSV, JSON, TXT, BIB): ~200 KB
- **Total estimado:** ~2.7 MB

---

## 🚀 Próximos Pasos para Desplegar

### 1. Hacer Commit de los Cambios

```bash
git commit -m "Add web visualization files and data for deployment"
```

### 2. Push a GitHub (si usas GitHub)

```bash
git push origin main
```

### 3. Desplegar en Vercel

**Opción A: Con CLI**
```bash
vercel login
vercel --prod
```

**Opción B: Con GitHub**
1. Ve a [vercel.com](https://vercel.com)
2. Importa tu repositorio
3. Vercel desplegará automáticamente

---

## 🔍 Verificación Post-Despliegue

Después del despliegue, verifica que funcionan:

### Requerimiento 1
- URL: `https://tu-proyecto.vercel.app/proyecto/requerimiento1/index.html`
- Debe cargar: `duplicados/duplicados.bib`

### Requerimiento 2
- URL: `https://tu-proyecto.vercel.app/proyecto/requerimiento2/index.html`
- Debe cargar: imágenes y archivos CSV/JSON/TXT

### Requerimiento 3
- URL: `https://tu-proyecto.vercel.app/proyecto/requerimiento3/index.html`
- Debe cargar: imágenes PNG y archivos CSV

### Requerimiento 4
- URL: `https://tu-proyecto.vercel.app/proyecto/requerimiento4/index.html`
- Debe cargar: 3 dendrogramas PNG

### Requerimiento 5
- URL: `https://tu-proyecto.vercel.app/proyecto/requerimiento5/index.html`
- Debe cargar: archivos CSV, imágenes PNG y PDFs

---

## ⚠️ Notas Importantes

1. **Límites de Vercel (Plan Gratuito):**
   - Tamaño máximo por archivo: 100 MB ✅
   - Tamaño total del proyecto: 100 MB ✅
   - Nuestro proyecto: ~2.7 MB ✅

2. **Rutas Relativas:**
   - Todos los HTML usan rutas relativas
   - No requieren configuración adicional

3. **CORS:**
   - No hay problemas de CORS porque todo está en el mismo dominio

4. **Archivos Excluidos:**
   - Notebooks (.ipynb)
   - Entorno virtual (venv/)
   - Archivos de descarga (descargas/)
   - Archivos temporales

---

## 🐛 Solución de Problemas

### Error 404 en archivos
- Verifica que el archivo esté en git: `git ls-files | grep nombre_archivo`
- Si no está, agrégalo: `git add -f ruta/al/archivo`

### Imágenes no cargan
- Verifica la ruta en el HTML
- Verifica que el archivo esté en el repositorio
- Revisa la consola del navegador para ver el error exacto

### Archivos muy grandes
- Comprime las imágenes PNG
- Considera usar almacenamiento externo (AWS S3, Cloudinary)

---

## 📝 Comandos Útiles

```bash
# Ver archivos que se desplegarán
git ls-files

# Ver archivos ignorados
git status --ignored

# Verificar tamaño del proyecto
du -sh .

# Ver archivos por tipo
git ls-files | grep -E "\.(png|pdf|csv)$"

# Limpiar caché de git
git rm -r --cached .
git add .
```
