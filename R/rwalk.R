#' Simulate a random walk process using an `EViews` engine.
#'
#' Use this function to simulate a random walk process using an `EViews` engine from R, R Markdown or Quarto.
#'
#' @inheritParams eviews_wfcreate
#' @inheritParams eviews_import
#' @inheritParams import_series
#' @param series Names of series for the random walk.
#' @param rndseed Set the `seed` for `Eviews` random number generator.
#' @param drift Numeric value as the drift term for random walk.
#' @return An EViews workfile
#'
#' @examples library(EviewsR)
#' \dontrun{
#'
#' # Simulate random walk and return as a dataframe object
#'
#' rwalk(series="a b e",rndseed=12345,start_date = 1990,frequency="m",num_observations=100)
#'
#' library(ggplot2)
#'
#' ggplot(eviews$abe,aes(x=date))+geom_line(aes(y=a,color="a"))+
#' geom_line(aes(y=b,color="b"))+geom_line(aes(y=e,color="e"))+labs(colour='',x="",y="")
#'
#' # To simulate random walk and return as an `xts` object
#'
#' rwalk(series="X Y Z",rndseed=12345,start_date = 1990,frequency="m",num_observations=100,class="xts")
#'
#' plot(eviews$xyz)
#'
#' autoplot(eviews$xyz,facet="")+xlab("")
#'
#'
#' plot(eviews$XYZ)
#'
#' # To simulate random walk series on existing workfile
#'
#' eviews_wfcreate(wf="rwalk",page="rwalk",frequency="7",start_date=2020,end_date="2022")
#' rwalk(wf="rwalk",series="rw1 rw2 rw3",rndseed=12345,frequency="M")
#'
#' head(eviews$rw1rw2rw3)
#'}
#' @family important functions
#' @keywords documentation
#' @export
rwalk=function(series="",wf="",page="",drift=NA,rndseed=NA,frequency="",start_date="",end_date="",num_cross_sections=NA,num_observations=NA,class="df"){
  fileName=tempfile("EviewsR", ".", ".prg")

wf2=wf

  if(wf=="") save="" else save="save"
  if(wf=="") {
   wf=basename(gsub(".prg","",fileName));if(page=="") page=wf
     eviews_wfcreate(wf=wf,page=wf,frequency=frequency,start_date=start_date,end_date=end_date,num_observations = num_observations)
    }

  wf1=paste0(wf,".wf1")
  wf=paste0('%wf=',shQuote_cmd(wf))
  save=paste0('%save=',shQuote_cmd(save))
  page=paste0('%page=',shQuote_cmd(page))
  rndseed=paste0('!rndseed=',rndseed)
  drift=paste0("!drift=",drift)
  num_observations=paste0("!num_observations=",num_observations)
  num_cross_sections=paste0("!num_cross_sections=",num_cross_sections)

  series1=paste(series,collapse = "")
  series1=gsub(" ","",series1) %>% tolower
  series=paste0("%series=",shQuote_cmd(paste(series,collapse = " ")))

    eviewsCode='
    if %wf<>"" then
    open {%wf}
    endif

    if %page<>"" then
    pageselect {%page}
    endif


    for %y {%series}
    series {%y}
    next

    group randomwalk_group {%series}
    !n=randomwalk_group.@count


    if !rndseed<>NA then
    \' White noise
    \'Seed the generator, so each run is the same
    rndseed {!rndseed}
    endif

    \'Generate a white noise series (in this case, of normals)
    for !i=1 to !n
    series wn{!i}=nrnd
    next


    for !k=1 to {!n}
    %x{!k}=randomwalk_group.@seriesname({!k})
    \' Random walks
    \' Declare new series, set equal to wn1
    series {%x{!k}}=wn{!k}
    \' Change sample period
    smpl @first+1 @last


    {%x{!k}}={%x{!k}}+{%x{!k}}(-1)

    if !drift<>NA then
    genr {%x{!k}}_drift={!drift}+{%x{!k}}
    endif

    smpl @all
    next

    %drift_series=@wlookup("*drift","series")
    group randomwalk_group_drift {%drift_series}

    if !drift<>NA then
    pagesave randomwalk_group.csv @keep randomwalk_group_drift
    else
    pagesave randomwalk_group.csv @keep randomwalk_group
    endif

    if %save="save" then
    wfsave {%wf}
    endif
\'    delete(noerr) wn* randomwalk_group*
    exit'

  writeLines(c(eviews_path(),save,wf,page,rndseed,drift,series,eviewsCode),fileName)
    system_exec()
    on.exit(unlink_eviews(),add = TRUE)
    on.exit(unlink(c("randomwalk_group.csv",fileName)),add = TRUE)

    if(wf2=="") on.exit(unlink(wf1),add = TRUE)


    chunkLabel=opts_current$get('label')

    envName=chunkLabel %n% "eviews" %>% gsub("^fig-","",.) %>% gsub("[._-]","",.)
    if(!identical(envName,"eviews")) assign(envName,new.env(),envir=knit_global())
    # if(identical(envName,"eviews")){
    #   if(!exists("eviews") || !is.environment(eviews)) assign(envName,new.env(),envir=globalenv())
    # }

    dataFrame=read.csv("randomwalk_group.csv")


    if(grepl('date',colnames(dataFrame)[1])){
      colnames(dataFrame)[1]="date"
      dataFrame$date=as.POSIXct(dataFrame$date)
      if(identical(class,'xts')) dataFrame=xts(dataFrame[-1],dataFrame[[1]])
    }

    assign(series1,dataFrame,envir=get(envName,envir = parent.frame()))

}

