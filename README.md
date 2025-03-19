# Grap Gallery en R - Visualización de Datos con R Shiny

**Bienvenido/a a Graph Gallery en R**, una aplicación interactiva desarrollada en `Shiny` para explorar distintos tipos de gráficos en R. Aprende y visualiza cómo generar potentes visualizaciones con `ggplo2`, `plotly` y `R base`.

## Descripción del Proyecto

Graph Gallery en R es una aplicación Shiny que permite explorar distintos tipos de visualizaciones en R de una manera estructurada e interactiva. Desde gráficos de barras hasta diagramas de dispersión, esta aplicación está diseñada tanto para principiantes como para usuarios avanzados que desean mejorar sus habilidades en visualización de datos.

## Tecnologías utilizadas
* **R Shiny** - Para la interfaz interactiva.
* **shinydashboard** - Para un diseñoi moderno y estructurado.
* **ggplot2** - Visualizaciones estáticas de alta calidad.
*  **plotly** - Visualizaciones interactivas y dinámicas.
*   **DT** - Tablas interactivas.
*   **ggiraph** - Gráficos interactivos en `ggplot2`.
*   **bslib** - Personalización de temas en Shiny

## Características
* **Exploración de distintos tipos de gráficos**:
    * Gráficos de barras
    * Diagramas de dispersión
    * Histogramas
    * Mapas interactivos (próximamente)
* **Interactividad**:
    * Zoom y selección en los gráficos con `plotly`
    * Personalización dinámica de los gráficos
* **Tablas interactivas con `DT`**
* **Temas personalizables con `bslib`**
* **Interfaz moderna con `shinydashboard`**

## Instalación y uso
1. Clona este repositorio

```{cmd}
git clone https://github.com/AlbertoMadinRivera/GraphGallery_R.git
  cd GraphGallery_R
```

2. Clonar desde R
```{cmd}
system("git clone https://github.com/AlbertoMadinRivera/GraphGallery_R.git")
  setwd("GraphGallery_R")
```

3. Clonar desde Python
```{cmd}
import os
  os.system("git clone https://github.com/AlbertoMadinRivera/GraphGallery_R.git")
  os.chdir("GraphGallery_R")
```

4. Instala los paquetes necesarios en R
```{cmd}
 install.packages(c("shiny", "shinydashboard", "ggplot2", "plotly", "DT", "ggiraph", "bslib"))
```

5. Ejecuta la aplicación
```{cmd}
shiny::runApp("App.R")
```

## Contribuciones
Si deseas contribuir a este proyecto, sigue los siguientes pasos:
1. **Fork** este repositorio.
2. Crea una nueva rama: `git checkout -b feature/nueva-funcionalidad`.
3. Realiza tus cambios y sube los commits: `git commit -m 'Agrega nueva funcionalidad'`.
4. Envía un **pull request**.

## Autor
**Alberto Madin Rivera**
* [Linkedin](https://www.linkedin.com/in/alberto-madin-rivera-3a1b38223/)
* Email: albertomadinrivera@gmail.com
* Email2: 2163019389@alumnos365.xoc.uam.mx


## Hashtags
#Shiny #Rstats #DataViz #Dashboards #DataScience #ggplot2 #plotly #OpenSource #MachineLearning #Visualizacion #BigData
