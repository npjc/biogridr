#' specify how to parse request contents
#' @param bg bg
#' @keywords internal
select_parser_fun <- function(bg) {
  uri <- bg$path
  selection <- grep(uri, biogridr:::bg_ws$uri, value = T) %>% names()

  interactions_parser <- function(request) {
    #   # how to get the names of the tab2 format columns.
    #   library(rvest)
    #
    #   h <- read_html("http://wiki.thebiogrid.org/doku.php/biogrid_tab_version_2.0")
    #   tmp <- h %>%
    #     html_node("ol") %>%
    #     html_nodes("li") %>%
    #     html_text()
    #
    #   tab2_col_names <- tmp %>%
    #     stringi::stri_split_fixed(".", n=2) %>%
    #     lapply(.,"[[",1L) %>%
    #     unlist() %>%
    #     tolower() %>%
    #     stringi::stri_trim(side = "both") %>%
    #     stringi::stri_replace_all_fixed(" ", "_")
    #   dput(tab2_col_names)
    if(length(httr::content(request,"raw")) == 0) return("")
    dt <- httr::content(request,"text") %>% data.table::fread(header=F, sep = "\t")
    data.table::setnames(dt, c("biogrid_interaction_id", "entrez_gene_id_for_interactor_a",
                               "entrez_gene_id_for_interactor_b", "biogrid_id_for_interactor_a",
                               "biogrid_id_for_interactor_b", "systematic_name_for_interactor_a",
                               "systematic_name_for_interactor_b", "official_symbol_for_interactor_a",
                               "official_symbol_for_interactor_b", "synonyms/aliases_for_interactor_a",
                               "synonyms/aliases_for_interactor_b", "experimental_system_name",
                               "experimental_system_type", "first_author_surname_of_the_publication_in_which_the_interaction_has_been_shown,_optionally_followed_by_additional_indicators,_e",
                               "pubmed_id_of_the_publication_in_which_the_interaction_has_been_shown",
                               "organism_id_for_interactor_a", "organism_id_for_interactor_b",
                               "interaction_throughput", "quantitative_score", "post_translational_modification",
                               "phenotypes", "qualifications", "tags", "source_database"))
    data.table::setattr(dt, "class", "data.frame")
    dt
  }

  organisms_parser <- function(request) {
    dt <- httr::content(request, "text") %>% data.table::fread(header = F, sep = "\t")
    data.table::setnames(dt, c("tax_id","organism"))
    data.table::setattr(dt, "class", "data.frame")
    dt
  }

  identifiers_parser <- function(request) {
    dt <- httr::content(request, "text") %>% data.table::fread(header = F, sep = "\t")
    data.table::setnames(dt,"identifier_type")
    data.table::setattr(dt,"class","data.frame")
    dt
  }

  evidence_parser <- function(request) {
    dt <- httr::content(request,"text") %>% data.table::fread(header = F, sep = "\n")
    dt <- data.table::fread(dt)
    data.table::setnames(dt,"evidence_type")
    data.table::setattr(dt, "class", "data.frame")
    dt
  }

  version_parser <- function(request) {
    string <- paste("version",httr::content(request,"text"), sep = "\n")
    dt <- data.table::fread(string)
    data.table::setattr(dt, "class", "data.frame")
    dt
  }

  lookup <- list(interactions = interactions_parser,
                 organisms = organisms_parser,
                 identifiers = identifiers_parser,
                 evidence = evidence_parser,
                 version = version_parser)

  lookup[[selection]]
}
