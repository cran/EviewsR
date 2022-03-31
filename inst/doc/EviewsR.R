## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  echo = T,
  eval=F
)
library(EviewsR)
set_eviews_path('eviews12_X64')
# set_eviews_path()
library(knitr)

## ----installation,eval=F------------------------------------------------------
#  install.packages("EviewsR")
#  
#              OR
#  
#  devtools::install_github('sagirumati/EviewsR')

## ----eval=F-------------------------------------------------------------------
#  set_eviews_path("C:/Program Files (x86)/EViews 10/EViews10.exe")
#  

## ----wfcreate-----------------------------------------------------------------
#  eviews_wfcreate(wf="EviewsR_workfile",page="EviewsR_page",frequency = "m",start_date = "1990",end_date = "2022")
#  

## ----execCommands-------------------------------------------------------------
#  exec_commands(c('%path=@runpath','cd %path',
#    'wfcreate(page=EviewsR_page,wf=EviewsR_workfile) m 2000 2022',
#    'for %y EviewsR package page1 page2',
#    'pagecreate(page={%y}) EviewsR m 2000 2022',
#    'next',
#  '  pageselect EviewsR_page',
#    'rndseed 123456',
#  '  genr y=rnd',
#    'genr x=rnd',
#    'equation ols.ls y c x',
#    'freeze(EviewsROLS,mode=overwrite) ols',
#    'freeze(EviewsR_Plot,mode=overwrite) y.line',
#    'wfsave EviewsR_workfile',
#    'exit'))
#  

## ----rwalk--------------------------------------------------------------------
#  rwalk(wf="eviewsr_workfile",series="X Y Z",page="",rndseed=12345,frequency="M",num_observations=100)
#  

## ----object-------------------------------------------------------------------
#  create_object(wf="EviewsR_workfile",action="equation",action_opt="",object_name="eviews_equation",view_or_proc="ls",options_list="",arg_list="y ar(1)")
#  

## ----importTable--------------------------------------------------------------
#  options(knitr.kable.NA = '')
#  import_table(wf="EViewsR_workfile",page="EviewsR_page",table_name = "EViewsrOLS",table_range = "r7c1:r10c5",digits=3)

## ----wfsave-------------------------------------------------------------------
#  eviews_wfsave(wf="eviewsr_workfile",source_description = "EviewsR_wfsave.csv")

## ----pagesave-----------------------------------------------------------------
#  eviews_pagesave(wf="eviewsr_workfile",source_description = "EviewsR_pagesave.csv",drop_list = "y")
#  

## ----eviewsImport-------------------------------------------------------------
#  eviews_import(wf="eviewsr_workfile",source_description = "EviewsR_pagesave.csv")
#  

## ----import,out.height="100%",out.width="100%"--------------------------------
#  
#  import(object_name = "import",wf="eviewsr_workfile",keep_list = c("x","y"))
#  plot(eviews$import$y,type="l",ylab="EviewsR",col="red")

## ----export-------------------------------------------------------------------
#  export(wf="eviewr_export",source_description=eviews$import,start_date = '1990',frequency = "m")
#  

## ----eviewsGraph,fig.cap="EviewsR example figure",out.width='80%',out.height='80%',fig.path=""----
#  
#  y=runif(100)
#  x=runif(100)
#  uu=data.frame(x,y)
#  
#   eviews_graph(wf="EviewsR_workfile",page = "EviewsR_page",series="x y",mode = "overwrite",options = "m",merge_graphs =F,start_date="1",frequency="5",save_path = '')
#  

