# 5miniloganalizer - Variante B
**Estudiante:** Pablo Angel Cuevas Marquez  
**Materia:** Lenguajes de Interfaz  
**Profesor:** Rene Solis Reyes

## Descripción de la Actividad
Este proyecto consiste en un analizador de logs desarrollado en **ARM64 Assembly**. El programa procesa archivos de texto para extraer métricas de estado del sistema mediante la manipulación de datos a bajo nivel.

### Variante B
El objetivo de esta variante es realizar el **conteo de niveles de log**. El programa debe identificar cuántas veces aparecen los siguientes identificadores en el archivo:
- `INFO`
- `DEBUG`
- `WARNING`
- `ERROR`
- `CRITICAL`

## Lógica de Solución (Algoritmo)
Para resolver la variante B, se implementará el siguiente flujo en Assembly:

1. **Gestión de Archivos:** Uso de la syscall `openat` (X8 = 56) para obtener el File Descriptor del dataset.
2. **Procesamiento de Búfer:** Lectura del archivo en bloques de memoria para optimizar el rendimiento y minimizar accesos a disco.
3. **Análisis de Patrones:** - Recorrido del búfer byte por byte comparando valores ASCII.
   - Identificación de etiquetas mediante comparaciones de cadenas (String Comparison).
   - Uso de registros de propósito general como contadores dedicados para cada nivel.
4. **Salida de Resultados:** Conversión de los contadores (binario) a caracteres legibles (ASCII) para desplegar los totales en la terminal mediante la syscall `write` (X8 = 64).

## Datos de Prueba
Se ha generado un archivo de 1,000 registros mediante **Mockaroo**, configurado específicamente para simular una carga de trabajo real con niveles de severidad y mensajes de sistema aleatorios, facilitando el poder validar los contadores.
