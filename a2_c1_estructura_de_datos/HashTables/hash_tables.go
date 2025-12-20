package main

import "fmt"


type hashTable struct {
	Data []int
}

func main() {
	fmt.Println("=== HASH TABLES (MAPS) EN GO ===\n")

	// 1. CREACIÓN DE MAPS
	fmt.Println("1. Creación de maps:")

	// Forma 1: make
	hashTable := make(map[string]int)

	// Forma 2: map literal
	fruits := map[string]int{
		"apple":  1,
		"banana": 2,
		"cherry": 3,
	}

	// Tipos de Mapas
	type Operacion func(int, int) int

	mapFunctions := map[string]Operacion{
		"suma": func(x int, y int) int {
			return x + y
		},
		"resta": func(x int, y int) int {
			return x - y
		}
	}

	a := func(x int, y int) int {
		return x + y
	}

	fmt.Println(a(1,10))
	fmt.Println(mapFunctions["suma"](10,11))
	fmt.Println(mapFunctions["resta"](10,11))

	// // Forma 3: con capacidad inicial
	capacityMap := make(map[string]int, 10)

	fmt.Printf("Map vacío: %v\n", hashTable)
	fmt.Printf("Map literal: %v\n", fruits)
	fmt.Printf("Map con capacidad: %v\n\n", capacityMap)

	// // 2. INSERCIÓN Y ACTUALIZACIÓN
	fmt.Println("2. Inserción y actualización:")
	hashTable["apple"] = 1
	hashTable["banana"] = 2
	hashTable["cherry"] = 3
	fmt.Printf("Después de insertar: %v\n", hashTable)

	hashTable["apple"] = 100 // Actualizar valor existente
	fmt.Printf("Después de actualizar 'apple': %v\n\n", hashTable)

	// // 3. LECTURA DE VALORES
	fmt.Println("3. Lectura de valores:")
	value := hashTable["apple"]
	fmt.Printf("Valor de 'apple': %d\n", value)

	// // Lectura segura (idioma de Go)
	value, exists := hashTable["orange"]
	if exists {
		fmt.Printf("Valor de 'orange': %d\n", value)
	} else {
		fmt.Printf("'orange' no existe en el map (valor por defecto: %d)\n", value)
	}
	fmt.Println()

	// // 4. FUNCIÓN len() - Obtener tamaño
	fmt.Println("4. Tamaño del map:")
	fmt.Printf("Número de elementos: %d\n\n", len(hashTable))

	// 5. FUNCIÓN delete() - Eliminar elementos
	fmt.Println("5. Eliminación de elementos:")
	fmt.Printf("Antes de eliminar: %v\n", hashTable)
	delete(hashTable, "banana")
	fmt.Printf("Después de eliminar 'banana': %v\n", hashTable)

	// Eliminar clave que no existe (no causa error)
	delete(hashTable, "nonexistent")
	fmt.Printf("Después de eliminar clave inexistente: %v\n\n", hashTable)

	// 6. ITERACIÓN CON range
	fmt.Println("6. Iteración sobre el map:")

	data := map[string]int{
		"uno":    1,
		"dos":    2,
		"tres":   3,
		"cuatro": 4,
	}

	// Clave y valor
	fmt.Println("Clave-Valor:")
	for key, value := range data {
		fmt.Printf("  %s = %d\n", key, value)
	}

	// Solo claves
	fmt.Println("\nSolo claves:")
	for key := range data {
		fmt.Printf("  %s\n", key)
	}

	// Solo valores
	fmt.Println("\nSolo valores:")
	for _, value := range data {
		fmt.Printf("  %d\n", value)
	}
	fmt.Println()

	// 7. VERIFICAR EXISTENCIA DE CLAVE
	fmt.Println("7. Verificar existencia de clave:")
	if _, exists := data["dos"]; exists {
		fmt.Println("  'dos' existe en el map")
	}
	if _, exists := data["cinco"]; !exists {
		fmt.Println("  'cinco' NO existe en el map")
	}
	fmt.Println()

	// 8. MAPS CON DIFERENTES TIPOS
	fmt.Println("8. Maps con diferentes tipos:")

	// Map de string a struct
	type Person struct {
		Name string
		Age  int
	}
	people := map[string]Person{
		"alice": {Name: "Alice", Age: 30},
		"bob":   {Name: "Bob", Age: 25},
	}
	fmt.Printf("Map de structs: %v\n", people)

	// Map de int a slice
	groups := map[int][]string{
		1: {"Alice", "Bob"},
		2: {"Charlie", "David"},
	}
	fmt.Printf("Map de slices: %v\n", groups)

	// Map de string a map (map anidado)
	nested := map[string]map[string]int{
		"fruits":  {"apple": 1, "banana": 2},
		"veggies": {"carrot": 3, "lettuce": 4},
	}
	fmt.Printf("Map anidado: %v\n\n", nested)

	// 9. LIMPIAR UN MAP
	fmt.Println("9. Limpiar un map:")
	clearMap := map[string]int{"a": 1, "b": 2, "c": 3}
	fmt.Printf("Antes: %v (len=%d)\n", clearMap, len(clearMap))

	// Opción 1: Recrear el map
	clearMap = make(map[string]int)
	fmt.Printf("Después de recrear: %v (len=%d)\n", clearMap, len(clearMap))

	// Opción 2: Eliminar todos los elementos
	clearMap2 := map[string]int{"x": 10, "y": 20, "z": 30}
	for key := range clearMap2 {
		delete(clearMap2, key)
	}
	fmt.Printf("Después de eliminar todo: %v (len=%d)\n\n", clearMap2, len(clearMap2))

	// 10. MAP COMO REFERENCIA
	fmt.Println("10. Maps son tipos de referencia:")
	original := map[string]int{"a": 1, "b": 2}
	copy := original // No crea copia, ambos apuntan al mismo map
	copy["a"] = 100
	fmt.Printf("Original: %v\n", original)
	fmt.Printf("Copia: %v\n", copy)
	fmt.Println("Ambos son el mismo map en memoria!")
}


