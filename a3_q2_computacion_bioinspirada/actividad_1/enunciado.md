# Algoritmos de Adaptación Social – Actividad Obligatoria

## 📋 Objetivos

Esta actividad persigue que los estudiantes:

1. **Investiguen** algoritmos de adaptación social (swarm intelligence) NO estudiados en clase mediante búsqueda activa.
2. **Comprendan** la aplicación real de un algoritmo bioinspirado mediante su implementación y ejecución.
3. **Analicen** el comportamiento y rendimiento del algoritmo seleccionado frente a un problema de optimización.
4. **Validen** el funcionamiento mediante pruebas experimentales documentadas.

---

## 📝 Descripción de la Actividad

### Parte 1: Investigación del Algoritmo
Deberás seleccionar un algoritmo de adaptación social que **no haya sido profundizado en clase** y realizar una investigación documentada que incluya:
- Descripción detallada del algoritmo
- Ilustración del concepto mediante figuras o esquemas
- Justificación de la elección del algoritmo

### Parte 2: Implementación y Ejecución
- Buscar o desarrollar una **implementación en MATLAB** del algoritmo
- Aplicarlo a un **problema de optimización concreto**
- Ejecutar el código y generar resultados cuantitativos
- Documentar el funcionamiento mediante gráficas y métricas

### Parte 3: Análisis Crítico
- Evaluar la calidad de las soluciones obtenidas
- Analizar el balance entre **exploración y explotación**
- Discutir convergencia, óptimos locales y comportamiento del algoritmo
- Proponer mejoras fundamentadas

---

## ✅ REQUISITOS TÉCNICOS OBLIGATORIOS

### 🖥️ Software y Lenguaje de Programación

⚠️ **CRÍTICO: USO EXCLUSIVO DE MATLAB**

- El código **DEBE** estar implementado en MATLAB
- Formatos aceptados: archivos `.m` (scripts) o `.mlx` (Live Scripts)
- **NO se aceptan implementaciones en Python, R, JavaScript u otros lenguajes**
- El código debe ser ejecutable directamente sin dependencias externas

### 📁 Convención de Nombres de Archivos

**⚠️ RESTRICCIÓN IMPORTANTE:**
- **Prohibido usar barras bajas (`_`) en los nombres de archivo**
- Usar CamelCase o espacios en su lugar
- Incluir el **nombre completo del estudiante** en todos los archivos

**Ejemplos CORRECTOS:**
- `MiguelGarciaABC.m`
- `Ana Martinez ABC Algorithm.m`
- `CarlosLopezMurcielagos.mlx`

**Ejemplos INCORRECTOS:**
- ~~`Miguel_Garcia_ABC.m`~~ ❌
- ~~`algoritmo_abc.m`~~ ❌
- ~~`code_v2.m`~~ ❌

---

## 📚 ALGORITMOS RECOMENDADOS

Según las notas del curso, estos algoritmos de **adaptación social no vistos en profundidad** son particularmente valorados:

### 1. **ABC – Artificial Bee Colony (Colonia Artificial de Abejas)**
- Inspirado en el comportamiento de forrajeo de abejas melíferas
- Divide población en abejas empleadas, exploradoras y observadoras
- Particularmente eficaz en optimización continua multidimensional

### 2. **Algoritmo del Murciélago (Bat Algorithm)**
- Basado en la ecolocalización de murciélagos
- Combina características de búsqueda local y global
- Versátil para múltiples tipos de problemas

### 3. **Algoritmo de las Luciérnagas (Firefly Algorithm)**
- Simula el comportamiento de bioluminiscencia
- Atracción proporcional al brillo (calidad de solución)
- Excelente rendimiento en espacios multidimensionales

### 4. **Variaciones Propias o Algoritmos Alternativos**
- Se **valorará positivamente** cualquier variación original de un algoritmo estándar
- O la propuesta de otro algoritmo de adaptación social no mencionado
- Ejemplos: Algoritmo de Hormiga, Particle Swarm Optimization mejorado, etc.

---

