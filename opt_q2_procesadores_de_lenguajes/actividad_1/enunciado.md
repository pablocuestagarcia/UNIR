
# Laboratorio 1. Construcción de un analizador léxico

## Objetivos 

El objetivo de esta actividad es la construcción de un analizador léxico para el lenguaje pocket, utilizando Java como lenguaje de programación y la herramienta generadora de analizadores léxicos JFlex. Se utilizará como guía la documentación disponible en la sección Documentación y las explicaciones del profesor en las sesiones de clase.

Además del analizador léxico, se desarrollará un programa escrito en Java para probarlo.

## Pautas de elaboración

La actividad incluye las tareas que se describen a continuación.

1. Codificación de una especificación para JFlex.

Partiendo de la gramática del lenguaje pocket (disponible en la sección Documentación del aula), se identificarán los tokens y se diseñará el conjunto de expresiones regulares que los representan. A partir de estas expresiones regulares, se codificará el fichero de especificación para la herramienta JFlex. Del conjunto completo de las reglas de la gramática, solamente serán objeto del analizador léxico aquellas que están resaltadas en color gris.

Junto a las reglas necesarias para la identificación de los tokens del lenguaje, se añadirán reglas para:

•	Ignorar los espacios, tabuladores y saltos de línea.
•	Ignorar los comentarios (recuérdese que en pocket un comentario comienza con // y acaba al final de la línea).
•	Gestionar los errores léxicos. Solo se considerarán dos tipos de errores: los símbolos no permitidos y los identificadores que excedan la longitud máxima que permite el lenguaje.

Generalmente, la acción asociada a cada regla será un return de un valor numérico que identifique el tipo de token identificado, excepto los casos particulares, por ejemplo, las reglas dedicadas a los espacios en blanco o los comentarios que no devolverán ningún token. 

2.	Generación del analizador léxico. Generación del analizador léxico encapsulado en una clase Java a partir de la especificación de JFlex.

3.	Codificación de un programa de prueba.

Una vez generada la clase que contiene el analizador léxico se desarrollará un programa en Java para probarlo. Dicho programa recibirá como argumentos los nombres de dos ficheros. Utilizará el primer fichero como entrada para realizar el análisis léxico de su contenido y escribirá los resultados del análisis en el segundo fichero. A continuación, se describen los ficheros de entrada y salida y se muestran algunos ejemplos.


	Ficheros de entrada al programa de prueba. Se utilizarán dos tipos de ficheros, por una parte, uno que contenga todos los tokens del lenguaje para asegurar que el analizador léxico es totalmente correcto. Por otra parte, se utilizarán ficheros que contengan distintos errores. 
	Funcionalidad del programa de prueba. Haciendo uso del analizador léxico construido con JFlex, el programa de prueba deberá detectar en el fichero de entrada los siguientes patrones:
•	Palabras reservadas.
•	Símbolos.
•	Identificadores (téngase en cuenta las reglas para la construcción de identificadores especificadas en la descripción de la gramática).
•	Constantes (enteras o booleanas).
•	Errores (símbolos no permitidos e identificadores que excedan de la longitud máxima).
•	Cada vez que se detecte un token válido, el programa informará de ello, indicando el tipo de token detectado. Si se detecta un error, el programa avisará del mismo indicando el tipo de error, así como la línea y la columna en la que aparece. 
	Ficheros de salida del programa de prueba. El fichero de salida tendrá una línea por cada uno de los patrones léxicos detectados en el fichero de entrada. En cada línea se mostrará:
•	El tipo de token detectado. Se utilizarán los nombres descritos en el fichero tokens.txt de la sección de Documentación.
•	El lexema analizado.



Por ejemplo, si en el fichero de entrada aparece la palabra printf, en el fichero de salida se escribirá:

TOK_PRINTF printf

En caso de que aparezca algún error, se informará del mismo mostrando el tipo de error, la fila y la columna del fichero en el que aparece (véanse los ejemplos disponibles en la sección de Documentación del aula).

	Ejemplos de ejecución del programa de prueba. Para probar el código desarrollado se facilitan ficheros de prueba en el apartado de Documentación del aula.

Extensión y formato 

Se entregará un único fichero comprimido (apellido1_apellido2_nombre.zip) que contenga:

	Todos los ficheros .java necesarios para resolver el enunciado propuesto. 
	El fichero de especificación de JFlex.
	Un fichero docx/pdf correspondiente a la memoria de la actividad en la que se describa el proceso de construcción del analizador léxico.



