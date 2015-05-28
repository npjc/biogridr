# biogridr
biogridr: BioGRID R API 


## Synopsis

Biogridr provides an R interface to the BioGRID (Biological General Repository for Interaction Datasets) REST API [described here](Biological General Repository for Interaction Datasets). It aims to provide convenient and reproducible ways to query and access BioGRID data.



## Install

```r
# install.packages("devtools")
devtools::install_github("npjc/biogridr")
```

## Get started

```r
library(biogridr)
```

To talk to BioGRID we first need to get a free access key. For this use 
`bg_get_key()`. If you provide your details as in below it creates a profile 
for you and assigns a key (or if you have already done this before it retreives the key). `bg_get_key()` will store you key so you only need to run it once at the beginning of each session. This is equivalent to interactively doing this via [this form](http://webservice.thebiogrid.org/)

```r
bg_get_key("first_name","last_name","email@domain.com","my_project_name")
```

To query for interactions you would do:
```r
bg("interactions") %>%
  bg_constrain(taxId = 7227) %>%
  bg_get_results()
```

where `taxId = 7227` constrains the results returned to those associated with Drosophila melanogaster. If you want to be kind to future you or can't remember the taxonomic id for your organism of interest use `taxId()`. It will retrieve the identifier (or return all allowed organisms and their identifiers; see `?taxId`). This is equivalent to the above:
```r
bg("interactions") %>%
  bg_constrain(taxId = taxId("Drosophila melanogaster")) %>%
  bg_get_results()
```

Another query might be against a list of genes:
```r
z <- bg("interactions") %>% 
  bg_constrain(geneList = "HP1|HP1a|HP1b|HP1c") %>% 
  bg_get_results()
```

