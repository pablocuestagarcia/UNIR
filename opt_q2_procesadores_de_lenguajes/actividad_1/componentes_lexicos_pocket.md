# Componentes léxicos del lenguaje Pocket

---

## 1. Palabras reservadas

Las palabras reservadas se reconocen mediante comparación directa con su lexema exacto. En JFlex tienen mayor prioridad que la regla de identificadores al aparecer antes en la especificación.

| Token | Lexema | Expresión regular (JFlex) |
|-------|--------|---------------------------|
| `TOK_MAIN` | `main` | `"main"` |
| `TOK_INT` | `int` | `"int"` |
| `TOK_BOOLEAN` | `boolean` | `"boolean"` |
| `TOK_FLOAT` | `float` | `"float"` |
| `TOK_ARRAY` | `array` | `"array"` |
| `TOK_SET` | `set` | `"set"` |
| `TOK_OF` | `of` | `"of"` |
| `TOK_FUNCTION` | `function` | `"function"` |
| `TOK_MALLOC` | `malloc` | `"malloc"` |
| `TOK_IF` | `if` | `"if"` |
| `TOK_ELSE` | `else` | `"else"` |
| `TOK_WHILE` | `while` | `"while"` |
| `TOK_FOR` | `for` | `"for"` |
| `TOK_SCANF` | `scanf` | `"scanf"` |
| `TOK_PRINTF` | `printf` | `"printf"` |
| `TOK_CPRINTF` | `cprintf` | `"cprintf"` |
| `TOK_FREE` | `free` | `"free"` |
| `TOK_RETURN` | `return` | `"return"` |
| `TOK_SWITCH` | `switch` | `"switch"` |
| `TOK_CASE` | `case` | `"case"` |
| `TOK_DEFAULT` | `default` | `"default"` |
| `TOK_UNION` | `union` | `"union"` |
| `TOK_INTERSECTION` | `intersection` | `"intersection"` |
| `TOK_ADD` | `add` | `"add"` |
| `TOK_CLEAR` | `clear` | `"clear"` |
| `TOK_SIZE` | `size` | `"size"` |
| `TOK_CONTAINS` | `contains` | `"contains"` |
| `TOK_TRUE` | `true` | `"true"` |
| `TOK_FALSE` | `false` | `"false"` |

---

## 2. Operadores y delimitadores

Los operadores de un único carácter se representan directamente con ese carácter entre comillas. Los operadores de dos caracteres requieren ambos en la expresión.

> En JFlex, los caracteres con significado especial en expresiones regulares (`|`, `.`, `*`, `+`, `?`, `(`, `)`, `[`, `]`, `{`, `}`, `^`, `$`, `\`) deben entrecomillarse con `"..."` o escaparse con `\` para tratarlos como literales.

| Token | Lexema | Expresión regular (JFlex) |
|-------|--------|---------------------------|
| `TOK_PUNTOYCOMA` | `;` | `";"` |
| `TOK_COMA` | `,` | `","` |
| `TOK_PARENTESISIZQUIERDO` | `(` | `"("` |
| `TOK_PARENTESISDERECHO` | `)` | `")"` |
| `TOK_LLAVEIZQUIERDA` | `{` | `"{"` |
| `TOK_LLAVEDERECHA` | `}` | `"}"` |
| `TOK_CORCHETEIZQUIERDO` | `[` | `"["` |
| `TOK_CORCHETEDERECHO` | `]` | `"]"` |
| `TOK_ASIGNACION` | `=` | `"="` |
| `TOK_MAS` | `+` | `"+"` |
| `TOK_MENOS` | `-` | `"-"` |
| `TOK_DIVISION` | `/` | `"/"` |
| `TOK_ASTERISCO` | `*` | `"*"` |
| `TOK_DIR` | `&` | `"&"` |
| `TOK_AND` | `&&` | `"&&"` |
| `TOK_OR` | `\|\|` | `"||"` |
| `TOK_NOT` | `!` | `"!"` |
| `TOK_IGUAL` | `==` | `"=="` |
| `TOK_DISTINTO` | `!=` | `"!="` |
| `TOK_MENORIGUAL` | `<=` | `"<="` |
| `TOK_MAYORIGUAL` | `>=` | `">="` |
| `TOK_MENOR` | `<` | `"<"` |
| `TOK_MAYOR` | `>` | `">"` |
| `TOK_PUNTODECIMAL` | `.` | `"."` |

> **Nota de prioridad:** Las reglas de dos caracteres (`&&`, `||`, `==`, `!=`, `<=`, `>=`) deben aparecer **antes** que las de un único carácter (`&`, `|`, `=`, `!`, `<`, `>`) en el fichero `.flex` para evitar que el analizador devuelva dos tokens simples en lugar de uno compuesto.

---

## 3. Identificadores y constantes

### 3.1 Definiciones auxiliares (macros JFlex)

Estas macros se declaran en la sección de definiciones del fichero `.flex` y se reutilizan en las reglas:

```
letra       = [a-zA-Z]
digito      = [0-9]
id_valido   = {letra}({letra}|{digito})*
```

### 3.2 Reglas léxicas

| Token | Expresión regular (JFlex) | Notas |
|-------|---------------------------|-------|
| `TOK_IDENTIFICADOR` | `{id_valido}` | Empieza por letra; seguido de letras o dígitos. Si la longitud supera el máximo permitido → error léxico. |
| `TOK_CONSTANTE_ENTERA` | `{digito}+` | Secuencia de uno o más dígitos. |
| `TOK_CONSTANTE_REAL` | `{digito}+"."{digito}+` | Dígitos, punto decimal obligatorio, más dígitos. |

### 3.3 Reglas de gestión de blancos y comentarios

Estas reglas no devuelven ningún token (la acción asociada es vacía o un simple `/* ignorar */`):

| Patrón | Expresión regular (JFlex) | Acción |
|--------|---------------------------|--------|
| Espacios y tabuladores | `[ \t\r\n]+` | Ignorar (sin return) |
| Comentario de línea | `"//"[^\n]*` | Ignorar (sin return) |

### 3.4 Reglas de error léxico

| Tipo de error | Condición | Acción |
|---------------|-----------|--------|
| Identificador demasiado largo | `{id_valido}` con longitud > máximo | Reportar error con fila y columna |
| Símbolo no permitido | Cualquier carácter no reconocido por el resto de reglas | Reportar error con fila y columna |

> **Orden en el fichero `.flex`:** La regla de identificador demasiado largo debe colocarse **antes** de la regla de identificador válido si se implementa con una expresión separada, o bien gestionarse dentro de la acción de `{id_valido}` comprobando `yytext().length()`.

---

## 4. Resumen de categorías de tokens

| Categoría | Nº de tokens |
|-----------|:---:|
| Palabras reservadas | 29 |
| Operadores y delimitadores | 24 |
| Identificadores | 1 |
| Constantes | 2 |
| **Total tokens** | **56** |
