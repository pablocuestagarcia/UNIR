# Breadth-First Search

There is a **G(V,E)** graph and the aim is to visit every **V** vertex exactly once.
Breadth-first search visits the neighbors and then the neighbors of these new vertices until all nodes are visited.

* running time complexity is **O(V+E)** where **V** are the number of vectices and **E** the number of edges.
* memory complexity is not that favorable as we have to store lot of references.


## Memory Complexity

Because breadth-first search (BFS) needs a lot of memory, usually **depth-first search** is preferred.

## Shortest Path

Breadth-first seach (BFS) has a huge advantage: it constructs a shortest path

## Use Cases

* Pathfinding algorithms: ML algorithms uses BFS and DFS.
* Maximum Flow: we can find the maximum flow in a flow network with Edmonds-karp.
* Garbage Collection: cheyen's algorithm uses BFS during garbage collection to maintain the active references on the heap memory.
* Serialization: tree like structures it enables the tree to be reconstructed in a efficent manner.