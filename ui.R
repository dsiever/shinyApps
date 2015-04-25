library(shiny)
library(ggplot2)

shinyUI(
   bootstrapPage(title="Examples in Shiny",
      tabsetPanel(  
            tabPanel("Set-Up Tab 1",
               div(class="span4",  
                  wellPanel(h3("Choose your plotting variable:"),
                     uiOutput('my_list'),
                     uiOutput('my_list2'),
                        br(), br(),
                        helpText("To plot each variable, simply choose
                                 from the drop down.  The plot will update
                                 automagically.")
                  )
               ),
               div(class="span8",h2("Scatterplots"),
                                 h3("Easy Interaction with Variables"),
                                 h4("Example with GGPLOT2"),
                                 plotOutput("p1")
               )
            ),
            tabPanel("Set-Up Tab 2",
               div(class="span12",  
                  wellPanel(h3("Simple Scatter Plots with Exposed Data Table:")
                  )
               ),
               div(class="row-fluid", style="height=1200px",
                  div(class="row-fluid",
                     div(class="span6"), 
                     div(class="span6")
                  ),
                  div(class="row-fluid",
                     div(class="span6", plotOutput("p2")),
                        div(class="span6", plotOutput("p3")
                        ), br(), br(), br(),
                        tabsetPanel(
                        tabPanel('test',
                        div(class="span4", "offset1",dataTableOutput("dat_table"))),
                        tabPanel('test2')
                     )
                  )
               )
            ),
            tabPanel("Set-Up Tab 3",
               div(class="span8",  
                  wellPanel(h3("Economic Variables:"),
                     uiOutput('eco_list1'),
                        br(), 
                        helpText("To plot each variable, simply choose
                                 from the drop down.  The plot will update
                                 automagically."), 
                     div(class="span8",br(), br(), h2("Time Series Plots"),
                        h3("Easy Interaction with Variables"),
                        h4("Example with base graphics"),
                        plotOutput("eco1")
                     )
                  )
               ),     
               div(class="span4",
                  wellPanel(h2("Regression Variables:"),
                     uiOutput('eco_list2'),
                     uiOutput('independent') 
                  ),
               mainPanel(tableOutput("regTab"))
               )
            )
         )
      )
   )
 