package main

import "fmt"

/*
Javascript Template
class HashTable {
    constructor(size) { this.data = new Array(size)}
	_hash(key) {
		let hash = 0
		for (let i = 0; i < key.length; i++) {
			hash = (hash + key.charCodeAt(i) * i) % this.data.length
		}
		return hash
	}
}

const myHashtTable = new HashTable(50)
myHashtTable.set('grapes', 10000)
myHashtTable.get('grapes')
*/

// KeyValue representa un par clave-valor
type KeyValue struct {
	Key   string
	Value any
}

// HashTable es nuestra implementación personalizada de tabla hash
type HashTable struct {
	data [][]KeyValue // Array de buckets (cada bucket es un slice para manejar colisiones)
	size int
}

// NewHashTable crea una nueva tabla hash con el tamaño especificado
func NewHashTable(size int) *HashTable {
	return &HashTable{
		data: make([][]KeyValue, size),
		size: size,
	}
}

// hash es la función hash privada que convierte una clave en un índice
func (ht *HashTable) hash(key string) int {
	hash := 0
	for i := 0; i < len(key); i++ {
		hash = (hash + int(key[i])*i) % ht.size
	}
	return hash
}

// Set inserta o actualiza un par clave-valor en la tabla hash
func (ht *HashTable) Set(key string, value any) {
	index := ht.hash(key)

	// Si el bucket está vacío, inicializarlo
	if ht.data[index] == nil {
		ht.data[index] = []KeyValue{}
	}

	// Verificar si la clave ya existe (para actualizar)
	for i, kv := range ht.data[index] {
		if kv.Key == key {
			ht.data[index][i].Value = value
			return
		}
	}

	// Si no existe, agregar nuevo par clave-valor
	ht.data[index] = append(ht.data[index], KeyValue{Key: key, Value: value})
}

// Get obtiene el valor asociado a una clave
func (ht *HashTable) Get(key string) (interface{}, bool) {
	index := ht.hash(key)

	// Si el bucket está vacío, la clave no existe
	if ht.data[index] == nil {
		return nil, false
	}

	// Buscar la clave en el bucket (manejo de colisiones)
	for _, kv := range ht.data[index] {
		if kv.Key == key {
			return kv.Value, true
		}
	}

	return nil, false
}

// Delete elimina un par clave-valor de la tabla hash
func (ht *HashTable) Delete(key string) bool {
	index := ht.hash(key)

	if ht.data[index] == nil {
		return false
	}

	// Buscar y eliminar la clave
	for i, kv := range ht.data[index] {
		if kv.Key == key {
			// Eliminar elemento del slice
			ht.data[index] = append(ht.data[index][:i], ht.data[index][i+1:]...)
			return true
		}
	}

	return false
}

// Keys retorna todas las claves almacenadas en la tabla hash
func (ht *HashTable) Keys() []string {
	keys := []string{}

	for _, bucket := range ht.data {
		if bucket != nil {
			for _, kv := range bucket {
				keys = append(keys, kv.Key)
			}
		}
	}

	return keys
}

// Values retorna todos los valores almacenados en la tabla hash
func (ht *HashTable) Values() []interface{} {
	values := []interface{}{}

	for _, bucket := range ht.data {
		if bucket != nil {
			for _, kv := range bucket {
				values = append(values, kv.Value)
			}
		}
	}

	return values
}

// Size retorna el número de elementos en la tabla hash
func (ht *HashTable) Size() int {
	count := 0

	for _, bucket := range ht.data {
		if bucket != nil {
			count += len(bucket)
		}
	}

	return count
}

// Print muestra el contenido completo de la tabla hash (útil para debugging)
func (ht *HashTable) Print() {
	fmt.Println("=== HashTable Contents ===")
	for i, bucket := range ht.data {
		if bucket != nil && len(bucket) > 0 {
			fmt.Printf("Bucket %d: ", i)
			for _, kv := range bucket {
				fmt.Printf("[%s: %v] ", kv.Key, kv.Value)
			}
			fmt.Println()
		}
	}
	fmt.Printf("Total elements: %d\n", ht.Size())
	fmt.Println("=========================")
}