## 📦 ESTRUCTURA DE ENTREGABLES

### Archivo 1: Código MATLAB Ejecutable

```
NombreApellidoAlgoritmo.m (o .mlx)
```

**Requisitos del código:**

- ✅ Debe ejecutarse directamente sin errores
- ✅ Incluir comentarios explicativos en puntos clave
- ✅ Definir claramente el problema a optimizar
- ✅ Incluir parámetros configurables (población, iteraciones, etc.)
- ✅ Generar salidas visuales (gráficas de convergencia)
- ✅ Mostrar la mejor solución encontrada y su fitness

**Ejemplo de estructura mínima:**
```matlab
% Algoritmo ABC (Colonia Artificial de Abejas)
% Autor: [Tu Nombre Completo]
% Problema: Optimización de función Rastrigin

clear all; close all;

% ========== CONFIGURACIÓN ===========
poblacion = 50;
iteraciones = 500;
% ... resto del código
```

---

### Archivo 2: Memoria Técnica (PDF)

**Nombre:** `NombreApellidoMemoria.pdf`

**Extensión máxima:** 4 páginas

**Formato recomendado:** Word, LaTeX o similar (presentación cuidada)

#### Estructura OBLIGATORIA:

##### **1. Portada e Índice**
- Título: "Algoritmos de Adaptación Social: [Nombre del Algoritmo]"
- Nombre completo del estudiante
- Fecha de entrega
- Grupo/Aula
- Índice con numeración clara

##### **2. Introducción y Descripción del Algoritmo (≈1 página)**
- Fundamento biológico del algoritmo
- Características principales
- Ventajas respecto a otros enfoques
- **Figura o esquema conceptual** del funcionamiento

##### **3. Descripción del Problema (≈0.5 páginas)**
- Problema de optimización seleccionado
- Espacio de búsqueda y restricciones
- Por qué es un buen banco de pruebas para este algoritmo

##### **4. Implementación y Metodología (≈1 página)**

⚠️ **PROHIBIDO:**
- ❌ Pegar código fuente del programa
- ❌ Screenshots del entorno de MATLAB
- ❌ Listados de código formateado

✅ **OBLIGATORIO:**
- Describir mediante **pseudocódigo comentado** tu implementación
- Explicar **decisiones de diseño**:
  - ¿Cómo representas las soluciones? (vectores binarios, reales, etc.)
  - ¿Cómo generas nuevos candidatos/vecinos?
  - ¿Cuál es el criterio de parada?
  - ¿Qué parámetros has ajustado y por qué?

**Ejemplo de pseudocódigo aceptable:**
```
ALGORITMO ABC:
  Inicializar población aleatoria (empleadas + observadoras)
  PARA cada iteración HACER
    Abejas empleadas generan nuevas soluciones cercanas
    Evaluar fitness de nuevas soluciones
    Actualizar si mejora es significativa
    Abejas observadoras seleccionan mejores soluciones
    ...
  FIN PARA
```

##### **5. Resultados Experimentales (≈1 página)**
- **Gráficas de convergencia** (evolución del fitness a lo largo de iteraciones)
- **Tabla con parámetros y resultados numéricos** (mejor solución, tiempo, iteraciones)
- Ejecuciones múltiples si es relevante (mostrar variabilidad)
- Comparación visual del comportamiento

##### **6. Análisis Crítico de Resultados**

**Debes responder explícitamente a las siguientes preguntas:**

1. **¿Son buenos los resultados obtenidos?**
   - Comparar con óptimo teórico (si existe)
   - Evaluar el fitness de la mejor solución
   - Analizar estabilidad entre ejecuciones

2. **¿Son mejorables los resultados?**
   - Identificar limitaciones observadas
   - ¿Converge rápido o lentamente?
   - ¿Cae en óptimos locales?

3. **Análisis de Rendimiento (conceptos del curso):**
   - **Exploración vs. Explotación:** ¿Cómo tu algoritmo balancea buscar nuevas zonas frente a refinar zonas prometedoras?
   - **Óptimos Locales:** ¿El algoritmo tiende a quedar atrapado? ¿Cómo lo mitiga?
   - **Convergencia:** ¿Se estabiliza la solución? ¿En cuántas iteraciones?

