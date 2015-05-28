#' Convenient and Reproducible Access to BioGRID data
#'
#' @section Access Key:
#' You need an access key to interact with BioGRID. Simply run
#' \code{\link{bg_get_key}} initially and you're done. No need to explicitly
#' provide each time.
#'
#' @section Design:
#'
#' Compose a query with by creating and modifying a \code{bg} object. Retrieve
#' results via \code{bg_get_*} functions which handle errors, pagination, and
#' formating.
#'
#' Most if not all functions start with \code{bg_*} for convenient auto-
#' completion.
#'
#' Package works well with %>% from maggritr.
#'
#' @docType package
#' @name biogridr
NULL

.onLoad <- function(...) {
  ws_build()
  packageStartupMessage("biogridr: Beginner developer minions about. ",
                        "Be on the lookout. ")
}
