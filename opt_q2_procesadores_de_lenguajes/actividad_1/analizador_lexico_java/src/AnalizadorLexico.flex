%%

%class AnalizadorLexico
%unicode
%line
%column
%type int

%{
    // Longitud máxima de identificador según la gramática de Pocket
    private static final int MAX_ID_LENGTH = 100;

    // Valor de retorno para errores (distinto de 0 que es EOF)
    public static final int TOK_ERROR = -1;

    // Palabras reservadas
    public static final int TOK_MAIN         = 1;
    public static final int TOK_INT          = 2;
    public static final int TOK_BOOLEAN      = 3;
    public static final int TOK_FLOAT        = 4;
    public static final int TOK_ARRAY        = 5;
    public static final int TOK_SET          = 6;
    public static final int TOK_OF           = 7;
    public static final int TOK_FUNCTION     = 8;
    public static final int TOK_MALLOC       = 9;
    public static final int TOK_IF           = 10;
    public static final int TOK_ELSE         = 11;
    public static final int TOK_WHILE        = 12;
    public static final int TOK_FOR          = 13;
    public static final int TOK_SCANF        = 14;
    public static final int TOK_PRINTF       = 15;
    public static final int TOK_CPRINTF      = 16;
    public static final int TOK_FREE         = 17;
    public static final int TOK_RETURN       = 18;
    public static final int TOK_SWITCH       = 19;
    public static final int TOK_CASE         = 20;
    public static final int TOK_DEFAULT      = 21;
    public static final int TOK_UNION        = 22;
    public static final int TOK_INTERSECTION = 23;
    public static final int TOK_ADD          = 24;
    public static final int TOK_CLEAR        = 25;
    public static final int TOK_SIZE         = 26;
    public static final int TOK_CONTAINS     = 27;
    public static final int TOK_TRUE         = 28;
    public static final int TOK_FALSE        = 29;

    // Operadores y delimitadores
    public static final int TOK_PUNTOYCOMA           = 30;
    public static final int TOK_COMA                 = 31;
    public static final int TOK_PARENTESISIZQUIERDO  = 32;
    public static final int TOK_PARENTESISDERECHO    = 33;
    public static final int TOK_LLAVEIZQUIERDA       = 34;
    public static final int TOK_LLAVEDERECHA         = 35;
    public static final int TOK_CORCHETEIZQUIERDO    = 36;
    public static final int TOK_CORCHETEDERECHO      = 37;
    public static final int TOK_ASIGNACION           = 38;
    public static final int TOK_MAS                  = 39;
    public static final int TOK_MENOS                = 40;
    public static final int TOK_DIVISION             = 41;
    public static final int TOK_ASTERISCO            = 42;
    public static final int TOK_DIR                  = 43;
    public static final int TOK_AND                  = 44;
    public static final int TOK_OR                   = 45;
    public static final int TOK_NOT                  = 46;
    public static final int TOK_IGUAL                = 47;
    public static final int TOK_DISTINTO             = 48;
    public static final int TOK_MENORIGUAL           = 49;
    public static final int TOK_MAYORIGUAL           = 50;
    public static final int TOK_MENOR                = 51;
    public static final int TOK_MAYOR                = 52;
    public static final int TOK_PUNTODECIMAL         = 53;

    // Identificadores y constantes
    public static final int TOK_IDENTIFICADOR    = 54;
    public static final int TOK_CONSTANTE_ENTERA = 55;
    public static final int TOK_CONSTANTE_REAL   = 56;
%}

// Macros reutilizables en las reglas
letra     = [a-zA-Z]
digito    = [0-9]
id_valido = {letra}({letra}|{digito})*

%%

// Palabras clave (van antes que la regla de identificadores)
"main"         { return TOK_MAIN; }
"int"          { return TOK_INT; }
"boolean"      { return TOK_BOOLEAN; }
"float"        { return TOK_FLOAT; }
"array"        { return TOK_ARRAY; }
"set"          { return TOK_SET; }
"of"           { return TOK_OF; }
"function"     { return TOK_FUNCTION; }
"malloc"       { return TOK_MALLOC; }
"if"           { return TOK_IF; }
"else"         { return TOK_ELSE; }
"while"        { return TOK_WHILE; }
"for"          { return TOK_FOR; }
"scanf"        { return TOK_SCANF; }
"printf"       { return TOK_PRINTF; }
"cprintf"      { return TOK_CPRINTF; }
"free"         { return TOK_FREE; }
"return"       { return TOK_RETURN; }
"switch"       { return TOK_SWITCH; }
"case"         { return TOK_CASE; }
"default"      { return TOK_DEFAULT; }
"union"        { return TOK_UNION; }
"intersection" { return TOK_INTERSECTION; }
"add"          { return TOK_ADD; }
"clear"        { return TOK_CLEAR; }
"size"         { return TOK_SIZE; }
"contains"     { return TOK_CONTAINS; }
"true"         { return TOK_TRUE; }
"false"        { return TOK_FALSE; }

// Operadores de dos caracteres (antes que los de uno)
"&&"  { return TOK_AND; }
"||"  { return TOK_OR; }
"=="  { return TOK_IGUAL; }
"!="  { return TOK_DISTINTO; }
"<="  { return TOK_MENORIGUAL; }
">="  { return TOK_MAYORIGUAL; }

// Operadores y delimitadores de un carácter
";"   { return TOK_PUNTOYCOMA; }
","   { return TOK_COMA; }
"("   { return TOK_PARENTESISIZQUIERDO; }
")"   { return TOK_PARENTESISDERECHO; }
"{"   { return TOK_LLAVEIZQUIERDA; }
"}"   { return TOK_LLAVEDERECHA; }
"["   { return TOK_CORCHETEIZQUIERDO; }
"]"   { return TOK_CORCHETEDERECHO; }
"="   { return TOK_ASIGNACION; }
"+"   { return TOK_MAS; }
"-"   { return TOK_MENOS; }
"/"   { return TOK_DIVISION; }
"*"   { return TOK_ASTERISCO; }
"&"   { return TOK_DIR; }
"!"   { return TOK_NOT; }
"<"   { return TOK_MENOR; }
">"   { return TOK_MAYOR; }
"."   { return TOK_PUNTODECIMAL; }

// Identificadores: si supera 100 chars es error léxico
{id_valido}  {
                 if (yytext().length() > MAX_ID_LENGTH) {
                     System.err.println("****ERROR MORFOLÓGICO EN [lin "
                         + yyline + ", col " + yycolumn
                         + "]: IDENTIFICADOR DEMASIADO LARGO (" + yytext() + ")");
                     return TOK_ERROR;
                 }
                 return TOK_IDENTIFICADOR;
             }

// Constantes numéricas (real antes que entera)
{digito}+"."{digito}+  { return TOK_CONSTANTE_REAL; }
{digito}+              { return TOK_CONSTANTE_ENTERA; }

// Espacios, tabuladores y saltos de línea: se ignoran
[ \t\r\n]+   { /* ignorar */ }

// Comentarios de línea: se ignoran
"//"[^\n]*   { /* ignorar */ }

// Cualquier carácter no reconocido es un error léxico
.  {
       System.err.println("****ERROR MORFOLÓGICO EN [lin "
           + yyline + ", col " + yycolumn
           + "]: simbolo no permitido (" + yytext() + ")");
       return TOK_ERROR;
   }

// Fin de fichero: devuelve 0 (convención JFlex para EOF con %type int)
<<EOF>>  { return 0; }