func main() {
	fmt.Println("=== IMPLEMENTACIÓN DE HASH TABLE DESDE CERO ===\n")

	// Crear una hash table con tamaño 50
	myHashTable := NewHashTable(2)

	// 1. SET - Insertar valores
	fmt.Println("1. Insertando valores con Set():")
	myHashTable.Set("grapes", 10000)	
	myHashTable.Set("apples", 54)
	myHashTable.Set("oranges", 2)
	myHashTable.Set("bananas", 17)
	fmt.Println("Ejemplo:", myHashTable)
	// fmt.Println("   Valores insertados: grapes, apples, oranges, bananas")

	// // 2. GET - Obtener valores
	// fmt.Println("\n2. Obteniendo valores con Get():")
	// if value, exists := myHashTable.Get("grapes"); exists {
	// 	fmt.Printf("   grapes = %v\n", value)
	// }
	// if value, exists := myHashTable.Get("apples"); exists {
	// 	fmt.Printf("   apples = %v\n", value)
	// }

	// // Intentar obtener una clave que no existe
	// if value, exists := myHashTable.Get("pears"); !exists {
	// 	fmt.Printf("   pears = NO EXISTE (returned: %v)\n", value)
	// }

	// // 3. KEYS - Obtener todas las claves
	// fmt.Println("\n3. Obteniendo todas las claves con Keys():")
	// keys := myHashTable.Keys()
	// fmt.Printf("   %v\n", keys)

	// // 4. VALUES - Obtener todos los valores
	// fmt.Println("\n4. Obteniendo todos los valores con Values():")
	// values := myHashTable.Values()
	// fmt.Printf("   %v\n", values)

	// // 5. SIZE - Obtener tamaño
	// fmt.Println("\n5. Tamaño de la tabla con Size():")
	// fmt.Printf("   Número de elementos: %d\n", myHashTable.Size())

	// // 6. UPDATE - Actualizar un valor existente
	// fmt.Println("\n6. Actualizando valor existente:")
	// fmt.Printf("   grapes antes: ")
	// if value, exists := myHashTable.Get("grapes"); exists {
	// 	fmt.Printf("%v\n", value)
	// }
	// myHashTable.Set("grapes", 99999)
	// fmt.Printf("   grapes después: ")
	// if value, exists := myHashTable.Get("grapes"); exists {
	// 	fmt.Printf("%v\n", value)
	// }

	// // 7. DELETE - Eliminar un elemento
	// fmt.Println("\n7. Eliminando elementos con Delete():")
	// fmt.Printf("   Eliminando 'oranges'... ")
	// if myHashTable.Delete("oranges") {
	// 	fmt.Println("ÉXITO")
	// }
	// fmt.Printf("   Tamaño después de eliminar: %d\n", myHashTable.Size())

	// // 8. COLISIONES - Demostrar manejo de colisiones
	// fmt.Println("\n8. Manejo de colisiones:")
	// fmt.Println("   Insertando múltiples elementos que podrían colisionar...")

	// // Crear una tabla pequeña para forzar colisiones
	// smallTable := NewHashTable(10)
	// smallTable.Set("cat", 1)
	// smallTable.Set("dog", 2)
	// smallTable.Set("bird", 3)
	// smallTable.Set("fish", 4)
	// smallTable.Set("hamster", 5)
	// smallTable.Set("rabbit", 6)
	// smallTable.Set("turtle", 7)
	// smallTable.Set("snake", 8)

	// fmt.Println("\n   Tabla pequeña (size=10) con 8 elementos:")
	// smallTable.Print()

	// // 9. TIPOS DE DATOS - Diferentes tipos de valores
	// fmt.Println("\n9. Almacenando diferentes tipos de datos:")
	// mixedTable := NewHashTable(20)
	// mixedTable.Set("number", 42)
	// mixedTable.Set("string", "Hello, World!")
	// mixedTable.Set("boolean", true)
	// mixedTable.Set("float", 3.14159)
	// mixedTable.Set("slice", []int{1, 2, 3, 4, 5})

	// type Person struct {
	// 	Name string
	// 	Age  int
	// }
	// mixedTable.Set("struct", Person{Name: "Alice", Age: 30})

	// fmt.Println("   Valores de diferentes tipos:")
	// for _, key := range mixedTable.Keys() {
	// 	value, _ := mixedTable.Get(key)
	// 	fmt.Printf("   %s = %v (type: %T)\n", key, value, value)
	// }

	// // 10. PRINT - Visualizar estructura interna
	// fmt.Println("\n10. Visualización completa de la tabla hash original:")
	// myHashTable.Print()
}

func RecurringNumber(array []int) int {
	
	// Inicializamos la hash table
	hashTable := NewHashTable(len(array))


}