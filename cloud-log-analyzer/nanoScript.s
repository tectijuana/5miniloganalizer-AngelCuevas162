//Pablo Angel Cuevas Marquez 23211943
//23-04-2026
// main.s - Analizador de Logs ARM64
.data
    filename:   .asciz "data/logs.txt"
    buffer:     .fill 1024, 1, 0
    err_count:  .quad 0        // Contador para ERROR

.text
.global _start

_start:
    // 1. Abrir archivo
    mov x0, -100
    ldr x1, =filename
    mov x2, 0
    mov x8, 56
    svc 0
    mov x19, x0             // x19 = file descriptor

read_loop:
    // 2. Leer bloque del archivo
    mov x0, x19
    ldr x1, =buffer
    mov x2, 1024
    mov x8, 63              // syscall read
    svc 0
    
    cbz x0, end_program     // Si leyó 0 bytes, terminar
    mov x20, x0             // x20 = bytes leídos
    ldr x21, =buffer        // x21 = puntero al buffer

parse_buffer:
    ldrb w22, [x21], #1     // Cargar byte y avanzar puntero
    
    // Lógica Variante B: Buscar 'E' de ERROR (ASCII 0x45)
    cmp w22, #0x45          
    b.ne skip_char
    
    // Aquí deberías comparar los siguientes bytes para confirmar "RROR"
    // Si coincide:
    ldr x23, =err_count
    ldr x24, [x23]
    add x24, x24, #1
    str x24, [x23]

skip_char:
    subs x20, x20, #1
    b.gt parse_buffer
    b read_loop

end_program:
    // Cerrar y Salir
    mov x0, x19
    mov x8, 57
    svc 0
    mov x0, 0
    mov x8, 93
    svc 0