4. **¿Cómo se podrían mejorar los resultados?**
   - Ajuste de parámetros fundamentado
   - Modificación del operador de generación de vecinos
   - Introducción de mecanismos anti-estancamiento
   - Hibridación con otras técnicas
   - Propuestas concretas y justificadas

---

## 📊 RÚBRICA DE EVALUACIÓN

| Criterio | Descripción | Puntuación | Peso |
|----------|-------------|-----------|------|
| **Criterio 1** | El algoritmo es de adaptación social, **no visto en profundidad en clase**, y está correctamente documentado | 4 puntos | 40% |
| **Criterio 2** | Implementación MATLAB **correcta y funcional**. Código ejecutable. Resultados válidos y reproducibles | 4 puntos | 40% |
| **Criterio 3** | Documento PDF: estructura completa, sin código pegado, pseudocódigo adecuado, análisis crítico fundamentado, formato cuidado | 2 puntos | 20% |

**Nota total:** Suma ponderada = (Crit.1 × 0.4) + (Crit.2 × 0.4) + (Crit.3 × 0.2)

---

## 🎯 CRITERIOS DE EXCELENCIA (Bonus)

Para obtener máxima puntuación, considera:

✨ **Variación Original:** Proponer una mejora o variante propia del algoritmo
✨ **Problemas Complejos:** Aplicar a un problema de optimización desafiante (con muchas variables, multimodal, etc.)
✨ **Análisis Profundo:** Comparación experimental contra otras metaheurísticas
✨ **Visualizaciones:** Incluir animaciones o gráficas tridimensionales del espacio de búsqueda
✨ **Presentación:** Documento cuidadosamente redactado y formateado

---

## 🔗 Recursos de Referencia

- Algoritmos bioinspirados: artículos en IEEE Xplore o Google Scholar
- Repositorios MATLAB: File Exchange de MathWorks
- Benchmarks de optimización: BBOB (Black-Box Optimization Benchmarking)
- Documentación: notas del curso y referencias bibliográficas

---

## ⏰ Plazos y Entrega

- **Plazo:** [Indicar fecha]
- **Formato de entrega:** Subida a plataforma
- **Archivos a entregar:**
  1. `NombreApellidoAlgoritmo.m` (o `.mlx`)
  2. `NombreApellidoMemoria.pdf`

**Revisa antes de entregar:**
- ✅ Nombres sin barras bajas
- ✅ Código ejecutable sin errores
- ✅ Documento PDF sin código fuente pegado
- ✅ Pseudocódigo claro y comentado
- ✅ Análisis fundamentado y crítico
- ✅ Máximo 4 páginas

---

## ❓ Preguntas Frecuentes

**P: ¿Puedo usar una implementación que encuentre en internet?**
A: Sí, pero debes comprenderla completamente, adaptarla (usarla para tu problema específico) y analizarla. La memoria debe reflejar tu aprendizaje.

**P: ¿Qué pasa si mi código usa barras bajas?**
A: El profesor advirtió que genera problemas de ejecución. Usa CamelCase o espacios.

**P: ¿Puedo incluir un pantallazo del output de MATLAB en el PDF?**
A: No. Sí puedes incluir tablas con números o gráficas (exportadas como figuras), pero no screenshots del editor.

**P: ¿Cuántos párrafos debe tener el análisis de resultados?**
A: No hay mínimo de párrafos, pero debes responder explícitamente a todas las preguntas de la rúbrica. Brevedad y precisión.

**P: ¿Es obligatorio usar uno de los algoritmos recomendados?**
A: No, pero son sugerencias. Cualquier algoritmo de swarm intelligence no visto en clase es válido. Los recomendados son seguros en términos de aceptación.

---

**Última actualización:** Abril 2025  
**Versión:** 2.0 (Actualizada con requisitos explícitos del equipo docente)