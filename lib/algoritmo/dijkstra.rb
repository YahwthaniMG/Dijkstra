class Dijkstra
  def self.calcular(grafo, inicio, fin)
    # Inicializa las estructuras de datos
    distancias = {} # Almacena la distancia más corta a cada nodo
    previos = {} # Almacena el nodo anterior en el camino más corto
    nodos = grafo.nodos.keys # Obtiene todos los nodos del grafo

    # Inicializa las distancias como infinito y los previos como nil
    nodos.each do |nodo|
      distancias[nodo] = Float::INFINITY
      previos[nodo] = nil
    end

    # La distancia al nodo inicial es 0
    distancias[inicio] = 0
    # Mientras haya nodos por procesar
    while nodos.any?
      # Selecciona el nodo con la menor distancia
      nodo_actual = nodos.min_by { |nodo| distancias[nodo] }
      break if nodo_actual == fin # Si llegamos al final, terminamos

      nodos.delete(nodo_actual)  # Removemos el nodo actual de la lista
      # Para cada vecino del nodo actual
      grafo.vecinos(nodo_actual).each do |vecino, peso|
        if peso == 0
          peso = 1 # Si el peso es 0, lo convertimos a 1
        end
        # Calculamos la distancia alternativa
        alt = distancias[nodo_actual] + peso
        # Si encontramos un camino más corto
        if alt < distancias[vecino]
          distancias[vecino] = alt # Actualizamos la distancia
          previos[vecino] = nodo_actual # Actualizamos el camino
        end
      end
    end

    # Reconstruimos el camino
    camino = []
    nodo_actual = fin
    while nodo_actual
      camino.unshift(nodo_actual) # Agregamos el nodo al inicio del camino
      nodo_actual = previos[nodo_actual] # Movemos al nodo anterior
    end

    [camino, distancias[fin]] # Retornamos el camino y la distancia total
  end
end

=begin Esta clase implementa el algoritmo de Dijkstra:
Encuentra el camino más corto entre dos nodos en un grafo ponderado
Maneja casos especiales como pesos = 0
Retorna tanto el camino como la distancia total 
=end