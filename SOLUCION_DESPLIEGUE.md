# Solución a Problemas de Despliegue

## Problemas Identificados

### 1. ❌ Archivos CSS no se cargan
**Causa:** El archivo `.vercelignore` no tenía reglas explícitas para incluir archivos `.css`

**Archivos afectados:**
- `proyecto/requerimiento1/style.css`
- `proyecto/requerimiento5/style.css`

### 2. ❌ Archivos de outputs no se encuentran
**Causa:** Las reglas en `.vercelignore` no estaban correctamente configuradas para incluir todos los archivos de outputs

**Archivos afectados:**
- `proyecto/requerimiento2/outputs/*.png`
- `proyecto/requerimiento5/outputs/*.png`
- `proyecto/requerimiento5/outputs/*.pdf`
- Y otros archivos en carpetas outputs/

## Solución Aplicada

He actualizado el archivo `.vercelignore` con las siguientes mejoras:

```
# IMPORTANTE: Permitir archivos necesarios para visualización
!duplicados/
!duplicados/duplicados.bib
!proyecto/requerimiento*/data/
!proyecto/requerimiento*/data/*.csv
!proyecto/requerimiento*/outputs/
!proyecto/requerimiento*/outputs/*.png
!proyecto/requerimiento*/outputs/*.pdf
!proyecto/requerimiento*/outputs/*.html
!proyecto/requerimiento*/outputs/*.json
!proyecto/requerimiento*/outputs/*.txt
!proyecto/requerimiento*/outputs/*.csv
!proyecto/requerimiento*/*.css      # ← NUEVO: Incluir archivos CSS
!proyecto/requerimiento*/*.html     # ← NUEVO: Incluir archivos HTML
```

## Pasos para Redesplegar

### Opción 1: Despliegue con Vercel CLI (Recomendado)

```bash
# 1. Verificar que los cambios están listos
./verificar_despliegue.sh

# 2. Hacer commit de los cambios
git add .vercelignore
git commit -m "Fix: Actualizar .vercelignore para incluir CSS y outputs"

# 3. Push a tu repositorio (si usas Git + Vercel)
git push

# 4. O desplegar directamente con Vercel CLI
vercel --prod
```

### Opción 2: Despliegue automático con Git + Vercel

Si tienes configurado Vercel para desplegar automáticamente desde GitHub:

```bash
# 1. Hacer commit
git add .vercelignore
git commit -m "Fix: Actualizar .vercelignore para incluir CSS y outputs"

# 2. Push
git push

# Vercel desplegará automáticamente en unos minutos
```

## Verificación Post-Despliegue

Después del despliegue, verifica que:

1. ✅ **CSS carga correctamente:**
   - Abre https://tu-proyecto.vercel.app/proyecto/requerimiento1/
   - Verifica que los estilos se apliquen correctamente
   - Abre las herramientas de desarrollador (F12) → Network
   - Busca `style.css` y verifica que cargue con status 200

2. ✅ **Archivos de outputs se encuentran:**
   - Abre https://tu-proyecto.vercel.app/proyecto/requerimiento2/
   - Haz clic en "Cargar resultados"
   - Verifica que las imágenes se muestren correctamente
   - Verifica que no haya errores 404 en la consola

3. ✅ **duplicados.bib está disponible:**
   - Abre https://tu-proyecto.vercel.app/proyecto/requerimiento1/
   - Haz clic en "Cargar duplicados"
   - Verifica que cargue sin errores

## Archivos Verificados

### Archivos CSS (2):
- ✅ proyecto/requerimiento1/style.css
- ✅ proyecto/requerimiento5/style.css

### Archivos en outputs/ (13):
- ✅ proyecto/requerimiento2/outputs/benchmark_results.csv
- ✅ proyecto/requerimiento2/outputs/benchmark_results.json
- ✅ proyecto/requerimiento2/outputs/benchmark_results.txt
- ✅ proyecto/requerimiento2/outputs/benchmark_similarities.png
- ✅ proyecto/requerimiento2/outputs/benchmark_times.png
- ✅ proyecto/requerimiento5/outputs/linea_tiempo_by_source.html
- ✅ proyecto/requerimiento5/outputs/linea_tiempo_by_source.pdf
- ✅ proyecto/requerimiento5/outputs/linea_tiempo_by_source.png
- ✅ proyecto/requerimiento5/outputs/mapa_paises.pdf
- ✅ proyecto/requerimiento5/outputs/mapa_paises.png
- ✅ proyecto/requerimiento5/outputs/nube_palabras.pdf
- ✅ proyecto/requerimiento5/outputs/nube_palabras.png
- ✅ proyecto/requerimiento5/outputs/requerimiento5_report.pdf

### Otros archivos importantes:
- ✅ duplicados/duplicados.bib (93 KB)
- ✅ index.html (página principal)

## Solución de Problemas

### Si los archivos CSS aún no cargan:

1. Verifica que el commit se haya hecho correctamente:
   ```bash
   git log -1
   ```

2. Verifica que los archivos CSS estén en Git:
   ```bash
   git ls-files | grep "\.css$"
   ```

3. Limpia el caché de Vercel:
   - Ve a tu proyecto en Vercel Dashboard
   - Settings → General → Clear Cache
   - Redeploy

### Si los archivos de outputs no se encuentran:

1. Verifica que estén en Git:
   ```bash
   git ls-files | grep "outputs/"
   ```

2. Si no están, agrégalos:
   ```bash
   git add proyecto/requerimiento*/outputs/
   git commit -m "Add output files"
   git push
   ```

### Si duplicados.bib no se encuentra:

1. Verifica que esté en Git:
   ```bash
   git ls-files | grep "duplicados.bib"
   ```

2. Si no está, agrégalo:
   ```bash
   git add duplicados/duplicados.bib
   git commit -m "Add duplicados.bib"
   git push
   ```

## Comandos Útiles

```bash
# Ver el estado de Git
git status

# Ver archivos rastreados por Git
git ls-files

# Ver logs de despliegue en Vercel
vercel logs

# Ver información del proyecto
vercel inspect

# Forzar redespliegue
vercel --prod --force
```

## Notas Importantes

- ✅ Todos los archivos necesarios ya están en Git
- ✅ El `.vercelignore` ha sido actualizado correctamente
- ✅ Solo necesitas hacer commit y push para que Vercel redespliegue
- ⚠️ Si usas Vercel CLI, asegúrate de estar en la rama correcta antes de desplegar
- ⚠️ El despliegue puede tardar 1-3 minutos en completarse

## Contacto y Soporte

Si sigues teniendo problemas después de seguir estos pasos:

1. Revisa los logs de Vercel: `vercel logs`
2. Verifica la consola del navegador (F12) para errores específicos
3. Comprueba que la URL de despliegue sea la correcta
