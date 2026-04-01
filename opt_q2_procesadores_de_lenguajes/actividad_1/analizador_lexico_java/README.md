# Laboratorio 1 — Analizador Léxico para el lenguaje Pocket

## Estructura del proyecto

```
analizador_lexico_java/
│
├── lib/
│   ├── jflex-full-1.9.1.jar          → Herramienta generadora del analizador léxico
│   └── java-cup-11b-20160615.jar     → Generador de parsers (se usará en Lab 2)
│
├── src/
│   
│
├── test/
│   ├── entrada1.txt                  → Todos los tokens válidos de Pocket
│   ├── entrada2.txt                  → Caso con error: identificador demasiado largo
│   ├── entrada3.txt                  → Caso con error: símbolo no permitido
│   ├── salida1_esperada.txt          → Salida correcta para entrada1 (referencia)
│   ├── salida2_esperada.txt          → Salida correcta para entrada2 (referencia)
│   └── salida3_esperada.txt          → Salida correcta para entrada3 (referencia)
│
└── README.md                         → Este fichero
```

---

## ¿Qué hace cada herramienta?

### JFlex
Toma un fichero `.flex` (la "receta" con las reglas léxicas) y genera automáticamente
una clase Java que implementa el analizador léxico. Esa clase contiene un método
`yylex()` que devuelve el siguiente token cada vez que se le llama.

**No se edita el `.java` generado nunca.** Si hay que cambiar algo, se cambia el `.flex`
y se vuelve a generar.

---

## Cómo generar el analizador léxico (ejecutar JFlex)

JFlex está configurado como herramienta externa en IntelliJ. Para usarlo:

1. Abre el fichero `.flex` que quieras procesar (`EjemploLexico.flex` o `AnalizadorLexico.flex`)
2. Ve al menú: `Tools → External Tools → Generar con JFlex`
3. IntelliJ ejecutará:
   ```
   java -jar lib\jflex-full-1.9.1.jar src\<fichero>.flex
   ```
4. El fichero `.java` correspondiente aparecerá en `src/`

> Si ves el error `Cannot run program ... CreateProcess error=193`, el campo **Program**
> del External Tool está mal. Debe ser `$JDKPath$\bin\java`, no el JAR directamente.

---

## Cómo ejecutar el Ejemplo Básico

El ejemplo reconoce números, operadores (`+ - * /`) y paréntesis en expresiones
aritméticas. Es el punto de partida para entender JFlex antes de abordar Pocket.

**Paso 1 — Generar el lexer del ejemplo:**
Abre `EjemploLexico.flex` → `Tools → External Tools → Generar con JFlex`
Aparecerá `EjemploLexico.java` en `src/`

**Paso 2 — Compilar:**
`Build → Build Project`

**Paso 3 — Ejecutar:**
Clic derecho en `EjemploMain.java` → `Run 'EjemploMain'`

**Entrada** (hardcodeada en `EjemploMain.java`):
```
3 + 4 * (2 - 1)
```

**Salida esperada en consola:**
```
=== Entrada ===
3 + 4 * (2 - 1)

=== Tokens reconocidos ===
NUMERO        : 3
SUMA          : +
NUMERO        : 4
MULTIPLICACION: *
PAREN_IZQ     : (
NUMERO        : 2
RESTA         : -
NUMERO        : 1
PAREN_DER     : )

=== Análisis completado ===
```

---

## Cómo ejecutar el Analizador de Pocket

El analizador de Pocket reconoce todos los tokens del lenguaje: palabras reservadas,
operadores, identificadores y constantes. Detecta dos tipos de error léxico.

**Paso 1 — Generar el lexer de Pocket:**
Abre `AnalizadorLexico.flex` → `Tools → External Tools → Generar con JFlex`
Aparecerá `AnalizadorLexico.java` en `src/`

**Paso 2 — Compilar:**
`Build → Build Project`

**Paso 3 — Ejecutar (pendiente de implementar Main.java):**
El programa recibe dos argumentos: fichero de entrada y fichero de salida.
```
java Main test\entrada1.txt salida_obtenida.txt
```
Después se compara `salida_obtenida.txt` con `test\salida1_esperada.txt`.

---

## Formato de salida esperado

**Token válido** — una línea por token, nombre y lexema separados por tabulador:
```
TOK_MAIN	main
TOK_INT		int
TOK_IDENTIFICADOR	x
```

**Error léxico** — mensaje por `stderr`, el análisis se detiene:
```
****ERROR MORFOLÓGICO EN [lin 8, col 4]: IDENTIFICADOR DEMASIADO LARGO (x0123...)
****ERROR MORFOLÓGICO EN [lin 8, col 4]: simbolo no permitido (&)
```

> `lin` y `col` usan numeración **base 0** (como las devuelve JFlex internamente).

---

## Tokens del lenguaje Pocket

| Categoría | Ejemplos |
|-----------|---------|
| Palabras reservadas | `TOK_MAIN`, `TOK_INT`, `TOK_IF`, `TOK_WHILE`... |
| Operadores 2 chars | `TOK_AND (&&)`, `TOK_OR (\|\|)`, `TOK_IGUAL (==)`... |
| Operadores 1 char | `TOK_MAS (+)`, `TOK_PUNTOYCOMA (;)`, `TOK_LLAVEIZQUIERDA ({)`... |
| Identificadores | `TOK_IDENTIFICADOR` — máx. 100 caracteres |
| Constantes | `TOK_CONSTANTE_ENTERA`, `TOK_TRUE`, `TOK_FALSE` |
