#' retreive taxonomy id for through fuzzy matching
#'
#' @param organism name (character string)
#' @return taxonomy id (integer vector)
#' @examples
#' taxId("Drosophila melanogaster")
#' @export
taxId <- function(organism) {
  df <- get_organisms()

  subsetting_vector <- organism == df$organism
  if(sum(subsetting_vector) == 1) {
    df[subsetting_vector,"tax_id"]
  } else {
    df
    message("did not match organism. returning all allowed values.")
  }

}

#' Organisms supported by BioGrid
#' @return data.frame of organisms and their taxID supported by biogrid
#' @keywords internal
get_organisms <- function() {
  already_exists <- exists("organisms",envir=biogridr:::bg_ws)
  if (already_exists) {
    get("organisms", envir = biogridr:::bg_ws)
  } else {
    organisms <- bg("organisms") %>%
      bg_get_results()
    assign("organisms", organisms, envir = biogridr:::bg_ws)
  }
  bg_ws$organisms
}
