#' @name download
#' @title Load Zenodo files into a running session
#'
#' @description
#' Download data stored in Zenodo into a running R session.
#'
#' List alternative formats.
#'
#' Refer to a new function listing data sets.
#'
#' @param name A character value with the name of the data set to be downloaded.
#' @param format Format of data. Altenatives.
#' @param url A character value with the link to the source. Only used if
#'     missing name of data set.
#'
#' @export
download <- function(name, format = "rds", url) {
  formats <- c("rds", "bib")
  if (!format %in% formats) {
    stop(paste0(
      "Wrong value in 'format'. Use one of these: ",
      paste0(formats, collapse = ", "), "."
    ))
  }
  if (!missing(name)) {
    if (!name %in% zenodo_data$name) {
      stop(paste(
        "Wrong value for 'name'. This data set does not exist",
        "in the reference list"
      ))
    }
  }
  if (missing(url)) {
    url <- zenodo_data$url[zenodo_data$name == name[1]]
  }
  if (!grepl("?download=1", url, fixed = TRUE)) {
    url <- paste0(url, "?download=1")
  }
  ## Load rds
  if (format == "rds") {
    d_file <- paste0(tempdir(), "/", name[1], ".", format)
    download.file(url = url, destfile = d_file, method = "curl")
    invisible(readRDS(d_file))
  }
  ## Load bib
}
