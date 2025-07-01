# Dijkstra Visualizer

Una aplicación interactiva desarrollada en Ruby que permite visualizar y ejecutar el algoritmo de Dijkstra para encontrar el camino más corto entre dos nodos en un grafo.

![Dijkstra Visualizer](https://img.shields.io/badge/Ruby-2.7+-red.svg)
![License](https://img.shields.io/badge/License-Open%20Source-green.svg)
![Academic Project](https://img.shields.io/badge/Academic-Project-blue.svg)

## 📋 Descripción

Este proyecto implementa una visualización interactiva del algoritmo de Dijkstra, permitiendo a los usuarios:

- Crear nodos haciendo clic en el área de trabajo
- Conectar nodos para formar aristas con pesos personalizados
- Ejecutar el algoritmo de Dijkstra para encontrar el camino más corto
- Visualizar el resultado con resaltado del camino óptimo

## 🚀 Características

- **Interfaz gráfica intuitiva**: Creación fácil de grafos mediante clics
- **Nodos automáticos**: Los nodos se etiquetan automáticamente con letras (A-Z)
- **Aristas dirigidas**: Soporte para grafos dirigidos con visualización de direcciones
- **Pesos personalizables**: Asignación de pesos específicos a cada arista
- **Visualización del resultado**: Resaltado del camino más corto encontrado
- **Funciones de limpieza**: Botón para borrar todo el grafo y empezar de nuevo

## 🛠️ Instalación

### Prerrequisitos

- Ruby 2.7 o superior
- Bundler (gestor de gemas de Ruby)

### Instalación de Ruby en Windows

1. **Descargar Ruby**:
   - Visita [RubyInstaller](https://rubyinstaller.org/)
   - Descarga la versión más reciente de Ruby+Devkit
   - Ejecuta el instalador y sigue las instrucciones

2. **Verificar la instalación**:
   ```bash
   ruby --version
   gem --version
   ```

3. **Instalar Bundler**:
   ```bash
   gem install bundler
   ```

### Configuración del proyecto

1. **Clonar el repositorio**:
   ```bash
   git clone https://github.com/YahwthaniMG/dijkstra_visualizer.git
   cd dijkstra_visualizer
   ```

2. **Instalar dependencias**:
   ```bash
   gem install ruby2d
   ```

3. **Ejecutar la aplicación**:
   ```bash
   ruby main.rb
   ```

## 🎮 Uso

### Creación del grafo

1. **Crear nodos**: Haz clic en cualquier área vacía para crear un nuevo nodo
2. **Conectar nodos**: 
   - Haz clic en un nodo (se seleccionará)
   - Haz clic en otro nodo para crear una arista entre ambos
3. **Establecer pesos**: 
   - Introduce el peso deseado en el campo "Peso"
   - El peso se aplicará a las nuevas aristas creadas

### Ejecución del algoritmo

1. **Configurar nodos**: 
   - Introduce la letra del nodo inicial en el campo "Start"
   - Introduce la letra del nodo final en el campo "End"
2. **Ejecutar**: Haz clic en el botón "RUN"
3. **Ver resultado**: El camino más corto se resaltará en verde

### Controles adicionales

- **DELETE**: Borra todos los nodos y aristas del grafo
- **Peso por defecto**: Si no se especifica peso, se asigna automáticamente 1

## 🏗️ Estructura del proyecto

```
dijkstra-visualizer/
├── main.rb                    # Punto de entrada de la aplicación
├── lib/
│   ├── algoritmo/
│   │   └── dijkstra.rb       # Implementación del algoritmo de Dijkstra
│   ├── grafo/
│   │   └── grafo.rb          # Estructura de datos del grafo
│   └── visual/
│       ├── ventana.rb        # Ventana principal y manejo de eventos
│       ├── nodo.rb           # Representación visual de nodos
│       └── arista.rb         # Representación visual de aristas
└── assets/
    └── fonts/
        └── ArimaMadurai-Regular.ttf  # Fuente utilizada
```

## 🧩 Componentes principales

### Ventana (`lib/visual/ventana.rb`)
- Maneja la interfaz gráfica completa
- Procesa eventos de mouse y teclado
- Coordina la interacción entre componentes
- Controla la ejecución del algoritmo

### Algoritmo de Dijkstra (`lib/algoritmo/dijkstra.rb`)
- Implementa el algoritmo clásico de Dijkstra
- Encuentra el camino más corto entre dos nodos
- Maneja casos especiales (pesos = 0)
- Retorna el camino y la distancia total

### Nodo (`lib/visual/nodo.rb`)
- Representación visual de los nodos del grafo
- Maneja la detección de clics
- Controla el resaltado visual

### Arista (`lib/visual/arista.rb`)
- Representación visual de las conexiones
- Dibuja líneas direccionales con flechas
- Muestra los pesos de las aristas
- Maneja diferentes colores según la dirección

### Grafo (`lib/grafo/grafo.rb`)
- Estructura de datos del grafo dirigido
- Almacena nodos y sus conexiones
- Mantiene los pesos de las aristas

## 🎯 Ejemplos de uso

### Crear un grafo simple
1. Crea 3 nodos haciendo clic en diferentes posiciones
2. Establece el peso como "5" en el campo de peso
3. Conecta el nodo A con B
4. Establece el peso como "3" 
5. Conecta el nodo B con C
6. Establece el peso como "8"
7. Conecta el nodo A con C
8. Ejecuta Dijkstra de A a C

### Resultado esperado
- El algoritmo mostrará que el camino más corto es A → B → C con distancia total de 8
- Los nodos y aristas del camino se resaltarán en verde

## 📚 Documentación adicional

Para obtener información más detallada sobre el proyecto, incluyendo especificaciones técnicas y documentación completa, consulta los archivos:

- `AIV_2nd_Partial_Project.pdf`
- `AIV_2nd_Partial_Project.docx`

Estos documentos contienen información adicional sobre la implementación, metodología y detalles técnicos del proyecto.

## 🐛 Solución de problemas

**Error: "No such file or directory - ruby2d"**
- Solución: Instala la gema ruby2d con `gem install ruby2d`

**Error: "Font not found"**
- Solución: Asegúrate de que el archivo de fuente esté en `assets/fonts/`

**El algoritmo no encuentra camino**
- Verifica que los nodos estén correctamente conectados
- Asegúrate de usar las letras exactas de los nodos creados

### Problemas comunes

## 🤝 Contribuciones

Este es un proyecto de código abierto desarrollado con fines académicos. Las contribuciones son bienvenidas. Para contribuir:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto es de código abierto y fue desarrollado con fines educativos. Puedes usar, modificar y distribuir este código libremente para cualquier propósito.

## 👨‍💻 Equipo de desarrollo

**Desarrolladores:**
- Carlos Daniel Esparza Osuna
- Isaac Humberto Preciado Bazavilvazo  
- Eduardo Ulises Martínez Vaca
- Yahwthani Morales Gómez

**Profesor:**
- Alfredo Emmanuel García Falcón

## 🙏 Agradecimientos

- [Ruby2D](https://www.ruby2d.com/) por la librería de gráficos
- Edsger W. Dijkstra por el algoritmo fundamental
- La comunidad de Ruby por el soporte y documentación

---

⭐ Si este proyecto te fue útil, ¡considera darle una estrella!
