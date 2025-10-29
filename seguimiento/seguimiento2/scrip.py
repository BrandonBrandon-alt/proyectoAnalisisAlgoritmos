import re

def extraer_primeros_n_elementos(archivo_entrada, archivo_salida, n=500):
    """
    Extrae los primeros N elementos de un archivo .bib
    
    Args:
        archivo_entrada: Ruta del archivo .bib original
        archivo_salida: Ruta del archivo .bib de salida
        n: Número de elementos a extraer (default: 1000)
    """
    try:
        with open(archivo_entrada, 'r', encoding='utf-8') as f:
            contenido = f.read()
        
        # Patrón para encontrar entradas BibTeX (ARTICLE, INPROCEEDINGS, BOOK, etc.)
        # Busca desde @ hasta el cierre de llave correspondiente
        patron = r'@\w+\s*\{[^@]*?\n\}'
        
        # Encontrar todas las entradas
        entradas = re.findall(patron, contenido, re.DOTALL)
        
        # Tomar solo las primeras n entradas
        entradas_seleccionadas = entradas[:n]
        
        # Guardar en el archivo de salida
        with open(archivo_salida, 'w', encoding='utf-8') as f:
            f.write('\n\n'.join(entradas_seleccionadas))
        
        print(f"✓ Se extrajeron {len(entradas_seleccionadas)} elementos de {len(entradas)} totales")
        print(f"✓ Archivo guardado en: {archivo_salida}")
        
        return len(entradas_seleccionadas)
    
    except FileNotFoundError:
        print(f"✗ Error: No se encontró el archivo '{archivo_entrada}'")
        return 0
    except Exception as e:
        print(f"✗ Error al procesar el archivo: {str(e)}")
        return 0


# Uso del script
if __name__ == "__main__":
    import os
    from dotenv import load_dotenv
    
    # Cargar variables de entorno
    load_dotenv()
    
    # Obtener rutas desde variables de entorno
    archivo_entrada = os.getenv("CONSOLIDADO_PATH", "consolidado.bib")
    archivo_salida = os.getenv("PRIMEROS_500", "primeros_500.bib")
    
    # Verificar que el archivo de entrada existe
    if not os.path.exists(archivo_entrada):
        print(f"✗ Error: No se encuentra el archivo de entrada '{archivo_entrada}'")
        print(f"   Asegúrate de que la variable CONSOLIDADO_PATH esté configurada en el archivo .env")
        exit(1)
    
    print(f"📖 Archivo de entrada: {archivo_entrada}")
    print(f"💾 Archivo de salida: {archivo_salida}")
    
    # Extraer los primeros 500 elementos
    extraer_primeros_n_elementos(archivo_entrada, archivo_salida, n=500)