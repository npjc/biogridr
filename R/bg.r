#' Build a BioGRID query
#' @param access_point what to query for (character string). See
#' details for available options.
#' @param key if you wish to explicitly set an access key (character string). If
#' left as NULL will use the key set by \code{\link{bg_get_key}}.
#' @export
bg <- function(access_point) {
  key <- ratify_key()
  path <- ratify_access_point(access_point)
  list(url = ws_$url, path = path, query = list(accessKey = key))
}


#' validate application key and retrieve it
#' @return application key (character string)
#' @keywords internal
ratify_key <- function() {

  valid <- ws_$key != "not set"

  if (valid) {
    ws_$key
  }else {
    stop("Must get an application key. First run bg_get_key")
  }
}

#' validate access_point and retrieve its uri
#' @param access_point (character string)
#' @return access point uri (character string)
#' @keywords internal
ratify_access_point <- function(access_point) {

  valid <- access_point %in% names(ws_$uri)

  if (valid) {
    ws_$uri[[access_point]]
  }else {
    stop(access_point, " is not a valid access point.")
  }
}
