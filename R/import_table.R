#' Import `EViews` table objects(s) into R, R Markdown or Quarto.
#'
#' Use this function to import `EViews` table objects(s) into R, R Markdown or Quarto.
#'
#' @inheritParams eviews_wfcreate
#' @param table Name(s) or wildcard expressions for `EViews` table object(s) in an `EViews` workfile
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#' demo(exec_commands)
#'
#' # To import all table objects across all pages
#'
#' import_table(wf="exec_commands")
#'
#' # To import specific table objects, for example for example `OLSTable`
#'
#' import_table(wf="exec_commands",table="OLStable")
#'
#' # To import table objects on specific pages
#'
#' import_table(wf="exec_commands",page="eviewspage")
#'
#' # To access the table in base R
#'
#' eviews$eviewspage_olstable
#'
#' # To get the values above in R Markdown or Quarto
#'
#' # chunkLabel$eviewspage_olstable
#'
#'}
#' @family important functions
#' @keywords documentation
#' @export
import_table=function(wf="",page="*",table="*"){

  table %<>% paste0(collapse = " ")
  page %<>% paste0(collapse = " ")

chunkLabel=opts_current$get('label')

    envName=chunkLabel %n% "eviews" %>% gsub("^fig-","",.) %>% gsub("[._-]","",.)


  if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
  # if(identical(envName,"eviews")){
  #   if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env(),envir=globalenv())
  # }

  eviewsrText=tempfile("eviewsrText",".") %>%
    basename
  eviewsrText1=eviewsrText

  eviewsrText %<>%   shQuote_cmd %>%
    paste0("%eviewsrText=",.)


  fileName=basename(tempfile("EVIEWS", ".", ".prg"))

  wf=paste0('%wf=',shQuote_cmd(wf))
  page=paste0('%page=',shQuote_cmd(page))
  table=paste0('%table=',shQuote_cmd(table))


  saveCode='open {%wf}



  %pagelist=@pagelist

  if %page<>"*" then
   %pagelist=%page
  endif


  %tablePath=""

  for %page {%pagelist}
  pageselect {%page}
  %tables1=@wlookup(%table ,"table")

  if @wcount(%tables1)<>0 then
  for %y {%tables1}
  %tablePath=%tablePath+" "+%page+"_"+%y+"-"+%eviewsrText
  {%y}.save(t=csv) {%page}_{%y}-{%eviewsrText}
  next
  endif
  next

  text {%eviewsrText}_table
  {%eviewsrText}_table.append {%tablePath}
  {%eviewsrText}_table.save {%eviewsrText}-table

  exit'



  on.exit(unlink_eviews(),add = TRUE)


  eviewsCode=paste0(c(eviews_path(),eviewsrText,wf,page,table,saveCode),collapse = '\n')


writeLines(c(eviewsCode,saveCode),fileName)

system_exec()

  if(file.exists(paste0(eviewsrText1,"-table.txt"))) tablePath=readLines(paste0(eviewsrText1,"-table.txt")) %>%
    strsplit(split=" ") %>% unlist()

  for (i in tablePath){
    tableName=gsub("\\-.*","",i) %>% tolower
    assign(tableName,read.csv(paste0(i,".csv")),envir = get(envName,envir = parent.frame()))
  }

on.exit(unlink(paste0(tablePath,".csv")),add = TRUE)
on.exit(unlink(paste0(eviewsrText1,"-table.txt")),add = TRUE)


}
