# Actividad 1. Ejercicios sobre prestaciones

## Introducción

En esta actividad se resuelven los tres ejercicios propuestos en el enunciado aplicando los conceptos de prestaciones vistos en clase: MIPS, tiempo de CPU, Ley de Amdahl y penalización por fallos de caché. En todos los apartados se muestran los pasos de cálculo y una breve interpretación de los resultados, ya que el razonamiento es más importante que el simple valor numérico final.

---

## Ejercicio 1

Se desea ejecutar una aplicación en un procesador con dos tipos de instrucción:

- Instrucción 1: `CPI = 3`
- Instrucción 2: `CPI = 2`
- Frecuencia del procesador: `200 MHz`

Los compiladores generan el siguiente código:

| Compilador | Instrucción 1 | Instrucción 2 |
|---|---:|---:|
| A | 6 | 2 |
| B | 4 | 6 |

### 1.1. Cálculo de los MIPS

La expresión de MIPS es:

\[
MIPS = \frac{f}{CPI_{medio} \cdot 10^6}
\]

Como la frecuencia es `200 MHz`, se tiene:

\[
MIPS = \frac{200}{CPI_{medio}}
\]

#### Compilador A

Número total de instrucciones:

\[
N_A = 6 + 2 = 8
\]

Ciclos totales:

\[
C_A = 6 \cdot 3 + 2 \cdot 2 = 18 + 4 = 22
\]

CPI medio:

\[
CPI_A = \frac{22}{8} = 2{,}75
\]

Por tanto:

\[
MIPS_A = \frac{200}{2{,}75} \approx 72{,}73
\]

#### Compilador B

Número total de instrucciones:

\[
N_B = 4 + 6 = 10
\]

Ciclos totales:

\[
C_B = 4 \cdot 3 + 6 \cdot 2 = 12 + 12 = 24
\]

CPI medio:

\[
CPI_B = \frac{24}{10} = 2{,}4
\]

Por tanto:

\[
MIPS_B = \frac{200}{2{,}4} \approx 83{,}33
\]

### 1.2. Comparación usando tiempo de CPU

El período de reloj es:

\[
T_{ciclo} = \frac{1}{200 \cdot 10^6} = 5 \text{ ns}
\]

Entonces:

\[
T_A = 22 \cdot 5 \text{ ns} = 110 \text{ ns}
\]

\[
T_B = 24 \cdot 5 \text{ ns} = 120 \text{ ns}
\]

### 1.3. Comentario de resultados

Aunque el compilador B presenta un valor de MIPS mayor (`83,33 MIPS` frente a `72,73 MIPS`), el compilador A ejecuta el programa en menos tiempo (`110 ns` frente a `120 ns`).

Esto demuestra que los MIPS no siempre son la mejor métrica para comparar soluciones. El compilador B ejecuta más instrucciones por segundo, pero también necesita más instrucciones totales para resolver el mismo problema. Por ello, la métrica realmente válida para comparar ambas opciones es el tiempo de CPU, y según este criterio la mejor opción es el compilador A.

### 1.4. Conclusión

La opción más eficiente es la del compilador A, porque minimiza el tiempo de ejecución total del programa, aunque su tasa de MIPS sea menor.

---

## Ejercicio 2

Un benchmark presenta la siguiente distribución del tiempo de ejecución:

| Tipo de operación | Porcentaje |
|---|---:|
| Multiplicación | 20 % |
| Acceso a memoria | 50 % |
| Resto | 30 % |

Se estudian dos mejoras:

- Opción 1: acelerar `4` veces las multiplicaciones.
- Opción 2: reducir a la mitad el tiempo de acceso a memoria.

Para resolver el ejercicio se aplica la Ley de Amdahl:

\[
S = \frac{1}{(1-F) + \frac{F}{m}}
\]

donde `F` es la fracción afectada y `m` el factor de mejora.

### 2.1. Aceleración si solo se aplica la opción 1

En este caso:

- `F = 0,20`
- `m = 4`

\[
S_1 = \frac{1}{(1-0{,}20) + \frac{0{,}20}{4}}
     = \frac{1}{0{,}80 + 0{,}05}
     = \frac{1}{0{,}85}
     \approx 1{,}18
\]

Por tanto, la aceleración global es:

\[
S_1 \approx 1{,}18
\]

Es decir, el sistema sería aproximadamente `1,18` veces más rápido, o un `17,65 %` más rápido.

### 2.2. Aceleración si solo se aplica la opción 2

Reducir a la mitad el tiempo de acceso a memoria equivale a una mejora de:

\[
m = 2
\]

Como el acceso a memoria representa el `50 %` del tiempo:

- `F = 0,50`
- `m = 2`

