# URLs para Probar el Despliegue

## 🌐 URL Base de Producción
`https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app`

---

## 📄 Páginas a Probar

### Página Principal
```
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/
```
**Debe mostrar:** Menú con 5 requerimientos

---

### Requerimiento 1 - Duplicados
```
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento1/
```
**Debe cargar:**
- ✅ HTML con botón "Cargar duplicados"
- ✅ CSS (estilos aplicados)
- ✅ Al hacer clic: `../../duplicados/duplicados.bib`

**Archivo de datos:**
```
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/duplicados/duplicados.bib
```

---

### Requerimiento 2 - Benchmark
```
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento2/
```
**Debe cargar:**
- ✅ `outputs/benchmark_times.png`
- ✅ `outputs/benchmark_similarities.png`
- ✅ `outputs/benchmark_results.csv`
- ✅ `outputs/benchmark_results.json`
- ✅ `outputs/benchmark_results.txt`

---

### Requerimiento 3 - Frecuencias
```
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento3/
```
**Debe cargar:**
- ✅ `frecuencia_palabras_categoria.png`
- ✅ `frecuencias_palabras_categoria.csv`
- ✅ `top15_palabras.png`
- ✅ `top15_palabras_frecuentes.csv`

---

### Requerimiento 4 - Clustering
```
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento4/
```
**Debe cargar:**
- ✅ `dendrograma_single.png`
- ✅ `dendrograma_complete.png`
- ✅ `dendrograma_average.png`

---

### Requerimiento 5 - Análisis Geográfico
```
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento5/
```
**Debe cargar:**
- ✅ `data/records.csv`
- ✅ `data/country_lookup.csv`
- ✅ `outputs/mapa_paises.png`
- ✅ `outputs/nube_palabras.png`
- ✅ `outputs/linea_tiempo_by_source.png`
- ✅ `outputs/linea_tiempo_by_source.pdf`
- ✅ `outputs/requerimiento5_report.pdf`

---

## 🔍 Cómo Verificar

### 1. Abrir la Consola del Navegador
- Chrome/Edge: `F12` o `Ctrl+Shift+I`
- Firefox: `F12` o `Ctrl+Shift+K`

### 2. Ver Errores 404
En la pestaña **Console** o **Network**, busca:
- ❌ Errores rojos (404 Not Found)
- ✅ Códigos 200 (OK)

### 3. Verificar Archivos Específicos

Prueba URLs directas de archivos:

```
# Duplicados
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/duplicados/duplicados.bib

# Imágenes R2
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento2/outputs/benchmark_times.png

# CSV R3
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento3/frecuencias_palabras_categoria.csv

# PNG R4
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento4/dendrograma_single.png

# CSV R5
https://proyecto-analisis-algoritmos-qw01pd8af.vercel.app/proyecto/requerimiento5/data/records.csv
```

---

## 🐛 Si Siguen los Errores 404

### Verificar que los archivos están en el despliegue

1. **Ver archivos desplegados en Vercel:**
   - Ve a: https://vercel.com/brandons-projects-f3345dbf/proyecto-analisis-algoritmos
   - Click en el último despliegue
   - Pestaña "Source" para ver archivos

2. **Verificar en git:**
```bash
git ls-files | grep duplicados
git ls-files | grep "requerimiento2/outputs"
git ls-files | grep "requerimiento3.*\.(png\|csv)"
```

3. **Verificar que están en staging:**
```bash
git status
```

### Si faltan archivos

```bash
# Agregar archivos faltantes
git add -f ruta/al/archivo

# Commit
git commit -m "Add missing data files"

# Push
git push origin test-deploy

# Redesplegar
vercel --prod
```

---

## ✅ Checklist de Verificación

Después de redesplegar, verifica:

- [ ] Página principal carga
- [ ] Requerimiento 1 carga HTML
- [ ] Requerimiento 1 carga duplicados.bib
- [ ] Requerimiento 2 carga imágenes PNG
- [ ] Requerimiento 2 carga CSV/JSON/TXT
- [ ] Requerimiento 3 carga imágenes PNG
- [ ] Requerimiento 3 carga CSV
- [ ] Requerimiento 4 carga 3 dendrogramas
- [ ] Requerimiento 5 carga archivos CSV
- [ ] Requerimiento 5 carga imágenes PNG
- [ ] Requerimiento 5 carga PDFs
- [ ] No hay errores 404 en consola
- [ ] Estilos CSS se aplican correctamente

---

## 🚀 Próximo Paso

```bash
# Push de los cambios
git push origin test-deploy

# Redesplegar
vercel --prod
```

Luego prueba las URLs de arriba y verifica en la consola del navegador.
