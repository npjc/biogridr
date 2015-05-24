# biogridr
biogridr: BioGRID R API 

```r
bg_get_key()
bg("interactions") %>%
  bg_constrain(taxId = 7227) %>%
  bg_get_results()
```
