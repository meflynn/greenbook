
<!-- README.md is generated from README.Rmd. Please edit that file -->

\#`greenbook`: Tools For Analzing US Foreign Policy Spending Data

<!-- badges: start -->
<!-- badges: end -->

<img src="man/figures/greenbook-hex-logo.png" alt="greenbook hex logo" align="right" width="200" style="padding: 0 15px; float: right;"/>

The goal of greenbook is to facilitate user access to spending data
related to various aspects of US foreign policy. The name of the package
is based on the annual State Department and Defense Department
“greenbooks” that contain annual budgetary and spending data. Currently
the package only includes data from the US State Department’s Overseas
Loans and Grants greenbook, but I’ll be adding more DOD data as I get
the chance.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("meflynn/greenbook")
```

The package is still in development so you can plan on seeing some added
features in the coming months. Eventually I’ll push a version to CRAN,
too, but for now you’ll have to rely on the GitHub version

## Example

This is a basic example of using the first function, `greenbook_aid()`
to extract custom data on US economic and military aid.

``` r
library(greenbook)
#> Loading required package: data.table

aiddata <- greenbook_aid(type = "all", recipient = c(200, 645, 700), startyear = 1946, endyear = 2020, value = NULL, format = "long")

head(aiddata)
#>           country ccode iso3c year                       region category
#> 1: United Kingdom   200   GBR 1946               Western Europe Economic
#> 2: United Kingdom   200   GBR 1946               Western Europe Economic
#> 3: United Kingdom   200   GBR 1946               Western Europe Economic
#> 4:           Iraq   645   IRQ 1947 Middle East and North Africa Economic
#> 5: United Kingdom   200   GBR 1947               Western Europe Economic
#> 6: United Kingdom   200   GBR 1947               Western Europe Economic
#>               pubrow                         agency
#> 1: Inactive Programs     Department of the Treasury
#> 2: Inactive Programs Unknown - Historical Greenbook
#> 3: Inactive Programs Unknown - Historical Greenbook
#> 4: Inactive Programs Unknown - Historical Greenbook
#> 5: Inactive Programs     Department of the Treasury
#> 6: Inactive Programs Unknown - Historical Greenbook
#>                                         account    value aid_value
#> 1:                 INACTIVE - Lend Lease Silver constant     2e+08
#> 2:               INACTIVE - US Surplus Property constant   6.5e+08
#> 3: INACTIVE - UN Relif and Rehab Agency (UNRRA) constant   1.5e+07
#> 4:               INACTIVE - US Surplus Property constant   8732873
#> 5:                      INACTIVE - British Loan constant   3.6e+10
#> 6: INACTIVE - UN Relif and Rehab Agency (UNRRA) constant   6.8e+07
```

The function has several arguments to let users tailor the data to their
needs. The `recipient` argument takes correlates of war (COW) numeric
country codes or ISO3C character codes. You can supply single values or
a vector of values.

the `startyear` and `endyear` arguments are required and determine the
time span of the data. Currently the data go back to 1946 and up through
2020.

the `value` argument serves as a filter for historical dollar values
(current) or inflation adjusted values (constant). Users can specify
either or these, or leave the value argument out to return both values.

Finally, the `format` argument will return the data in long or wide
format, with the only difference currently being whether or not the
constant and current values are stacked or not. But there are other
variables contained in the resulting data frame that users can use to
further arrange the data according to their needs.
