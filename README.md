# :mortar_board: Interactive raster visualization with R

In this workshop:

- How to visualize rasters interactively
  - Start with htmlwidgets, developed by RStudio
  - Crash course in pipe operators -- need to know to work with most of these libraries
  - [plotly](https://plotly.com/r/)
    - [wiki](https://en.wikipedia.org/wiki/Plotly)
    - [maps with Plotly](https://plotly-r.com/maps.html)
    - [Interactive web-based data visualization with R, plotly, and Shiny](https://plotly-r.com/)
    - [Embedding images](https://plotly-r.com/embedding-images.html): possible solution for rasters in with plotly
    - [`Rasterly`](https://github.com/plotly/rasterly): other solution to visualize rasters using plotly
    - Still worth showing, considering that plotly offers a lot of interactive vizualization tools

  - [Highcharter](https://jkunst.com/highcharter/) - Mentionned, not explored

  - Heart of the workshop will revolve around leaflet
  - [Leaflet](https://leafletjs.com/)
    - [Leaflet for R](https://rstudio.github.io/leaflet/)
    - [Example 1](https://medium.com/civis-analytics/making-interactive-maps-of-public-data-in-r-d360c0e13f13)
    - [Example 2](https://hansenjohnson.org/post/interactive-maps-in-r/)
    - [Example 3](https://towardsdatascience.com/making-interactive-maps-in-r-with-less-than-15-lines-of-code-bfd81f587e12)
    - [Example 4](https://www.earthdatascience.org/courses/earth-analytics/spatial-data-r/make-interactive-maps-with-leaflet-r/)
  - [Mapview](https://r-spatial.github.io/mapview/)
  - [leafem](https://r-spatial.github.io/mapview/articles/articles/mapview_06-add.html)
  - [Mapdeck](https://github.com/SymbolixAU/mapdeck)
  - [tmap](https://cran.r-project.org/web/packages/tmap/vignettes/tmap-getstarted.html)
  -
  - Dashboards
    - [Flexdashboard](https://rmarkdown.rstudio.com/flexdashboard/)
    - [Flexdashboard in R Markdown book](https://bookdown.org/yihui/rmarkdown/dashboards.html)
  - Shiny
    - [Example 1](https://rviews.rstudio.com/2019/10/09/building-interactive-world-maps-in-shiny/)
- Accessing open data through R
- Building a simple Shiny dashboard
- Exporting



- JavaScript is the modern interactive web
- D3.js library


Check:

- [`htmltools`](https://CRAN.R-project.org/package=htmltools)
- [`htmlwidgets`](https://CRAN.R-project.org/package=htmlwidgets)
- [Geocomputation with R](https://geocompr.robinlovelace.net/adv-map.html)
- [Interactive maps in R](https://bhaskarvk.github.io/user2017.geodataviz/notebooks/03-Interactive-Maps.nb.html)


- other example: https://www.arcgis.com/apps/opsdashboard/index.html#/bda7594740fd40299423467b48e9ecf6


## Installation 

## Packages 

The following R packages are required : 

- [`sf`](https://CRAN.R-project.org/package=sf)
- [`stars`](https://CRAN.R-project.org/package=stars)
- [`raster`](https://CRAN.R-project.org/package=raster)
- [`rgdal`](https://CRAN.R-project.org/package=rgdal)
- [`tmap`](https://CRAN.R-project.org/package=tmap)
- [`mapview`](https://CRAN.R-project.org/package=mapview)
- [`leaflet`](https://CRAN.R-project.org/package=leaflet)
- [`flexdashboard`](https://CRAN.R-project.org/package=flexdashboard)
- [`shiny`](https://CRAN.R-project.org/package=shiny)

[`sf`](https://CRAN.R-project.org/package=sf) might be trickier to install, check out the [README](https://github.com/r-spatial/sf/) for guidelines to install it. Also, on for Ubuntu users, there is a [comprehensive blog post](https://geocompr.github.io/post/2020/installing-r-spatial-ubuntu/) for installing spatial packages. 




## Local environment

Once installed, you can set your local environment, the following commands may prove helpful: 

- `getwd()` to get the working directory
- `setwd()` to set the working directory
- `dir.create()` to create a directory 
- `list.files()` to liste files in a directory

also the following code can be used to download data and unzip them

```R 
download.file("https://github.com/inSilecoInc/workshop_raster/raw/main/data_and_script.zip", destfile = "tmp.zip")
unzip("tmp.zip")
unlink("tmp.zip") # remove temporary file
```