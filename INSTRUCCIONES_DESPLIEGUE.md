# Instrucciones para Despliegue desde Nueva Rama

## ✅ Archivos Preparados

Los archivos `.gitignore` y `.vercelignore` ya están optimizados para el despliegue:

- **`.gitignore`**: Controla qué archivos NO se suben a Git
- **`.vercelignore`**: Controla qué archivos NO se despliegan en Vercel

## 📋 Pasos para Crear Nueva Rama y Desplegar

### 1. Verificar archivos necesarios

```bash
# Verificar que los archivos importantes estén en Git
git ls-files | grep -E "(\.css|\.html|outputs/|duplicados\.bib)"
```

Deberías ver:
- ✅ `proyecto/requerimiento1/style.css`
- ✅ `proyecto/requerimiento5/style.css`
- ✅ Archivos en `outputs/` (PNG, PDF, JSON, CSV, etc.)
- ✅ `duplicados/duplicados.bib`

### 2. Crear nueva rama para despliegue

```bash
# Opción A: Crear rama desde la rama actual
git checkout -b deploy-production

# Opción B: Crear rama desde main/master
git checkout main  # o master
git pull
git checkout -b deploy-production
```

### 3. Asegurar que todos los cambios estén commiteados

```bash
# Ver estado
git status

# Si hay cambios pendientes, agregarlos
git add .gitignore .vercelignore
git commit -m "Optimizar archivos de configuración para despliegue"
```

### 4. Push de la nueva rama

```bash
# Push de la nueva rama a GitHub
git push -u origin deploy-production
```

### 5. Desplegar con Vercel

**Opción A: Despliegue con Vercel CLI**

```bash
# Desplegar como preview
vercel

# O desplegar directamente a producción
vercel --prod
```

**Opción B: Despliegue automático desde GitHub**

1. Ve a [vercel.com](https://vercel.com)
2. Selecciona tu proyecto
3. Ve a **Settings → Git**
4. En **Production Branch**, cambia a `deploy-production`
5. Haz push a la rama y Vercel desplegará automáticamente

### 6. Verificar el despliegue

Una vez desplegado, verifica:

```bash
# Ver URL del despliegue
vercel ls
```

Abre la URL en tu navegador y verifica:

1. **Página principal carga**: `https://tu-proyecto.vercel.app/`
2. **CSS se aplica correctamente**: 
   - Abre `https://tu-proyecto.vercel.app/proyecto/requerimiento1/`
   - Verifica que los estilos se vean bien
3. **Archivos de outputs cargan**:
   - Abre `https://tu-proyecto.vercel.app/proyecto/requerimiento2/`
   - Haz clic en "Cargar resultados"
   - Las imágenes deben mostrarse sin errores 404
4. **duplicados.bib está disponible**:
   - Abre `https://tu-proyecto.vercel.app/proyecto/requerimiento1/`
   - Haz clic en "Cargar duplicados"
   - Debe cargar sin errores

### 7. Verificar en el navegador (F12)

Abre las herramientas de desarrollador (F12) y verifica:

**Network Tab:**
- ✅ `style.css` → Status 200
- ✅ `duplicados.bib` → Status 200
- ✅ Imágenes PNG/PDF → Status 200

**Console Tab:**
- ❌ No debe haber errores 404
- ❌ No debe haber errores de CORS

## 🔧 Solución de Problemas

### Si los archivos CSS no cargan:

```bash
# Verificar que estén en Git
git ls-files | grep "\.css$"

# Si no aparecen, agregarlos
git add proyecto/requerimiento*/style.css
git commit -m "Add CSS files"
git push
```

### Si los archivos de outputs no cargan:

```bash
# Verificar que estén en Git
git ls-files | grep "outputs/"

# Si no aparecen, agregarlos
git add proyecto/requerimiento*/outputs/
git commit -m "Add output files"
git push
```

### Si duplicados.bib no carga:

```bash
# Verificar que esté en Git
git ls-files | grep "duplicados.bib"

# Si no aparece, agregarlo
git add duplicados/duplicados.bib
git commit -m "Add duplicados.bib"
git push
```

### Limpiar caché de Vercel:

Si los archivos están en Git pero no cargan:

1. Ve a tu proyecto en [Vercel Dashboard](https://vercel.com/dashboard)
2. **Settings → General**
3. Scroll hasta **Clear Cache**
4. Click en **Clear Cache**
5. Redeploy: `vercel --prod --force`

## 📊 Checklist de Despliegue

Antes de desplegar, verifica:

- [ ] `.gitignore` actualizado
- [ ] `.vercelignore` actualizado
- [ ] Archivos CSS en Git
- [ ] Archivos outputs/ en Git
- [ ] duplicados.bib en Git
- [ ] index.html en raíz
- [ ] Todos los cambios commiteados
- [ ] Push a GitHub completado

Después del despliegue, verifica:

- [ ] Página principal carga
- [ ] CSS se aplica correctamente
- [ ] Imágenes cargan sin 404
- [ ] duplicados.bib carga sin errores
- [ ] No hay errores en consola del navegador

## 🎯 Comandos Rápidos

```bash
# Crear rama y desplegar (todo en uno)
git checkout -b deploy-production
git add .
git commit -m "Preparar para despliegue en producción"
git push -u origin deploy-production
vercel --prod

# Ver logs si hay problemas
vercel logs

# Forzar redespliegue
vercel --prod --force

# Ver información del proyecto
vercel inspect
```

## 📝 Notas Importantes

1. **No uses patrones de negación (`!`) en `.vercelignore`** - No funcionan como en `.gitignore`
2. **Solo ignora lo que NO necesitas** - Todo lo demás se incluirá automáticamente
3. **Los archivos deben estar en Git primero** - Vercel despliega desde Git
4. **El despliegue tarda 1-3 minutos** - Ten paciencia
5. **Verifica en el navegador** - Usa F12 para ver errores específicos

## 🆘 Ayuda Adicional

Si sigues teniendo problemas:

1. Ejecuta el script de verificación:
   ```bash
   ./verificar_despliegue.sh
   ```

2. Revisa la documentación completa:
   ```bash
   cat SOLUCION_DESPLIEGUE.md
   ```

3. Consulta los logs de Vercel:
   ```bash
   vercel logs
   ```

¡Buena suerte con el despliegue! 🚀
