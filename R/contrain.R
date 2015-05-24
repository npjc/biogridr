#' contrain BioGRID query which additional parameters
#' @param bg bg object
#' @param ... additional parameters
#' @return modified bg object. N.B. current behaviour overwites and previously
#' present params.
#' @export
bg_constrain <- function(bg, ...) {

  parameters <- stratify_parameters(list(...))
  # get the names parameters not present in new params, subset old bg$query
  # according to this vector and add new params (effective overwriting)
  old_subset <- setdiff(names(bg$query), names(parameters))
  bg[["query"]] <- c(bg$query[old_subset], parameters)
  bg
}


#' validate constrain parameters
#' @param param_list list of parameters
#' @return parameter list if valid, stop if not.
#' @keywords internal
stratify_parameters <- function(param_list) {
  allowed_params <- bg_constrain_params()$Parameter
  valid <- sapply(names(param_list),`%in%`, allowed_params) %>%
    all()

  if (valid) {
    return(param_list)
  } else {
    stop("invalid parameters. See http://wiki.thebiogrid.org/doku.php/biogridrest")
  }
}

#' show data.frame of available constrain parameters
#'
#' @keywords internal
bg_constrain_params <- function(){
#   # df obtained via:
#   library(rvest)
#
#   h <- read_html("http://wiki.thebiogrid.org/doku.php/biogridrest")
#   out <- h %>%
#     html_nodes("div .level4 table") %>%
#     html_table()
#
#   out <- out[[1]]
#

  df <- structure(list(Parameter = c("accessKey", "start", "max", "interSpeciesExcluded",
                                     "selfInteractionsExcluded", "evidenceList", "includeEvidence",
                                     "geneList", "searchIds", "searchNames", "searchSynonyms", "searchBiogridIds",
                                     "additionalIdentifierTypes", "excludeGenes", "includeInteractors",
                                     "includeInteractorInteractions", "pubmedList", "excludePubmeds",
                                     "htpThreshold", "throughputTag", "taxId", "includeHeader", "format",
                                     "translate"), Type = c("string", "int", "int", "boolean", "boolean",
                                                            "string", "boolean", "string", "boolean", "boolean", "boolean",
                                                            "boolean", "string", "boolean", "boolean", "boolean", "string",
                                                            "boolean", "int", "string", "string", "boolean", "string", "boolean"
                                     ), Default = c("NONE", "0", "10000", "FALSE", "FALSE", "empty",
                                                    "FALSE", "empty", "FALSE", "FALSE", "FALSE", "FALSE", "empty",
                                                    "FALSE", "TRUE", "FALSE", "empty string", "FALSE", "2147483647 (maximum 32-bit integer)",
                                                    "“any”", "“All”", "FALSE", "“tab2”", "FALSE"), `Valid Values` = c("Only 32 character Alphanumeric strings",
                                                                                                                      "0-2147483647", "1-10000", "true, false", "true, false", "Pipe-separated list of evidence codes from here",
                                                                                                                      "true, false", "Pipe-separated list of gene names or identifiers.",
                                                                                                                      "true, false", "true, false", "true, false", "true, false", "Pipe-separated list of identifier types from here",
                                                                                                                      "true, false", "true, false", "true, false", "Pipe-separated list of pubmed IDs",
                                                                                                                      "true, false", "0-2147483647", "“any”,“low”,“high”",
                                                                                                                      "Pipe-separated list of NCBI taxonomy identifiers or “All”. Get full list of supported ids here",
                                                                                                                      "true, false", "“tab1”,”tab2,”extendedTab2”,”count”, “json”, “jsonExtended”",
                                                                                                                      "true,false"), Description = c("All rest access must supply a valid accessKey to prevent spamming of the service. Access Keys are free and openly available here.",
                                                                                                                                                     "Query results are numbered from 0. Results fetched will start at this value e.g. start = 50 will skip the the first 50 results. Ignored if using “count” in the format parameter.",
                                                                                                                                                     "Number of results to fetch; this will be ignored if greater than 10,000, i.e. pagination using several requests is required to retrieve  more than 10,000 interactions. Ignored if using “count” in the format parameter.",
                                                                                                                                                     "If ‘true’, interactions with interactors from different species will be excluded.",
                                                                                                                                                     "If ‘true’, interactions with one interactor will be excluded.",
                                                                                                                                                     "Any interaction evidence with its Experimental System in the list will be excluded from the results unless includeEvidence is set to true.",
                                                                                                                                                     "If set to true, any interaction evidence with its Experimental System in the evidenceList will be included in the result",
                                                                                                                                                     "Interactions between genes in this list will be fetched. This parameter is ignored if one of searchIds, searchNames, searchSynonyms is not ‘true’ and additionalIdentifierTypes is empty.",
                                                                                                                                                     "If ‘true’, the interactor  ENTREZ_GENE, ORDERED LOCUS and SYSTEMATIC_NAME (orf) will be examined for a match with the geneList .",
                                                                                                                                                     "If ‘true’, the interactor OFFICIAL_SYMBOL will be examined for a match with the geneList.",
                                                                                                                                                     "If ‘true’, the interactor SYNONYM will be examined for a match with the geneList.",
                                                                                                                                                     "If ‘true’, the entries in 'GENELIST' will be compared to BIOGRID internal IDS which are provided in all Tab2 formatted files.",
                                                                                                                                                     "Identifier types on this list are examined for a match with the geneList. Some identifier types search multiple types simultaneously. UNIPROT or UNIPROTKB will search SWISS-PROT/TREMBL/UNIPROT-ACCESSION/UNIPROT-ISOFORM. REFSEQ will search REFSEQ-RNA-GI, REFSEQ-RNA-ACCESSION, REFSEQ-PROTEIN-GI, REFSEQ-PROTEIN-ACCESSION-VERSIONED, REFSEQ-PROTEIN-ACCESSION, REFSEQ-LEGACY. WORMBASE will search WORMBASE and WORMBASE-OLD. ENSEMBL will search ENSEMBL, ENSEMBL GENE, ENSEMBL PROTEIN, ENSEMBL RNA.",
                                                                                                                                                     "If ‘true’, interactions containing genes in the geneList will be excluded from the results. Ignored if one of searchIds, searchNames, searchSynonyms is not ‘true’ and additionalIdentifierTypes is empty.",
                                                                                                                                                     "If ‘true’, in addition to interactions between genes on the geneList, interactions will also be fetched which have only one interactor on the geneList i.e. the geneList’s first order interactors will be included",
                                                                                                                                                     "If ‘true’ interactions between the geneList’s first order interactors will be included. Ignored if includeInteractors is ‘false’ or if excludeGenes is set to ‘true’.",
                                                                                                                                                     "Interactions will be fetched whose Pubmed Id is/ is not in this list, depending on the value of excludePubmeds.",
                                                                                                                                                     "If ‘false’, interactions with Pubmed ID in pubmedList will be included in the results; if ‘true’ they will be excluded.",
                                                                                                                                                     "Interactions whose Pubmed ID has more than this number of interactions will be excluded from the results. Ignored if excludePubmeds is ‘false’.",
                                                                                                                                                     "If set to 'low or 'high', only interactions with 'Low throughput' or 'High throughput' in the 'throughput' field will be returned. Interactions with both 'Low throughput' and 'High throughput' will be returned by either value.",
                                                                                                                                                     "Only genes from these organisms will be searched with reference to gene identifiers or names.",
                                                                                                                                                     "If ‘true’, the first line of the result will be a BioGRID column header, appropriate for the format parameter (‘count’ format has no header).",
                                                                                                                                                     "‘tab1’ and ‘tab2’ will return data in .tab or .tab2 format respectively. 'json' will return data in json a json formatted object. ‘extendedTab2’ and 'jsonExtended' will return data in .tab2 and json file formats respectively with extra fields for “Source Database Identifiers”, “Number of Interactions per Publication” and “Additional Identifiers”. For more information on file formats, visit our file format listing.",
                                                                                                                                                     "If 'true', the rest service will show a small snippet above your results detailing how your input parameters were translated for use in returning your data. This is helpful in troubleshooting why you may or may not be getting back the results expected. For example, if you enter a typo for a field such as “searchNamez”, no result will be translated, and thus this parameter will be ignored."
                                                                                                                      )), .Names = c("Parameter", "Type", "Default", "Valid Values",
                                                                                                                                     "Description"), class = "data.frame", row.names = c(NA, -24L))
  df
}
