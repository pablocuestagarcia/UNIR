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

	type HashMap struct {
		data [][]KeyValue
		size int
	}

	h := HashMap{
		data: make([][]KeyValue, 4),
		size: 4,
	}

	fmt.Println("Ejemplo:", h)

	fmt.Println("Get:", h.data[1])

	
}