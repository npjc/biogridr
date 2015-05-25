# biogridr
biogridr: BioGRID R API 

```r
bg_get_key()
bg("interactions") %>%
  bg_constrain(taxId = 7227) %>%
  bg_get_results()
```


This just works.

```r
z <- bg("interactions") %>% 
  bg_constrain(geneList = "HP1|HP1a|HP1b|HP1c") %>% 
  bg_get_results()
```

```r
head(z)
#>    biogrid_interaction_id entrez_gene_id_for_interactor_a entrez_gene_id_for_interactor_b
#> 1:                  17583                           23468                            6839
#> 2:                  18414                           23468                            3930
#> 3:                  33407                           33043                           31834
#> 4:                  33578                           32090                           34119
#> 5:                  33766                           36957                           34119
#> 6:                  34472                           40302                           34119
#>    biogrid_id_for_interactor_a biogrid_id_for_interactor_b systematic_name_for_interactor_a
#> 1:                      117030                      112706                                -
#> 2:                      117030                      110122                                -
#> 3:                       59332                       58290                      Dmel_CG1676
#> 4:                       58501                       60248                      Dmel_CG1745
#> 5:                       62651                       60248                     Dmel_CG18468
#> 6:                       65559                       60248                      Dmel_CG3680
#>    systematic_name_for_interactor_b official_symbol_for_interactor_a
#> 1:                                -                             CBX5
#> 2:                          PRO0650                             CBX5
#> 3:                      Dmel_CG7041                           cactin
#> 4:                      Dmel_CG8409                              HP5
#> 5:                      Dmel_CG8409                              Lhr
#> 6:                      Dmel_CG8409                           CG3680
#>    official_symbol_for_interactor_b synonyms/aliases_for_interactor_a
#> 1:                          SUV39H1                    HEL25|HP1|HP1A
#> 2:                              LBR                    HEL25|HP1|HP1A
#> 3:                             HP1b               CG1676|Dmel\\CG1676
#> 4:                       Su(var)205               CG1745|Dmel\\CG1745
#> 5:                       Su(var)205 CG18468|Dmel\\CG18468|HP3|mel-Lhr
#> 6:                       Su(var)205                      Dmel\\CG3680
#>                                                                                                                                                                                              synonyms/aliases_for_interactor_b
#> 1:                                                                                                                                                                                            H3-K9-HMTase 1|KMT1A|MG44|SUV39H
#> 2:                                                                                                                                                                                                    DHCR14B|LMN2R|PHA|TDRD18
#> 3:                                                                                                                                                                                                     CG7041|Dmel\\CG7041|HP1
#> 4: CBX5|CG8409|DmHP-1|DmHP1|Dmel\\CG8409|E(var)29|E(var)29A|FBgn0003607|HP-1|HP1|HP1-VS|HP1A|HP1alpha|Su(Var)2-5|Su(var)|Su(var)2-05|Su(var)2-501|Su(var)29A|Su(var)[205]|Su-var(2)5|Su[Var]205|Suvar(2)5|Suvar2-5|dHP-1a|dHP1
#> 5: CBX5|CG8409|DmHP-1|DmHP1|Dmel\\CG8409|E(var)29|E(var)29A|FBgn0003607|HP-1|HP1|HP1-VS|HP1A|HP1alpha|Su(Var)2-5|Su(var)|Su(var)2-05|Su(var)2-501|Su(var)29A|Su(var)[205]|Su-var(2)5|Su[Var]205|Suvar(2)5|Suvar2-5|dHP-1a|dHP1
#> 6: CBX5|CG8409|DmHP-1|DmHP1|Dmel\\CG8409|E(var)29|E(var)29A|FBgn0003607|HP-1|HP1|HP1-VS|HP1A|HP1alpha|Su(Var)2-5|Su(var)|Su(var)2-05|Su(var)2-501|Su(var)29A|Su(var)[205]|Su-var(2)5|Su[Var]205|Suvar(2)5|Suvar2-5|dHP-1a|dHP1
#>    experimental_system_name experimental_system_type
#> 1:               Two-hybrid                 physical
#> 2:               Two-hybrid                 physical
#> 3:               Two-hybrid                 physical
#> 4:               Two-hybrid                 physical
#> 5:               Two-hybrid                 physical
#> 6:               Two-hybrid                 physical
#>    first_author_surname_of_the_publication_in_which_the_interaction_has_been_shown,_optionally_followed_by_additional_indicators,_e
#> 1:                                                                                                                  Fujita N (2003)
#> 2:                                                                                                                      Ye Q (1996)
#> 3:                                                                                                                    Giot L (2003)
#> 4:                                                                                                                    Giot L (2003)
#> 5:                                                                                                                    Giot L (2003)
#> 6:                                                                                                                    Giot L (2003)
#>    pubmed_id_of_the_publication_in_which_the_interaction_has_been_shown
#> 1:                                                             12711603
#> 2:                                                              8663349
#> 3:                                                             14605208
#> 4:                                                             14605208
#> 5:                                                             14605208
#> 6:                                                             14605208
#>    organism_id_for_interactor_a organism_id_for_interactor_b interaction_throughput
#> 1:                         9606                         9606         Low Throughput
#> 2:                         9606                         9606         Low Throughput
#> 3:                         7227                         7227        High Throughput
#> 4:                         7227                         7227        High Throughput
#> 5:                         7227                         7227        High Throughput
#> 6:                         7227                         7227        High Throughput
#>    quantitative_score post_translational_modification phenotypes qualifications tags
#> 1:                  -                               -          -              -    -
#> 2:                  -                               -          -              -    -
#> 3:                  -                               -          -              -    -
#> 4:                  -                               -          -              -    -
#> 5:                  -                               -          -              -    -
#> 6:                  -                               -          -              -    -
#>    source_database
#> 1:         BIOGRID
#> 2:         BIOGRID
#> 3:         BIOGRID
#> 4:         BIOGRID
#> 5:         BIOGRID
#> 6:         BIOGRID
```
