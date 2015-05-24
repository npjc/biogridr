bg_ws <- new.env()

#' Assign static variables to bg_ws environment
#' @keywords internal
bg_ws_build <- function() {

  ## webservice url
  url <- "http://webservice.thebiogrid.org"
  assign("url", url, envir = biogridr:::bg_ws)

  ## webservice access key
  key <- "not set"
  assign("key", key, envir = biogridr:::bg_ws)

  ## webservice access_points
  uri <- list(
    interactions   = "interactions/",
    organisms      = "organisms/",
    identifiers    = "identifiers/",
    evidence       = "evidence/",
    version        = "version/",
    generate_key   = "admin/GenerateAccessKey.php")

  assign("uri",uri, envir = biogridr:::bg_ws)

}
