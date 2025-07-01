class Nodo
  attr_reader :x, :y, :letra
  attr_accessor :color

  def initialize(x, y, letra, color)
    @x = x
    @y = y
    @letra = letra
    @color = color
    @radius = 20
    actualizar_elementos_visuales
  end

  def dibujar
    actualizar_elementos_visuales
    @circulo.add
    @texto.add
  end

  def eliminar
    @circulo.remove if @circulo
    @texto.remove if @texto
  end

  def resaltar
    @color = 'green'  
    @radius = 25
    actualizar_elementos_visuales
  end

  def normalizar
    @radius = 20
    actualizar_elementos_visuales
  end

  def contiene?(px, py)
    Math.sqrt((px - @x)**2 + (py - @y)**2) <= @radius
  end

  private

  def actualizar_elementos_visuales
    eliminar
    
    @circulo = Circle.new(
      x: @x, y: @y,
      radius: @radius,
      sectors: 32,
      color: @color,
      z: 1
    )
    
    # Siempre usaremos texto negro para mayor simplicidad y legibilidad
    @texto = Text.new(
      @letra,
      x: @x - 6,
      y: @y - 10,
      size: 20,
      color: 'black',
      font: Ventana::FONT,
      z: 2
    )
  end
end

=begin
Esta clase maneja la representación visual de los nodos:
Dibuja círculos con letras
Controla el tamaño y color de los nodos
Permite detectar clics en los nodos
Maneja el resaltado de nodos para mostrar el camino más corto
Controla la profundidad de los elementos visuales
=end