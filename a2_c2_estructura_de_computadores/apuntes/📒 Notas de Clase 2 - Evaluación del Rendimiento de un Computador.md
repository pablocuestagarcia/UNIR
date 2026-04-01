
_Diseño de Compiladores / Arquitectura de Computadores_

---

## 📢 ANUNCIOS Y AVISOS DEL PROFESOR

- **Corrección sobre los apuntes de clase:** El profesor se disculpa por una información errónea previa. Los apuntes subidos a la plataforma **no están actualizados** y hacen referencia a un manual externo que **no es obligatorio consultar**. El material de estudio suficiente son las **presentaciones de clase**.
- **Presentación del Tema 2 actualizada:** Si ya te la habías descargado, descárgala de nuevo, pues contenía información desactualizada sobre la organización de grupos.
- **Primer taller:** Viernes **20 de marzo, a las 17:00 (hora de Madrid)**. Duración: 90 minutos. Habrá 4 talleres en total.
- **Actividad Grupal (Actividad 1):** Fecha límite de entrega — **6 de abril**. Vale 3–4 puntos sobre 15 de la evaluación continua.
- **Sesión con límite de tiempo:** El profesor tenía otra sesión a las 20:00, por lo que no pudo terminar el tema completo. Se retomará la semana siguiente.

---

## ⚠️ NOTAS IMPORTANTES (Posible material de examen)

> ⚠️ **La métrica más fiable para comparar rendimiento de procesadores es el _tiempo de CPU_**, no los MIPS ni los MEGAFLOPs. Usar instrucciones por segundo puede ser engañoso si los juegos de instrucciones son diferentes.

> ⚠️ **Ecuación fundamental del rendimiento:** $$T_{CPU} = N_i \times CPI \times T_{ciclo} = \frac{N_i \times CPI}{f}$$ Donde $N_i$ = número de instrucciones ejecutadas, $CPI$ = ciclos por instrucción (promedio), $T_{ciclo}$ = duración de un ciclo de reloj, $f$ = frecuencia de reloj.

> ⚠️ **El número de instrucciones ejecutadas ≠ instrucciones del programa.** Los bucles y saltos hacen que el procesador ejecute más (o menos) instrucciones de las que hay escritas en memoria.

> ⚠️ **"Instrucciones" siempre se refiere a instrucciones de ensamblador**, no a líneas de código fuente. Una línea en C puede generar 3, 14 o más instrucciones de ensamblador.

> ⚠️ **El CPI promedio se calcula ponderando** el CPI de cada tipo de instrucción por su frecuencia de aparición en el programa. Depende tanto del procesador como de la carga del programa.

> ⚠️ **Tiempo de ciclo e inverso de frecuencia:** $T_{ciclo} = \frac{1}{f}$. Si $f = 1,\text{MHz} = 10^6,\text{Hz}$, entonces $T_{ciclo} = 10^{-6},\text{s} = 1,\mu\text{s}$.

---

## 🎯 ACTIVIDADES Y EJERCICIOS

### Actividad Grupal — Actividad 1

- **Descripción:** Tres ejercicios en grupo (3–5 estudiantes):
    1. Comparativa de rendimiento con métricas básicas.
    2. Ejercicios de **Ley de Amdahl**.
    3. Introducción a la **jerarquía de memoria y caché** (un solo nivel).
- **Objetivo de aprendizaje:** Aplicar las métricas de rendimiento vistas en el Tema 2; practicar tipos de ejercicios del examen.
- **Deadline:** 6 de abril.
- **Notas:** Grupos de 3 a 5 estudiantes. Hay que inscribirse siguiendo el proceso indicado por el coordinador (se envió correo). Entrega individual solo permitida si los compañeros abandonan el grupo tras haberse formado.

### Taller 1

- **Descripción:** Problemas muy similares a los de la Actividad 1 y al examen.
- **Objetivo de aprendizaje:** Reforzar los conceptos de rendimiento con ejercicios prácticos guiados.
- **Fecha:** Viernes 20 de marzo, 17:00 (Madrid).

---

## 📚 CONTENIDO DE LA CLASE

### Perspectivas para medir el rendimiento de un computador

**Explicación accesible:** No existe una única forma de medir qué tan rápido es un computador. Según lo que nos interese estudiar, nos fijamos en distintos componentes:

- **Organización de la memoria:** latencia, ancho de banda, escalabilidad.
- **El computador como sistema:** tiempo de respuesta, productividad (throughput), funcionalidades.
- **El procesador:** instrucciones, ciclos de reloj, frecuencia.

---

### Latencia vs. Ancho de Banda

**Explicación accesible:** Son dos formas distintas de medir el "rendimiento" de una comunicación o acceso a memoria, y a menudo se confunden.

- **Latencia:** tiempo que transcurre desde que se solicita un dato hasta que se recibe. Es crítica en aplicaciones interactivas (SSH, videollamadas, control remoto).
- **Ancho de banda (throughput de datos):** cantidad de datos transmitidos por unidad de tiempo (bits/s o bytes/s). Importa más cuando hay transferencias masivas unidireccionales (streaming de vídeo 4K, entrenamiento de modelos).

**Ejemplo práctico — el burro con discos duros:** Un burro que transporta terabytes de datos tarda 10 minutos en recorrer 1 km (latencia altísima), pero su promedio de datos enviados por segundo puede ser enorme. Alta latencia no implica bajo ancho de banda.

**Conexión con otros temas:** La latencia de memoria principal vs. caché será central en el tema de jerarquía de memoria.

---

### Escalabilidad de la memoria RAM

**Explicación accesible:** Cuando ampliamos la RAM conectando varios módulos, podemos hacerlo de dos formas:

- **En serie (conexión en profundidad):** aumentamos el **número de palabras** (más posiciones de memoria), manteniendo el mismo tamaño de palabra.
- **En paralelo:** aumentamos el **tamaño de la palabra** (más bits por posición), manteniendo el número de posiciones.

**Ejemplo práctico:** 4 módulos de $2^{14}$ palabras de 8 bits cada uno:

- En serie → $2^{16}$ palabras de 8 bits.
- En paralelo → $2^{14}$ palabras de 32 bits.

---

### Tiempo de CPU vs. Tiempo de Respuesta

**Explicación accesible:** El tiempo de respuesta es todo lo que percibe el usuario (incluyendo esperas de red, disco, teclado, otros procesos). El **tiempo de CPU** es solo el tiempo que el procesador dedicó a ejecutar _nuestro_ programa. Para comparar procesadores, nos quedamos solo con el tiempo de CPU, aislando los demás factores.

**¿Por qué descartamos E/S y otros procesos?** No porque sean insignificantes, sino para poder comparar CPUs de forma justa, en condiciones controladas (programa monohilo, sin interferencias externas).

---

### Productividad (Throughput) y Funcionalidades

- **Throughput:** tareas completadas por unidad de tiempo. Relevante para administradores de centros de datos; puede no reflejar la experiencia de un usuario individual.
- **Funcionalidades:** características del software; relevante para comparar aplicaciones, no procesadores. En esta asignatura se asume siempre el mismo código fuente.

---

### Ecuación Fundamental del Rendimiento

**Explicación accesible:** El tiempo que tarda la CPU en ejecutar un programa depende de tres factores multiplicados entre sí:

$$T_{CPU} = N_i \times CPI \times T_{ciclo}$$

|Factor|Qué mide|Depende de...|
|---|---|---|
|$N_i$|Instrucciones ejecutadas|Programa, repertorio ISA, compilador|
|$CPI$|Ciclos por instrucción (promedio)|ISA, compilador, organización hardware|
|$T_{ciclo}$|Duración de un ciclo de reloj|Tecnología, organización hardware|

**Formalización:** $$T_{CPU} = \frac{N_i \times CPI}{f} \qquad \text{donde } T_{ciclo} = \frac{1}{f}$$

**Ejemplo práctico:** Si $f = 1,\text{GHz}$, $N_i = 10^9$ instrucciones y $CPI = 2$: $$T_{CPU} = \frac{10^9 \times 2}{10^9} = 2,\text{segundos}$$

**Conexión con otros temas:** Esta ecuación es la base para analizar la mejora que introduce el pipeline (reduce CPI hacia 1 en condiciones ideales) y la caché (reduce ciclos de parada).

---

### CPI Promedio en Arquitecturas CISC

**Explicación accesible:** En procesadores CISC, instrucciones distintas consumen distintos ciclos (una suma puede costar 4 ciclos, una división 16). Para calcular un CPI representativo, se hace una **media ponderada**:

$$CPI_{prom} = \frac{\sum_{i} (CPI_i \times n_i)}{N_i}$$

Donde $CPI_i$ es el coste en ciclos del tipo de instrucción $i$, y $n_i$ es cuántas veces aparece en el programa.

> El CPI promedio depende de la carga del programa, no solo del procesador. Un programa sin divisiones tendrá un CPI menor.

---

### RISC vs. CISC — Implicaciones en rendimiento

**Explicación accesible:**

- **RISC:** instrucciones simples, coste uniforme en ciclos, ideal para pipeline. Puede requerir más instrucciones para hacer la misma tarea.
- **CISC:** instrucciones complejas (ej. sumar dos datos en memoria y guardar resultado en memoria en una sola instrucción), pero CPI mayor y variable, lo que complica el pipeline.

La métrica que resuelve esta comparación no son los MIPS sino el **tiempo de CPU**, que integra todos los factores.

---

### Métricas derivadas: MIPS y MEGAFLOPs

**Explicación accesible:** Son métricas históricas de uso frecuente, pero con limitaciones importantes.

**MIPS** (Millones de Instrucciones Por Segundo): $$MIPS = \frac{N_i}{T_{CPU} \times 10^6} = \frac{f}{CPI \times 10^6}$$

⚠️ Limitación: no sirve para comparar procesadores con ISA distintas (una instrucción RISC hace menos trabajo que una CISC).

**MEGAFLOPs** (Millones de Operaciones en Punto Flotante Por Segundo): solo cuenta operaciones de punto flotante. Para ser justos, se usan **MEGAFLOPs normalizados**, asignando pesos distintos según la complejidad:

|Operación|Peso ejemplo|
|---|---|
|Suma / Resta|1|
|Multiplicación|2|
|División|4|
|Trigonométricas|> 4|

**Conexión con otros temas:** Estos conceptos reaparecen al comparar procesadores en los ejercicios de la Actividad 1 y el examen.

---

### Introducción al CPI real con caché (adelanto)

🔍 _[Explicación breve al final de clase, pendiente de desarrollo completo en el tema de jerarquía de memoria]_

El profesor adelantó que: $$CPI_{real} = CPI_{ideal} + \text{ciclos de parada por fallos de caché}$$

Un **fallo de caché** ocurre cuando el dato buscado no está en la caché y hay que ir a memoria principal, lo cual cuesta muchos ciclos adicionales. Cuando hay un fallo, se carga un **bloque completo** desde memoria principal a caché (aprovechando el principio de localidad espacial).

---

## 🗺️ DIAGRAMA — Factores que afectan a cada componente del rendimiento---

## 📝 RESUMEN EJECUTIVO

1. **La métrica fundamental de rendimiento es el tiempo de CPU** — no los MIPS ni los MEGAFLOPs, que pueden llevar a conclusiones erróneas al comparar procesadores con juegos de instrucciones distintos.
    
2. **Ecuación clave:** $T_{CPU} = N_i \times CPI \times T_{ciclo}$. Cada factor está influenciado por el programa, el compilador, la arquitectura ISA y la tecnología hardware.
    
3. **"Instrucciones" siempre significa instrucciones de ensamblador**, no líneas de código fuente. Los bucles y saltos condicionales hacen que el número de instrucciones ejecutadas difiera del tamaño del programa en memoria.
    
4. **El CPI promedio se calcula ponderando** el coste en ciclos de cada tipo de instrucción por su frecuencia de uso. Depende tanto del procesador como de la carga del programa, no solo del hardware.
    
5. **RISC vs. CISC:** RISC tiene instrucciones simples y CPI uniforme (ideal para pipeline); CISC tiene instrucciones complejas con CPI variable (más difícil de segmentar). El tiempo de CPU es el árbitro final entre ambos, no los MIPS.
    
6. **Latencia ≠ ancho de banda:** son métricas ortogonales. Una puede ser alta mientras la otra es baja. La latencia importa en interactividad; el ancho de banda, en transferencias masivas.
    
7. **Los MEGAFLOPs normalizados** ponderan operaciones de punto flotante según su complejidad (÷ > × > ±) para comparar procesadores de forma más justa en cargas científicas.
    
8. **Próxima extensión de la ecuación:** $CPI_{real} = CPI_{ideal} + \text{penalizaciones por fallos de caché}$ — se desarrollará en el tema de jerarquía de memoria.