\[
S_2 = \frac{1}{(1-0{,}50) + \frac{0{,}50}{2}}
     = \frac{1}{0{,}50 + 0{,}25}
     = \frac{1}{0{,}75}
     \approx 1{,}33
\]

Por tanto:

\[
S_2 \approx 1{,}33
\]

El sistema sería `1,33` veces más rápido, es decir, un `33,33 %` más rápido.

### 2.3. Aceleración si se aplican las dos opciones

Como las mejoras afectan a partes distintas del tiempo de ejecución, se puede aplicar Amdahl considerando ambas fracciones:

\[
S = \frac{1}{\frac{0{,}20}{4} + \frac{0{,}50}{2} + 0{,}30}
\]

\[
S = \frac{1}{0{,}05 + 0{,}25 + 0{,}30}
  = \frac{1}{0{,}60}
  \approx 1{,}67
\]

Por tanto:

\[
S \approx 1{,}67
\]

Esto significa que, aplicando las dos mejoras a la vez, el sistema sería `1,67` veces más rápido, o aproximadamente un `66,67 %` más rápido.

### 2.4. Comentario de resultados

La opción 2 produce más mejora que la opción 1, porque actúa sobre una parte mayor del tiempo total de ejecución (`50 %` frente a `20 %`). Este resultado encaja plenamente con la Ley de Amdahl: conviene optimizar la parte del sistema que más tiempo consume.

Además, incluso aplicando las dos mejoras simultáneamente, la aceleración total no alcanza un valor muy elevado. Esto ocurre porque siempre queda una parte del programa que no se ha mejorado, en este caso el `30 %` correspondiente al resto de operaciones.

### 2.5. Conclusión

La mejora más rentable por separado es la opción 2. Si se aplican ambas mejoras, la aceleración total es de aproximadamente `1,67`, lo que confirma que la mejora global siempre está limitada por la fracción no optimizada.

---

## Ejercicio 3

Datos del enunciado:

- Tasa de fallos de caché de instrucciones: `2 %`
- Tasa de fallos de caché de datos: `4 %`
- `CPI` sin paradas de memoria: `2`
- Penalización por fallo: `100` ciclos
- Frecuencia de instrucciones de carga y almacenamiento: `36 %`

Se pide determinar cuánto más rápido sería un procesador con caché perfecta.

### 3.1. Penalización por fallos de caché de instrucciones

Todas las instrucciones acceden a la caché de instrucciones. Por tanto, los ciclos de parada por instrucción debidos a fallos en dicha caché son:

\[
0{,}02 \cdot 100 = 2
\]

### 3.2. Penalización por fallos de caché de datos

Solo acceden a la caché de datos las instrucciones de carga y almacenamiento, que representan el `36 %`:

\[
0{,}36 \cdot 0{,}04 \cdot 100 = 1{,}44
\]

### 3.3. CPI real

El `CPI` real será el `CPI` base más las penalizaciones por caché:

\[
CPI_{real} = 2 + 2 + 1{,}44 = 5{,}44
\]

Si la caché fuera perfecta, no existirían paradas por fallos, luego:

\[
CPI_{perfecta} = 2
\]

### 3.4. Cálculo de la aceleración

Como el número de instrucciones y el tiempo de ciclo son los mismos en ambos casos, la aceleración se puede calcular como el cociente entre ambos CPI:

\[
S = \frac{CPI_{real}}{CPI_{perfecta}} = \frac{5{,}44}{2} = 2{,}72
\]

### 3.5. Interpretación

Un procesador con caché perfecta sería:

\[
2{,}72 \text{ veces más rápido}
\]

También puede expresarse como una mejora del:

\[
(2{,}72 - 1)\cdot 100 = 172 \%
\]

Es decir, la ausencia total de fallos de caché produciría una mejora muy notable del rendimiento, porque las penalizaciones por acceso a memoria son muy elevadas en comparación con el `CPI` base.

### 3.6. Conclusión

El procesador con caché perfecta sería `2,72` veces más rápido que el procesador original. Este ejercicio pone de manifiesto la importancia de la jerarquía de memoria, ya que una tasa de fallos aparentemente pequeña puede provocar un incremento muy grande del tiempo total de ejecución.

---

## Conclusión general

Los tres ejercicios muestran ideas fundamentales de la evaluación de prestaciones. En primer lugar, el tiempo de CPU es la métrica más fiable para comparar alternativas, por encima de MIPS. En segundo lugar, la Ley de Amdahl demuestra que no basta con mejorar mucho una parte del sistema: lo importante es mejorar la parte que más tiempo consume. Finalmente, el tercer ejercicio confirma que la memoria caché tiene un impacto decisivo en el rendimiento global del procesador, ya que los fallos introducen penalizaciones muy elevadas.
