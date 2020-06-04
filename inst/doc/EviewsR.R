## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----installation,eval=FALSE--------------------------------------------------
#  install.packages("EviewsR")
#  
#              OR
#  
#  devtools::install_github('sagirumati/EviewsR')

## ----image,echo=F-------------------------------------------------------------
knitr::include_graphics('tools/EviewsR.png')


## ----color,echo=T,eval=F------------------------------------------------------
#  knitr::include_graphics("EviewsR_Plot_color.png")
#  

## ----nocolor,echo=T,eval=F----------------------------------------------------
#  knitr::include_graphics("EviewsR_Plot_nocolor.png")
#  

## ----OLS,echo=T,eval=F--------------------------------------------------------
#  olsResult=read.csv("EviewsROLS.csv")
#  knitr::kable(olsResult)

## ----OLStable,echo=T,eval=F---------------------------------------------------
#  olsTable=read.csv("EviewsRtable.csv")
#  knitr::kable(olsTable,format = "html")

