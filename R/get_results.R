#' GET results of a query to the BioGRID web service.
#'
#' @param bg biogrid object returned by \code{\link{bg}}. (named list)
#' @param as format in which to return results. (character string)
#' @param file Specify name of file if you wish to write the results to file.
#' (character string). N.B. not yet implemented.
#' @export
bg_get_results <- function(bg, as = "tab2", file = NULL, .request = FALSE) {

  bg$query$format <- ratify_format(as)
  bg <- ratify_bg(bg)

  if(!is.null(file)) stop("direct file writing not implemented yet.")

  if(.request) {
    r <- httr::GET(url = bg$url, path = bg$path, query = bg$query)
    return(r)
  }

  parse_fun <- select_parser_fun(bg)

  # pagination handling function for interactions/
  paginate <- function(req) {
    req <- req %>% bg_constrain(start = start)
    r <- httr::GET(url = req$url, path = req$path, query = req$query)
    if(length(httr::content(r,"raw"))!=0){
      dt_ls[[i]] <<- r
      i <<- i + 1
      start <<- start + 10000
      paginate(req)
    }
  }

  # only paginate for interactions as it's the only one that doesn't ignore
  # start parameter.

  if( bg$path == bg_ws$uri$interactions) {
    dt_ls <- vector("list")
    i <- start <- 1
    paginate(bg)
    lapply(dt_ls, parse_fun) %>% data.table::rbindlist()
  } else {
    rout <- httr::GET(url = bg$url, path = bg$path, query = bg$query)
    parse_fun(rout)
  }

}

#' Validate if a format is allowed
#' @param format format
#' @return format type (character string)
#' @keywords internal
ratify_format <- function(format) {
  valid <- format %in% c("tab2", "json")
  if (valid) {
    return(format)
  } else {
    stop("only tab2 and json formats are supported.")
  }
}

#' Validate the structure bg object
#' @param bg bg
#' @return bg object (named list)
#' @keywords internal
ratify_bg <- function(bg) {
  valid <- all(
               is.list(bg),
               c("url", "path", "query") %in% names(bg),
               "accessKey" %in% names(bg$query))

  if (valid) {
    return(bg)
  } else {
    stop("bg object not valid. must at least contain \n $url, $path and $query$accessKey")
  }
}

#' Validate GET request
#' @param request request
#' @return TRUE if successful or list of status code and content.
#' @keywords internal
ratify_request <- function(request) {
  successful <- httr::status_code(request) == 200
  if (successful) {
    invisible()
  } else {
    stop("request did not succeed. set .request = TRUE for details.")
  }
}
