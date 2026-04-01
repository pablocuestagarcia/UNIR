
**Tema 3 (final): Memoria Caché · Tema 4 (inicio): Memoria Virtual**

---

## 📢 ANUNCIOS Y AVISOS DEL PROFESOR

- **Taller del viernes pasado:** Se resolvieron ejercicios de memoria caché. Si no pudiste asistir, ve la grabación — _son ejercicios que caen en el examen_.
- **Actividades:** La Actividad 1 tiene cuentas pero son sencillas; los ejercicios se repiten bastante. En el tema de paralelismo habrá ejercicios numéricos distintos, pero también simples (sumar y dividir).
- **Calculadora en examen:** Se puede usar calculadora en el examen.
- **Gestión de grupos:** Si tienes problemas con la asignación de grupos, contacta con tu mentora — los grupos los gestiona el coordinador académico, no el profesor.
- **Semana Santa:** Es probable que la semana siguiente no haya clase. Se confirmará. ¡Buen descanso!

---

## ⚠️ NOTAS IMPORTANTES (Posible material de examen)

> ⚠️ **Funciones de correspondencia (mapeo directo, completamente asociativo, asociativo por conjuntos):** el profesor indica explícitamente que _"esto es pregunta de examen"_ y que _"son preguntas teóricas"_. Hay que saber describirlas, diferenciarlas y saber cuándo se necesita algoritmo de sustitución.

> ⚠️ **Políticas de escritura (Write-Through vs. Copy-Back/Write-Back):** el profesor enfatiza que _"es importante conocer las dos diferencias"_. Saber nombrarlas correctamente (son sinónimos: Copy-Back = Write-Back).

> ⚠️ **Dirty Bit:** concepto clave asociado al Copy-Back. Hay que saber qué es y para qué sirve.

> ⚠️ **Fórmula del tiempo de CPU con fallos de caché:** desarrollada en el taller. Hay que saber calcularla diferenciando accesos a memoria de instrucciones y de datos.

---

## 🎯 ACTIVIDADES Y EJERCICIOS

- **Taller 1 (ya realizado):** Ejercicios prácticos de memoria caché, incluyendo cálculo de tiempo de CPU con fallos. Ver la grabación si no se asistió.
- **Actividad 1 (en curso):** Ejercicios numéricos sobre jerarquía de memoria. El profesor los describe como asequibles; los patrones se repiten.

---

## 📚 CONTENIDO DE LA CLASE

---

### Función de Correspondencia

**Explicación accesible:** Cuando se va a cargar un bloque desde memoria principal a caché, hay que decidir _en qué línea de caché se guarda_. Esa regla de decisión es la función de correspondencia. Hay tres variantes, cada una con un equilibrio distinto entre simplicidad y flexibilidad.

---

#### Mapeo Directo

**Explicación accesible:** Cada bloque de memoria principal tiene _una única línea posible_ en caché. Es como tener taquillas numeradas: el bloque 5 siempre va a la taquilla 5 (o a la que le corresponda por módulo). No hay elección.

**Formalización:**

$$\text{Línea} = j \mod n$$

donde $j$ es el número de bloque en memoria principal y $n$ es el número de líneas de caché.

**Ejemplo práctico:** Si la caché tiene 4 líneas (0–3), el bloque 0 → línea 0, bloque 4 → línea 0, bloque 5 → línea 1, bloque 8 → línea 0, etc. Es un patrón cíclico.

**¿Necesita algoritmo de sustitución?** No. El bloque solo puede ir a un sitio; simplemente sobrescribe lo que haya (aplicando Copy-Back si procede).

**Ventaja:** Muy sencillo y rápido de implementar en hardware.  
**Desventaja:** Dos bloques que mapean a la misma línea son mutuamente excluyentes, lo que puede generar más fallos de conflicto.

---

#### Mapeo Completamente Asociativo

**Explicación accesible:** Cualquier bloque puede ir a cualquier línea de caché. Máxima flexibilidad, como un parking sin plazas asignadas.

**¿Necesita algoritmo de sustitución?** Sí, obligatoriamente. Cuando la caché está llena, hay que decidir qué línea reemplazar.

**Algoritmos de sustitución mencionados:**

|Algoritmo|Descripción|Observaciones|
|---|---|---|
|**LRU** _(Least Recently Used)_|Elimina la línea usada hace más tiempo|Óptimo conceptualmente, difícil de implementar en hardware|
|**Pseudo-LRU**|Aproximación con árboles binarios|Más fácil de implementar; no siempre elige el más antiguo, pero funciona bien|
|**LFU** _(Least Frequently Used)_|Elimina la menos frecuentada|Problema: puede retener bloques muy usados en el pasado pero ya irrelevantes|
|**FIFO**|Elimina el que entró primero|Simple, no considera frecuencia de uso reciente|
|**Aleatorio** _(Random)_|Sustitución al azar|Sorprendentemente aceptable en la práctica; muy fácil de implementar|

> 💡 **Heurística vs. algoritmo exacto:** El profesor distingue entre algoritmos que _garantizan_ el óptimo y heurísticas (como Pseudo-LRU) que _casi siempre_ funcionan bien pero sin garantía formal. Muchos algoritmos de sustitución son heurísticas deterministas.

