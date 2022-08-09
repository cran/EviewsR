## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", 
  echo = T,
  eval=F,
  out.width = "45%",
  out.height = "20%",
  fig.show="hold"
)
library(EviewsR)
library(knitr)

## ----installation,eval=F------------------------------------------------------
#  install.packages("EviewsR")
#  
#              OR
#  
#  devtools::install_github('sagirumati/EviewsR')

## ----eval=F-------------------------------------------------------------------
#  set_eviews_path("C:/Program Files (x86)/EViews 10/EViews10.exe")

## -----------------------------------------------------------------------------
#  EviewsR$eviewsrpage_ols$r2
#  EviewsR$eviewsrpage_ols$aic
#  K=EviewsR$eviewsrpage_olstable[c(6,8,9),1:5]
#  colnames(K)=NULL
#  knitr::kable(K,row.names = F,caption = 'Selected cells of  EViews table object')

## -----------------------------------------------------------------------------
#  EviewsR$eviewsrpage |> head()
#  

## ----object-------------------------------------------------------------------
#  create_object(wf="EviewsR_workfile",action="equation",action_opt="",object_name="eviews_equation",view_or_proc="ls",options_list="",arg_list="y ar(1)")
#  

## ----object1------------------------------------------------------------------
#  create_object(wf="EviewsR_workfile",object_name="x1",
#  object_type="series",expression="y^2")
#  

## -----------------------------------------------------------------------------
#  eviews_graph(wf="EviewsR_workfile",page = "EviewsRPage",series="x y",mode = "overwrite",
#  graph_options = "m")
#  

## -----------------------------------------------------------------------------
#  Data=data.frame(x=cumsum(rnorm(100)),y=cumsum(rnorm(100)))
#  
#  eviews_graph(series=Data,group=TRUE,start_date="1990Q4",frequency="Q")
#  

## ----echo=FALSE---------------------------------------------------------------
#  write.csv(Data,"eviews_import.csv",row.names = FALSE)
#  

## ----eviewsImport-------------------------------------------------------------
#  eviews_import(source_description = "eviews_import.csv",start_date = "1990",frequency = "m",
#  rename_string = "x ab",smpl_string = "1990m10 1992m10")

## -----------------------------------------------------------------------------
#  eviews_import(source_description = Data,wf="eviews_import1",start_date = "1990",
#  frequency = "m",rename_string = "x ab",smpl_string = "1990m10 1992m10")

## ----pagesave-----------------------------------------------------------------
#  eviews_pagesave(wf="eviewsr_workfile",page="EviewsRPage",source_description = "pagesave.csv",drop_list = "y")
#  

## ----wfcreate-----------------------------------------------------------------
#  eviews_wfcreate(wf="eviews_wfcreate",page="EviewsRPage",frequency = "m",
#  start_date = "1990",end_date = "2022")
#  

## -----------------------------------------------------------------------------
#  
#  eviews_wfcreate(source_description=Data,wf="eviews_wfcreate1",page="EviewsR_page",frequency="m",
#  start_date="1990")
#  

## ----wfsave-------------------------------------------------------------------
#  eviews_wfsave(wf="eviewsr_workfile",source_description = "wfsave.csv")

## ----execCommands-------------------------------------------------------------
#  exec_commands(c("wfcreate(wf=exec_commands,page=eviewsPage) m 2000 2022"))
#  

## -----------------------------------------------------------------------------
#  eviewsCommands=r'(pagecreate(page=eviewspage1) 7 2020 2022
#  for %page eviewspage eviewspage1
#  pageselect {%page}
#  genr y=@cumsum(nrnd)
#  genr x=@cumsum(nrnd)
#  equation ols.ls y c x
#  graph x_graph.line x
#  graph y_graph.area y
#  freeze(OLSTable,mode=overwrite) ols
#  next
#  )'
#  
#  exec_commands(commands=eviewsCommands,wf="exec_commands")
#  

## ----exportDataframe----------------------------------------------------------
#  export_dataframe(wf="export_dataframe",source_description=Data,start_date = '1990',frequency = "m")

## ----importEquation-----------------------------------------------------------
#  import_equation(wf="EviewsR_workfile",page="EviewsRPage",equation="OLS")
#  

## ----eval=FALSE,echo=FALSE----------------------------------------------------
#  eviews$eviewspage_ols
#  

## -----------------------------------------------------------------------------
#  import_graph(wf="exec_commands")

## -----------------------------------------------------------------------------
#  import_graph(wf="exec_commands",graph="x*")
#  

## ----importKable--------------------------------------------------------------
#  import_kable(wf="EViewsR_workfile",page="EviewsRPage",table = "OLSTable",range = "r7c1:r10c5",digits=3,caption = "Selected cells of EViews table imported using import_kable() function")

## ----importSeries-------------------------------------------------------------
#  import_series(wf="eviewsr_workfile")

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  eviews$eviewspage |> head()

## ----importSeries1------------------------------------------------------------
#  import_series(wf="eviewsr_workfile",series = c("x","y"),class='xts')
#  

## ----importTable--------------------------------------------------------------
#  import_table(wf="EviewsR_workfile")

## ----importTable1-------------------------------------------------------------
#  import_table(wf="EviewsR_workfile",table="OLStable")
#  

## ----importTable2-------------------------------------------------------------
#  import_table(wf="EviewsR_workfile",page=" EviewsRPage")
#  

## ----echo=TRUE,eval=FALSE-----------------------------------------------------
#  eviews$eviewspage_olstable

## -----------------------------------------------------------------------------
#  import_workfile(wf="EviewsR_workfile")
#  

## ----importWorfile1,eval=FALSE,echo=TRUE--------------------------------------
#  import_workfile(wf="exec_commands",equation="ols",graph="x*",series="y*",table="ols*")

## ----importWorfile2,eval=FALSE,echo=TRUE--------------------------------------
#  import_workfile(wf="exec_commands",page="eviewspage eviewspage1")

## ----eval=FALSE,echo=TRUE-----------------------------------------------------
#  eviews$eviewspage_ols # equation
#  # eviewspage-x_graph # graph saved in "figure/" folder
#  eviews$eviewspage |> head() # series
#  eviews$eviewspage_olstable  # table

## ----rwalk--------------------------------------------------------------------
#  
#  rwalk(wf="eviewsr_workfile",series="X Y Z",page="",rndseed=12345,frequency="M",num_observations=100,class='xts')
#  

## ----fig-eviews,eval=F,fig.dim=c(7,4),dpi=300,out.width="45%"-----------------
#  demo(create_object())
#  demo(eviews_graph())
#  demo(eviews_import())
#  demo(eviews_pagesave())
#  demo(eviews_wfcreate())
#  demo(eviews_wfsave())
#  demo(exec_commands())
#  demo(export_dataframe())
#  demo(import_equation())
#  demo(import_graph())
#  demo(import_kable())
#  demo(import_series())
#  demo(import_table())
#  demo(import_workfile())
#  demo(rwalk())
#  demo(set_eviews_path())

