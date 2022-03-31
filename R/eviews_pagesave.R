#' Save an `EViews` workfile page from R
#'
#' Use this function to save an `EViews` workfile page from R
#'
#' @usage eviews_pagesave(wf="",page="",options="",source_description="",
#' table_description="",keep_list="",drop_list="",keepmap_list="",dropmap_list="",
#' smpl_spec="")
#' @inheritParams eviews_graph
#' @param options Object or a character string of any of the acceptable `EViews` \code{pagesave} options, such as \code{noid}, \code{nomapval}, \code{nonames}.
#' @param source_description The path and name of the file to be saved.
#' @param table_description Further description of the \code{source_description} such as specifying the \code{range=arg}, \code{byrow}.
#' @param keep_list Optional. Specify the list of `EViews` object to be saved.
#' @param drop_list Optional. Specify the list of `EViews` object to be dropped.
#' @param keepmap_list Optional. Specify the list of patterns of `EViews` object to be saved.
#' @param dropmap_list Optional. Specify the list of patterns of `EViews` object to be dropped.
#' @param smpl_spec Optional. Specify the `EViews` sample string
#' @return An EViews workfile.
#'
#' @examples library(EviewsR)
#' \dontrun{
#'  exec_commands(c("wfcreate(wf=Workfile,page=Page) m 1990 2022",
#' "genr y=rnd","genr x=rnd","save workfile","exit"))
#'
#' eviews_pagesave(wf="workfile",source_description = "pagesave.csv",drop_list = "y")
#'}
#' @seealso eng_eviews, exec_commands, eviews_graph, eviews_import, create_object, eviews_pagesave, rwalk, eviews_wfcreate, eviews_wfsave, export, import_table, import
#' @keywords documentation
#' @export
eviews_pagesave=function(wf="",page="",options="",source_description="",table_description="",keep_list="",drop_list="",keepmap_list="",dropmap_list="",smpl_spec=""){

  fileName=tempfile("EVIEWS", ".", ".prg")
  wf=paste0('%wf=',shQuote(wf))
  page=paste0('%page=',shQuote(page))

  options=paste(options,collapse = ",")
  options=paste0('%options=',shQuote(options))
  source_description=paste0('%source_description=',shQuote(source_description))
  table_description=paste0('%table_description=',shQuote(table_description))

  keep_list=paste(keep_list,collapse = " ")
  keep_list=paste0('%keep_list=',shQuote(keep_list))

  drop_list=paste(drop_list,collapse = " ")
  drop_list=paste0('%drop_list=',shQuote(drop_list))

  keepmap_list=paste(keepmap_list,collapse = " ")
  keepmap_list=paste0('%keepmap_list=',shQuote(keepmap_list))

  dropmap_list=paste(dropmap_list,collapse = " ")
  dropmap_list=paste0('%dropmap_list=',shQuote(dropmap_list))

  smpl_spec=paste0('%smpl_spec=',shQuote(smpl_spec))

  eviews_code=r'(open {%wf}

if %page<>"" then
pageselect {%page}
endif

if %keep_list<>"" then
%keep_list="@keep "+%keep_list
endif


if %drop_list<>"" then
%drop_list="@drop "+%drop_list
endif

if %keepmap_list<>"" then
%keepmap_list="@keepmap "+%keepmap_list
endif

if %dropmap_list<>"" then
%dropmap_list="@dropmap "+%dropmap_list
endif


if %smpl_spec<>"" then
%smpl_spec="@smpl "+%smpl_spec
endif

pagesave(%options) {%source_description} {%table_description} {%keep_list} {%drop_list} {%keepmap_list} {%dropmap_list} {%smpl_spec}
exit
)'
writeLines(c(eviews_path(),wf,page,options,source_description,table_description,keep_list,drop_list,keepmap_list,dropmap_list,smpl_spec
,eviews_code),fileName)

  system_exec()
  on.exit(unlink_eviews(),add = TRUE)
}


# eviews_pagesave(wf="eviews/workfile",source_description = "eviews/path/EviewsR.csv",drop_list = "y")