**Ventaja:** Minimiza fallos de conflicto.  
**Desventaja:** Más costoso en hardware; requiere algoritmo de sustitución complejo.

---

#### Mapeo Asociativo por Conjuntos _(Set-Associative)_

**Explicación accesible:** Es el punto medio. Los bloques no van a una línea única (como en directo) ni a cualquier línea (como en asociativo completo). Cada bloque puede ir a _un conjunto determinado_, y dentro de ese conjunto se aplica mapeo completamente asociativo.

**Formalización:**

$$\text{Conjunto} = j \mod k$$

donde $k$ es el número de conjuntos. Dentro del conjunto (que puede tener 2, 4, 8… líneas), se aplica un algoritmo de sustitución.

**Ejemplo práctico:** Si hay 4 conjuntos de 2 líneas cada uno, el bloque 0 solo puede ir al conjunto 0 (en cualquiera de sus 2 líneas), el bloque 4 también solo al conjunto 0, etc.

**¿Necesita algoritmo de sustitución?** Solo dentro del conjunto.

**Conexión con otros temas:** Es el esquema usado en cachés reales de procesadores modernos (L1, L2, L3 suelen ser asociativas por conjuntos de distinto grado).

---

### Políticas de Escritura

**Explicación accesible:** Cuando se modifica un dato en caché, ¿cuándo se actualiza en memoria principal? Hay dos enfoques:

**Write-Through (escritura inmediata):** Cada vez que se escribe en caché, se escribe también simultáneamente en memoria principal.

- ✅ Memoria principal siempre consistente.
- ❌ Lento: no se aprovecha la velocidad de caché para escrituras.

**Copy-Back / Write-Back (escritura diferida):** Se escribe solo en caché y se activa el **Dirty Bit** (bit especial en el directorio de caché). Solo cuando esa línea va a ser reemplazada, se copia el bloque modificado a memoria principal.

- ✅ Mucho más eficiente: solo se penaliza al sustituir.
- ❌ La memoria principal puede estar temporalmente desactualizada.

> 🔑 **Dirty Bit:** Es un bit en el directorio de la caché que se pone a `1` cuando una línea ha sido modificada. El módulo de gestión de memoria lo consulta antes de reemplazar una línea.

---

### Mejora de Prestaciones de la Caché

**Explicación accesible:** Hay tres palancas principales, todas con un coste asociado:

**1. Aumentar el tamaño de la caché:** Más líneas → menos fallos. Pero memorias más grandes tienen mayor latencia (más transistores, más distancia eléctrica). Hay un óptimo.

**2. Aumentar la asociatividad:** Pasar de mapeo directo a asociativo por conjuntos reduce fallos de conflicto, pero el hardware de decisión es más complejo → mayor latencia en aciertos.

**3. Aumentar el tamaño del bloque/línea:** Bloques más grandes aprovechan mejor la localidad espacial (si recorro un array, cargo más elementos de golpe). Pero si el bloque es demasiado grande: mayor latencia en cada fallo, y menos bloques distintos caben en caché → posibles más fallos.

---

### Jerarquía Multinivel de Caché (L1, L2, L3)

**Explicación accesible:** Como no hay una caché que sea a la vez rápida _y_ grande, se usan varios niveles en cascada. Cada nivel es más grande, más lento y más alejado del procesador.

**Estructura típica en un procesador moderno:**

```
Núcleo A               Núcleo B
  ├── L1-I (instrucciones)    ├── L1-I
  ├── L1-D (datos)            ├── L1-D
  └── L2 (unificada)          └── L2 (unificada)
           └────── L3 compartida ──────┘
                        │
                   Memoria RAM
```

- **L1:** La más pequeña y rápida. Separada en datos e instrucciones. Privada por núcleo.
- **L2:** Unificada, más grande, algo más lenta. Privada por núcleo.
- **L3:** La más grande de las cachés. Compartida por todos los núcleos. Tecnología: SRAM estática.

**Principio:** Los datos más frecuentemente accedidos "suben" hacia L1; los menos frecuentes "bajan" hacia L3 o RAM.

---

### Fórmula del Tiempo de CPU con Fallos de Caché

**Formalización:**

$$T_{CPU} = (\text{Ciclos de ejecución} + \text{Ciclos de parada por memoria}) \times T_{ciclo}$$

Los ciclos de parada se descomponen en accesos a **memoria de instrucciones** y a **memoria de datos**:

$$\text{Ciclos de parada} = N_{instr} \times \text{Tasa de fallos} \times \text{Penalización por fallo}$$

Con Write-Through, las escrituras añaden un término adicional por el **buffer de escritura**, aunque en los ejercicios suele considerarse despreciable.

> 💡 En arquitecturas RISC (como DLX), solo las instrucciones `LOAD` y `STORE` generan accesos a memoria de datos. El resto opera exclusivamente en registros.

---

### Memoria Virtual — Introducción

**Explicación accesible:** La memoria virtual es un mecanismo del sistema operativo (en cooperación con la **MMU**, Memory Management Unit) que hace creer a cada programa que dispone de un espacio de memoria propio y contiguo, cuando en realidad ese espacio está repartido entre RAM y disco.

