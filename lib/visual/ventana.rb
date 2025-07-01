require 'ruby2d'
require_relative 'nodo'
require_relative 'arista'
require_relative '../algoritmo/dijkstra'
require_relative '../grafo/grafo'

class Ventana
  # Constante para la fuente a utilizar
  FONT = 'assets/fonts/ArimaMadurai-Regular.ttf'

  def initialize
    # Inicialización de estructuras de datos
    @grafo = Grafo.new           # Grafo para el algoritmo
    @nodos = []                  # Lista de nodos visuales
    @aristas = []                # Lista de aristas visuales
    @nodo_seleccionado = nil     # Nodo actualmente seleccionado
    @letras = ('A'..'Z').to_a    # Letras disponibles para nodos
    @input_activo = nil          # Control del input actual
    @start_node = ''             # Nodo inicial para Dijkstra
    @end_node = ''               # Nodo final para Dijkstra
    @peso_arista = ''            # Peso para nuevas aristas
    crear_elementos_ui           # Crea la interfaz
  end

  def crear_elementos_ui
    # Título de la aplicación
    @titulo = Text.new('Dijkstra Visualizer', x: 10, y: 10, size: 20, font: FONT)
    
    # Input para nodo inicial
    @input_start = Rectangle.new(x: 10, y: 50, width: 100, height: 30, color: 'gray')
    @text_start = Text.new("Start: #{@start_node}", x: 15, y: 55, size: 15, font: FONT)
    
    # Input para nodo final
    @input_end = Rectangle.new(x: 120, y: 50, width: 100, height: 30, color: 'gray')
    @text_end = Text.new("End: #{@end_node}", x: 125, y: 55, size: 15, font: FONT)
    
    # Botón de ejecución
    @boton_run = Rectangle.new(x: 230, y: 50, width: 80, height: 30, color: 'blue')
    @texto_boton = Text.new('RUN', x: 250, y: 55, size: 15, color: 'white', font: FONT)

    # Botón de borrado
    @boton_delete = Rectangle.new(x: 320, y: 50, width: 80, height: 30, color: 'red')
    @texto_delete = Text.new('DELETE', x: 330, y: 55, size: 15, color: 'white', font: FONT)
    
    # Input para peso de arista
    @input_peso = Rectangle.new(x: 420, y: 50, width: 60, height: 30, color: 'gray')
    @texto_peso = Text.new("Peso: #{@peso_arista}", x: 425, y: 55, size: 15, font: FONT)
  end

  def crear_nodo(x, y)
    # Crea un nuevo nodo en la posición del clic
    letra = @letras[@nodos.size]  # Asigna la siguiente letra disponible
    color = color_random          # Asigna un color aleatorio
    nodo = Nodo.new(x, y, letra, color)
    @nodos << nodo
    @grafo.agregar_nodo(letra)
  end

  def crear_arista(nodo1, nodo2)
    # Crea una nueva arista entre dos nodos
    peso = @peso_arista.to_i
    arista = Arista.new(nodo1, nodo2, peso)
    @aristas << arista
    @grafo.agregar_arista(nodo1.letra, nodo2.letra, peso)
  end

  def manejar_clic(x, y)
    # Maneja los clics en diferentes elementos de la interfaz
    if @input_start.contains?(x, y)
      @input_activo = :start
    elsif @input_end.contains?(x, y)
      @input_activo = :end
    elsif @input_peso.contains?(x, y)
      @input_activo = :peso
    elsif @boton_run.contains?(x, y)
      ejecutar_dijkstra
    elsif @boton_delete.contains?(x, y)
      borrar_todo
    else
      # Maneja clics para crear/conectar nodos
      @input_activo = nil
      nodo_clickeado = @nodos.find { |n| n.contiene?(x, y) }
      if nodo_clickeado
        if @nodo_seleccionado
          crear_arista(@nodo_seleccionado, nodo_clickeado)
          @nodo_seleccionado = nil
        else
          @nodo_seleccionado = nodo_clickeado
        end
      else
        crear_nodo(x, y)
      end
    end
  end

  def borrar_todo
    # Limpia todos los elementos visuales y datos
    @aristas.each do |arista|
      arista.normalizar
      arista.eliminar
    end
  
    @nodos.each do |nodo|
      nodo.normalizar
      nodo.eliminar
    end
    
    # Reinicia todas las estructuras de datos
    @nodos.clear
    @aristas.clear
    Arista.limpiar_aristas  # Limpia la lista de todas las aristas
    @grafo = Grafo.new
    @nodo_seleccionado = nil
    @start_node = ''
    @end_node = ''
    actualizar_textos_input
    puts "Todo ha sido borrado."
  end


  def actualizar
    # Actualiza todos los elementos visuales
    @nodos.each(&:dibujar)
    @aristas.each(&:dibujar)
    @input_peso.add
    @texto_peso.add
    @boton_delete.add
    @texto_delete.add
  end

  # Métodos para manejar entrada de texto
  def manejar_tecla(key)
    case @input_activo
    when :start, :end
      manejar_input_nodo(key)
    when :peso
      manejar_input_peso(key)
    end
  end

  def manejar_input_nodo(key)
    # Maneja la entrada de texto para nodos inicio/fin
    if key == 'backspace'
      if @input_activo == :start
        @start_node = @start_node[0...-1]
      else
        @end_node = @end_node[0...-1]
      end
    elsif key.length == 1 && @letras.include?(key.upcase)
      if @input_activo == :start
        @start_node += key.upcase
      else
        @end_node += key.upcase
      end
    end
    actualizar_textos_input
  end

  def manejar_input_peso(key)
    # Maneja la entrada de texto para pesos
    if key == 'backspace'
      @peso_arista = @peso_arista[0...-1]
    elsif key =~ /^\d$/ && @peso_arista.length < 3  # Limita a 3 dígitos
      @peso_arista = (@peso_arista + key).to_i.to_s 
    end
    actualizar_textos_input
  end

  def actualizar_textos_input
    # Actualiza los textos mostrados en los inputs
    @text_start.text = "Start: #{@start_node}"
    @text_end.text = "End: #{@end_node}"
    if @peso_arista == ''
      @texto_peso.text = "Peso: 1"
    else
      @texto_peso.text = "Peso: #{@peso_arista}"
    end
  end

  def ejecutar_dijkstra
    # Ejecuta el algoritmo de Dijkstra
    return if @start_node.empty? || @end_node.empty?
    
    camino, distancia = Dijkstra.calcular(@grafo, @start_node, @end_node)
    if camino
      resaltar_camino(camino)
      puts "Camino más corto: #{camino.join(' -> ')}, Distancia: #{distancia}"
    else
      puts "No se encontró un camino entre #{@start_node} y #{@end_node}"
    end
  end

  def resaltar_camino(camino)
    # Resalta visualmente el camino encontrado
    @nodos.each { |nodo| nodo.color = 'gray' }
    @aristas.each { |arista| arista.color = 'gray' }
    
    camino.each_cons(2) do |nodo1, nodo2|
      nodo_visual1 = @nodos.find { |n| n.letra == nodo1 }
      nodo_visual2 = @nodos.find { |n| n.letra == nodo2 }
      nodo_visual1.resaltar if nodo_visual1
      nodo_visual2.resaltar if nodo_visual2
      arista = @aristas.find { |a| (a.nodo1.letra == nodo1 && a.nodo2.letra == nodo2) || (a.nodo1.letra == nodo2 && a.nodo2.letra == nodo1) }
      arista.resaltar if arista
    end
  end

  private

  def color_random
    # Genera un color aleatorio de una lista predefinida
    ncolors=['red','yellow','blue', 'orange', 'purple', 'aqua','lime','teal','olive', 'silver']
    scolor = rand(0..9)
    return ncolors[scolor]
  end
end

=begin
Esta es la clase principal que:
Maneja la interfaz gráfica completa
Coordina la interacción entre todos los componentes
Procesa la entrada del usuario
Gestiona la creación y conexión de nodos
Controla la ejecución del algoritmo
Maneja la visualización de resultados
=end