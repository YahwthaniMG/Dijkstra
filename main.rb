require 'ruby2d'
require_relative 'lib/visual/ventana'

# Configura la ventana principal
set title: "Dijkstra Visualizer", width: 800, height: 600, background: 'white'

# Crea una instancia de la clase Ventana
ventana = Ventana.new

# Maneja los eventos de clic del mouse
on :mouse_down do |event|
  if event.button == :left
    ventana.manejar_clic(event.x, event.y)
  end
end

# Maneja los eventos del teclado
on :key_down do |event|
  ventana.manejar_tecla(event.key)
end

# Bucle principal de actualización
update do
  ventana.actualizar
end

# Muestra la ventana
show
=begin
Este archivo es el punto de entrada de la aplicación:

Configura una ventana de 800x600 píxeles con fondo blanco
Establece los manejadores de eventos para mouse y teclado
Crea un bucle de actualización continua
Inicia la visualización
=end