**¿Para qué sirve?**

**1. Ampliar la memoria disponible:** Si tienes 8 GB de RAM pero varios procesos necesitan más, parte de los datos se guarda en disco (partición swap en Linux, archivo de paginación en Windows). La RAM actúa como caché del disco.

**2. Reubicación:** Un programa no sabe en tiempo de compilación en qué dirección física de RAM va a ejecutarse. Trabaja con **direcciones virtuales (lógicas)**; la MMU las traduce a **direcciones físicas** en tiempo de ejecución.

**3. Protección:** Cada proceso solo puede acceder a su propio espacio de direcciones. Intentar escribir fuera provoca un _segmentation fault_ (core dump). Esto evita corrupciones entre procesos e inyección de código malicioso. Se implementa mediante **modos de ejecución** (modo usuario vs. modo protegido/kernel).

**4. Compartición:** Las librerías dinámicas (`.dll` en Windows, `.so` en Linux) se cargan una sola vez en memoria y se comparten entre todos los procesos que las usan (enlazado dinámico), a diferencia del enlazado estático, que duplica el código en cada ejecutable.

**Conceptos mencionados:**

- **Paginación:** Mecanismo dinámico (en tiempo de ejecución) gestionado por el SO para cargar/descargar páginas de memoria según se necesiten. Es el overlay moderno.
- **TLB** _(Translation Lookaside Buffer):_ Una caché especializada dentro de la MMU que almacena traducciones recientes de dirección virtual → física para acelerarlas.
- **Overlay:** Técnica antigua (usada en microcontroladores) donde el propio programa gestiona manualmente qué páginas carga en RAM.
- **Heap (montón):** Zona de memoria dinámica (`malloc`/`new`). En lenguajes con GC (Java, Python), el recolector de basura libera automáticamente lo que ya no se referencia.

---

## 🗺️ DIAGRAMA — Jerarquía de Memoria Completa

```
┌─────────────────────────────────────────────────────┐
│                   PROCESADOR                        │
│  ┌──────────┐  ┌──────────┐                         │
│  │ Registros│  │ Registros│   ← más rápido, más caro│
│  └────┬─────┘  └────┬─────┘                         │
│  ┌────▼─────┐  ┌────▼─────┐                         │
│  │L1-I L1-D │  │L1-I L1-D │                         │
│  └────┬─────┘  └────┬─────┘                         │
│  ┌────▼─────┐  ┌────▼─────┐                         │
│  │    L2    │  │    L2    │                         │
│  └────┬─────┘  └────┬─────┘                         │
│       └──────┬───────┘                              │
│         ┌────▼─────┐                                │
│         │    L3    │  ← compartida por todos        │
│         └────┬─────┘                                │
└──────────────┼──────────────────────────────────────┘
          ┌────▼──────┐
          │ Memoria   │  RAM (DRAM)
          │ Principal │
          └────┬──────┘
          ┌────▼──────┐
          │  Memoria  │  Disco SSD/HDD (swap)
          │ Secundaria│  ← más lento, más barato
          └───────────┘
```

---

## 📝 RESUMEN EJECUTIVO

1. **Funciones de correspondencia** (⚠️ examen): mapeo directo (`j mod n`, sin sustitución), completamente asociativo (máxima flexibilidad, requiere algoritmo de sustitución) y asociativo por conjuntos (punto medio: módulo para el conjunto, asociativo dentro).
    
2. **Algoritmos de sustitución** (solo necesarios en caché asociativa): LRU es el más intuitivo pero difícil de implementar en hardware; Pseudo-LRU con árboles binarios es el más común; también existen FIFO, LFU y aleatorio.
    
3. **Políticas de escritura** (⚠️ examen): Write-Through escribe siempre en RAM (lento pero consistente); Copy-Back/Write-Back solo escribe en RAM al reemplazar la línea, usando el Dirty Bit para señalizar líneas modificadas.
    
4. **Mejora de prestaciones** implica un equilibrio: más capacidad reduce fallos pero aumenta latencia; más asociatividad reduce conflictos pero complica el hardware; bloques más grandes aprovechan localidad espacial pero tienen un tamaño óptimo.
    
5. **Jerarquía multinivel (L1–L3):** solución práctica a la tensión velocidad/tamaño. L1 es pequeña y rapidísima (privada por núcleo); L3 es grande y compartida. Todas usan SRAM.
    
6. **Tiempo de CPU** = ciclos de ejecución + ciclos de parada por fallos de caché, multiplicado por el período de reloj. Los ciclos de parada se calculan como `N_instrucciones × tasa_fallos × penalización`.
    
7. **Memoria virtual** no es solo una "extensión de RAM": también permite reubicación (direcciones virtuales → físicas), protección entre procesos (modos usuario/kernel, segmentation fault) y compartición eficiente de librerías (enlazado dinámico).
    
8. **TLB** es la caché de traducciones de la MMU, y la **paginación** es el mecanismo dinámico por el que el SO gestiona qué páginas están en RAM y cuáles en disco — sin que el programa lo sepa.