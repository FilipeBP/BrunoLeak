lerRAS1  <- function(){
  
    library(easycsv)
  #Lê todos os csv de uma pasta
  
  fread_folder(directory = "RAS",
               extension = "CSV",
               sep = ";",
               nrows = -1L,
               header = TRUE,
               na.strings = "NA",
               stringsAsFactors = FALSE,
               verbose=getOption("datatable.verbose"),
               skip = 0L,
               drop = NULL,
               colClasses = NULL,
               integer64=getOption("datatable.integer64"),# default:"integer64"
               dec = if (sep!=".") "." else ",",
               check.names = FALSE,
               encoding = "unknown",
               quote = "\"",
               strip.white = TRUE,
               fill = FALSE,
               blank.lines.skip = FALSE,
               key = NULL,
               Names=NULL,
               prefix=NULL,
               showProgress = interactive(),
               data.table=FALSE
  )
  
}
  