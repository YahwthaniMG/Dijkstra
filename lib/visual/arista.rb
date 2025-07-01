class Arista
  attr_reader :nodo1, :nodo2
  attr_accessor :color

  @@todas_las_aristas = [] # Variable de clase que almacena todas las aristas creadas

  def initialize(nodo1, nodo2, peso)
    @nodo1 = nodo1
    @nodo2 = nodo2
    # Si el peso es 0, se establece como 1
    if peso == 0
      @peso = 1
    else
      @peso = peso
    end
    @color = determinar_color_inicial # Determina el color basado en la dirección
    @width = 2 # Grosor inicial de la línea
    @tiene_opuesta = self.class.arista_opuesta_existe?(nodo1, nodo2)
    @@todas_las_aristas << self # Agrega esta arista a la lista global
    actualizar_elementos_visuales
  end

  def self.limpiar_aristas
    @@todas_las_aristas.clear # Limpia la lista global de aristas
  end

  def dibujar
    actualizar_elementos_visuales
    @linea.add
    @flecha.add
    @texto.add
  end

  def eliminar
    @linea.remove if @linea
    @flecha.remove if @flecha
    @texto.remove if @texto
  end

  def resaltar
    @color_original = @color  # Guarda el color original
    @color = 'green'
    @width = 4
    actualizar_elementos_visuales
  end

  def normalizar
    @color = @color_original || determinar_color_inicial  # Restaura el color original
    @width = 2
    actualizar_elementos_visuales
  end

  private

  def determinar_color_inicial
    # Azul si va de A->B, Rojo si va de B->A
    @nodo1.letra < @nodo2.letra ? 'blue' : 'red'
  end

  def self.arista_opuesta_existe?(nodo1, nodo2)
    @@todas_las_aristas.any? do |arista|
      arista.nodo1 == nodo2 && arista.nodo2 == nodo1
    end
  end

  def actualizar_elementos_visuales
    eliminar

    # Crea la línea principal con z = 0 (atrás)
    @linea = Line.new(
      x1: @nodo1.x, y1: @nodo1.y,
      x2: @nodo2.x, y2: @nodo2.y,
      width: @width,
      color: @color,
      z: 0  # Se dibuja en el fondo
    )

    # Calcula el ángulo para la flecha
    angulo = Math.atan2(@nodo2.y - @nodo1.y, @nodo2.x - @nodo1.x)
    radio_nodo = 20

    # Calcula la posición de la flecha
    fx = @nodo2.x - radio_nodo * Math.cos(angulo)
    fy = @nodo2.y - radio_nodo * Math.sin(angulo)
    
    # Crea la punta de la flecha
    tam_flecha = 10
    @flecha = Triangle.new(
      x1: fx,
      y1: fy,
      x2: fx - tam_flecha * Math.cos(angulo - Math::PI/6),
      y2: fy - tam_flecha * Math.sin(angulo - Math::PI/6),
      x3: fx - tam_flecha * Math.cos(angulo + Math::PI/6),
      y3: fy - tam_flecha * Math.sin(angulo + Math::PI/6),
      color: @color,
      z: 0  # Esto pone la flecha en el fondo
    )

    # Calcula la posición del texto del peso
    distancia_texto = radio_nodo + 10
    text_x = @nodo1.x + distancia_texto * Math.cos(angulo)
    text_y = @nodo1.y + distancia_texto * Math.sin(angulo)

    # Crea el texto del peso
    @texto = Text.new(
      "#{@peso}",
      x: text_x - 15,
      y: text_y - 10,
      size: 15,
      color: @color,
      font: Ventana::FONT,
      z: 2  # Esto pone el texto encima de todo
    )
  end
end

=begin
Esta clase maneja la representación visual de las aristas:
Dibuja líneas con flechas entre nodos
Maneja colores diferentes según la dirección
Muestra el peso de cada arista
Controla la profundidad de los elementos visuales
Permite resaltar y normalizar las aristas para mostrar el camino más corto
=end