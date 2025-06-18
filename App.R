rm(list = ls())
cat("\014")  # Esto limpia la consola

library(shiny)
library(shinydashboard)
library(ggplot2)
library(plotly)
library(markdown)
library(DT)
library(ggiraph)
library(bslib)

# Aplicar tema oscuro con primary en negro
shinyOptions(bootstrap = 4)

# CSS para personalizar la barra superior y los box
custom_css = tags$head(
  tags$style(HTML("
    /* Hacer la barra superior completamente negra */
    .main-header .navbar {
      background-color: #000000 !important;
    }
    
    /* Hacer la parte del título negra */
    .main-header .logo {
      background-color: #000000 !important;
      color: #FFFFFF !important; /* Texto en blanco */
      font-weight: bold;
    }
    
    /* Hacer el texto del navbar en blanco */
    .main-header .navbar .navbar-brand {
      color: #FFFFFF !important;
    }

    /* Personalizar los box para que sean negros */
    .box.box-black {
      background-color: #000000 !important;
      border-color: #000000 !important;
      color: #FFFFFF !important; /* Texto en blanco */
    }

    /* Cambiar también el header del box */
    .box.box-black>.box-header {
      background-color: #000000 !important;
      color: #FFFFFF !important;
    }
  "))
)


################################################################################

# Definir la UI
ui = dashboardPage(
  skin = "black",
  dashboardHeader(title = "Graph Gallery"),
  
  dashboardSidebar(
    # Menú de navegación
    sidebarMenu(
      menuItem("Página Principal", tabName = "home", icon = icon("home")),
      
      menuItem("Introducción a R", tabName = "r_introduction", icon = icon("sitemap"),
               menuSubItem("¿Qué es R?", tabName = "r_0"),
               menuSubItem("¿Qué es ggplot2?", tabName = "r_2"),
               menuSubItem("¿Qué es plotly?", tabName = "r_3")
               ),
      
      # Gráficos de Barras (con subopciones)
      menuItem("Gráfico de Barras", tabName = "barplot_main", icon = icon("bar-chart"),
               menuSubItem("Introducción", tabName = "barplot__1"),
               menuSubItem("Gráfico de Barras r base", tabName = "barplot_base"),
               menuSubItem("Gráfico de Barras ggplot2", tabName = "barplot_ggplot2"),
               menuSubItem("Gráfico de Barras con Plotly", tabName = "barplot_colored")
      ),
      
      # Gráficos de Dispersión (con subopciones)
      menuItem("Gráfico de Dispersión", tabName = "scatterplot", icon = icon("line-chart"),
               menuSubItem("Introducción", tabName = "scatterplot_1"),
               menuSubItem("Gráfico de Dispersión r base", tabName = "scatterplot"),
               menuSubItem("Gráfico de Dispersión con ggplot2", tabName = "scatterplot_colored"),
               menuSubItem("Distribución marginal con ggExtra", tabName = "scatterplot_ggExtra"),
               menuSubItem("Diagrama de Dispersión con Plotly", tabName = "scatterplot_plotly")
      )
    )
  ),
  
  dashboardBody(
    theme = custom_css,  # Aplicar tema bslib
    custom_css,  # Incluir CSS para la barra negra
    
    tabItems(
      # Página principal (Home)
      tabItem(tabName = "home",
              fluidRow(
                box(title = "¡Bienvenido a la Graph Gallery!",
                    status = NULL,
                    class = "box-black",
                    solidHeader = TRUE, 
                    width = 12,
                    tags$div(style = "text-align: center;",
                             tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d5/Logo_de_la_UAM.svg/800px-Logo_de_la_UAM.svg.png", 
                                      height = "100px", width = "auto")),
                    br(),
                    HTML('
                         <h1 style="text-align: center;">¡Bienvenidos a la Galería de Gráficos en R!</h1>
                         <p>
                         <b>Alberto Madin Rivera</b>, economista comprometido con el
                         análisis riguroso de datos y el desarrollo de herramientas visuales
                         que faciliten la comprensión de fenómenos económicos complejos.
                         Con una formación académica sólida como Licenciado en Economía por la
                         Universidad Autónoma Metropolitana (UAM) Xochimilco. Siendo destacado a
                         lo largo de la carrera en diversas áreas de la economía, incluyendo
                         microeconomía, macroeconomía, economía internacional, estadística y
                         econometría neoclásica. Este enfoque me ha permitido abordar problemas
                         económicos desde una perspectiva analítica y cuantitativa,
                         utilizando herramientas matemáticas y estadísticas para ofrecer soluciones
                         prácticas en diferentes contextos.
                         La integración de la teoría económica con las técnicas de 
                         visualización y análisis de datos es uno de los pilares del trabajo.
                         A través de la Galería de Gráficos en <code>R</code>, pongo a disposición de
                         estiduantes, académicos y profesionales una amplia gama de recursos didácticos y
                         herramientas interactivas que permiten explorar y analizar grandes
                         volúmenes de datos de manera eficiente. Este proyecto busca democraticar el acceso
                         a la visualización de datos y promover una comprensión más profunda
                         de los patrones y relaciones económicas que subyacen en los fenómenos sociales
                         y de mercado.
                         </p>
                         
                         <p>
                         Dentro de la carrera universitaria con la que he forjado conocimientos,
                         cuento con la afinidad de la teoría neoclásica, que constituye uno de los
                         enfoques más influyentes en el análisis económico moderno. Desde los primeros estudios
                         he trabajado con los principios fundamentales de la microeconomía y la
                         macroeconomía neoclásica, como el equilibrio de mercado,
                         la racionalidad de los agentes económicos y la maximización de la utilidad y la producción.
                         El enfoque se distingue por usar modelos matemáticos y econométricos para explicar y
                         predecir el comportamiento económico tanto a nivel indivisual como agregado y
                         predecir el comportamiento económico tanto
                         a nivel individual como agregado, aplicando los principios neoclásicos para abordar
                         problemas contemporáneos de la economía global.
                         En el campo de la <b>microeconomía</b> he analizado y modelado el comportamiento de los
                         agentes económicos, abordando temas como la teoría del consumidor, teoría de la producción,
                         teoría de costos, competencia perfecta y los mercados monopolistas, siempre con un enfoque
                         basado en los supuestos clave de la racionalidad y la maximización de la utilidad.
                         En el ámbito de la <b>macroeconomía</b>, he trabajado con modelos de equilibrio
                         general y análisis de políticas económicas, buscando comprender la dinámica de variables
                         agregadas como el producto interno bruto (PIB), el desempleo y la inflación,
                         con un énfasis particular en la aplicación de modelos matemáticos y ecuaciones estructurales
                         del corto, mediano y largo plazo.
                         Por otra parte, en <b>economía internacional</b> he explorado el comercio internacional,
                         las políticas cambiarias y los flujos de capitales, integrando herramientas econométricas
                         para estudiar los efectos de las políticas comerciales y monetarias en los mercados
                         globales. La visión neoclásica me ha permitido aplicar modelos de ventaja comparativa y
                         teorías del comercio internacional para analizar los beneficios del libre comercio y la globalización.
                         </p>
                         
                         <p>
                         El conocimiento de la teoría económica no se limita a la capacidad de que me ayude a comprender
                         los modelos económicos, sino que también extiende al dominio de la <b>estadística</b> y la 
                         <b>econometría</b>, disciplinas fundamentales para la validación y aplicación de teorías
                         económicas. A través de la formación y experiencia profesional, he perfeccionado
                         la capacidad para aplicar métodos estadísticos avanzados para analizar datos económicos
                         reales, identificar patrones y estimar modelos econométricos.
                         Esto me ha permitido desarrollar herramientas estadísticas de alto nivel para el análisis
                         de series temporales, datos de corte transversal y paneles de datos,
                         utilizando tantos métodos tradicionales como modernos.
                         La econometría, en particular, ha sido un campo de especialización clave en mi carrera.
                         La capacidad para identificar relaciones causales entre
                         variables económicas a través de modelos de regresión y técnicas avanzadas de estimación
                         ha sido crucial para evaluar políticas económicas y su impacto en la economía. Además,
                         el dominio de las técnicas de <b>análisis de series temporales</b> y <b>modelos dinámicos</b>
                         me ha permitido estudiar fenómenos económicos como las fluctuaciones del ciclo económico,
                         las tasas de interés, las políticas fiscales y monetarias, entre otros.
                         </p>
                         
                         <p>
                         Uno de los logros más significativos que he tenido ha sido la creación
                         de la <b>Galerìa de Gráficos en R</b>, una plataforma interactiva
                         y accesible destinada a estudiantes y profesionales de la economía, la
                         estadística, la administración y las ciencias sociales. Este sitio web
                         es el resultado del deseo de compartir el conocimiento en el análisis
                         de datos y visualización,permitiendo a lo usuarios explorar y compreder
                         patrones y relaciones en los datos a través de gráfios interacivos y estáticos
                         en <code>R</code>, un lenguaje de programación reconocido por su eficacia en el
                         análisis estadístico y visualización de datos.
                         La galería ofrece una colección extensa de gráficos que cubren diversas
                         áreas de la economía, tales como la representación de series temporales
                         económicas, análisis de regresión, distribución de probabilidad y 
                         simulaciones de modelos económicos. Cada gráfico está acompañado de su
                         respectivo código en <code>R</code>, lo que permite a los
                         usuarios no solo replicar los gráficos, sino también modificar y adaptar
                         el código a sus propios proyectos. Esta característica hace que el sitio sea
                         una herramienta invaluable para el aprendizaje práctico de técnicas avanzadas
                         de visualización de datos, especialmente en el contexo económico y actuarial.
                         Además, el sitio no se limita solo a proporcionar ejemplos de gráficos,
                         sino que también incluye explicaciones detalladas sobre el proceso de creación
                         de cada uno, permitiendo a los usuarios comprender las decisiones metodológicas
                         detrás de cada visualización. El enfoque didáctico y accesible
                         de la plataforma la convierte en un recurso valioso tanto para quienes se inician
                         en el análisis de datos como para profesionales experimentados que
                         buscan mejorar sus habilidades de visualización y análisis.
                         </p>
                         
                         <p>
                         El sitio está diseñado para ser un espacio de aprendizaje interactivo, donde los
                         usuarios no solo consumen información, sino que tamién experimentan con los datos y se
                         convierten en creadores de sus propios análisis. La posibilidad
                         de personalizar y replicar gráficos proporciona a los usuarios una comprensión
                         más profunda de los procesos detrás de la visualización de datos, lo que contribuye a la formación
                         de un perfil profesional altamente capacitado para trabajar con datos complejos
                         y realizar análisis de alta calidad.
                         </p>
                         
                         <p>
                         Este proyecto está inspirado en los artículos, tutoriales y 
                         páginas web creadas por el reconocido experto en visualización 
                         de datos y análisis en <code>R</code>, <b>Yan Holtz</b>. 
                         A lo largo de su carrera, Yan ha sido una fuente invaluable de 
                         conocimiento para aquellos interesados en la creación de 
                         visualizaciones efectivas y en el dominio del lenguaje de 
                         programación <code>R</code>. Su trabajo ha ayudado a miles de 
                         estudiantes y profesionales a mejorar sus habilidades de 
                         visualización de datos, proporcionando recursos accesibles y 
                         prácticos que permiten a los usuarios no solo aprender a crear 
                         gráficos, sino también a comprender los conceptos y metodologías 
                         subyacentes.
                         En particular, sus páginas web y artículos han servido como 
                         guía para la creación de gráficos interactivos y estáticos 
                         en <code>R</code>, utilizando herramientas avanzadas 
                         como <code>ggplot2</code>, <code>plotly</code>, <code>dplyr</code>, 
                         entre 
                         otros paquetes y librerías. La claridad y profundidad 
                         con la que aborda los temas hacen de su trabajo una referencia 
                         imprescindible en el ámbito de la visualización de datos. 
                         Este proyecto, la <b>Galería de Gráficos en R</b>, se 
                         inspira en esa misma filosofía: ofrecer contenido práctico, 
                         accesible y orientado al aprendizaje activo, permitiendo a los 
                         usuarios replicar y personalizar visualizaciones para sus propios proyectos 
                         y necesidades.
                         Si estás interesado en explorar más sobre su trabajo y los 
                         recursos que ofrece, te invito a visitar su página web 
                         oficial. En ella encontrarás una serie de tutoriales, 
                         ejemplos de código, y artículos que te ayudarán a profundizar 
                         en el mundo de la visualización de datos y a mejorar tus 
                         habilidades en el uso de <code>R</code>. Puedes acceder a su 
                         sitio web a través del siguiente enlace:
                         <a href="https://www.yan-holtz.com/" target="_blank">Yan Holtz</a>.
                         </p>
                         
                         <hr>
                         
                         <p>
                         Puedes seleccionar cualquier cuadro del menú de la izquierda para comenzar a explorar.
                         </p>
                         '),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                    ),
                box(title = "Información de contacto",                     
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML("<p>
                         <i class = 'fa fa-envelope-open-o'></i><b> Correo</b>:   2163019389@alumnos365.xoc.uam.mx
                         <br>
                         <i class = 'fa fa-envelope-open-o'></i><b> Correo</b>:   2163019389@alumnos.xoc.uam.mx
                         <br>
                         <i class = 'fa fa-envelope-open-o'></i><b> Correo</b>:   albertomadinrivera@gmail.com
                         <br>
                         <i class = 'fa fa-envelope-open-o'></i><b> Correo</b>:   albertomadinrivera@outlook.com
                         <br>
                         <i class = 'fa fa-phone'></i><b> Teléfono</b>:           +52 55 3454 4963
                         <br>
                         <i class = 'fa fa-linkedin'></i><b> LinkedIn</b>:        Alberto Madin Rivera
                         </p>"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                    ),
                box(title = "Acerca del Autor", 
                    status = NULL,
                    class = "box-black",
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML('
                    <div style="display: flex; justify-content: space-between;">
                    <!-- Columna izquierda (1/3 para la foto) -->
                    <div style="width: 32%; padding: 10px; text-align: center; background-color: #a3e4d7;">
                    <img src="https://pbs.twimg.com/media/Ge3CFklaIAEK0zv?format=jpg&name=small" 
                    height="200px" width="auto" style="border-radius: 50%;"/>
                    <br>
                    <hr>
                    <h3>Habilidades y Conocimientos</h3>
                    <ul style="text-align: left;"> <!-- Lista sin centrado -->
                    <li>Análisis de datos</li>
                    <li>Resolución de problemas</li>
                    <li>Comunicación efectiva</li>
                    <li>Mejora continua</li>
                    <li>Gestión del cambio</li>
                    <li>Trabajo bajo presión con la calidad</li>
                    <li>Metodología Scrum / Agile</li>
                    </ul>
                    <br>
                    <h3>Programas y Softwares</h3>
                    <ul style="text-align: left;"> <!-- Lista sin centrado -->
                    <li>Microsoft Office</li>
                    <li>R, RStudio, RShiny, RMarkdown</li>
                    <li>Python, pyspark, Spyder, Jupyter Notebook</li>
                    <li>SQL Oracle, MySQL</li>
                    <li>Latex, Overleaf</li>
                    <li>HTML, CSS</li>
                    <li>Java Básico</li>
                    <li>Git y Github</li>
                    <li>Jira</li>
                    <li>Flask</li>
                    <li>Beautifulsoup</li>
                    <li>Dash, Plotly</li>
                    </ul>
                    <h3>Proyectos Personales</h3>
                    <ul style="text-align: left;"> <!-- Lista sin centrado -->
                    <li>Desarrollo Web</li>
                    <li>Desarrollo de pequeñas aplicaciones en Java para Programación Orientada a Objetos</li>
                    <li>Shiny Dashboard para trading</li>
                    <li>Galería de gráficos en R</li>
                    </ul>
                    </div>
  
                    <!-- Columna derecha (2/3 para el contenido HTML) -->
                    <div style="width: 64%; padding: 10px; background-color: #ebedef;">
                    <h1>Alberto Madin Rivera</h1>
                    <h2>Licenciado en Economía</h2>
                    <h3>Perfil</h3>
                    <p>Me especializo en la rama de la Econometría y el análisis de datos descriptivos.
                    Manejo lenguajes de programación en <code>R</code> y <code>Python</code>.
                    Así como el uso de programas para base de datos como <b>SQL Oracle</b>y <b>MySQL</b>.
                    Actualmente trabajo como <b>Estadístico de Operaciones Jr</b> en <b>NIQ</b>.
                    Donde he podido desarrollar mis habilidades dentro de la metodología Scrum.
                    </p>
                    <hr>
                    <h2>Experiencia Laboral</h2>
                    <h3>Estadístico Jr de Operaciones | NIQ</h3>
                    <h4>Junio 2022 - Actualidad</h4>
                    <ul>
                    <li>Participación en las próximas reuniones: Daily Stand Ups, Sample Meeting (Panel Management, DA) e Intermonth Sample Inspection.</li>
                    <li>Mantenimiento de una sample.</li>
                    <li>Ejecución y mantenimiento de la muestra, sobremuestreo de rotación.</li>
                    <li>Cálculo de factores de proyección.</li>
                    <li>Configuración de controles de calidad de datos y revisión de parámetros cada año.</li>
                    <li>Actualización de Universos.</li>
                    <li>Validación de tendencias.</li>
                    <li>Seguimiento ante requerimientos y solicitudes.</li>
                    <li>Análisis preliminares de Scorecard para cliente.</li>
                    </ul>
                    <br>
                    <h3>Analista Investigador de Datos Freelance | Superprof</h3>
                    <h4>Enero 2022 - Mayo 2022</h4>
                    <ul>
                    <li>Consultar el punto de contacto sobre el problema.</li>
                    <li>Reunión con el cliente para revisar cobertudas y alineaciones.</li>
                    <li>Análisis de datos exploratorios.</li>
                    <li>Creación de modelos econométricos y de Machine Learning.</li>
                    <li>Validación de hipótesis.</li>
                    <li>Vinculación con la teoría y modelos econométricos.</li>
                    <li>Creación de artículos e investigaciones.</li>
                    <li>Aprobación de cambios en Pull Request y commit de cambios en Github.</li>
                    </ul>
                    <h3>Becario de Proyecto | UAM - Xochimilco</h3>
                    <h4>Abril 2021 - Noviembre 2021</h4>
                    <ul>
                    <li>Diseño y creación de contenido temático en plataforma Moodle para la impartición de cursos de capacitación para la <b>SEP</b>.</li>
                    <li>Organización de formatos entregables.</li>
                    <li>Creación de Manuales y Actividades.</li>
                    <li>Reportes de entrega supervisando al equipo de trabajo.</li>
                    <li>Trabajo con un equipo bajo la línea de operación del área (Inicio - Fin del entregable)</li>
                    </ul>
                    <hr>
                    <h2>Educación</h2>
                    <h3>Licenciatura en Economía | Universidad Autónoma Metropolitana - Unidad Xochimilco</h3>
                    <h4>2016 - 2020</h4>
                    <ul>
                    <li>Graduado con Honores.</li>
                    <li>Titulado y Certificado con Cédula profesional.</li>
                    <li>Especializado en la Econometría y Estadística.</li>
                    </ul>
                    </div>
                    </div>'),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                    )
                )
              ),
      ##########################################################################
      # Introducción a R
      tabItem(
        tabName = "r_0",
        fluidRow(
          box(title = "¿Qué es R?", 
              status = NULL,
              class = "box-black",
              solidHeader = TRUE,
              width = 12,
              collapsible = TRUE,
              tags$div(style = "text-align: center;",
                       tags$img(src = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSdAx5hTJjeIWJA7pmVzHinb2xC_GDI7OqCjw&s", 
                                height = "100px", width = "auto")
              ),
              HTML('
                   <h1 style="text-align: center;">¿Qué es R?</h1>
                   <p>
                   <code>R</code> es un lenguaje de programación y un entorno de software
                   desarrollado principalmente para el análisis estadístico y la visualización de
                   datos. Su origen se remontaa 1993, cuando fue creado por Ross Ihaka y Robert
                   Gentleman. Desde ese entonces, ha evolucionado hasta convertirse en una de las
                   herramientas más populares en la comunidad académica, científica y profesional,
                   especialmente en áreas como la estadística, la economía, la ciencia de datos y
                   las ciencias sociales. Una de las características más destacadas de <code>R</code>
                   es su capacidad para realizar análisis estadísticos avanzados.
                   Ofrece una amplia gama de funciones estadísticas que permiten realizar desde analisis
                   descriptivos básicos hasta procedimientos más complejos como regresión,
                   análisis mutivariado, series temporales, pruebas de hipótesis y modelos
                   predictivos. Esto lo convierte en una herramienta ideal para los profesionales
                   que trabajan con grandes volúmenes de datos y que requieren análisis rigurosos y
                   detallados.
                   </p>
                   
                   <p>
                   Además de sus capacidades estadísticas, <code>R</code> se distingue por su
                   poder en la visualización de datos. Con herramientas como <code>ggplot2</code>,
                   <code>plotly</code> t <code>shiny</code>, los usuarios pueden crear visualizaciones interactivas
                   y personalizadas de alta calidad. Esto es fundamental en campos donde la comunicación
                   efectiva de los resultados de los análisis es crucial, como en la investigación científica
                   o en la toma de decisiones empresariales.
                   <code>R</code> es también un lenguaje de código abierto, lo que significa
                   que cualquiera puede acceder, modificar y distribuir su código fuente de manera
                   gratuita. Esto ha facilitado el desarrollo de una amplia comunidad de usuarios
                   y desarrolladores, quienes contribuyen constantemente con nuevos
                   paquetes y recursos. Los paquetes de <code>R</code> permiten extender su funcionalidad,
                   abordando tareas específicas y haciendo que el software sea aún más versátil. 
                   Por otro lado, <code>R</code> es conocido por su alto nivel de reproducibilidad.
                   Esto significa que los análisis realizados en <code>R</code> pueden ser fácilmente replicados,
                   lo cual es fundamental en la investigación científica y en entornos donde la
                   transparencia es clave. Además, la capaciad de escribir scripts en <code>R</code> hace que
                   sea posible documentar todo el proceso de análisis, asegurando que los resultados sean
                   verificables y reproducibles por otros.
                   </p>
                   
                   <p>
                   Entre las facilidades de usar <code>R</code>, podemos observar 5
                   formas de usar un <code>print("¡Hola Mundo!")</code> en otros lenguajes
                   de programación:
                   </p>

                   <li><b>Python:</b></li>
                   '),
              verbatimTextOutput("print_1"),
              HTML('
                   <li><b>JavaScript:</b></li>
                   '),
              verbatimTextOutput("print_2"),
              HTML('
                   <li><b>C:</b></li>
                   '),
              verbatimTextOutput("print_3"),
              HTML('
                   <li><b>Java:</b></li>
                   '),
              verbatimTextOutput("print_4"),
              HTML('
                   <li><b>Ruby:</b></li>
                   '),
              verbatimTextOutput("print_5"),
              HTML('
                   <p>
                   En resumen, <code>R</code> es especialmente útil si estás en el campo de
                   las ciencias de datos o estadísticas, y su sintaxis y entorno interactivo
                   facilitan tareas complejas de análisis sin necesidad de escribir demasiado
                   código.
                   </p>
                   '),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
              )
        )
      ),
      tabItem(
        tabName = "r_1",
        fluidRow(
          box(title = "¿Qué es R Base?",
              solidHeader = TRUE, 
              status = NULL,
              class = "box-black",
              width = 12,
              collapsible = TRUE,
              tags$div(style = "text-align: center;",
                       tags$img(src = "https://raw.githubusercontent.com/docker-library/docs/18225eea5667b1bc03a19024eb09ccc482207ecf/r-base/logo.png", 
                                height = "100px", width = "auto")
              ),
              HTML('
                   <h1 style="text-align: center;">¿Qué es R Base?</h1>
                   <p>
                   En <code>R</code>, el término <b>"R base"</b> se refiere al conjunto
                   de funciones y herramientas que vienen preinstaladas con el lenguaje de
                   programación <code>R</code>, es decir, todo lo que es esencial para realizar
                   análisis estadísticos, manipulación de datos y visualización de manera básica.
                   </p>
                   
                   <p>
                   <b>Gráficos en R base</b> se refieren a las funciones de visualización de datos que están
                   integradas directamente en <code>R</code> sin necesidad de utilizar paquetes
                   externos como <code>ggplot2</code> o <code>lattice</code>. Estas funciones
                   permiten crear gráficos básicos como diagrabas de barras, gráficos de dispersión,
                   histogramas, gráficos de líneas, entre otros.
                   </p>
                   
                   <p>
                   Algunos ejemplos de gráficos en <b>R base</b> incluyen:
                   </p>
                   <li><b>Gráfico de dispersión:</b></li>
                   '),
              verbatimTextOutput("r_primero"),
              HTML('
                   <p>
                   Donde <code>x</code> y <code>y</code> son vectores de datos
                   </p>
                   <li><b>Histograma:</b></li>
                   '),
              verbatimTextOutput("r_segundo"),
              HTML('
                   <p>
                   Donde <code>x</code> es un vector numérico de datos.
                   </p>
                   <li><b>Gráfico de barras:</b></li>
                   '),
              verbatimTextOutput("r_tercero"),
              HTML('
                   <p>
                   Donde <code>height</code> es un vector numérico o una tabla de
                   frecuencia.
                   </p>
                   <li><b>Gráfico de líneas:</b></li>
                   '),
              verbatimTextOutput("r_cuarto"),
              HTML('
                   <p>
                   Aquí <code>type = "l"</code> indica que el gráfico debe ser de líneas.
                   </p>
                   
                   <p>
                   Algunas de las características de los gráficos en R base son:
                    <ol>
                      <li><b>Simplicidad:</b> Son fáciles de crear, especialmente
                      para exploración rápida de los datos.</li>
                      <li><b>Interactividad limitada:</b> Los gráficos creados en R
                      base no suelen ser interactivos, a diferencia de los creados con 
                      herramientas más avanzadas.</li>
                      <li><b>Flexibilidad:</b> Si bien no son tan sofisticados como
                      los de otros paquetes, permiten personalizar aspectos básicos como títulos,
                      ejes y colores mediante argumentos en las funciones.</li>
                    </ol>
                   </p>
                   
                   <p>
                   A pesar de su simplicidad, R base es muy útil cuando se necesita
                   crear gráficos rápidos sin recurris a paquetes adicionales. Sin embargo,
                   si se desea más personalización y características avanzadas, herramientas como
                   <code>ggplot2</code> o <code>lattice</code> suelen ser más recomendables.
                   </p>
                   
                   <p>
                   Para mayor información, visita 
                   <a href = "https://r-charts.com/es/r-base/">R CHARTS: Gráficos de R base</a>.
                   Este sitio ofrece una amplia variedad de tutoriales sobre gráficos en R base,
                   incluyendo cómo personalizarlos con parámetros gráficos y funciones de bajo nivel.
                   </p>
                   '),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
              )
        )
      ),
      
      # ¿Qué es ggplot2?
      tabItem(
        tabName = "r_2",
        fluidRow(
          box(title = "¿Qué es ggplot2?", 
              status = NULL,
              class = "box-black",
              solidHeader = TRUE,
              width = 12,
              collapsible = TRUE,
              tags$div(style = "text-align: center;",
                       tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/Ggplot2_hex_logo.svg/665px-Ggplot2_hex_logo.svg.png", 
                                height = "100px", width = "auto")
              ),
              HTML('
                   <h1 style="text-align: center;">¿Qué es ggplot2?</h1>
                   <p>
                   <b>ggplot2</b> es un paquete de visualización de datos para <code>R</code>,
                   que fue creado por <b>Hadley Wickham</b> en 2005. Su nombre proviene de "Grammar of Graphics"
                   (Gramática de Gráficos), un enfoque teórico desarrollado por <b>Leland Wilkinson</b>
                   en su libro <i>The Grammar of Graphics</i>. <code>ggplot2</code> se basa en esta gramática
                   para construir gráficos de forma declarativa, lo que significa que
                   los usuarios describen el gráfico que quieren en lugar de indicar paso a paso cómo
                   se debe crear.
                   
                   El objetivo principal de <code>ggplot2</code> es facilitar la creación de gráficos
                   estadísticos complejos, permitiendo que los usuarios puedan representar sus datos de
                   manera clara y efectiva, mientras mantienen un alto grado de personalización. Con <code>ggplot2</code>,
                   se pueden crear gráficos de forma estructurada mediante la adición de capas, lo que
                   permite componer visualizaciones complejar de forma fácil y modular.
                   </p>
                   
                   <p>
                   La diferencia más importante entre <code>ggplot2</code> y <b>R base</b> (la funcionalidad
                   de gráficos básica de <code>R</code>) radica en cómo se estructuran y personalizan los
                   gráficos:
                   
                    <ol>
                      <li><b>Facilidad de uso</b>: <code>ggplot2</code> sigue un enfoque de
                      "gramática de gráficos", lo que hace que la creación de gráficos complejos
                      sea mucho más intuitiva. En cambio, con <b>R base</b>, los gráficos requieren
                      más código y pasos manuales para personalizar aspectos como colores, leyendas
                      y ejes.</li>
                      <li><b>Flexibilidad y control</b>: <code>ggplot2</code> ofrece una mayor
                      flexibilidad al permitirte agregar y modificar capas, y controlar de manera
                      precisa los elementos gráficos. <b>R base</b>, aunque funcional, no tiene
                      la misma capacidad para construir visualizaciones complejas de manera tan
                      fluida.</li>
                      <li><b>Estética</b>: <code>ggplot2</code> se enfoca en representar los datos de forma
                      estética y visualmente atractiva por defecto. Los gráficos generados con
                      <code>ggplot2</code> suelen tener una apariencia más pulida y profesional que
                      los gráficos generados con <b>R base</b>.</li>
                      <li><b>Estructura del código</b>: En <code>ggplot2</code>, los gráficos se
                      construyen de manera modular y compositiva, utilizando una
                      sintaxis simple y coherente. <b>R base</b>, por otro lado, puede requerir
                      una mayor cantidad de líneas de código para lograr un mismo nivel de personalización
                      y complejidad.</li>
                    </ol>
                   </p>
                   
                   <h2>Ejemplo de diferencias:</h2>
                   
                   <p>
                   En <b>R base</b> para crear un gráfico de dispersión podría escribirse lo siguiente:
                   </p>
                   '),
              verbatimTextOutput("r_ggplot1"),
              HTML('
                   <p>
                   Mientras que en <code>ggplot2</code>, el mismo gráfico de dispersión
                   podría escribirse de la siguiente manera:
                   </p>
                   '),
              verbatimTextOutput("r_ggplot2"),
              HTML('
                   <p>
                   En este último caso, puede fácilmente agregar más capas (como
                   líneas de tendencia, títulos, o cambiar temas) de manera modular.
                   </p>
                   '),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
                ),
          box(title = "Ejemplo 1. Gráfico en R Base",
              status = NULL,
              class = "box-black",
              solidHeader = TRUE,
              width = 6,
              collapsible = TRUE,
              collapsed = TRUE,
              plotOutput("plot__1"),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
              ),
          box(title = "Ejemplo 2. Gráfico en ggplot2",
              status = NULL,
              class = "box-black",
              solidHeader = TRUE,
              width = 6,
              collapsible = TRUE,
              collapsed = TRUE,
              plotOutput("plot__2"),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
              )
        )
      ),
      # ¿Qué es plotly?
      tabItem(
        tabName = "r_3",
        fluidRow(
          box(title = "¿Qué es Plotly?", 
              status = NULL,
              class = "box-black",
              width = 12,
              solidHeader = TRUE,
              collapsible = TRUE,
              tags$div(style = "text-align: center;",
                       tags$img(src = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR6UTPV9TTPThzYSFv8Ps9o4hdlr84SRn_f5g&s", 
                                height = "100px", width = "auto")
              ),
            HTML('
                 <h1 style="text-align: center;">¿Qué es plotly?</h1>
                 <p>
                 <code>Plotly</code> es una poderosa librería de visualización interactiva que permite crear
                 gráficos dinámicos, tanto en 2D como en 3D, con una cantidad de opciones para personalizar y controlar la interactividad.
                 A diferencia de <b>R Base</b> y <code>ggplot2</code>, que son principalmente herramientas para generar gráficos estáticos,
                 <code>plotly</code> permite a los usuarios interactuar con los gráficos, haciendo zoom, desplazándose por ellos y
                 obteniendo información detallada al pasar el mouse sobre los puntos de datos. Esto la convierte en una
                 excelente opción cuando se quiere ofrecer una experiencia más inmersiva y dinámica en la visualización de datos.
                 </p>
                 
                 <p>
                 Uno de los principales benecicios de <code>plotly</code> es la facilidad con la que permite crear gráficos interactivos
                 avanzados, como gráficos 3D, mapas geoespaciales o diagramas de dispersión complejos. Si bien <b>R Base</b> también permite
                 crear gráficos, suele ser más limitado en cuanto a interactividad y características avanzadas. Además, para crear gráficos complejos
                 en <b>R Base</b>, puede requerirse más esfuerzo, mientras que <code>plotly</code> facilita estas visualizaciones de manera más directa.
                 En cuanto a la personalización, sobresale en la creación de gráficos altamente interactivos, y
                 ofrece una gran variedad de opciones para ajustar detalles como los estilos de línea, colores, e incluso
                 añadir animaciones entre las diferentes visualizaciones. Aunque <code>ggplot2</code> también es muy flexible y 
                 potente en términos de personalización para gráficos estáticos, <code>plotly</code> simplifica la creación de gráficos 
                 interactivos, permitiendo transiciones más fluidas y configuraciones fáciles de aplicar. <b>R Base</b> ofrece un control
                 básico sobre los gráficos, pero no cuenta con la misma capacidad de personalización ni la opción de interactividad avanzada.
                 </p>
                 
                 <p>
                 Otro punto importante es la integración de <code>plotly</code> con aplicaciones web y dashboards. Si se está trabajando
                 en aplicaciones de <code>shiny</code>, por ejemplo, se integra de manera nativa y permite crear
                 gráficos interactivos sin complicaciones adicionales. A diferencia de <code>ggplot2</code>, que también se integra
                 a páginas web, <code>plotly</code> ofrece una experiencia más sencilla para interactuar con los datos directamente
                 desde el navegador, mejorando la accesibilidad y la facilidad de uso. Además, de que facilita la exportación de gráficos
                 tanto como imágenes estáticas como visualizacione sinteractivas, lo que es
                 ideal para compartir y mostrar resultados de manera efectiva.
                 </p>
                 '),
            verbatimTextOutput("plotly__1"),
            plotlyOutput("plotly__2"),
            HTML('
                 <p>
                 El gráfico interactivo generado permite una exploración dinámica de los datos,
                 proporcionando una ventaja significativa sobre los gráficos estáticos típicos generados
                 por <b>R Base</b> o <code>ggplot2</code>. Esta interactividad facilita la comprensión y el análisis de lso datos al
                 permitir a los usuarios realizar acciones como hacer zoom, desplazarse y obtener información detallada al pasar el mouse
                 sobre los elementos del gráfico. Estas caragterísticas son particularmente útiles en el contexto de la
                 <b>ciencia de datos</b>, ya que permiten a los analistas y científicos explorar grandes volúmenes de datos
                 de manera eficiente, identificar patrones y relaciones, y comunicar resultados de manera más efectiva.
                 </p>
                 '),
            tags$footer(
              style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
              "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
          )
        )
      )
      ),
      
      # Introducción gráfico de barras
      tabItem(
        tabName = "barplot__1",
        fluidRow(
          box(
            title = "Introducción a los Gráficos de Barras", 
            status = NULL,
            class = "box-black",
            solidHeader = TRUE,
            width = 12,
            collapsible = TRUE,
            HTML('
                 <h1 style="text-align: center;">¿Qué es un Gráfico de Barras?</h1>
                 
                 <p>
                 Un <b>gráfico de barras</b> es un tipo de visualización de datos que utiliza barras rectangulares para
                 representar y comparar cantidades o valores entre diferentes categorías. Las barras tienen una longitud
                 o altura proporcional al valor que representan, lo que permite una comparación visual fácil y rápida
                 entra las categorías. Estos gráficos son ampliamente utilizados debido a su simplicidad y claridad, y se
                 emplean para mostrar datos categóricos o discretos en los que se desea destacar las diferencias entre
                 distintos grupos.
                 En un gráfico de barras, las categorías se ubican generalmente en el eje horizontal (eje X), mientras que
                 los valores asociados a cada categoría se representan en el eje vertical (eje Y). Dependiendo de la
                 orientación de las barras, estas pueden ser verticales u horizontales, y cada barra refleja el
                 valor de una categoría específica.
                 </p>
                 '),
            tags$div(style = "text-align: center;",
                     tags$img(src = "https://raw.githubusercontent.com/fkellner/D3-graph-gallery/master/img/section/Bar150.png", 
                              height = "100px", width = "auto")
            ),
            tags$footer(
              style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
              "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
          )
        ),
        box(
          title = "Características de un gráfico de barras", 
          status = NULL,
          class = "box-black",
          solidHeader = TRUE,
          width = 12,
          collapsible = TRUE,
          collapsed = TRUE,
          HTML('
               <h2 style="text-align: center;">Características de un gráfico de barras</h2>
               
               <p>
               <li><b>Ejes</b>:</li>
                <ol>
                  <li>El eje <b>X</b> (horizontal) representa las <b>categorías</b> o grupos a comparar.</li>
                  <li>El eje <b>Y</b> (vertical) muestra las <b>magnitudes</b> o valores correspondientes a esas categorías.</li>
                </ol>
                <li><b>Barras</b>: Las barras son representaciones gráficas de las categorías. En un gráfico de barras vertical,
                la <b>altura</b> de la barra es proporcional al valor de la categoría; en un gráfico de barras horizontal,
                la <b>longitud</b> de la barra se ajusta según el valor de la categoría.<li>
                <li><b>Color</b>: A menudo, las barras pueden ser coloreadas para diferenciar visualmente las categorías o
                para resaltar la información específica. El uso del color puede mejorar la legibilidad y
                ayudar a identificar patrones o agrupaciones dentro de los datos.</li>
                <li><b>Distribución de las barras</b>: Las barras pueden ordenarse de diferentes maneras: por valor, de forma
                ascendente o descendente, o por cualquier otro criterio como un orden alfabético o temporal,
                según lo que se desea resaltar en los datos.</li>
                <li><b>Anotaciones</b>: Los gráficos de barras suelen incluir etiquetas y títulos para explicar los valores
                representados. Estas etiquetas pueden estar ubicadas en la parte superior de cada barra o dentro de ellas para una mayor
                claridad.</li>
               </p>
               
               <p>
               Los gráficos de barras son útiles en una amplia variedad de contextos,
               desde la presentación de resultados hasta el análisis exploratorio de datos. En <b>ciencia de datos</b>, los gráficos
               de barras son fundamentales para comparar categorías, visualizar distribuciones y descubrir patrones en grandes
               volúmenes de datos. Son una herramienta clave cuando se desea mostrar la frecuencia, la cantidad o
               cualquier tipo de medición asociada a diferentes cateogrías.
               </p>
               
               <p>
               En esta sección se mostrará algunos ejemplos de cómo crear grágicos de barras utilizando los tresn enfoques:
               <b>R Base</b>, <code>ggplot2</code> y <code>plotly</code>. A continuación, se mostrarán ejemplos sencillos de cómo generar un gráfico de
               barras en cada una de estas librerías, permitiendo explorar las diferencias y ventajas de cada enfoque.
               </p>
               '),
          tags$footer(
            style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
            "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
          )
        )
      )
      ),

      
      # Gráfico de barras base
      tabItem(
        tabName = "barplot_base",
        fluidRow(
          box(title = "Introducción al Gráfico de Barras en R Base", 
              status = NULL,
              class = "box-black", 
              solidHeader = TRUE, 
              width = 12,
              collapsible = TRUE,
              HTML('
                   <h1 style="text-align: center;">Gráfico de barras en <b>R Base</b></h1>
                   
                   <p>
                   Un gráfico de barras en <b>R Base</b> es una representación visual de datos
                   donde las categorías se muestran en el eje X y la altura de cada barra
                   representa la frecuencia o valor asociado a cada categoría en el eje Y. Este
                   tipo de gráfico es útil para comparar diferntes categorías o grupos de datos.
                   
                   A continuación trabajaremos con el conjunto de datos de la librería
                   <b>Iris</b>, siendo conocido en <code>R</code> que contiene
                   medidas de 150 flores de iris, distribuidas en 3 especies: <b>setosa</b>, <b>versicolor</b> y
                   <b>virginica</b>m con 4 características: largo y ancho del sépalo, y largo y ancho del
                   pétalo
                   </p>
                   
                   <p>
                   Supongamos que queremos crear un gráfico de barras que muestre la cantidad
                   de observaciones para cada especie en el conjunto de datos Iris.
                   Esto puede ser útil para ver cómo se distribuyen las especies.
                   </p>
                   '),
              verbatimTextOutput("barras__1"),
              div(
                style = "display: flex; justify-content: center; align-items: center; height: 400px;",
                plotOutput("barras__2", height = "400px", width = "400px")
              ),
              HTML('
                   <p>
                   Explicación del código:
                   </p>
                   
                   <p>
                   <ul>
                    <li><strong>data(iris):</strong> Carga el conjunto de datos Iris.</li>
                    <li><strong>table(iris$Species):</strong> Calcula la frecuencia de cada especie en el conjunto de datos.</li>
                    <li><strong>barplot(...):</strong> Crea el gráfico de barras con las especificaciones:
                      <ul>
                        <li><strong>main:</strong> Título del gráfico.</li>
                        <li><strong>col:</strong> Color de las barras (en este caso, "skyblue").</li>
                        <li><strong>ylab:</strong> Etiqueta para el eje Y (cantidad de observaciones).</li>
                        <li><strong>xlab:</strong> Etiqueta para el eje X (especies).</li>
                        <li><strong>border:</strong> Color del borde de las barras (negro).</li>
                      </ul>
                    </li>
                  </ul>
                   </p>
                   
                   <p>
                   De esta forma, el gráfico será útil cuando se quiera visualizar comparaciones entre diferentes categorías
                   de datos.
                   </p>
                   '),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
              ),
          box(title = "Gráfico de Barras en Horizontal R Base", 
              status = NULL,
              class = "box-black", 
              solidHeader = TRUE, 
              width = 6,
              collapsible = TRUE,
              collapsed = TRUE,
              verbatimTextOutput("barras__3"),
              plotOutput("barras__4"),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                )
              ),
          
          box(title = "Gráfico de barras con Paleta de Colores y Borde NA R base", 
              status = NULL,
              class = "box-black", 
              solidHeader = TRUE, 
              width = 6,
              collapsible = TRUE,
              collapsed = TRUE,
              verbatimTextOutput("barras__5"),
              plotOutput("barras__6"),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
          ),
          
          box(title = "Gráfico de barras con Color de Borde y leyenda R Base", 
              status = NULL,
              class = "box-black", 
              solidHeader = TRUE, 
              width = 6,
              collapsible = TRUE,
              collapsed = TRUE,
              verbatimTextOutput("barras__7"),
              plotOutput("barras__8"),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
          ),
          
          box(title = "Gráfico de Barras más delgadas R Base", 
              status = NULL,
              class = "box-black", 
              solidHeader = TRUE, 
              width = 6,
              collapsible = TRUE,
              collapsed = TRUE,
              verbatimTextOutput("barras__9"),
              plotOutput("barras__10"),
              tags$footer(
                style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
              )
          ),
          box(
            title = "Ejemplo: Distribución de Vehículos según el Número de Cilindros en el conjunto de datos de mtcars (R Base)", 
            status = NULL,
            class = "box-black", 
            solidHeader = TRUE, 
            width = 12,
            collapsible = TRUE,
            collapsed = TRUE,
            HTML('
                 <p>
                 Este gráfico de barras se genera utilizando la base de datos
                 <code>mtcars</code>, que contiene información sobre varias características
                 de automóviles. En este caso, el gráfico visualiza la distribución de los
                 vehículos según el número de cilindros de su motor (<code>cyl</code>).
                 Se cuenta la cantidad de vehículos para cada número de cilindros (4, 6, 8)
                 y se representan en un gráfico de barras.
                 
                 El gráfico se personaliza profesionalmente, con colores suaves, bordes
                 elegantes y etiquetas de tecto grande y claras, lo cual lo hace ideal para
                 ser utilizado en presentaciones científicas o proyectos donde la visualización
                 de datos sea fundamental para explicar el análisis.
                 Ademas, el fondo blanco y las fuentes en negrita aseguran que el gráfico sea
                 legible y limpio.
                 </p>
                 '),
            verbatimTextOutput("barras__11"),
            div(
              style = "display: flex; justify-content: center; align-items: center; height: 500px;",
              plotOutput("barras__12", height = "500px", width = "500px")
            ),
            HTML('
                 <p>
                 El <b>gráfico de barras</b> en R base es una herramienta
                 poderosa para mostrar la distribución de datos categóricos, es decir,
                 para contar la frecuencia de diferentes categorías dentro de un conjunto de datos.
                 Este tipo de gráfico es especialmente útil cuando se desea comparar cantidades en
                 diferentes grupos, como el número de cilindros de los vehículos en el conjunto
                 de datos <code>mtcars</code>.
                 Algunas de las aplicaciones comunes del gráfico de barras incluyen:
                  <li><b>Análisis de la frecuencia</b> de categorías de un
                  conjuto de datos (por ejemplo, la cantidad de vehículos con diferentes
                  números de cilindros).</li>
                  <li><b>Visualización clara y directa</b> de la distribución de datos categóricos
                  como clasificaciones o respuestas a encuestas.</li>
                  <li><b>Presentaciones científicas y profesionales</b>, donde se necesita resaltar
                  de manera efectiva la comparación entre diferentes categorías de datos.</li>
                 El gráfico de barras permite a los usuarios observar de manera rápida
                 y efectiva las diferencias en las cantidades de diferentes categorías,
                 facilitando la toma de decisiones o la comunicación de hallazgos en
                 diversas áreas de estudio, como ingeniería, economía, ciencias sociales,
                 y más.
                 </p>
                 '),
            tags$footer(
              style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
              "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
            )
          ),
        )
      ),
      
      # Gráfico de barras ggplot2
      tabItem(tabName = "barplot_ggplot2",
              fluidRow(
                box(title = "Introducción al Gráfico de Barras en ggplot2", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    HTML('
                         <h1 style="text-align: center;">Gráfico de barras en <code>ggplot2</code></h1>
                         
                         <p>
                         Un <b>gráfico de barras</b> en <code>ggplot2</code> es una visualización
                         que muestra la distribución de datos categóricos utilizando barras rectangulares,
                         donde la altura de cada barra representa la frecuencia o el valor asociado a cada
                         categoría. En <code>ggplot2</code>, un gráfico de barras se genera usando
                         la función <code>geom_bar()</code>, y se pueden personalizar múltiples
                         aspectos como colores, etiquetas y títulos.
                         La principal diferencia con los gráficos de barras tradicionales es
                         que <code>ggplot2</code> sigue un enfoque basado en la gramática de gráficos,
                         que hace que la creación y personalización de los gráficos sean flexibles y poderosos.
                         </p>
                         '),
                    verbatimTextOutput("barras__13"),
                    div(
                      style = "display: flex; justify-content: center; align-items: center; height: 500px;",
                      plotOutput("barras__14", height = "500px", width = "500px")
                    ),
                    HTML('<p>
                         Explicación:
                            <li><code>nombre</code>: Se utiliza como el eje X,
                            que contiene los nombres de las personas.</li>
                            <li><code>valor</code>: Se utiliza como el eje Y, con los valores
                            correspondientes a cada persona (por ejemplo, podría representar alguna medida,
                            como la cantidad de tareas completadas, horas trabajadas, etc...).</li>
                            <li><code>geom_bar(stat = "identity")</code>: Utilizamos esta función
                            para crear el gráfico de barras. <code>stat = "identity"</code> le indica a
                            <code>ggplot2</code> que los valores de barras deben de ser tomados
                            directamente de la columna <code>valor</code> de los datos.</li>
                          Este es un gráfico básico de barras, que muestra cómo varía los valores entre
                          diferentes categorías (en este caso, las personas).
                         </p>'),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                    ),
                box(title = "Gráfico de barras con ggplot con tono de color viridis", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 6,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    p("Para usar la paleta de colores ", tags$b("viridis"),
                      " se puede usar la función ", tags$code("scale_fill_viridis"),
                      " que viene con el paquete ", tags$code("viridis"), "."),
                    verbatimTextOutput("barplot_gg__1"),
                    plotOutput("barplot_gg__2"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                box(title = "Gráfico de barras con ggplot con diferentes tamaños de anchos de las barras", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 6,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    p("Para variar el tamaño de las barras, podemos modificar el ancho
                      de las barras usando el argumento ", tags$code("width"), " dentro
                      de ", tags$code("geom_bar()"), ". Aquí el ejemplo:"),
                    verbatimTextOutput("barplot_gg__3"),
                    plotOutput("barplot_gg__4"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                box(title = "Gráfico de barras con ggplot con coord_flip() para hacerlo horizontal", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 6,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    p("El siguiente código usa la función ", tags$code("coord_flip()"),
                      " para girar el gráfico y hacerlo horizontal:"),
                    verbatimTextOutput("barplot_gg__5"),
                    plotOutput("barplot_gg__6"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                    ),
                box(title = "Gráfico de barras con ggplot con un tema minimalista de fondo",
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 6,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    p("Se puede usar el tema ", tags$code("theme_minimal()"), " para darle un fondo
                      limpio y sin detalles adicionales."),
                    verbatimTextOutput("barplot_gg__7"),
                    plotOutput("barplot_gg__8"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                      )
                    )
              )
              
      ),
      
      # Gráfico de barras con colores
      tabItem(tabName = "barplot_colored",
              fluidRow(
                box(title = "Introducción al Gráfico de Barras en Plotly", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    HTML('
                         <h1 style="text-align: center;">Gráfico de barras en <code>ggplot2</code></h1>
                         '),
                    p(),
                    HTML('<p>
                    <code>Plotly</code> es una biblioteca de visualización interactiva de datos que permite
                         crear gráficos dinámicos y visuales y visuales, como lo son los gráficos de barras.
                         Su principal característica es que los gráficos generados son interactivos, permitiendo la explotación de los datos
                         a través de acciones como el zoom, la selección de elementos y visualización de detalles al pasar el ratón
                         por encima. <code>Plotly</code> es especialmente útil para crear gráficos atractivos y personalizables,
                         que pueden integrar fácilmente  en aplicaciones web.
                         <br><br>
                         <code>Plotly</code> fue fundada en 2012 por <b>Chris Parmer</b> y <b>Jack Parmer</b> como una plataforma de
                         visualización de datos interactivos en línea. Aunque inicialmente se centró en ofrecer una herramienta web para crear
                         gráficos, la empresa evolucionó para crear bibliotecas de código abierto en varios lenguajes de programación,
                         como lo son: <code>Python</code>, <code>R</code>, <code>Julia</code>, y <code>MATLAB</code>.
                         <br><br>
                         En <code>R</code>, <code>ggplot2</code> es una de las bibliotecas más populares para crear gráficos estáticos,
                         pero con <code>Plotly</code> se utiliza para convertir estos gráficos estáticos en gráficos interactivos. Mediante
                         la función <code>ggplotly()</code>, toma un gráfico creado y lo convierte en un gráfico interactivo sin
                         necesidad de escribir código adicional para manejar la interactividad.
                         <br><br>
                         Para más información sobre <code>plotly</code>
                   <a href = "https://plotly.com/"
                         target="_blank">, haz clic aquí para más detalles</a>.
                         </p>'),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                box(title = "Gráfico de Barras Plotly", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML('<p>
                         Como primer ejemplo, se va a utilizar el conjunto de datos <code>mtcars</code>, que es un conjunto
                         de datos clásico incluido dentro de <code>R</code>.
                         <br><br>
                         Para este caso, nos centraremos en la variable <code>cyl</code>, que representa el número de cilindros
                         en los motores de los automóviles del conjunto de datos <code>mtcars</code>. La variable
                         <code>cyl</code> tiene tres posibles valores: 4, 6 y 8 cilindros.
                         <br><br>
                         A través de un <b>gráfico de barras</b>, vamos a visualizar la frecuencia de cada una de estas categorías de cilindros
                         en el conjunto de datos. Es decir, mostraremos cuántos autos en el conjunto de datos tienen
                         4, 6 y 8 cilindros.
                         </p>'),
                    verbatimTextOutput("a"),
                    plotlyOutput("a_graph"),
                    HTML('<p>
                         Este gráfico permitirá ver de forma clara cuántos autos tienen 4, 6 y 8 cilindros,
                         y la interactividad permitirá explorar los datos de manera más dinámica.
                         </p>'),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                )
              ),
      ),
      # Aquí se empieza con la programación
      # Gráfico de dispersión
      tabItem(tabName = "scatterplot_1",
              fluidRow(
                box(
                  title = "Introducción a los Gráficos de Dispersión", 
                  status = NULL,
                  class = "box-black", 
                  solidHeader = TRUE, 
                  width = 12,
                  collapsible = TRUE,
                  HTML('
                     <h1 style="text-align: center;">¿Qué es un Gráfico de Dispersión?</h1>
                     '),
                  p('Un', tags$b('gráfico de dispersión'), 'es una representación visual
                    que muetra la relación entre dos variables numéricas mediante puntos
                    colocados en un plano cartesiano. Cada punto representa una observación
                    con valores en los ejes X e Y.'),
                  tags$div(style = "text-align: center;",
                  tags$img(src = "https://raw.githubusercontent.com/holtzy/data_to_viz/master/img/section/ScatterPlotSmall.png", 
                  height = "100px", width = "auto"),
                  tags$div(style = "margin-top: 10px") # Margen para la imagen que hay.
                  ),
                  p('Como el diagrama de dispersión mide la relación entre dos variables, a menudo
                    se acompaña de una', tags$b('correlación de cálculo del coeficiente'), 'que generalmente trata de medir
                    la relación lineal.'),
                  p('Sin embargo, otros tipos de relación se pueden detectar mediante diagramas de dispersión, y una
                    tarea común consiste en ajustar un modelo que explique Y en función de X. Aquí hay algunos
                    patrones que se pueden detectar haciendo un diagrama de dispersión.'),
                  tags$div(style = "text-align: center;",
                           tags$img(src = "https://www.data-to-viz.com/graph/scatter_files/figure-html/unnamed-chunk-2-1.png", 
                                    height = "500px", width = "auto")
                  ),
                  p('Hay que recordar que el gráfico de dispersión es una representaión', tags$b('bidimensional'),
                    'utilizada para visualizar la relación entre dos variables cuantitativas continuas.
                    Cada observación se representa como un punto en el plano cartesiano, donde el eje X
                    corresponde a la variable independiente (predictora) y el eje Y a la variable dependiente (respuesta).
                    Este tipo de gráfico permite', tags$b('identificar patrones estructurales en los datos'), ', tales como:',
                    tags$li("Tendencias lineales o no lineales."),
                      tags$li("Fuerza y dirección de la asociación (positiva o negativa)."),
                      tags$li("Presencia de heterocedasticidad."),
                      tags$li("Agrupamientos (cluster)."),
                      tags$li("Valores atípicos (outliers)."),
                    ),
                  tags$footer(
                    style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                    "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                  )
                ),
                
                box(
                  title = "Características d eun gráfico de dispersión", 
                  status = NULL,
                  class = "box-black", 
                  solidHeader = TRUE, 
                  width = 12,
                  collapsible = TRUE,
                  collapsed = TRUE,
                  
                  p(
                    tags$ul(tags$b("1. Bidimensionalidad"),
                      tags$li("Representa ds variables cuantitativas continuas."),
                      tags$li("Cada punto es una observación con un par de valores (X, Y).")
                      ),
                    tags$ul(tags$b("2. Puntos individuales"),
                            tags$li("Cada punto refleja una observación única."),
                            tags$li("La ubicación exacta transmite información precisa sobre la relación
                                    entre variables.")
                            ),
                    tags$ul(tags$b("3. Asociación visual"),
                      tags$li("Permite identificar visualmente relaciones entre variables:",
                              tags$ol(
                                tags$li(tags$b("Dirección"),": positiva, negativa o nula."),
                                tags$li(tags$b("Forma"), ": lineal, curvilínea, exponencial, etc."),
                                tags$li(tags$b("Fuerza"), ": qué tan 'ajustados' están los puntos a un patrón.")  
                              ),
                              
                              )
                    ),
                    tags$ul(
                      tags$b("4. Detección de outliers"),
                      tags$li("Facilita la identificación de valores atípicos o extremos que se
                              desvían del patrón general.")
                    ),
                    tags$ul(
                      tags$b("5. Detección de grupos o clusters"),
                      tags$li("Puede mostrar agrupaciones naturales de datos, indicando segmentos,
                              categorías ocultas o comportamientos diferenciados.")
                    ),
                    tags$ul(
                      tags$b("6. Distribución conjunta"),
                      tags$li("Es una forma efectiva de representar la", 
                      tags$b(" distribución conjunta (bivariada)")),
                      " de las dos variables."
                    ),
                    tags$ul(
                      tags$b("7. No requiere supuestos estadísticos"),
                      tags$li("A diferencia de modelos formales, el scatterplot
                              es puramente exploratorio y no depende de supuestos
                              como normalidad o linealidad.")
                    ),
                    tags$ul(
                      tags$b("8. Escalabilidad limitada"),
                      tags$li("No es adecuado para bases de datos muy grandes
                              (miles de puntos), ya que puede haber overplotting.
                              En esos casos se usan alternativas como:",
                              tags$li("Gráficos de densidad bivariada."),
                              tags$li("Hexbin plots."),
                              tags$li("Contour plots.")
                              )
                    ),
                    tags$ul(
                      
                    )
                    ),
                  tags$footer(
                    style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                    "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                  )
                ),
                
              )
              ),
      tabItem(tabName = "scatterplot",
              fluidRow(
                box(title = "Introducción al Gráfico de dispersión en R Base", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    HTML('
                     <h1 style="text-align: center;">Gráfico de Dispersión en <b>R Base</b></h1>
                     '),
                    p('Un ', tags$b("gráfico de dispersión"), "en ", tags$code("R base"), " es una
                      representación visual que permite mostrar la relación entre dos variables numéricas.
                      Cada punto en el gráfico representa una observación, con su posición determinada por los
                      valores de esas dos variables. Este tipo de gráfico es útil para detectar patrones,
                      tendencias, agrupaciones o relaciones lineales/no lineales entre variables."),
                    p("A continuación trabajaremos con el conjunto de datos", tags$code("iris"), " ampliamente
                      conocido en ", tags$code("R"), ", que contiene medidas de 150 flores de iris, distribuidas
                      en tres especies: ", tags$i("setosa, versicolor, virginica"), " y cuatro características:
                      largo y ancho del sépalo y largo y ancho del pétalo."),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                box(title = tagList(icon("elementor"), 
                                    "Ejemplo de Gráfico en R base"), 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    width = 12,
                    HTML('<p>
                         Usando el conjunto de datos <code>mtcars</code>, tomaremos las variables <code>mpg</code> (millas por galón) y
                         <code>wt</code> (peso por vehículo) para crear el gráfico de dispersión.
                         </p>'),
                    verbatimTextOutput("s"),
                    plotOutput("s_1"),
                    HTML('<p>
                         Este código genera un gráfico de dispersión donde cada punto representa un automóvil
                         del conjunto de datos <code>mtcars</code>, con su peso en el eje X y su eficiencia de combustible
                         en el eje Y. Esto te permitirá visualizar la relación entre el peso y la eficiencia de combustible
                         de los autos.
                         </p>'),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Recuerda que puedes agregar la línea e tendencia al gráfico de dispersión - ", Sys.Date()),
                    
                )
                
              )
      ),
      
      # Gráfico de dispersión con colores
      tabItem(tabName = "scatterplot_colored",
              fluidRow(
                box(title = "Gráfico de Dispersión con ggplot2", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    HTML('<p>
                         Un gráfico de dispersión es una de las herramientas más útiles
                         para visualizar la relación entre dos variables numéricas.
                         Permite identificar patrones, correlaciones o incluso outliers, lo cual es esencial.
                         Al utilizar esto con <code>ggplot2</code> para crear este tipo de gráfico es
                         una excelente opción por varias razones.
                         <br><br>
                         Además de la personalización, <code>ggplot2</code> es muy eficiente para manejar
                         grandes volúmenes de datos sin perder claridad. Cuando se trabaja con conjuntos de
                         datos grandes, es posible aplicar técnicas como la
                         transparencia de los puntos o el ajuste de su tamaño para mejorar la legibilidad.
                         Esto es crucial en el análisis de datos reales, donde los puntos pueden
                         ser densos y se corre el riesgo de perder la visión general de la distribución
                         de los mismos.
                         <br><br>
                         <hr>
                         Además, <code>ggplot2</code> permite combinar gráficos de dispersión
                         con otros tipos de visualización, lo que permite crear representaciones
                         más complejas y detalladas. Se puede superponer gráficos de barras,
                         histogramas o incluso crear gráficos de dispersión faceteados para mostrar cómo
                         cambian las relaciones entre las variables en diferentes grupos. Esto
                         no solo mejora la presentación visual, sino que también permite un análisis más
                         profundo.
                         <br><br>
                         Por último, <code>ggplot2</code> se integra perfectamente con otras herramientas y
                         librerías del ecosistema de <code>R</code>, como lo es con <code>dplyr</code>
                         para la manipulación de datos o con <code>shiny</code> para la creación de 
                         aplicaciones interactivas. Esta integración facilita todo el proceso, desde la preparación
                         de los datos hasta su visualización, creando un flujo
                         de trabajo eficiente para los análisis de datos.
                         </p>'),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                box(title = "Gráfico básico de Dispersión en ggplot2", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, width = 12,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML('
                         <p>
                         Un <b>diagrama de dispersión</b> muestra los valores de dos
                         variables a lo largo de dos ejes. Muestra la relación entre ellos,
                         revelando finalmente si existe una correlación.
                         <br><br>
                         Acá se muestra un ejemplo básico de un diagrama de dispersión con <code>ggplot2</code> utilizando
                         el conjunto de datos <code>iris</code>:
                         </p>
                         '),
                    verbatimTextOutput("a1"),
                    plotOutput("plot_a1"),
                    HTML('
                         <p>
                         La función clave en este gráfico es la función <code>geom_point()</code> para agregar los puntos
                         al gráfico. Específicamente, crea un gráfico de dispersión donde cada punto representa
                         una observación en el conjunto de datos.
                         </p>
                         <br><br><hr>
                         <h2>¿Qué muestra este gráfico?</h2>
                         <p>
                         Este gráfico de dispersión muestra la relación entre el largo (<code>Sepal.Length</code>) y el ancho
                         (<code>Sepal.Width</code>) del sépalo en las flores del conjunto de datos <code>iris</code>.
                         Cada punto representa una flor, y su posición está determinada por el valor de estas dos variables.
                         <p>
                         <li>El eje <b>X</b> muestra el largo del sépalo.</li>
                         <li>El eje <b>Y</b> muestra el ancho del sépalo.</li>
                         <p>
                         Este es el gráfico más básico posible en <code>ggplot2</code> para un gráfico
                         de dispersión, sin ninguna personalización adicional (como colores, formas de los puntos
                         o líneas de tendencia).
                         </p>
                         '),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia - ", Sys.Date()
                    )
                ),
                box(title = "Diagrama de dispersión ggplot2 personalizado",
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, width = 6,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML('
                         <p>
                         La magia de <code>ggplot2</code> es en tener la habilidad de asignar una variable a entidades de marcador.
                         Aquí, el marcador depende de su valor en el campo <code>Species</code> dentro de la función <code>color =</code>.
                         Hay que tener en cuenta que la etiqueta se crea automaticamente.
                         </p>
                         '),
                    verbatimTextOutput("iris_code"),
                    plotOutput("iris_plot"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                box(title = "Tabla de datos de la librería Iris",
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, width = 6,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML('
                         <p>
                         El conjunto de datos de la librería <code>iris</code> es uno de los conjuntos de datos más conocidos y utilizados
                         en el ámbito de la estadística y el análisis de datos. Fue introducido por el famoso estadístico
                         <b>Anderson (1935)</b> en su artículo <i>"The Iris Data Set"</i> como parte de su investigación sobre la discriminación de
                         especies botánicas. El conjunto contiene medidas morfológicas (largo y ancho de sépalo y  del pétalo) de 
                         <b>150 flores</b> pertenecientes a <b>tres especies de iris</b>: <i>Setosa</i>, <i>Versicolor</i> y <i>Virginica</i>.
                         Cada fila del conjunto de datos corresponde a una observación de una florindividual, y las columnas representan las 
                         características medidas.
                         <br><br>
                         El propósito original de la recopilación de estos datos era para ilustrar las diferencias entre las especies de iris,
                         basándose en sus características morfológicas. Hoy en día, el conjunto de datos es
                         ampliamente utilizado para enseñar técnicas de clasificación y regresión, y es una referencia estándar
                         para la visualización y el análisis de datos multivariables.
                         </p>
                         '),
                    dataTableOutput("iris_tabla"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                    ),
                box(title = "Personalización de Diagramas de Dispersión en ggplot2: Uso de Atributos Visuales",
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, width = 12,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML('<p>
                         A continuación, se explorará cómo personalizar estos diagramas usando diferentes atributos
                         visuales como color, forma, tamaño y trasnparencia.
                         </p>'),
                    verbatimTextOutput("scatter_t1"),
                    verbatimTextOutput("scatter_t2"),
                    verbatimTextOutput("scatter_t3"),
                    verbatimTextOutput("scatter_t4"),
                    plotOutput("scatter_plots"),
                    HTML('<h2>Resumen de Atributos en el diagrama de dispersión</h2>
                            <li><b>Color</b> (<code>color</code>): Se utiliza para asignar colores
                            a los puntos según una variable categórica o continua.</li>
                            <li><b>Relleno</b> (<code>fill</code>): Cambia el color de relleno de los úntos, útil 
                            especialmente con ciertas formas de puntos (<code>shape</code>).</li>
                            <li><b>Transparencia</b> (<code>alpha</code>): Controla la opacidad de los puntos,
                            lo que puede ser útil para mostrar la densidad de los datos.</li>
                            <li><b>Tamaño</b> (<code>size</code>): Permite ajustar el tamaño de los puntos según una 
                            variable continua.</li>
                         <br><br>
                         <p>
                         Estos atributos visualespermiten personalizar los diagramas de dispersión en
                         <code>ggplot2</code> y aregar más información visual en un solo gráfico,
                         facilitando la interpretación de las relaciones
                         entre variables.
                         </p>
                         '),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                )
              )
      ),
      tabItem(tabName = "scatterplot_ggExtra",
              fluidRow(
                box(title = "¿Qué hace ggMarginal() y cuál es su función de la librería ggExtra?", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    HTML('<p>
                  La función <code>ggMarginal</code> de la librería <code>ggExtra</code> en
                       <code>R</code> se utiliza para agregar <b>gráficos marginales</b> a los gráficos
                       creados en <code>ggplot2</code>. Es decir, permite agregar una visualización adicional
                       sobre las distribuciones de las variables de los ejes <code>x</code> e <code>y</code>
                       de un gráfico.
                       <br><br>
                       </p>
                       <h2>¿Qué es un gráfico marginal?</h2>
                       <p>
                       Un <b>gráfico marginal</b> es una representación gráfica de la distribución univariante
                       de una variable en uno de los márgenes de un gráfico de dispersión.
                       Generalmente, se coloca un gráfico marginal en la parte superior
                       (para la variable en el eje <code>x</code>) y otro en el lado derecho
                       (para la variable en el eje <code>y</code>).
                       Estos gráfcos pueden ser de varios tipos, como lo son <b>histogramas</b>, 
                       <b>gráficos de densidad</b>, <b>boxplots</b> o 
                       <b>gráficos de violín</b>.
                       </p>
                       <br><br>
                       <h2>¿Cómo puede ayudar <code>ggMarginal()</code> a mejorar los diagramas de 
                       dispersión?</h2>
                       <p>
                       Cuando se trabaja con <b>diagramas de dispersión</b> en <code>ggplot2</code>,
                       estos gráficos ayudan a visualizar la relación entre dos variables, pero no
                       proporcionan información sobre cómo se distribuyen las variables de manera unitaria.
                       Es decir, no se sabe si los datos
                       en cada eje siguen una distribución normal, si están sesgados, si tienen valores atípicos,
                       etc. Aquí es donde los gráficos marginales de <code>ggMarginal()</code> pueden ser útiles:
                       </p>
                        <li><b>Visualización de distribuciones univariantes</b>:
                        Permite agregar un gráfico que muestra cómo se distribuyen los datos
                        en los ejes <code>x</code> e <code>y</code>, lo cual puede ser crucial para entender mejor
                        las características de las variables.</li>
                        <li><b>Detección de sesgos o outliers</b>: Al agregar histogramas o gráficos
                        de densidad, se puede ver si los datos siguen
                        una distribución simétrica, si están sesgados, o si hay valores
                        atípicos.</li>
                        <li><b>Mayor contexto</b>: Los gráficos marginales proporcionan un contexto
                        adicional al gráfico de dispersión.</li>
                       <p>Usando el conjunto de datos <code>iris</code>, se visualizarán algunos
                       ejemplos:</p>'),
                    verbatimTextOutput("marginal_p"),
                    HTML('<p>
                       Teniendo como la base este código para la creación de los diagramas marginales.
                       </p>'),
                    plotOutput("marginal_plot"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                
                box(title = "Diferentes personalizaciones con ggExtra y ggMarginal()",
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, width = 6,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    tabBox(width = 8,
                           tabPanel("Histograma",
                                    verbatimTextOutput("marginal_p1"),
                                    plotOutput("marginal_plot1")
                           ),
                           tabPanel("Densidad", 
                                    verbatimTextOutput("marginal_p2"),
                                    plotOutput("marginal_plot2")
                           ),
                           tabPanel("Violín",
                                    verbatimTextOutput("marginal_p3"),
                                    plotOutput("marginal_plot3")
                           )
                    ),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                box(title = "Conclusión visual y funcional",
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, width = 6,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML('
<p>
  La combinación de <code>ggplot2</code> y <code>ggExtra</code>, con la funcionalidad específica de <code>ggMarginal</code>, 
  representa una herramienta poderosa y flexible para enriquecer la visualización de datos en gráficos de dispersión. 
  Al integrar estos gráficos marginales en un gráfico principal de dispersión, los usuarios pueden obtener una visión más completa 
  de las relaciones bivariadas entre dos variables, al mismo tiempo que exploran las distribuciones univariadas de cada variable de 
  forma detallada.
</p>

<p>
  Los <b>gráficos marginales</b> (ya sean histogramas, boxplots o gráficos de densidad) agregan una capa adicional de 
  información visual a los gráficos de dispersión. Estos gráficos permiten observar las distribuciones de las variables en los 
  ejes X e Y, lo que facilita la identificación de patrones o tendencias, así como la detección de sesgos, anomalías y posibles 
  valores atípicos. Esto es especialmente útil cuando se tiene un conjunto de datos complejo, ya que proporciona una perspectiva 
  tanto global como local sobre los datos sin necesidad de generar gráficos adicionales, lo que hace que el proceso de análisis 
  sea más eficiente.
</p>

<p>
  Por ejemplo, los <code>histogramas</code> pueden mostrar la forma de la distribución de cada variable, ayudando a identificar 
  distribuciones sesgadas o distribuciones normales, mientras que los <code>boxplots</code> proporcionan una visión clara de la 
  dispersión, los cuartiles, la mediana y los posibles valores atípicos en los datos. Estas herramientas gráficas adicionales no solo 
  enriquecen la visualización, sino que también facilitan la interpretación de los resultados al proporcionar más contexto y detalle 
  sobre las características de las variables analizadas.
</p>

<p>
  Desde un punto de vista <strong>funcional</strong>, <code>ggMarginal</code> mejora significativamente la capacidad de tomar 
  decisiones informadas al ofrecer una visión complementaria y más detallada de las variables en el mismo gráfico. Por ejemplo, un 
  analista puede ser capaz de detectar rápidamente si una variable tiene una distribución normal o si existen posibles valores atípicos 
  que podrían afectar los resultados de un análisis estadístico.
</p>

<p>
  La <strong>integración</strong> de esta funcionalidad dentro de una aplicación <code>Shiny</code> no solo agrega valor visual, sino que 
  también incrementa la <strong>interactividad</strong> de la visualización. Al permitir que el usuario explore y personalice los gráficos 
  de dispersión con gráficos marginales en tiempo real, <code>Shiny</code> ofrece una experiencia dinámica y ajustable, donde los usuarios pueden 
  profundizar en los datos según sus necesidades. Esta interactividad es crucial cuando se trabajan con grandes volúmenes de datos o cuando 
  los usuarios desean explorar los datos desde diferentes perspectivas.
</p>

<p>
  Además, la capacidad de personalizar la apariencia de los gráficos marginales (como cambiar el tipo de gráfico, el color o el tamaño de 
  los elementos) hace que la visualización sea aún más flexible y adaptada a los requerimientos específicos de cada usuario o proyecto. 
  Esto permite una visualización de datos más clara, eficiente y centrada en las necesidades de los analistas, investigadores o cualquier 
  otro usuario que necesite trabajar con los datos de manera interactiva.
</p>

<p>
  En resumen, <code>ggExtra</code> y <code>ggMarginal</code> no solo enriquecen la capacidad de visualización de los gráficos de 
  dispersión, sino que también optimizan el análisis de datos al permitir una evaluación más profunda de las distribuciones univariadas 
  y las relaciones bivariadas entre las variables. Integrar estas funcionalidades en aplicaciones como <code>Shiny</code> permite 
  una visualización interactiva, flexible y accesible, mejorando tanto la experiencia del usuario como la capacidad de tomar decisiones 
  basadas en datos bien analizados.
</p>

                       '),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                )
              )
      ),
      tabItem(tabName = "scatterplot_plotly",
              fluidRow(
                box(title = "Gráfico de dispersión interactivo", 
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, 
                    width = 12,
                    collapsible = TRUE,
                    HTML('<h3>¿Por qué hacer un gráfico con <code>ggplotly</code> para un 
                       gráfico de dispersión?</h3>
          <p>Hacer un gráfico con <code>ggplotly</code> para un gráfico de dispersión tiene 
          varias ventajas, especialmente en términos de interactividad y exploración de datos. Al convertir un gráfico estático de <code>ggplot2</code> en un gráfico interactivo con <code>ggplotly</code>, obtienes características adicionales que pueden mejorar la experiencia de análisis y visualización de los datos.</p>
          
          <h4>1. Interactividad Mejorada</h4>
          <ul>
            <li><strong>Zoom y desplazamiento:</strong> Los usuarios pueden hacer zoom en 
            regiones específicas del gráfico para explorar detalles más finos.</li>
            <li><strong>Hover (Información emergente):</strong> Muestra información adicional 
            sobre los puntos del gráfico cuando el usuario pasa el cursor sobre ellos.</li>
            <li><strong>Selección de puntos:</strong> Los usuarios pueden seleccionar puntos 
            específicos en el gráfico, lo que permite resaltar o aislar datos.</li>
          </ul>
          
          <h4>2. Facilidad de Personalización en Tiempo Real</h4>
          <ul>
            <li><strong>Modificación dinámica:</strong> Los gráficos interactivos 
            creados con <code>ggplotly</code> permiten la personalización dinámica.</li>
            <li><strong>Visualización de distribuciones:</strong> Agregar visualizaciones 
            adicionales como histogramas o gráficos de densidad que se actualizan en función 
            de la selección de puntos en el gráfico de dispersión.</li>
          </ul>
          
          <h4>3. Mejor Exploración de Relaciones entre Variables</h4>
          <p>En un gráfico de dispersión, puedes explorar de manera interactiva las 
          relaciones entre dos (o más) variables. <code>ggplotly</code> permite al usuario 
          cambiar dinámicamente el enfoque entre diferentes grupos de datos o categorías.</p>
          
          <h4>4. Facilidad de Uso con <code>ggplot2</code></h4>
          <p><code>ggplotly</code> es una extensión de <code>plotly</code> que permite 
          convertir gráficos creados con <code>ggplot2</code> a gráficos interactivos sin 
          necesidad de reescribir el código.</p>
          
          <h4>5. Mejor Presentación en Dashboards y Aplicaciones Web</h4>
          <p>Al integrar gráficos interactivos en aplicaciones web o dashboards, los usuarios 
          pueden manipular los gráficos en tiempo real para obtener una comprensión más profunda de los datos.</p>
          
          <h4>6. Comparación con Gráficos Estáticos</h4>
          <p>Los gráficos estáticos creados con <code>ggplot2</code> son limitados en 
                            interactividad. <code>ggplotly</code> mejora la funcionalidad al agregar 
                            estos elementos interactivos y mucho más.</p>'),
                    verbatimTextOutput("Scatterplot_plotly"),
                    plotlyOutput("scatterplot_plotly1"),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                ),
                box(title = "Combinación de graficos interactivos para la Felicidad Global",
                    status = NULL,
                    class = "box-black", 
                    solidHeader = TRUE, width = 12,
                    collapsible = TRUE,
                    collapsed = TRUE,
                    HTML('
                          <p>Para esta parte se generará un modelo interactivo que examina 
                          cómo diversos factores socioeconómicos, como el <strong>PIB per cápita</strong>, 
                          se relacionan con el <strong>puntaje de felicidad</strong> en diferentes países. 
                          Utilizando una visualización dinámica que incluye gráficos de dispersión, 
                          barras y mapas, los usuarios podrán interactuar con los datos y obtener una 
                          comprensión más profunda sobre cómo el bienestar de las naciones puede estar 
                          influenciado por aspectos como el desarrollo económico, el apoyo social y la 
                          expectativa de vida saludable.</p>
                          
                          <p>A través de gráficos interactivos 
                          creados con <code>ggplot2</code> y <code>ggiraph</code>, se 
                          brindará una experiencia que permite explorar estas relaciones 
                          de manera intuitiva. Los usuarios podrán hacer clic sobre los 
                          países en el mapa, obtener detalles sobre las métricas de felicidad y 
                          comparar los resultados a nivel global. Este análisis no solo 
                          proporciona una visión clara de las disparidades entre regiones, sino 
                          que también permite explorar patrones complejos que podrían no ser 
                          evidentes a simple vista.</p>
                          
                          <p>El objetivo de esta visualización es 
                          facilitar la toma de decisiones informadas y generar insights sobre cómo los 
                          diferentes factores socioeconómicos contribuyen a la felicidad de los pueblos 
                          en distintas partes del mundo.</p>
                         '),
                    verbatimTextOutput("interactivo_1"),
                    HTML('
                          <p>Para este análisis y la creación de visualizaciones interactivas, se han utilizado 
                          una serie de paquetes esenciales en R, que nos permiten manipular, 
                          visualizar y personalizar los datos de manera efectiva. 
                          A continuación se describe brevemente cada uno de 
                          los paquetes utilizados:</p>
                          <ul>
                            <li><strong><code>ggiraph</code></strong>: Este paquete permite agregar 
                            interactividad a los gráficos creados con <code>ggplot2</code>. Con él, 
                            podemos transformar gráficos estáticos en visualizaciones interactivas, 
                            como gráficos de dispersión y mapas, añadiendo elementos como tooltips y 
                            efectos de hover.</li>
                            <li><strong><code>ggplot2</code></strong>: El paquete más 
                            popular para crear gráficos en R. Se utiliza para construir 
                            gráficos de alta calidad, como gráficos de dispersión, barras y 
                            otros tipos, de manera sencilla y flexible, basándose en una gramática de gráficos.</li>
                            <li><strong><code>dplyr</code></strong>: Herramienta esencial para la 
                            manipulación y transformación de datos. Con <code>dplyr</code>, podemos 
                            realizar operaciones como filtrado, agrupamiento, y creación de nuevas 
                            variables de manera eficiente y legible.</li>
                            <li><strong><code>patchwork</code></strong>: Este paquete facilita la 
                            combinación de múltiples gráficos en una única visualización. 
                            Con <code>patchwork</code>, podemos disponer de manera ordenada varios 
                            gráficos generados con <code>ggplot2</code> en una 
                            misma página o presentación.</li>
                            <li><strong><code>tidyr</code></strong>: Paquete que nos ayuda a limpiar y 
                            transformar datos, asegurando que las estructuras de datos estén listas para el 
                            análisis y la visualización. <code>tidyr</code> es útil para tareas como separar 
                            columnas o cambiar la forma de los datos (pivotar o deshacer pivote).</li>
                            <li><strong><code>sf</code></strong>: Paquete especializado en el manejo de datos 
                            espaciales en R. Con <code>sf</code>, podemos trabajar con objetos geoespaciales, como polígonos de 
                            países, y visualizarlos de manera eficiente, lo que resulta 
                            fundamental cuando trabajamos con mapas y datos geográficos.</li>
                          </ul>
                         <p>Estos 
                         paquetes combinados permiten desarrollar visualizaciones interactivas 
                         y dinámicas, facilitando la exploración y 
                         comprensión de datos complejos relacionados con factores 
                         socioeconómicos, geográficos y más.</p>'),
                    verbatimTextOutput("interactivo_2"),
                    HTML('<p>Ahora solamente falta el código para generar los
                         gráficos:</p>'),
                    verbatimTextOutput("interactivo_3"),
                    girafeOutput("interactivo_plot_a", height = "600px"),
                    HTML('
                         <p>
        Los gráficos de dispersión son una herramienta poderosa para 
        visualizar la relación entre dos variables. 
        En este caso, se ha utilizado <code>ggplot2</code> junto con <code>ggiraph</code> 
        para crear gráficos interactivos en un dashboard de <code>Shiny</code>. 
        A través de la interactividad proporcionada por <code>ggiraph</code>, los usuarios 
        pueden explorar y analizar mejor las relaciones entre las variables, 
        ya que pueden obtener información adicional al pasar el 
        cursor sobre los puntos del gráfico.
    </p>
    <p>
        Además, el uso de <strong>code</strong> permite mejorar aún más 
        la interactividad y personalización de los gráficos, 
        permitiendo una experiencia de usuario mucho más dinámica. 
        Ambas herramientas, <code>ggplot2</code> y <code>Plotly</code>, son 
        ampliamente utilizadas en la visualización de datos 
        debido a su flexibilidad y la calidad de las visualizaciones generadas.
    </p>
    <p>
        El código utilizado para la creación de los gráficos interactivos está 
        basado en el trabajo de <strong>Yan Holtz</strong>, 
        y puedes encontrar el código fuente original y más 
        ejemplos en el siguiente enlace: 
        <a href="https://r-graph-gallery.com/414-map-multiple-charts-in-ggiraph.html" target="_blank">R Graph Gallery. By Yan Holtz</a>
    </p>
    <p>
        Créditos a Yan Holtz por compartir este recurso útil y educativo sobre gráficos interactivos.
    </p>
                         '),
                    tags$footer(
                      style = "background-color: #f8f9fa; padding: 10px; text-align: center; font-size: 14px; color: #6c757d;",
                      "Fuente: Elaboración propia a partir de datos Alberto Madin Rivera - ", Sys.Date()
                    )
                )
              )
      )
    )
  )
)

################################################################################
################################################################################
##################################### SERVER ###################################
################################################################################
################################################################################

# Definir la lógica del servidor
server = function(input, output) {
###############################################################
  output$interactivo_1 = renderText({'library(ggiraph)
library(ggplot2) 
library(dplyr) 
library(patchwork)
library(tidyr)
library(sf)
set.seed(123)
'})
  
  output$barras__1 = renderText({
    '# Cargar los datos Iris
data(iris)

# Crear un gráfico de barras para mostrar la cantidad de observaciones por especie
barplot(table(iris$Species), 
        main = "Distribución de Especies en el Conjunto de Datos Iris", 
        col = "skyblue", 
        ylab = "Cantidad de observaciones", 
        xlab = "Especies", 
        border = "black")'
    })
  
  output$barras__2 = renderPlot({
    # Cargar los datos Iris
    data(iris)
    
    # Crear un gráfico de barras para mostrar la cantidad de observaciones por especie
    barplot(table(iris$Species), 
            main = "Distribución de Especies en el Conjunto de Datos Iris", 
            col = "skyblue", 
            ylab = "Cantidad de observaciones", 
            xlab = "Especies", 
            border = "black")
  })
  output$barras__3 = renderText({'# Gráfico de barras horizontal
barplot(table(iris$Species), 
        main = "Distribución de Especies (Barras Horizontales)", 
        col = "skyblue", 
        ylab = "Especies", 
        xlab = "Cantidad de observaciones", 
        border = "black", 
        horiz = TRUE)  # Barra horizontal'})
  
  output$barras__4 = renderPlot({
    # Gráfico de barras horizontal
    barplot(table(iris$Species), 
            main = "Distribución de Especies (Barras Horizontales)", 
            col = "skyblue", 
            ylab = "Especies", 
            xlab = "Cantidad de observaciones", 
            border = "black", 
            horiz = TRUE)  # Barra horizontal
  })
  
  output$barras__5 = renderText({'# Paleta de colores pastel
pastel_colors = c("#FAD02E", "#F28D35", "#D83367")

# Gráfico de barras con paleta de colores y borde NA (sin borde)
barplot(table(iris$Species), 
        main = "Distribución de Especies con Paleta de Colores y Borde NA", 
        col = pastel_colors, 
        ylab = "Cantidad de observaciones", 
        xlab = "Especies", 
        border = NA)  # Borde NA (sin borde)'})
  
  output$barras__6 = renderPlot({
    # Paleta de colores pastel
    pastel_colors = c("#FAD02E", "#F28D35", "#D83367")
    
    # Gráfico de barras con paleta de colores y borde NA (sin borde)
    barplot(table(iris$Species), 
            main = "Distribución de Especies con Paleta de Colores y Borde NA", 
            col = pastel_colors, 
            ylab = "Cantidad de observaciones", 
            xlab = "Especies", 
            border = NA)  # Borde NA (sin borde)
    })
  
  output$barras__7 = renderText({'# Gráfico con borde de otro color
    barplot(table(iris$Species),
            main = "Distribución de Especies con Borde y Leyenda",
            ylab = "Cantidad de observaciones",
            xlab = "Especies",
            border = "#69b3a2", 
    col = "white",
    legend.text = levels(iris$Species),
    args.legend = list(x = "topright", bty = "n", title = "Especies")'})
  
  output$barras__8 = renderPlot({
    barplot(table(iris$Species),
            main = "Distribución de Especies con Borde y Leyenda",
            ylab = "Cantidad de observaciones",
            xlab = "Especies",
            border = '#69b3a2', 
            col = 'white',
            legend.text = levels(iris$Species),
            args.legend = list(x = "topright", bty = "n", title = "Especies")
            )
  })
  
  output$barras__9 = renderText({'# Gráfico de barras más delgadas
barplot(table(iris$Species), 
        main = "Distribución de Especies con Barras Más Delgadas", 
        col = "skyblue", 
        ylab = "Cantidad de observaciones", 
        xlab = "Especies", 
        border = "black", 
        space = 5)  # Barras más delgadas (menos espacio)'})
  
  output$barras__10 = renderPlot({# Gráfico de barras más delgadas
    barplot(table(iris$Species), 
            main = "Distribución de Especies con Barras Más Delgadas", 
            col = "skyblue", 
            ylab = "Cantidad de observaciones", 
            xlab = "Especies", 
            border = "black", 
            space = 5)  # Barras más delgadas (menos espacio)
    })
  
  output$barras__11 = renderText({'# Usamos la base de datos mtcars
data(mtcars)

# Contar la frecuencia de cada número de cilindros
cyl_count = table(mtcars$cyl)

# Crear un gráfico de barras profesional
barplot(cyl_count, 
        main = "Distribución de Vehículos por Número de Cilindros",  # Título
        col = c("#69b3a2", "#404080", "#ff9999"),  # Colores suaves en las barras
        ylab = "Cantidad de Vehículos",  # Etiqueta eje Y
        xlab = "Número de Cilindros",    # Etiqueta eje X
        border = "white",  # Borde blanco para barras elegantes
        las = 1,  # Rotar etiquetas del eje X para mayor legibilidad
        cex.names = 1.2,  # Aumentar el tamaño de las etiquetas del eje X
        cex.axis = 1.2,   # Aumentar el tamaño de las etiquetas del eje Y
        cex.main = 1.5,   # Título más grande
        cex.lab = 1.3,    # Etiquetas de los ejes más grandes
        ylim = c(0, max(cyl_count) + 2),  # Ajustar el límite del eje Y para no cortar las barras
        col.main = "darkblue",  # Color del título
        col.lab = "black",      # Color de las etiquetas de los ejes
        font.main = 2,          # Título en negrita
        font.lab = 2,           # Etiquetas de los ejes en negrita
        bg = "white",           # Fondo blanco
        axes = TRUE)            # Mostrar ejes'})
  
  output$barras__12 = renderPlot({
    # Usamos la base de datos mtcars
    data(mtcars)
    
    # Contar la frecuencia de cada número de cilindros
    cyl_count = table(mtcars$cyl)
    
    # Crear un gráfico de barras profesional
    barplot(cyl_count, 
            main = "Distribución de Vehículos 
por Número de Cilindros",  # Título
            col = c("#69b3a2", "#404080", "#ff9999"),  # Colores suaves en las barras
            ylab = "Cantidad de Vehículos",  # Etiqueta eje Y
            xlab = "Número de Cilindros",    # Etiqueta eje X
            border = "white",  # Borde blanco para barras elegantes
            las = 1,  # Rotar etiquetas del eje X para mayor legibilidad
            cex.names = 1.2,  # Aumentar el tamaño de las etiquetas del eje X
            cex.axis = 1.2,   # Aumentar el tamaño de las etiquetas del eje Y
            cex.main = 1.5,   # Título más grande
            cex.lab = 1.3,    # Etiquetas de los ejes más grandes
            ylim = c(0, max(cyl_count) + 2),  # Ajustar el límite del eje Y para no cortar las barras
            col.main = "darkblue",  # Color del título
            col.lab = "black",      # Color de las etiquetas de los ejes
            font.main = 2,          # Título en negrita
            font.lab = 2,           # Etiquetas de los ejes en negrita
            bg = "white",           # Fondo blanco
            axes = TRUE)            # Mostrar ejes
    })
  
  output$barras__13 = renderText({'# Cargar ggplot2
library(ggplot2)

# Crear los datos
datos = data.frame(
  nombre=c("Ana", "Luis", "Pedro", "Maria", "Juan"),  
  valor=c(3, 12, 5, 18, 45)
)

# Gráfico de barras
ggplot(datos, aes(x=nombre, y=valor)) + 
geom_bar(stat = "identity") # Usamos "identity" para que las 
  # barras se construyan con los valores de "valor"'})

  output$barras__14 = renderPlot({
    # Cargar ggplot2
    library(ggplot2)
    
    # Crear los datos
    datos = data.frame(
      nombre=c("Ana", "Luis", "Pedro", "Maria", "Juan"),  
      valor=c(3, 12, 5, 18, 45)
    )
    
    # Gráfico de barras
    ggplot(datos, aes(x=nombre, y=valor)) + 
      geom_bar(stat = "identity")  # Usamos "identity" para que las 
    # barras se construyan con los valores de "valor"
  })
  
  output$plotly__1 = renderText({
    '# Instalar plotly si no lo tienes
# install.packages("plotly")

library(plotly)

# Datos de ejemplo
categorias = c("A", "B", "C", "D")
valores = c(5, 10, 13, 7)

# Crear un gráfico de barras interactivo con Plotly
fig = plot_ly(x = categorias, y = valores, type = "bar", marker = list(color = "skyblue"))

# Mostrar el gráfico
fig
'
  })
  
  output$plotly__2 = renderPlotly({
    library(plotly)
    
    categorias = c("A", "B", "C", "D")
    valores = c(5, 10, 13, 7)
    fig = plot_ly(x = categorias, y = valores,
                  type = "bar", marker = list(color = "skyblue"))
    fig
  })
  
  output$print_1 = renderText({
    'print("¡Hola mundo!")'
  })
  output$print_2 = renderText({
    'console.log("¡Hola mundo!")'
  })
  output$print_3 = renderText({
    '#include <stdio.h>
    int main() {
      printf("¡Hola mundo!\n");
      return 0;
}'
  })
  output$print_4 = renderText({
    'public class HolaMundo {
      public static void main(String[] args) {
        System.out.println("¡Hola mundo!");
    }
}'
  })
  output$print_5 = renderText({
    'puts "¡Hola mundo!"'
  })
  output$r_primero = renderText({
    '# Gráfico sencillo en r base
plot(x, y)'
  })
  output$r_segundo = renderText({
    '# Histograma sencillo en r base
hist(x)'
  })
  output$r_tercero = renderText({
    '# Barplot sencillo en r base
barplot(height)'
  })
  output$r_cuarto = renderText({
    '# Gráfico sencillo de líneas en r base
plot(x, y, type = "l)'
  })
  
  output$r_ggplot1 = renderText({
    'plot(x, y)'
  })
  output$r_ggplot2 = renderText({
    'library(ggplot2)
    ggplot(data, aes(x = x, y = y)) +
      geom_point()'
  })
  
  output$interactivo_3 = renderText({'# Crear el primer gráfico (Gráfico de dispersión)
p1 = ggplot(world_sf, aes(
  GDP_per_capita,
  Happiness_Score,
  tooltip = name,
  data_id = name,
  color = name
)) +
  geom_point_interactive(data = filter(world_sf, !is.na(Happiness_Score)), size = 4) +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none"
  )

# Crear el segundo gráfico (Gráfico de barras)
p2 = ggplot(world_sf, aes(
  x = reorder(name, Happiness_Score),
  y = Happiness_Score,
  tooltip = name,
  data_id = name,
  fill = name
)) +
  geom_col_interactive(data = filter(world_sf, !is.na(Happiness_Score))) +
  coord_flip() +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none"
  )

# Crear el tercer gráfico (Mapa temático)
p3 = ggplot() +
  geom_sf(data = world_sf, fill = "lightgrey", color = "lightgrey") +
  geom_sf_interactive(
    data = filter(world_sf, !is.na(Happiness_Score)),
    aes(fill = name, tooltip = name, data_id = name)
  ) +
  coord_sf(crs = st_crs(3857)) +
  theme_void() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "none"
  )

# Combinar los gráficos
combined_plot = (p1 + p2) / p3 + plot_layout(heights = c(1, 2))

# Crear el gráfico interactivo
interactive_plot = girafe(ggobj = combined_plot)
interactive_plot = girafe_options(
  interactive_plot,
  opts_hover(css = "fill:red;stroke:black;")
)

interactive_plot'})

output$interactivo_2 = renderText({'# Leer el mapa mundial completo
world_sf = read_sf("https://raw.githubusercontent.com/holtzy/R-graph-gallery/master/DATA/world.geojson")
world_sf = world_sf %>%
  filter(!name %in% c("Antarctica", "Greenland"))

# Crear un conjunto de datos de ejemplo
happiness_data = data.frame(
  Country = c(
    "France", "Germany", "United Kingdom",
    "Japan", "China", "Vietnam",
    "United States of America", "Canada", "Mexico"
  ),
  Continent = c(
    "Europe", "Europe", "Europe",
    "Asia", "Asia", "Asia",
    "North America", "North America", "North America"
  ),
  Happiness_Score = rnorm(mean = 30, sd = 20, n = 9),
  GDP_per_capita = rnorm(mean = 30, sd = 20, n = 9),
  Social_support = rnorm(mean = 30, sd = 20, n = 9),
  Healthy_life_expectancy = rnorm(mean = 30, sd = 20, n = 9)
)

# Unir los datos de felicidad con el mapa mundial completo
world_sf = world_sf %>%
  left_join(happiness_data, by = c("name" = "Country"))'})

output$Scatterplot_plotly = renderText({'# Cargar librerías
  library(ggplot2)
  library(plotly)
  
  plot_ly(iris, x = ~Sepal.Length, y = ~Sepal.Width, 
          color = ~Species, type = "scatter", mode = "markers") %>%
    layout(title = "Gráfico de Dispersión de Iris")'})

output$marginal_p1 = renderText({'# Agregar los gráficos marginales de histograma
ggMarginal(p, type = "histogram")'})

output$marginal_p2 = renderText({'# Agregar los gráficos marginales de densidad
ggMarginal(p, type = "density")'})

output$marginal_p3 = renderText({'# Agregar los gráficos marginales de violín
ggMarginal(p, type = "violin, fill = "lightblue)'})

output$marginal_p = renderText({'# Librerías a usar
library(ggplot2)
library(ggExtra)

# Crear el gráfico de dispersión
p = ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()

print(p)'})

output$scatter_t1 = renderText({'# Color
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
    geom_point(size=6) +
    ggtitle("Diagrama de Dispersión con Color") +
    theme_minimal()'})

output$scatter_t2 = renderText({'# Fill (Relleno)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) + 
    geom_point(shape=21, size=6, color="black") + 
    ggtitle("Diagrama de Dispersión con Relleno de Puntos") +
    theme_minimal()'})

output$scatter_t3 = renderText({'# Alpha (Transparencia con variable continua)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, alpha=Petal.Width)) + 
    geom_point(size=6, color="orange") +
    ggtitle("Diagrama de Dispersión con Transparencia (Alpha)") +
    theme_minimal()'})

output$scatter_t4 = renderText({'# Size (Tamaño de los puntos)
ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, size=Petal.Width)) + 
    geom_point(color="darkred") +
    ggtitle("Diagrama de Dispersión con Tamaño de los Puntos") +
    theme_minimal()'})

output$iris_tabla = renderDataTable({
  datatable(iris,
            options = list(scrollX = TRUE,
              pageLength = 10, # Número de filas en la página
              lengthMenu = c(10, 25, 50), # Opciones para el número de filas por página
              searching = TRUE, # Activar búsqueda
              paging = TRUE # Activar paginación
            ))
})

output$iris_code = renderText({'library(ggplot2)

ggplot(iris, 
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species # Esto cambiará el color por Especies
           )) +
  geom_point()'})

output$s = renderText({'# Cargar el conjunto de datos mtcars
data(mtcars)

# Crear un gráfico de dispersión con R base
plot(mtcars$wt, mtcars$mpg, 
     main = "Gráfico de Dispersión: Peso vs Millas por Galón",
     xlab = "Peso del Vehículo (wt)", 
     ylab = "Millas por Galón (mpg)", 
     pch = 19, # Estilo de los puntos
     col = "blue") # Color de los puntos'})

output$a1 = renderText({'# Cargar la librería ggplot2
library(ggplot2)

# Crear el gráfico de dispersión
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point()  # Agregar los puntos al gráfico'})

output$barplot_gg__3 = renderText({"# Cargar ggplot2
library(ggplot2)

# Crear los datos
datos = data.frame(
  nombre=c('Ana', 'Luis', 'Pedro', 'Maria', 'Juan'),  
  valor=c(3, 12, 5, 18, 45)
)

# Gráfico de barras con diferentes anchos
ggplot(datos, aes(x=nombre, y=valor)) + 
  geom_bar(stat = 'identity', width = 0.3)  
# Cambia el valor de 'width' para variar el ancho"})



# Código de R para el gráfico de barras ggplot2
output$barplot_gg__5 = renderText("# Cargar ggplot2
library(ggplot2)

# Crear los datos
datos = data.frame(
  nombre=c('Ana', 'Luis', 'Pedro', 'Maria', 'Juan'),  
  valor=c(3, 12, 5, 18, 45)
)

# Gráfico de barras horizontal con coord_flip
ggplot(datos, aes(x=nombre, y=valor)) + 
  geom_bar(stat = 'identity') + 
  coord_flip()  # Esto voltea el gráfico para que sea horizontal
")

output$barplot_gg__7 = renderText({"# Cargar ggplot2
library(ggplot2)

# Crear los datos
datos = data.frame(
  nombre=c('Ana', 'Luis', 'Pedro', 'Maria', 'Juan'),  
  valor=c(3, 12, 5, 18, 45)
)

# Gráfico de barras con tema minimalista
ggplot(datos, aes(x=nombre, y=valor)) + 
  geom_bar(stat = 'identity') + 
  theme_minimal()  # Aplica un fondo minimalista
"})

output$barplot_gg__1 = renderText({"# Cargar ggplot2 y viridis
library(ggplot2)
library(viridis)

# Crear los datos
datos = data.frame(
  nombre=c('Ana', 'Luis', 'Pedro', 'Maria', 'Juan'),  
  valor=c(3, 12, 5, 18, 45)
)

# Gráfico de barras con color viridis
ggplot(datos, aes(x=nombre, y=valor, fill=nombre)) + 
  geom_bar(stat = 'identity') + 
  scale_fill_viridis(discrete = TRUE)"
})

# Código de R para el gráfico de barras ggplotly
output$a = renderText({
  '# Cargar las librerías necesarias
library(ggplot2)
library(plotly)

# Crear un gráfico de barras con ggplot2
ggplot_bar = ggplot(mtcars, aes(x = as.factor(cyl))) +
  geom_bar(fill = "skyblue", color = "black") +
  labs(x = "Número de Cilindros", y = "Frecuencia", title = "Gráfico de Barras: Número de Cilindros en mtcars")

# Convertir el gráfico de ggplot a gráfico interactivo con Plotly
ggplotly(ggplot_bar)'})




output$s_1 = renderPlot({
  # Cargar el conjunto de datos mtcars
  data(mtcars)
  
  # Crear un gráfico de dispersión con R base
  plot(mtcars$wt, mtcars$mpg, 
       main = "Gráfico de Dispersión: Peso vs Millas por Galón",
       xlab = "Peso del Vehículo (wt)", 
       ylab = "Millas por Galón (mpg)", 
       pch = 19, # Estilo de los puntos
       col = "blue") # Color de los puntos
})


# Gráfico de barras ggplot2
output$barplot_gg__2 = renderPlot({
  # Cargar ggplot2 y viridis
  library(ggplot2)
  library(viridis)
  
  # Crear los datos
  datos = data.frame(
    nombre=c("Ana", "Luis", "Pedro", "Maria", "Juan"),  
    valor=c(3, 12, 5, 18, 45)
  )
  
  # Gráfico de barras con color viridis
  ggplot(datos, aes(x=nombre, y=valor, fill=nombre)) + 
    geom_bar(stat = "identity") + 
    scale_fill_viridis(discrete = TRUE)
})

output$plot_a1 = renderPlot({# Cargar la librería ggplot2
  library(ggplot2)
  
  # Crear el gráfico de dispersión
  ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point()  # Agregar los puntos al gráfico
})

# Gráfico de barras con colores
output$a_graph = renderPlotly({
  # Cargar las librerías necesarias
  library(ggplot2)
  library(plotly)
  
  # Crear un gráfico de barras con ggplot2
  ggplot_bar = ggplot(mtcars, aes(x = as.factor(cyl))) +
    geom_bar(fill = "skyblue", color = "black") +
    labs(x = "Número de Cilindros", y = "Frecuencia", title = "Gráfico de Barras: Número de Cilindros en mtcars")
  
  # Convertir el gráfico de ggplot a gráfico interactivo con Plotly
  ggplotly(ggplot_bar)
})


output$barplot_gg__4 = renderPlot({# Cargar ggplot2
  library(ggplot2)
  
  # Crear los datos
  datos = data.frame(
    nombre=c("Ana", "Luis", "Pedro", "Maria", "Juan"),  
    valor=c(3, 12, 5, 18, 45)
  )
  
  # Gráfico de barras con diferentes anchos
  ggplot(datos, aes(x=nombre, y=valor)) + 
    geom_bar(stat = "identity", width = 0.3)  # Cambia el valor de "width" para variar el ancho
  })

output$barplot_gg__8 = renderPlot({
  # Cargar ggplot2
  library(ggplot2)
  
  # Crear los datos
  datos = data.frame(
    nombre=c("Ana", "Luis", "Pedro", "Maria", "Juan"),  
    valor=c(3, 12, 5, 18, 45)
  )
  
  # Gráfico de barras con tema minimalista
  ggplot(datos, aes(x=nombre, y=valor)) + 
    geom_bar(stat = "identity") + 
    theme_minimal()  # Aplica un fondo minimalista
  
})

output$barplot_gg__6 = renderPlot({
  # Cargar ggplot2
  library(ggplot2)
  
  # Crear los datos
  datos = data.frame(
    nombre=c("Ana", "Luis", "Pedro", "Maria", "Juan"),  
    valor=c(3, 12, 5, 18, 45)
  )
  
  # Gráfico de barras horizontal con coord_flip
  ggplot(datos, aes(x=nombre, y=valor)) + 
    geom_bar(stat = "identity") + 
    coord_flip()  # Esto voltea el gráfico para que sea horizontal
  
})

output$iris_plot = renderPlot(ggplot(iris, 
                                     aes(x = Sepal.Length,
                                         y = Sepal.Width,
                                         color = Species # Esto cambiará el color por Especies
                                     )) +
                                geom_point())

output$scatter_plots = renderPlot({
  library(ggplot2)
  library(gridExtra)
  
  p1 = ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, color=Species)) + 
    geom_point(size=6) +
    ggtitle("Diagrama de Dispersión con Color") +
    theme_minimal()
  p2 = ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, fill=Species)) + 
    geom_point(shape=21, size=6, color="black") + 
    ggtitle("Diagrama de Dispersión con Relleno de Puntos") +
    theme_minimal()
  p3 = ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, alpha=Petal.Width)) + 
    geom_point(size=6, color="orange") +
    ggtitle("Diagrama de Dispersión con Transparencia (Alpha)") +
    theme_minimal()
  p4 = ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, size=Petal.Width)) + 
    geom_point(color="darkred") +
    ggtitle("Diagrama de Dispersión con Tamaño de los Puntos") +
    theme_minimal()
  
  grid.arrange(p1, p2, p3, p4, ncol = 2, nrow = 2)
})

output$marginal_plot =  renderPlot({# Librerías a usar
  library(ggplot2)
  library(ggExtra)
  
  # Crear el gráfico de dispersión
  p = ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point()
  print(p)})

output$marginal_plot1 = renderPlot({  
  library(ggplot2)
  library(ggExtra)
  
  # Crear el gráfico de dispersión
  p = ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point()
  ggMarginal(p, type = "histogram")
})

output$marginal_plot3 = renderPlot({  
  library(ggplot2)
  library(ggExtra)
  
  # Crear el gráfico de dispersión
  p = ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point()
  ggMarginal(p, type = "violin", fill = "lightblue")
})

output$marginal_plot2 = renderPlot({  
  library(ggplot2)
  library(ggExtra)
  
  # Crear el gráfico de dispersión
  p = ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width)) +
    geom_point()
  ggMarginal(p, type = "density")
})

output$plot__1 = renderPlot({
  categorias = c("A", "B", "C", "D")
  valores = c(5, 10, 13, 7)
  barplot(valores, names.arg = categorias, col = "skyblue",
          main = "Gráfico de Barras en R base")
})
output$plot__2 = renderPlot({
  categorias = c("A", "B", "C", "D")
  valores = c(5, 10, 13, 7)
  df = data.frame(categorias = categorias, valores = valores)
  
  ggplot(df, aes(x = categorias, y = valores)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    labs(title = "Gráfico de Barras en ggplot2", x = "Categorías", y = "Valores")
})

output$scatterplot_plotly1 = renderPlotly({# Cargar librerías
  library(ggplot2)
  library(plotly)
  
  plot_ly(iris, x = ~Sepal.Length, y = ~Sepal.Width, 
          color = ~Species, type = 'scatter', mode = 'markers') %>%
    layout(title = "Gráfico de Dispersión de Iris")
})

output$interactivo_plot_a = renderGirafe({library(ggiraph) # install.packages('ggiraph')
  library(ggplot2) # install.packages('ggplot2')
  library(dplyr) # install.packages('dplyr')
  library(patchwork) # install.packages('patchwork')
  library(tidyr) # install.packages('tidyr')
  library(sf) # install.packages('sf')
  set.seed(123)
  
  # Leer el mapa mundial completo
  world_sf = read_sf("https://raw.githubusercontent.com/holtzy/R-graph-gallery/master/DATA/world.geojson")
  world_sf = world_sf %>%
    filter(!name %in% c("Antarctica", "Greenland"))
  
  # Crear un conjunto de datos de ejemplo
  happiness_data = data.frame(
    Country = c(
      "France", "Germany", "United Kingdom",
      "Japan", "China", "Vietnam",
      "United States of America", "Canada", "Mexico"
    ),
    Continent = c(
      "Europe", "Europe", "Europe",
      "Asia", "Asia", "Asia",
      "North America", "North America", "North America"
    ),
    Happiness_Score = rnorm(mean = 30, sd = 20, n = 9),
    GDP_per_capita = rnorm(mean = 30, sd = 20, n = 9),
    Social_support = rnorm(mean = 30, sd = 20, n = 9),
    Healthy_life_expectancy = rnorm(mean = 30, sd = 20, n = 9)
  )
  
  # Unir los datos de felicidad con el mapa mundial completo
  world_sf = world_sf %>%
    left_join(happiness_data, by = c("name" = "Country"))
  
  # Crear el primer gráfico (Gráfico de dispersión)
  p1 = ggplot(world_sf, aes(
    GDP_per_capita,
    Happiness_Score,
    tooltip = name,
    data_id = name,
    color = name
  )) +
    geom_point_interactive(data = filter(world_sf, !is.na(Happiness_Score)), size = 4) +
    theme_minimal() +
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      legend.position = "none"
    )
  
  # Crear el segundo gráfico (Gráfico de barras)
  p2 = ggplot(world_sf, aes(
    x = reorder(name, Happiness_Score),
    y = Happiness_Score,
    tooltip = name,
    data_id = name,
    fill = name
  )) +
    geom_col_interactive(data = filter(world_sf, !is.na(Happiness_Score))) +
    coord_flip() +
    theme_minimal() +
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      legend.position = "none"
    )
  
  # Crear el tercer gráfico (Mapa temático)
  p3 = ggplot() +
    geom_sf(data = world_sf, fill = "lightgrey", color = "lightgrey") +
    geom_sf_interactive(
      data = filter(world_sf, !is.na(Happiness_Score)),
      aes(fill = name, tooltip = name, data_id = name)
    ) +
    coord_sf(crs = st_crs(3857)) +
    theme_void() +
    theme(
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      legend.position = "none"
    )
  
  # Combinar los gráficos
  combined_plot = (p1 + p2) / p3 + plot_layout(heights = c(1, 2))
  
  # Crear el gráfico interactivo
  interactive_plot = girafe(ggobj = combined_plot)
  interactive_plot = girafe_options(
    interactive_plot,
    opts_hover(css = "fill:red;stroke:black;")
  )
  
  interactive_plot})

}



# Ejecutar la aplicación Shiny
shinyApp(ui = ui, server = server)