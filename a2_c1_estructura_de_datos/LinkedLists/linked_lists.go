/*
Linked Lists en Go
Caracteristicas relevantes de Go:
- Tipado estático fuerte pero con inferencia.
- Punteros explícitos pero con recolector de basura.
- Sencillez y legibilidad como prioridad.
- Interfaces y polimorfismo.
*/

package main

import "fmt"

type Node struct {
	value int
	next *Node
}

type SimpleLinkedList struct {
	head *Node
}

func (ll *SimpleLinkedList) Append(value int) {
	newNode := &Node{value: value, next: nil}
	if ll.head == nil {
		ll.head = newNode
	} else {
		current := ll.head
		for current.next != nil {
			current = current.next
		}
		current.next = newNode
	}
}