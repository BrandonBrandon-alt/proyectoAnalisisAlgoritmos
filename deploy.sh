#!/bin/bash

# Script de despliegue para Vercel
# Proyecto: Análisis de Algoritmos

echo "🚀 Script de Despliegue en Vercel"
echo "=================================="
echo ""

# Verificar si Vercel CLI está instalado
if ! command -v vercel &> /dev/null
then
    echo "❌ Vercel CLI no está instalado."
    echo "📦 Instalando Vercel CLI..."
    npm install -g vercel
    echo "✅ Vercel CLI instalado correctamente"
    echo ""
fi

# Verificar autenticación
echo "🔐 Verificando autenticación en Vercel..."
if ! vercel whoami &> /dev/null
then
    echo "❌ No estás autenticado en Vercel."
    echo "🔑 Por favor, inicia sesión:"
    vercel login
    echo ""
fi

# Mostrar usuario actual
echo "👤 Usuario actual: $(vercel whoami)"
echo ""

# Preguntar tipo de despliegue
echo "📋 Selecciona el tipo de despliegue:"
echo "  1) Preview (desarrollo)"
echo "  2) Production (producción)"
echo ""
read -p "Opción (1 o 2): " option

case $option in
    1)
        echo ""
        echo "🔨 Desplegando en modo Preview..."
        vercel
        ;;
    2)
        echo ""
        echo "🚀 Desplegando en modo Production..."
        vercel --prod
        ;;
    *)
        echo "❌ Opción inválida. Saliendo..."
        exit 1
        ;;
esac

echo ""
echo "✅ Despliegue completado!"
echo ""
echo "📝 Comandos útiles:"
echo "  - Ver logs: vercel logs"
echo "  - Listar despliegues: vercel ls"
echo "  - Abrir en navegador: vercel open"
echo ""
