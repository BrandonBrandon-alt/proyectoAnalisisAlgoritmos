# Guía de Despliegue en Vercel

## Requisitos Previos

- Cuenta en [Vercel](https://vercel.com)
- Git instalado
- Node.js y npm instalados

## Opción 1: Despliegue con Vercel CLI (Recomendado)

### 1. Instalar Vercel CLI

```bash
npm install -g vercel
```

### 2. Iniciar sesión en Vercel

```bash
vercel login
```

Sigue las instrucciones para autenticarte (email, GitHub, GitLab, o Bitbucket).

### 3. Desplegar el proyecto

Desde la raíz del proyecto, ejecuta:

```bash
vercel
```

El CLI te hará algunas preguntas:
- **Set up and deploy?** → Yes
- **Which scope?** → Selecciona tu cuenta
- **Link to existing project?** → No (primera vez)
- **What's your project's name?** → proyecto-analisis-algoritmos (o el que prefieras)
- **In which directory is your code located?** → ./ (raíz)

Vercel detectará automáticamente que es un sitio estático y lo desplegará.

### 4. Despliegue en producción

Para desplegar a producción:

```bash
vercel --prod
```

## Opción 2: Despliegue con GitHub + Vercel (Automático)

### 1. Crear repositorio en GitHub

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/TU_REPO.git
git push -u origin main
```

### 2. Conectar con Vercel

1. Ve a [vercel.com](https://vercel.com)
2. Click en **"Add New Project"**
3. Importa tu repositorio de GitHub
4. Vercel detectará automáticamente la configuración
5. Click en **"Deploy"**

### 3. Configuración automática

Vercel detectará:
- Framework: **Other** (sitio estático)
- Build Command: (ninguno necesario)
- Output Directory: **.**
- Install Command: (ninguno necesario)

## Opción 3: Despliegue Manual (Drag & Drop)

### 1. Preparar archivos

Asegúrate de que solo los archivos necesarios estén en la carpeta:
- `index.html`
- `proyecto/` (con todos los requerimientos)
- Archivos de datos necesarios (CSV, imágenes, PDFs)

### 2. Subir a Vercel

1. Ve a [vercel.com/new](https://vercel.com/new)
2. Arrastra la carpeta del proyecto a la zona de "Drop"
3. Vercel subirá y desplegará automáticamente

## Estructura del Proyecto para Vercel

```
proyectoAnalisisAlgoritmos/
├── index.html                    # Página principal
├── vercel.json                   # Configuración de Vercel
├── .vercelignore                 # Archivos a ignorar
├── proyecto/
│   ├── requerimiento1/
│   │   ├── index.html
│   │   ├── style.css
│   │   └── data/               # Si hay datos necesarios
│   ├── requerimiento2/
│   │   ├── index.html
│   │   └── style.css
│   ├── requerimiento3/
│   │   ├── index.html
│   │   └── style.css
│   ├── requerimiento4/
│   │   ├── index.html
│   │   └── style.css
│   └── requerimiento5/
│       ├── index.html
│       ├── style.css
│       ├── data/
│       │   ├── records.csv
│       │   └── country_lookup.csv
│       └── outputs/
│           ├── mapa_paises.png
│           ├── nube_palabras.png
│           └── *.pdf
└── duplicados/
    └── duplicados.bib           # Archivo de duplicados

```

## Importante: Archivos de Datos

### Problema con archivos .gitignore

Si algunos archivos están en `.gitignore` (como `duplicados.bib`), Vercel no los desplegará. Tienes dos opciones:

#### Opción A: Remover del .gitignore temporalmente

```bash
# Editar .gitignore y comentar la línea de duplicados.bib
# duplicados/

git add duplicados/duplicados.bib
git commit -m "Add duplicados.bib for deployment"
git push
```

#### Opción B: Usar variables de entorno o API

Si los archivos son muy grandes, considera:
1. Subirlos a un servicio de almacenamiento (AWS S3, Google Cloud Storage)
2. Cargarlos dinámicamente desde el frontend

## Verificar el Despliegue

Después del despliegue, Vercel te dará una URL como:
```
https://proyecto-analisis-algoritmos.vercel.app
```

Verifica que:
- ✅ La página principal carga correctamente
- ✅ Los enlaces a cada requerimiento funcionan
- ✅ Los archivos CSS se cargan
- ✅ Los datos (CSV, imágenes, PDFs) están disponibles

## Solución de Problemas

### Error 404 en archivos de datos

Si los archivos de datos no cargan:

1. Verifica que estén en el repositorio
2. Revisa `.vercelignore` - asegúrate de no estar excluyendo archivos necesarios
3. Verifica las rutas en el código JavaScript (deben ser relativas)

### Error en rutas relativas

Si las rutas no funcionan, verifica en cada `index.html`:

```javascript
// Correcto - rutas relativas desde el archivo actual
const paths = {
    duplicates: '../../duplicados/duplicados.bib',  // requerimiento1
    records: 'data/records.csv',                     // requerimiento5
};
```

### Archivos grandes

Vercel tiene límites:
- Tamaño máximo de archivo: 100 MB
- Tamaño total del proyecto: 100 MB (plan gratuito)

Si excedes estos límites, considera:
1. Comprimir imágenes
2. Usar almacenamiento externo
3. Actualizar a plan Pro de Vercel

## Desplegar desde Otra Rama

### Desplegar rama específica

```bash
# Cambiar a la rama que quieres desplegar
git checkout nombre-de-la-rama

# Desplegar como preview
vercel

# Desplegar a producción
vercel --prod
```

### Configurar rama de producción en Vercel

Si usas GitHub + Vercel:

1. Ve a tu proyecto en Vercel Dashboard
2. Settings → Git
3. Cambia **Production Branch** de `main` a tu rama deseada
4. Guarda los cambios

### URLs por rama

Vercel crea URLs automáticas para cada rama:

- **Producción (main)**: `https://tu-proyecto.vercel.app`
- **Preview (test-deploy)**: `https://tu-proyecto-git-test-deploy.vercel.app`
- **Preview (otra-rama)**: `https://tu-proyecto-git-otra-rama.vercel.app`

## Comandos Útiles

```bash
# Ver logs del despliegue
vercel logs

# Listar despliegues
vercel ls

# Eliminar un despliegue
vercel rm [deployment-url]

# Ver información del proyecto
vercel inspect

# Ver en qué rama estás
git branch

# Desplegar rama actual
vercel --prod
```

## Actualizar el Despliegue

Cada vez que hagas cambios:

```bash
# Si usas Git + Vercel
git add .
git commit -m "Update"
git push  # Vercel despliega automáticamente

# Si usas Vercel CLI
vercel --prod
```

## Dominios Personalizados

Para usar un dominio personalizado:

1. Ve a tu proyecto en Vercel Dashboard
2. Settings → Domains
3. Agrega tu dominio
4. Configura los DNS según las instrucciones

## Recursos

- [Documentación de Vercel](https://vercel.com/docs)
- [Vercel CLI Reference](https://vercel.com/docs/cli)
- [Despliegue de sitios estáticos](https://vercel.com/docs/concepts/deployments/overview)
