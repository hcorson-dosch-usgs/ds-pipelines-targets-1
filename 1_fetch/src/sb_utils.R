
library(sbtools)

sb_download <- function(sb_id, file_name, out_file) {
  item_file_download(sb_id, names = file_name, destinations = out_file, overwrite_file = TRUE)
  return(out_file)
}



