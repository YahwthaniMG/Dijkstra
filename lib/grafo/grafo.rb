class Grafo
  attr_reader :nodos

  def initialize
    @nodos = {} # Estructura para almacenar el grafo
  end

  def agregar_nodo(nodo)
    @nodos[nodo] = {} unless @nodos.key?(nodo) # Inicializa un nodo si no existe
  end

  def agregar_arista(nodo1, nodo2, peso)
    @nodos[nodo1][nodo2] = peso # Agrega una arista dirigida de nodo1 a nodo2
  end

  def vecinos(nodo)
    @nodos[nodo] # Retorna todos los vecinos de un nodo
  end
end

=begin 
Esta clase maneja la estructura del grafo:
Almacena los nodos y sus conexiones
Implementa un grafo dirigido (las conexiones son unidireccionales)
Mantiene los pesos de las aristas 
=end