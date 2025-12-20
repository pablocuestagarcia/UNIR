# Proyecto Haskell - Programación Declarativa

Este proyecto es una aplicación Haskell desarrollada usando **Stack**, un sistema de gestión de proyectos y dependencias para Haskell.

## 📁 Estructura del Proyecto

El proyecto sigue la estructura estándar de un proyecto Haskell con Stack:

```
opt_q1_programacion_declarativa/
├── src/                    # Código fuente principal
│   ├── Main.hs            # Punto de entrada de la aplicación
│   └── AIntroduction.hs   # Módulo de ejemplo
├── test/                   # Tests unitarios (configurado pero vacío)
├── app/                    # Directorio adicional (opcional)
├── stack.yaml              # Configuración de Stack
├── stack.yaml.lock         # Archivo de bloqueo de versiones (generado automáticamente)
├── package.yaml            # Definición del paquete (usando hpack)
├── mi-proyecto-haskell.cabal  # Archivo Cabal generado automáticamente
└── README.md               # Este archivo
```

### Descripción de Directorios

- **`src/`**: Contiene todo el código fuente Haskell de la aplicación. Los módulos aquí definidos son los que componen la funcionalidad principal del proyecto.
  - `Main.hs`: Módulo principal que contiene la función `main`, punto de entrada de la aplicación.
  - `AIntroduction.hs`: Módulo de ejemplo con funciones auxiliares.

- **`test/`**: Directorio destinado a los tests unitarios. Actualmente está configurado en `package.yaml` pero vacío. Aquí se colocarían archivos como `Spec.hs` para usar con HSpec.

- **`app/`**: Directorio opcional que puede contener código adicional o scripts auxiliares.

## 🛠️ ¿Qué es Stack?

**Stack** es una herramienta de gestión de proyectos Haskell que:

- **Gestiona dependencias**: Descarga e instala automáticamente las versiones correctas de las librerías necesarias.
- **Gestiona compiladores**: Instala y gestiona diferentes versiones del compilador GHC (Glasgow Haskell Compiler).
- **Reproducibilidad**: Garantiza que el proyecto se compile de la misma manera en diferentes máquinas usando el archivo `stack.yaml.lock`.
- **Aislamiento**: Cada proyecto tiene su propio entorno de dependencias, evitando conflictos.

### Archivos de Stack

- **`stack.yaml`**: Archivo de configuración principal de Stack. Define:
  - `resolver`: Versión del conjunto de paquetes (LTS - Long Term Support) y versión de GHC a usar.
  - `packages`: Lista de paquetes del proyecto (normalmente solo `.` para el directorio actual).
  - `extra-deps`: Dependencias adicionales no incluidas en el resolver.
  
- **`stack.yaml.lock`**: Archivo generado automáticamente que "bloquea" las versiones exactas de todas las dependencias. Este archivo garantiza builds reproducibles y **no debe editarse manualmente**.

## 📦 ¿Qué es package.yaml?

**`package.yaml`** es un archivo de configuración en formato YAML que define el paquete Haskell usando **hpack**. Es más legible y fácil de mantener que escribir directamente un archivo `.cabal`.

### Contenido de package.yaml

- **Metadatos del proyecto**: nombre, versión, descripción, autor, licencia.
- **Dependencias**: Lista de librerías necesarias para compilar el proyecto.
- **Opciones del compilador**: Flags de GHC como `-Wall` para mostrar todas las advertencias.
- **Ejecutables**: Define el punto de entrada (`Main.hs`) y opciones de compilación.
- **Tests**: Configuración de los tests (usando HSpec en este proyecto).

### Relación con .cabal

El archivo `mi-proyecto-haskell.cabal` es **generado automáticamente** desde `package.yaml` por la herramienta `hpack`. No es necesario editarlo manualmente; los cambios se hacen en `package.yaml` y luego se regenera el `.cabal`.

## 🚀 Cómo Usar el Proyecto

### Prerrequisitos

