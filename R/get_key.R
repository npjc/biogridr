#' GET an access key for BioGRID web service
#'
#' @details
#' To submit requests to the BioGRID web service an application key is required.
#' You can obtain a key from \url{http://webservice.thebiogrid.org/} or via this
#' function. According to BioGRID this info is only used for notifying you in
#' the event of a problem.
#'
#' @section I already have a key:
#' If you have already done this it just returns the key associated with those
#' credentials.
#'
#' @param first first name (character string).
#' @param last last name (character string).
#' @param email e-mail (character string).
#' @param project project name (character string).
#' @return (character string) Biogrid access key invisibly.
#' @export
bg_get_key <- function(first, last, email, project) {
  form <- switch(as.character(nargs()),
         "0" = build_random_form(),
         "4" = build_form(first, last, email, project),
         stop("form incomplete!"))

  r <- httr::POST(url = bg_ws$url, path = bg_ws$uri$generate_key, body = form)
  if(httr::status_code(r)!=200) return(r)

  # the access key is in the first span of the first h3 in the html doc.
  h <- xml2::read_html(httr::content(r,"text"))
  key <- xml2::xml_find_one(h,"//h3//span") %>%
    xml2::xml_text()
  # puts the key into the cache env so it can be retrived by other functions.
  assign("key", key, envir=biogridr:::bg_ws)
  invisible(key)
}

#' build form from elements
#' @keywords internal
build_form <- function(first, last, email, project) {
  list(firstname = first, lastname = last, project = project, email = email)
}

#' generate a random form
#' @keywords internal
build_random_form <- function() {
  first <- random_string()
  last <- random_string()

  list(firstname = first, lastname = last, project = random_string(),
  email = paste0(first, ".",last, "@email.com"))
}

#' generate a random character string
#' @param length length of character string
#' @keywords internal
random_string <- function(length = 10) {
  paste0(sample(letters, length, replace = T), collapse = "")
}
