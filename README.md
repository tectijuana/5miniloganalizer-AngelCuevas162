# Analizador de Logs en ARM64 Assembly (Variante B)
 
**Estudiante:** Pablo Angel Cuevas Marquez  
**Institución:** TecNM Campus ITT (Instituto Tecnológico de Tijuana)  
**Materia:** Lenguajes de Interfaz  
**Profesor:** Rene Solis Reyes  
 
---
 
## Descripción del Proyecto
 
Este proyecto consiste en un programa desarrollado íntegramente en lenguaje ensamblador **ARM64**. El objetivo principal es procesar un dataset de registros (`logs.txt`) generado mediante Mockaroo para identificar y contabilizar la frecuencia de eventos específicos.
 
En esta **Variante B**, el programa está diseñado para filtrar y contar cuántas veces aparece el nivel de log **"ERROR"** dentro del archivo, optimizando el uso de registros de 64 bits para el manejo de contadores y punteros de memoria.
 
---
 
## Tecnologías Utilizadas
 
- **Lenguaje:** ARM64 Assembly (Arquitectura AArch64)
- **Entorno:** Ubuntu Linux (AWS Instance / WSL)
- **Herramientas de desarrollo:**
  - `as` (Assembler)
  - `ld` (Linker)
  - `gdb` con extensión **GEF** (Debugger)
  - `nano` (Editor de texto)
---
 
## Guía de Uso
 
### 1. Preparación del Dataset
 
El archivo de logs debe llamarse exactamente `logs.txt` y encontrarse en el mismo directorio que el código fuente (`main.s`).
 
### 2. Compilación y Enlazado
 
Para generar el ejecutable, se deben correr los siguientes comandos en la terminal:
 
```bash
as -o main.o main.s
ld -o main main.o
```
 
### 3. Ejecución y Debugging
 
Para verificar el funcionamiento interno del programa y el estado de los registros:
 
```bash
gdb ./main
```
 
---
 
## Evidencias de Funcionamiento y Depuración
 
### A. Gestión de Archivos y Rutas
 
Se comprobó mediante el comando `ls` la existencia de los archivos necesarios en el entorno de ejecución de Ubuntu, asegurando que el dataset estuviera disponible para el binario.
 
```bash
ubuntu@ip-172-31-43-110:~$ ls
logs.txt  main  main.o  main.s
```
 
### B. Análisis de Registros (Syscall `openat`)
 
Mediante el uso de GEF (GDB), se realizó un seguimiento paso a paso (instrucción por instrucción) para validar la apertura del archivo.
 
- **Éxito de Apertura:** Tras poner el archivo en sulugar y asegurar la ruta a `logs.txt`, el registro `$x0` mostró el valor `0x3`.
<img width="595" height="463" alt="image" src="https://github.com/user-attachments/assets/afad0982-caf3-4ea2-8103-d698677a6bf4" />

- **Interpretación Técnica:** El valor `3` es el File Descriptor asignado por el Kernel de Linux. Esto confirma que la comunicación entre el programa Assembly y el sistema de archivos es correcta.
  
### C. Ciclo de Lectura (`read_loop`)

Se verificó que el programa entra correctamente en la etiqueta `read_loop`, utilizando la syscall `63` (`read`) para transferir los datos del archivo al búfer de memoria RAM.
 
- **Registro `$x19`:** Almacena el File Descriptor (`3`) para mantener la persistencia del archivo abierto durante el ciclo.
- **Registro `$pc` (Program Counter):** Apunta correctamente a la siguiente instrucción de procesamiento (`mov x0, x19`), demostrando un flujo lógico sin desbordamientos ni bloqueos.
<img width="622" height="477" alt="image" src="https://github.com/user-attachments/assets/f928241a-edb7-4dbe-8c55-bf6038c2a8d2" />

---
 
## Conclusiones
 
El desarrollo de esta práctica permitió comprender la interacción de bajo nivel entre el software y el sistema operativo mediante el uso de Syscalls en arquitectura ARM64.
 
**Puntos clave aprendidos:**
 
1. **Depuración Profunda:** El uso de GDB/GEF fue fundamental para visualizar errores de ruta que no eran visibles en la ejecución normal del binario.
2. **Manejo de Registros:** Se comprendió la importancia de registros como `X0` para capturar resultados de funciones y `X8` para enviar el identificador de la operación al kernel.
3. **Entorno Linux:** La importancia de la concordancia de nombres y la ubicación de archivos en sistemas basados en Unix para evitar errores de ejecución y fallos de segmentación.
