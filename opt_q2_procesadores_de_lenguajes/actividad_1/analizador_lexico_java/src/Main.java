import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Main {

    public static void main(String[] args) throws IOException {

        if (args.length != 2) {
            System.err.println("Uso: java Main <fichero_entrada> <fichero_salida>");
            System.exit(1);
        }

        FileReader entrada = new FileReader(args[0]);
        PrintWriter salida = new PrintWriter(new FileWriter(args[1]));

        AnalizadorLexico lexer = new AnalizadorLexico(entrada);

        int token;
        while ((token = lexer.yylex()) != 0) {   // 0 == EOF en JFlex
            if (token == AnalizadorLexico.TOK_ERROR) {
                // El error ya lo imprimió el propio lexer en stderr
                break;
            }
            salida.println(nombreToken(token) + "\t" + lexer.yytext());
        }

        salida.close();
        entrada.close();
    }

    // Traduce el entero que devuelve yylex() al nombre del token
    private static String nombreToken(int token) {
        switch (token) {
            // Palabras reservadas
            case AnalizadorLexico.TOK_MAIN:         return "TOK_MAIN";
            case AnalizadorLexico.TOK_INT:          return "TOK_INT";
            case AnalizadorLexico.TOK_BOOLEAN:      return "TOK_BOOLEAN";
            case AnalizadorLexico.TOK_FLOAT:        return "TOK_FLOAT";
            case AnalizadorLexico.TOK_ARRAY:        return "TOK_ARRAY";
            case AnalizadorLexico.TOK_SET:          return "TOK_SET";
            case AnalizadorLexico.TOK_OF:           return "TOK_OF";
            case AnalizadorLexico.TOK_FUNCTION:     return "TOK_FUNCTION";
            case AnalizadorLexico.TOK_MALLOC:       return "TOK_MALLOC";
            case AnalizadorLexico.TOK_IF:           return "TOK_IF";
            case AnalizadorLexico.TOK_ELSE:         return "TOK_ELSE";
            case AnalizadorLexico.TOK_WHILE:        return "TOK_WHILE";
            case AnalizadorLexico.TOK_FOR:          return "TOK_FOR";
            case AnalizadorLexico.TOK_SCANF:        return "TOK_SCANF";
            case AnalizadorLexico.TOK_PRINTF:       return "TOK_PRINTF";
            case AnalizadorLexico.TOK_CPRINTF:      return "TOK_CPRINTF";
            case AnalizadorLexico.TOK_FREE:         return "TOK_FREE";
            case AnalizadorLexico.TOK_RETURN:       return "TOK_RETURN";
            case AnalizadorLexico.TOK_SWITCH:       return "TOK_SWITCH";
            case AnalizadorLexico.TOK_CASE:         return "TOK_CASE";
            case AnalizadorLexico.TOK_DEFAULT:      return "TOK_DEFAULT";
            case AnalizadorLexico.TOK_UNION:        return "TOK_UNION";
            case AnalizadorLexico.TOK_INTERSECTION: return "TOK_INTERSECTION";
            case AnalizadorLexico.TOK_ADD:          return "TOK_ADD";
            case AnalizadorLexico.TOK_CLEAR:        return "TOK_CLEAR";
            case AnalizadorLexico.TOK_SIZE:         return "TOK_SIZE";
            case AnalizadorLexico.TOK_CONTAINS:     return "TOK_CONTAINS";
            case AnalizadorLexico.TOK_TRUE:         return "TOK_TRUE";
            case AnalizadorLexico.TOK_FALSE:        return "TOK_FALSE";

            // Operadores y delimitadores
            case AnalizadorLexico.TOK_PUNTOYCOMA:           return "TOK_PUNTOYCOMA";
            case AnalizadorLexico.TOK_COMA:                 return "TOK_COMA";
            case AnalizadorLexico.TOK_PARENTESISIZQUIERDO:  return "TOK_PARENTESISIZQUIERDO";
            case AnalizadorLexico.TOK_PARENTESISDERECHO:    return "TOK_PARENTESISDERECHO";
            case AnalizadorLexico.TOK_LLAVEIZQUIERDA:       return "TOK_LLAVEIZQUIERDA";
            case AnalizadorLexico.TOK_LLAVEDERECHA:         return "TOK_LLAVEDERECHA";
            case AnalizadorLexico.TOK_CORCHETEIZQUIERDO:    return "TOK_CORCHETEIZQUIERDO";
            case AnalizadorLexico.TOK_CORCHETEDERECHO:      return "TOK_CORCHETEDERECHO";
            case AnalizadorLexico.TOK_ASIGNACION:           return "TOK_ASIGNACION";
            case AnalizadorLexico.TOK_MAS:                  return "TOK_MAS";
            case AnalizadorLexico.TOK_MENOS:                return "TOK_MENOS";
            case AnalizadorLexico.TOK_DIVISION:             return "TOK_DIVISION";
            case AnalizadorLexico.TOK_ASTERISCO:            return "TOK_ASTERISCO";
            case AnalizadorLexico.TOK_DIR:                  return "TOK_DIR";
            case AnalizadorLexico.TOK_AND:                  return "TOK_AND";
            case AnalizadorLexico.TOK_OR:                   return "TOK_OR";
            case AnalizadorLexico.TOK_NOT:                  return "TOK_NOT";
            case AnalizadorLexico.TOK_IGUAL:                return "TOK_IGUAL";
            case AnalizadorLexico.TOK_DISTINTO:             return "TOK_DISTINTO";
            case AnalizadorLexico.TOK_MENORIGUAL:           return "TOK_MENORIGUAL";
            case AnalizadorLexico.TOK_MAYORIGUAL:           return "TOK_MAYORIGUAL";
            case AnalizadorLexico.TOK_MENOR:                return "TOK_MENOR";
            case AnalizadorLexico.TOK_MAYOR:                return "TOK_MAYOR";
            case AnalizadorLexico.TOK_PUNTODECIMAL:         return "TOK_PUNTODECIMAL";

            // Identificadores y constantes
            case AnalizadorLexico.TOK_IDENTIFICADOR:    return "TOK_IDENTIFICADOR";
            case AnalizadorLexico.TOK_CONSTANTE_ENTERA: return "TOK_CONSTANTE_ENTERA";
            case AnalizadorLexico.TOK_CONSTANTE_REAL:   return "TOK_CONSTANTE_REAL";

            default: return "TOK_DESCONOCIDO(" + token + ")";
        }
    }
}
