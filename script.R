## ----load_leaflet, fig.width = 6, fig.height = 6, echo = FALSE----------------
library(leaflet)
lf <- leaflet() %>%
 addTiles(group = 'Default') %>%
 setView(lng = -63,
         lat = 48,
         zoom = 5)

lf


## ----use_pipe-----------------------------------------------------------------
# Example with pipe operator
lf <- leaflet() %>%
 setView(lng = -63,
         lat = 48,
         zoom = 5) %>%
 addTiles(group = 'Default')



## ----nopipe-------------------------------------------------------------------
# Example without pipe operator
lf <- setView(map = leaflet(),
              lng = -63,
              lat = 48,
              zoom = 5)
lf <- addTiles(map = lf,
               group = 'Default')




## ----base_maps, fig.width = 6, fig.height = 6, echo = FALSE-------------------
leaflet() %>%
      setView(lng = -63,
              lat = 48,
              zoom = 5) %>%
      addProviderTiles('Esri.OceanBasemap',
                       group = 'Ocean')




## ----multiple_base, fig.width = 6, fig.height = 6, echo = FALSE---------------
lf <- lf %>%
 addProviderTiles('Esri.OceanBasemap',
     group = 'Ocean') %>%
 addProviderTiles("OpenTopoMap",
     group = "Topo") %>%

 # Add layer selection
 addLayersControl(
     baseGroups = c('Default','Ocean','Topo'),
     position = 'topleft')

lf


## ----eDrivers, eval = TRUE----------------------------------------------------
# Install eDrivers
# devtools::install_github('eDrivers/eDrivers')

# Load data from eDrivers
library(eDrivers)
fetchDrivers(drivers = c('Hypoxia','FisheriesDD','Acidification'),
             output = 'data')

# Raster objects from eDrivers class objects
library(raster)
hyp <- raster('data/Hypoxia.tif')
fish <- raster('data/FisheriesDD.tif')
acid <- raster('data/Acidification.tif')




## ----leaflet_raster, fig.width = 6, fig.height = 6, echo = FALSE, eval = TRUE----
# Add layers to leaflet map
lf <- lf %>%
 addRasterImage(hyp,group = 'Hyp') %>%
 addRasterImage(fish,group = 'Fish') %>%
 addRasterImage(acid,group = 'Acid') %>%

# Reset layer selection
addLayersControl(
   baseGroups = c('Default','Ocean','Topo'),
   overlayGroups = c('Hyp','Fish','Acid'),
   position = 'topleft')

lf


## ----export_leaflet, eval = FALSE---------------------------------------------
## dir.create('output')
## htmlwidgets::saveWidget(lf, file="output/lf.html")






## ----mapview, eval = TRUE, fig.width = 12, fig.height = 6---------------------
library(mapview)
mv <- mapview(hyp) + fish + acid
mv


## ----mapview_export, eval = TRUE, fig.width = 12, fig.height = 6--------------
dir.create('output')
mapshot(mv, url = 'output/map.html')










## ----tmap_static, fig.width = 5.5, fig.height = 5, echo = TRUE, eval = FALSE----
## library(tmap)
## tmap_mode("plot")
## static <- tm_shape(fish) +
##           tm_raster(title = "Fisheries")
## static
## 
## # Export as png
## tmap_save(static,
##           filename = "output/Fisheries.png")


## ----tmap_interactive, fig.width = 5.5, fig.height = 5, echo = TRUE, eval = FALSE----
## library(tmap)
## tmap_mode("view")
## inter <- tm_shape(fish) +
##          tm_raster(title = "Fisheries")
## inter
## 
## # Export as html
## tmap_save(inter,
##           filename = "output/Fisheries.html")




## ----tmap_facets, fig.width = 6, fig.height = 6, echo = FALSE, eval = TRUE----
rstack <- stack(hyp, fish, acid)
tmap_mode("view")
tm_shape(rstack) +
  tm_raster(title = c("Hypoxia",
              "Fisheries",
              "Acidification")) +
tm_facets(as.layers = TRUE,
  free.scales.raster = TRUE)








## ---- eval = FALSE------------------------------------------------------------
## library(rmarkdown)
## library(flexdashboard)
## draft("dashboard.Rmd",
##       template = "flex_dashboard",
##       package = "flexdashboard")




## ----shiny, eval = FALSE------------------------------------------------------
## # General environment / data preparation
## library(shiny)
## library(leaflet)
## library(raster)
## Hypoxia <- raster('data/Hypoxia.tif')
## Acidification <- raster('data/Acidification.tif')
## Fisheries <- raster('data/FisheriesDD.tif')
## rstack <- stack(Hypoxia, Acidification, Fisheries)
## 
## # User interface
## ui <- fluidPage(
##  radioButtons(inputId = 'raster', label = 'Rasters to select',
##    choices = c("Hypoxia" = "Hypoxia", "Fisheries" = "FisheriesDD",
##                "Acidification" = "Acidification")),
##  leafletOutput(outputId = "map", height = 800)
## )
## 
## # Server function
## server <- function(input, output) {
##  output$map <- renderLeaflet({
##   leaflet() %>%
##   addProviderTiles("CartoDB.Positron") %>%
##   addRasterImage(rstack[[input$raster]])
##  })
## }
## 
## # Shiny app function
## shinyApp(ui, server)


## ---- eval = TRUE-------------------------------------------------------------
# General environment / data preparation
library(shiny)
library(leaflet)
library(raster)
Hypoxia <- raster('data/Hypoxia.tif')
Acidification <- raster('data/Acidification.tif')
Fisheries <- raster('data/FisheriesDD.tif')
rstack <- stack(Hypoxia, Acidification, Fisheries)


## ---- eval = FALSE------------------------------------------------------------
## radioButtons(inputId = 'raster', label = 'Rasters to select',
##   choices = c("Hypoxia" = "Hypoxia", "Fisheries" = "FisheriesDD",
##               "Acidification" = "Acidification")),


## ---- eval = FALSE------------------------------------------------------------
## input <- list(raster = 'Hypoxia')
## input$raster
## > "Hypoxia"


## ---- eval = FALSE------------------------------------------------------------
## leafletOutput(outputId = "map", height = 800)


## ---- eval = FALSE------------------------------------------------------------
## output$map <- renderLeaflet({
##  leaflet() %>%
##  addProviderTiles("CartoDB.Positron") %>%
##  addRasterImage(rstack[[input$raster]])
## })


## ---- eval = FALSE------------------------------------------------------------
## library(rmarkdown)
## library(flexdashboard)
## draft("shiny_dashboard.Rmd",
##       template = "flex_dashboard",
##       package = "flexdashboard")


## ---- eval = FALSE------------------------------------------------------------
## rmarkdown::run('shiny_dashboard.Rmd')


## ---- eval = FALSE------------------------------------------------------------
## rasterFunction <- reactive({
##   sum(rstack[[input$raster]], na.rm = T) %>%
##   calc(function(x) ifelse(x == 0, NA, x))
## })
## 


## ---- eval = FALSE------------------------------------------------------------
## observe({
##   # Clear maps if no raster is selected
##   leafletProxy(mapId = "map2") %>%
##   clearImages() %>% # Clears previous raster
##   addRasterImage(x = rasterFunction())
## })

