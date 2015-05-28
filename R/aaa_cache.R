ws_ <- new.env()

#' Convenience function for assignment
#' @keywords internal
ws_assign <- function(var, env = biogridr:::ws_) {
  assign(deparse(substitute(var)), var, envir = env)
}

#' Assign static variables to ws_ environment
#' @keywords internal
ws_build <- function() {

  ## webservice url
  url <- "http://webservice.thebiogrid.org"
  ws_assign(url)

  ## webservice access key
  key <- "not set"
  ws_assign(key)

  ## webservice access_points
  uri <- list(
    interactions   = "interactions/",
    organisms      = "organisms/",
    identifiers    = "identifiers/",
    evidence       = "evidence/",
    version        = "version/",
    generate_key   = "admin/GenerateAccessKey.php")

  ws_assign(uri)

}
