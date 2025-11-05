#!/bin/bash

echo "=== Verificación de Archivos para Despliegue ==="
echo ""

# Verificar archivos CSS
echo "1. Verificando archivos CSS..."
css_files=$(git ls-files | grep "\.css$" | wc -l)
echo "   ✓ Archivos CSS en Git: $css_files"
git ls-files | grep "\.css$"
echo ""

# Verificar archivos HTML
echo "2. Verificando archivos HTML..."
html_files=$(git ls-files | grep "proyecto/.*\.html$" | wc -l)
echo "   ✓ Archivos HTML en Git: $html_files"
git ls-files | grep "proyecto/.*\.html$"
echo ""

# Verificar archivos de outputs
echo "3. Verificando archivos de outputs..."
output_files=$(git ls-files | grep "outputs/" | wc -l)
echo "   ✓ Archivos en outputs/: $output_files"
git ls-files | grep "outputs/" | head -10
echo ""

# Verificar duplicados.bib
echo "4. Verificando duplicados.bib..."
if git ls-files | grep -q "duplicados/duplicados.bib"; then
    echo "   ✓ duplicados.bib está en Git"
    ls -lh duplicados/duplicados.bib
else
    echo "   ✗ duplicados.bib NO está en Git"
fi
echo ""

# Verificar .vercelignore
echo "5. Verificando .vercelignore..."
if [ -f .vercelignore ]; then
    echo "   ✓ .vercelignore existe"
    echo "   Reglas importantes:"
    grep -E "(css|outputs|duplicados)" .vercelignore
else
    echo "   ✗ .vercelignore NO existe"
fi
echo ""

# Verificar index.html principal
echo "6. Verificando index.html principal..."
if [ -f index.html ]; then
    echo "   ✓ index.html existe"
    ls -lh index.html
else
    echo "   ✗ index.html NO existe"
fi
echo ""

echo "=== Verificación Completa ==="
echo ""
echo "Para desplegar a Vercel, ejecuta:"
echo "  vercel --prod"
echo ""
echo "O si usas Git + Vercel:"
echo "  git add ."
echo "  git commit -m 'Fix: Actualizar .vercelignore para incluir CSS y outputs'"
echo "  git push"
