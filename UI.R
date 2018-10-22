#the ui component creates the user interface i.e. what a user 'sees'
ui <- fluidPage(
  column(width = 12,
    fluidRow(h2("A Study of Chick Weight as Influenced By Diet")),
    fluidRow(h3("By Emily Petrie")),
    fluidRow(h4("10/21/18")), br(),
    fluidRow(column(width = 4,
                    fluidRow("50 chicks were used in the study and were fed one of four protein diets during the first
                           month of life. Their weight was tracked over time. Use the drop-down below to select which
                           chicks to include in the visual to the right."), br(),
                    fluidRow(
                      #create a drop-down which allows the user to indicate which chicks to include in the visual 
                      selectInput(inputId = "pick", label = "Pick which chicks to analyze:", 
                                  choices = c("All of em!", "All of the even numbered chicks please", 
                                              "Odd balls only", "Every third chick except #24 - he is a screw up"), 
                                  selected = "All of em!", multiple = F))),
             column(width = 8,
                    #this output will serve as a visual representation of chick weights on different diet types 
                    plotlyOutput(outputId = "viz"))
    )
  )
)
