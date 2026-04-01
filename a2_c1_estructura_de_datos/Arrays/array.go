package main

import "fmt"

func main() {

	var arr1 [5]int
	fmt.Println("empty array:", arr1)

	arr1[4] = 100
	fmt.Println("set:", arr1)
	fmt.Println("get:", arr1[4])

	// arr1[10] = 20 // Esto nos da un error al salirse de los límites.
	var arr2 = [...]int{1,2,3: 10}
	fmt.Println("Array:", arr2)

	// Multidimensionales
	a := [3][3]int{
		{1,2,3},
		{4,5,6},
		{7,8,9},
	}
	fmt.Println("Matriz:", a)

	// Suma de matrices
	b := [3][3]int{
		{1,1,1},
		{1,1,1},
		{1,1,1},
	}

	var c [3][3]int

	for i := range 3 {
		for j := range 3 {
			c[i][j] = a[i][j] + b[i][j]
		}
	}

	fmt.Println("Suma de matrices:", c)
	

	// Esto es un slice
	s := []int{1,2,3}

	fmt.Println("Slice:", s)


	type KeyValue struct {
		Key string
		Value any
	}

	type HashMapFixed struct {
		data [][1]KeyValue
		size int
	}

	type HashMap struct {
		data [][]KeyValue
		size int
	}

	h := HashMapFixed{
		data: make([][1]KeyValue, 4),
		size: 4,
	}

	h_dynamic := HashMap{
		data: make([][]KeyValue, 4),
		size: 4,
	}

	h.data[0] = [1]KeyValue{KeyValue{Key: "apple", Value: 1}}
	h.data[1] = [1]KeyValue{KeyValue{Key: "banana", Value: 2}}
	h.data[2] = [1]KeyValue{KeyValue{Key: "cherry", Value: 3}}
	h.data[3] = [1]KeyValue{KeyValue{Key: "date", Value: 4}}
	
	fmt.Println("Ejemplo:", h)
	fmt.Println("Get:", h.data[1])

	h_dynamic.data[0] = []KeyValue{KeyValue{Key: "apple", Value: 1}}
	h_dynamic.data[1] = []KeyValue{KeyValue{Key: "banana", Value: 2}, KeyValue{Key: "cherry", Value: 3}}
	h_dynamic.data[2] = []KeyValue{KeyValue{Key: "cherry", Value: 3}}
	h_dynamic.data[3] = []KeyValue{KeyValue{Key: "date", Value: 4}}
	
	fmt.Println("Ejemplo:", h_dynamic)
	fmt.Println("Get:", h_dynamic.data[1])

	
}