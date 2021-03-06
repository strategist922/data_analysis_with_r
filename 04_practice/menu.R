ui <- fluidPage(
  titlePanel("Algoritmo de Calculo de Probabilidades"),
  sidebarLayout(
    
    sidebarPanel(
      selectInput("dist", "Distribuciones:",
               c("Beta" = "c_beta",
                 "Binomial" = "c_binom",
                 "Cauchy" = "c_cauchy",
                 "Chi-Cuadrada" = "c_chisq",
                 "Exponencial" = "c_exp",
                 "F"="c_f",
                 "Gamma"="c_gamma",
                 "Geometrica"="c_geom",
                 "Hipergeometrica"="c_hyper",
                 "Logistica"="c_logis",
                 "Lognormal"="c_lnorm",
                 "Binomial Negativa"="c_binomn",
                 "Normal"="c_norm",
                 "t-Student"="c_t",
                 "Uniforme"="c_unif",
                 "Weibull"="c_weibull",
                 "Poisson"="c_pois"
                 )
      ),
    conditionalPanel(
      condition = "input.dist == 'c_beta'",
      numericInput("shape1", "a", "0"),
      numericInput("shape2", "b", "0"),
      
      p("AREA SOMBREADA"),
      radioButtons(
        "sopt",
        "Opciones",
        c(
          "Ambos lados"= "1",
          "Izquierda" = "2",
          "Derecha" = "3"
        )
      )      
    ),
    conditionalPanel(
      condition = "input.dist == 'c_binom'",
      numericInput("size", "tamaño", "0"),
      numericInput("prob", "probabilidad", "0")
    ),    
    conditionalPanel(
      condition = "input.dist == 'unif'",
      sliderInput("breakCount", "Break Count", min=1, max=1000, value=10),
      textInput("caption", "Caption", "Data Summary")
    )

    
   ),
   
   mainPanel(
     conditionalPanel(
       condition = "input.dist == 'c_beta'",
       plotOutput("grafica")
     ),
     conditionalPanel(
       condition = "input.dist == 'c_binom'",
       plotOutput("grafica_bin")
     )     
   )
   
 )
)


server <- function(input, output, session) {
  output$grafica <- renderPlot(probabilidad.beta(input$shape1,input$shape2,input$sopt))
  output$grafica_bin <- renderPlot(probabilidad.binomial(input$size,input$prob))
}
shinyApp(ui, server)