#the server component fuels all functionality and reactivity i.e. what the app 'does'
server <- function(input, output){
  
  #load data and filter based on the user input above
  chicks <- reactive({
    data <- ChickWeight 
    data$Chick <- as.numeric(as.character(data$Chick))
    data$Diet <- ifelse(data$Diet == 1, "Diet 1",
                        ifelse(data$Diet == 2, "Diet 2",
                               ifelse(data$Diet == 3, "Diet 3",
                                      "Diet 4")))
    
    #if only certain chicks were selected - filter to those chicks 
    ifelse(input$pick == "All of em!", data <- data, 
                   ifelse(input$pick == "All of the even numbered chicks please", data <- data %>% filter(Chick %% 2 == 0),
                          ifelse(input$pick == "Odd balls only", data <- data %>% filter(Chick %% 2 == 1),
                                 data <- data %>% filter(Chick %% 3 == 0, Chick != 24))))
    
    data
  })
  
  #call the reactive expression containing filtered data and plot chick weight over time on each of the four diets
  output$viz <- renderPlotly({
    p <- plot_ly(data = chicks(), x = ~Time, y = ~weight, color = ~Diet,
                 type = "scatter", mode = "markers", alpha = 0.6,
                 hoverinfo = 'text', text = ~paste0("Chick:", Chick)) %>%
      layout(title = "An Arbitrary Assortment of Chick Weight Over Time By Diet",
             xaxis = list(title = "Days Since Birth"),
             yaxis = list(title = "Weight (gm)"))
    p
  })
