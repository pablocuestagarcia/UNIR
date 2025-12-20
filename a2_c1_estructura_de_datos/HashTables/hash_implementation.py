from dataclasses import dataclass
from typing import Any, Optional

@dataclass
class KeyValue:
    """Representa un par clave-valor"""
    key: str
    value: Any


class HashTable:
    """Implementación personalizada de una tabla hash con manejo de colisiones"""

    def __init__(self, size: int = 50):
        """
        Constructor de la HashTable

        Args:
            size: Tamaño del array interno (número de buckets)
        """
        self.size = size
        self.data: list[list[KeyValue]] = [[] for _ in range(size)]
        self._count = 0  # Contador de elementos

    def _hash(self, key: str) -> int:
        """
        Función hash privada que convierte una clave en un índice

        Args:
            key: La clave a hashear

        Returns:
            Índice en el array (0 a size-1)
        """
        hash_value = 0
        for i, char in enumerate(key):
            hash_value = (hash_value + ord(char) * i) % self.size
        return hash_value

    def set(self, key: str, value: Any) -> None:
        """
        Inserta o actualiza un par clave-valor en la tabla hash

        Args:
            key: La clave
            value: El valor a almacenar
        """
        index = self._hash(key)
        bucket = self.data[index]

        # Verificar si la clave ya existe (para actualizar)
        for kv in bucket:
            if kv.key == key:
                kv.value = value
                return

        # Si no existe, agregar nuevo par clave-valor
        bucket.append(KeyValue(key, value))
        self._count += 1

    def get(self, key: str) -> Optional[Any]:
        """
        Obtiene el valor asociado a una clave

        Args:
            key: La clave a buscar

        Returns:
            El valor si existe, None si no existe
        """
        index = self._hash(key)
        bucket = self.data[index]

        # Buscar la clave en el bucket (manejo de colisiones)
        for kv in bucket:
            if kv.key == key:
                return kv.value

        return None

    def has_key(self, key: str) -> bool:
        """
        Verifica si una clave existe en la tabla hash

        Args:
            key: La clave a verificar

        Returns:
            True si existe, False si no
        """
        index = self._hash(key)
        bucket = self.data[index]

        for kv in bucket:
            if kv.key == key:
                return True

        return False

    def delete(self, key: str) -> bool:
        """
        Elimina un par clave-valor de la tabla hash

        Args:
            key: La clave a eliminar

        Returns:
            True si se eliminó, False si no existía
        """
        index = self._hash(key)
        bucket = self.data[index]

        # Buscar y eliminar la clave
        for i, kv in enumerate(bucket):
            if kv.key == key:
                bucket.pop(i)
                self._count -= 1
                return True

        return False

    def keys(self) -> list[str]:
        """
        Retorna todas las claves almacenadas en la tabla hash

        Returns:
            Lista de claves
        """
        all_keys = []
        for bucket in self.data:
            for kv in bucket:
                all_keys.append(kv.key)
        return all_keys

    def values(self) -> list[Any]:
        """
        Retorna todos los valores almacenados en la tabla hash

        Returns:
            Lista de valores
        """
        all_values = []
        for bucket in self.data:
            for kv in bucket:
                all_values.append(kv.value)
        return all_values

    def items(self) -> list[tuple[str, Any]]:
        """
        Retorna todos los pares clave-valor como tuplas

        Returns:
            Lista de tuplas (clave, valor)
        """
        all_items = []
        for bucket in self.data:
            for kv in bucket:
                all_items.append((kv.key, kv.value))
        return all_items

    def clear(self) -> None:
        """Limpia todos los elementos de la tabla hash"""
        self.data = [[] for _ in range(self.size)]
        self._count = 0

    def __len__(self) -> int:
        """Retorna el número de elementos en la tabla hash"""
        return self._count

    def __str__(self) -> str:
        """Representación en string de la tabla hash"""
        items = {kv.key: kv.value for bucket in self.data for kv in bucket}
        return f"HashTable({items})"

    def __repr__(self) -> str:
        """Representación detallada de la tabla hash"""
        return f"HashTable(size={self.size}, count={self._count})"

    def __getitem__(self, key: str) -> Any:
        """Permite acceso usando ht[key]"""
        value = self.get(key)
        if value is None and not self.has_key(key):
            raise KeyError(f"Key '{key}' not found")
        return value

    def __setitem__(self, key: str, value: Any) -> None:
        """Permite asignación usando ht[key] = value"""
        self.set(key, value)

    def __delitem__(self, key: str) -> None:
        """Permite eliminación usando del ht[key]"""
        if not self.delete(key):
            raise KeyError(f"Key '{key}' not found")

    def __contains__(self, key: str) -> bool:
        """Permite uso de 'in' operator: if key in ht"""
        return self.has_key(key)

    def print_structure(self) -> None:
        """Muestra la estructura interna de la tabla hash (útil para debugging)"""
        print("=== HashTable Internal Structure ===")
        for i, bucket in enumerate(self.data):
            if bucket:
                print(f"Bucket {i}: ", end="")
                for kv in bucket:
                    print(f"[{kv.key}: {kv.value}] ", end="")
                print()
        print(f"Total elements: {len(self)}")
        print("====================================")


