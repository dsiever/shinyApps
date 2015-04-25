library(shiny)
library(ggplot2)
data(economics)

# foo <- list("Cylinders" = "cyl", "Transmission" = "am",
                          # "Gears" = "gear", "Morgan" = "morgan!!")  # could be col names of df
set.seed(1)
dat <- data.frame(cond = rep(c("A", "B","C", "D"), each=10),
                        xvar = 1:20 + rnorm(20,sd=3),
                        yvar = 1:20 + rnorm(20,sd=3))
foo <- unique(dat$cond)

shinyServer(
   function(input, output){
      output$my_list <- 
         renderUI({ 
            selectInput(inputId = "variable", label = "Variable 1:", choices = foo)
         })     
      output$my_list2 <- 
         renderUI({ 
            selectInput(inputId = "variable2", label = "Variable 2:", choices = foo)
         })  

      dat_foo <- 
         reactive({
            tmp <- dat[dat$cond %in% c(input$variable, input$variable2),]
            tmp2 <- tmp * tmp
            return(tmp2)
         }) 
 
         output$p1 <- 
            renderPlot({print(ggplot(dat_foo(), aes(x=xvar, y=yvar)) +  geom_point())})
         output$p2 <- 
            renderPlot({print(qplot(xvar, yvar, data = dat, colour = cond, size = I(6)))}) 
         output$p3 <- 
            renderPlot({print(ggplot(dat_foo(), aes(x=xvar, y=yvar)) +  geom_point())})
         output$dat_table <- renderDataTable({dat}) 

      output$eco_list1 <- 
         renderUI({ 
            selectInput(inputId = "ecoVar1", label = "Economic Variable", choices = colnames(economics)[-1])
         }) 

      output$eco_list2 <- 
         renderUI({ 
            selectInput(inputId = "ecoVar2", label = "Dependent Variable", choices = colnames(economics)[-1])
         }) 
   

      eco_dat <- 
         reactive({
            ecoTmp <- economics[, c('date', input$ecoVar1)]
            return(ecoTmp)
         })   

      output$eco1 <- 
         renderPlot({plot(eco_dat(), typ = 'l', col= "blue", lwd = 2, main = input$ecoVar1, 
            xlab = "");grid()})

      output$independent <- renderUI({
           checkboxGroupInput("independent", "Independent Variables:",
            names(economics)[-1][!names(economics) %in% input$dependent],names(economics)[!names(economics) %in% input$dependent])
      })

      runRegression <- reactive ({
         lm(as.formula(paste(input$dependent, "~", paste(input$independent, collapse="+"))), data = economics)
      })
      
      output$regTab <- renderTable({
         if(!is.null(input$independent)) {
            summary(runRegression())$coefficients
         } else {
         print(data.frame(Warning = "Please select model parameters."))
         }
      })
   }
)