- Tener Stack instalado. Si no lo tienes, puedes instalarlo desde [haskellstack.org](https://haskellstack.org/)

## 📋 Tabla de Comandos Útiles

| Comando | Descripción | Ejemplo |
|---------|-------------|---------|
| `stack build` | Compila el proyecto y descarga dependencias | `stack build` |
| `stack run` | Compila y ejecuta la aplicación | `stack run` |
| `stack exec mi-proyecto-exe` | Ejecuta el ejecutable compilado | `stack exec mi-proyecto-exe` |
| `stack test` | Ejecuta los tests del proyecto | `stack test` |
| `stack ghci` | Abre GHCi (REPL) con dependencias cargadas | `stack ghci` |
| `stack clean` | Limpia archivos compilados | `stack clean` |
| `stack clean --full` | Limpia todo incluyendo dependencias locales | `stack clean --full` |
| `stack path` | Muestra rutas importantes del proyecto | `stack path` |
| `stack solver --update-config` | Resuelve problemas de dependencias | `stack solver --update-config` |
| `stack install` | Instala el ejecutable en el PATH del sistema | `stack install` |
| `stack update` | Actualiza el índice de paquetes | `stack update` |
| `stack list-dependencies` | Lista todas las dependencias del proyecto | `stack list-dependencies` |
| `stack hoogle` | Busca funciones en Hoogle | `stack hoogle "nombreFuncion"` |
| `stack test --test-arguments` | Ejecuta tests con argumentos específicos | `stack test --test-arguments "--match 'testName'"` |
| `stack build --file-watch` | Recompila automáticamente al cambiar archivos | `stack build --file-watch` |
| `stack ghci --ghci-options` | Abre GHCi con opciones específicas | `stack ghci --ghci-options "-XOverloadedStrings"` |

### Comandos Principales (Detallados)

#### 1. Construir el proyecto

```bash
stack build
```

Este comando:
- Descarga las dependencias necesarias (si es la primera vez)
- Compila el código fuente
- Genera el ejecutable

#### 2. Ejecutar la aplicación

```bash
stack exec mi-proyecto-exe
```

O de forma más corta:

```bash
stack run
```

#### 3. Ejecutar los tests

```bash
stack test
```

#### 4. Abrir un REPL (GHCi) con las dependencias cargadas

```bash
stack ghci
```

Esto abre un intérprete interactivo donde puedes probar funciones y módulos.

#### 5. Limpiar archivos compilados

```bash
stack clean
```

#### 6. Ver información del proyecto

```bash
stack path
```

Muestra rutas importantes como dónde se instalan las dependencias.

### Desarrollo

#### Agregar una nueva dependencia

1. Edita `package.yaml` y agrega la dependencia en la sección `dependencies`:

```yaml
dependencies:
  - base >= 4.7 && < 5
  - tu-nueva-dependencia  # Agrega aquí
```

2. Regenera el archivo `.cabal` (si es necesario):

```bash
stack build
```

3. Stack descargará automáticamente la nueva dependencia en el próximo build.

#### Crear un nuevo módulo

1. Crea un nuevo archivo `.hs` en `src/`, por ejemplo `src/MiModulo.hs`:

```haskell
module MiModulo where

miFuncion :: Int -> Int
miFuncion x = x * 2
```

2. Si necesitas usarlo desde `Main.hs`, importa el módulo:

```haskell
import MiModulo
```

#### Ejecutar tests específicos

Si tienes tests configurados:

```bash
stack test --test-arguments "--match 'nombreDelTest'"
```

## 📚 Recursos Adicionales

- [Documentación oficial de Stack](https://docs.haskellstack.org/)
- [Guía de hpack](https://github.com/sol/hpack)
- [Documentación de Haskell](https://www.haskell.org/documentation/)
- [Hoogle - Búsqueda de funciones Haskell](https://hoogle.haskell.org/)

## ⚙️ Configuración Actual

- **Resolver**: LTS 21.25 (GHC 9.4.8)
- **Nombre del proyecto**: mi-proyecto-haskell
- **Versión**: 0.1.0.0
- **Licencia**: BSD3
- **Opciones del compilador**: Se activan varias advertencias (`-Wall`, `-Wcompat`, etc.) para mantener un código de alta calidad.

## 🔧 Solución de Problemas

### Stack no encuentra GHC

Si Stack necesita instalar GHC, lo hará automáticamente. Esto puede tardar varios minutos la primera vez.

### Error de dependencias

Si hay problemas con las dependencias:

```bash
stack solver --update-config
```

### Limpiar todo y reconstruir

```bash
stack clean --full
stack build
```

---

**Nota**: Este proyecto está configurado para trabajar con Dev Containers, lo que facilita el desarrollo en un entorno consistente.