def main():
    print("=== IMPLEMENTACIÓN DE HASH TABLE EN PYTHON ===\n")

    # Crear una hash table con tamaño 50
    ht = HashTable(50)

    # 1. SET - Insertar valores
    print("1. Insertando valores con set():")
    ht.set("grapes", 10000)
    ht.set("apples", 54)
    ht.set("oranges", 2)
    ht.set("bananas", 17)
    print(f"   Valores insertados: {ht.keys()}")

    # 2. GET - Obtener valores
    print("\n2. Obteniendo valores con get():")
    print(f"   grapes = {ht.get('grapes')}")
    print(f"   apples = {ht.get('apples')}")
    print(f"   pears = {ht.get('pears')} (no existe)")

    # 3. HAS_KEY - Verificar existencia
    print("\n3. Verificar existencia con has_key():")
    print(f"   'grapes' existe: {ht.has_key('grapes')}")
    print(f"   'pears' existe: {ht.has_key('pears')}")

    # 4. OPERADOR IN - Forma pythonic
    print("\n4. Verificar existencia con 'in' (pythonic):")
    print(f"   'apples' in ht: {'apples' in ht}")
    print(f"   'pears' in ht: {'pears' in ht}")

    # 5. ACCESO CON CORCHETES - Como diccionario
    print("\n5. Acceso con corchetes (como dict):")
    print(f"   ht['grapes'] = {ht['grapes']}")
    ht['grapes'] = 99999  # Actualizar
    print(f"   Después de ht['grapes'] = 99999: {ht['grapes']}")

    # 6. KEYS, VALUES, ITEMS
    print("\n6. Obteniendo claves, valores e items:")
    print(f"   keys(): {ht.keys()}")
    print(f"   values(): {ht.values()}")
    print(f"   items(): {ht.items()}")

    # 7. LEN - Tamaño
    print("\n7. Tamaño con len():")
    print(f"   len(ht) = {len(ht)}")

    # 8. DELETE - Eliminar elementos
    print("\n8. Eliminando elementos con delete():")
    print(f"   Antes de eliminar: {ht.keys()}")
    ht.delete("oranges")
    print(f"   Después de eliminar 'oranges': {ht.keys()}")
    print(f"   len(ht) = {len(ht)}")

    # 9. DEL - Eliminación pythonic
    print("\n9. Eliminación con del (pythonic):")
    del ht["bananas"]
    print(f"   Después de 'del ht[\"bananas\"]': {ht.keys()}")

    # 10. STR y REPR
    print("\n10. Representaciones en string:")
    print(f"   str(ht): {str(ht)}")
    print(f"   repr(ht): {repr(ht)}")

    # 11. COLISIONES - Demostrar manejo de colisiones
    print("\n11. Manejo de colisiones:")
    print("    Creando tabla pequeña (size=10) con múltiples elementos...")
    small_ht = HashTable(10)
    animals = ["cat", "dog", "bird", "fish", "hamster", "rabbit", "turtle", "snake"]
    for i, animal in enumerate(animals, 1):
        small_ht[animal] = i

    print(f"    Elementos insertados: {len(small_ht)}")
    small_ht.print_structure()

    # 12. DIFERENTES TIPOS DE DATOS
    print("\n12. Almacenando diferentes tipos de datos:")
    mixed_ht = HashTable(20)
    mixed_ht["number"] = 42
    mixed_ht["string"] = "Hello, World!"
    mixed_ht["boolean"] = True
    mixed_ht["float"] = 3.14159
    mixed_ht["list"] = [1, 2, 3, 4, 5]
    mixed_ht["dict"] = {"name": "Alice", "age": 30}
    mixed_ht["tuple"] = (1, 2, 3)

    print("    Valores de diferentes tipos:")
    for key in mixed_ht.keys():
        value = mixed_ht[key]
        print(f"    {key} = {value} (type: {type(value).__name__})")

    # 13. CLEAR - Limpiar tabla
    print("\n13. Limpiar tabla con clear():")
    print(f"    Antes: len = {len(mixed_ht)}")
    mixed_ht.clear()
    print(f"    Después de clear(): len = {len(mixed_ht)}")

    # 14. ITERACIÓN - Forma pythonic
    print("\n14. Iteración pythonic sobre la tabla:")
    ht2 = HashTable(20)
    ht2["uno"] = 1
    ht2["dos"] = 2
    ht2["tres"] = 3

    print("    Iterando sobre items():")
    for key, value in ht2.items():
        print(f"      {key} = {value}")

    # 15. ESTRUCTURA INTERNA
    print("\n15. Visualización de estructura interna:")
    ht.print_structure()


if __name__ == "__main__":
    main()
