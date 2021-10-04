## code to prepare `DATASET` dataset goes here

library(data.table)
library(rio)

greenbook.aid <- rio::import("https://s3.amazonaws.com/files.explorer.devtechlab.com/us_foreignaid_greenbook.xlsx")

write.csv(greenbook.aid, here::here("data-raw/us_foreignaid_greenbook.csv"))

greenbook.aid <- as.data.table(greenbook.aid)

colnames(greenbook.aid) <- c("year", "region", "country", "category", "pubrow", "agency", "account", "current", "constant")

greenbook.aid <- greenbook.aid[
  -c(1:6)
][
  , `:=` (ccode = countrycode::countrycode(country, "country.name", "cown"),
          iso3c =  countrycode::countrycode(country, "country.name", "iso3c"))
][
  , year := gsub("\\.\\d", "", year) # Remove 1976 weird part of year
][
  , .(constant = sum(as.numeric(constant), na.rm = TRUE),
      current = sum(as.numeric(current), na.rm = TRUE)),
  by = c("country", "ccode", "iso3c", "region", "category", "pubrow", "agency", "account", "year")
][
  , lapply(.SD, format, digits = 2), .SDcols = c("constant", "current"),
  by = c("country", "ccode", "iso3c", "region", "category", "pubrow", "agency", "account", "year")
][
  , year := as.numeric(year)
]

setcolorder(greenbook.aid, neworder = c("country", "ccode", "iso3c", "year", "region", "category", "pubrow", "agency", "account"))



usethis::use_data(greenbook.aid, overwrite = TRUE)
