globalVariables(c('country', 'ccode', 'iso3c', 'region', 'year', 'pubrow', 'agency', 'account', 'constant', 'current'))

#' Function to retrieve customized U.S. troop deployment data
#'
#' @description \code{greenbook_aid()} generates a data set containing USAID Overseas Loans and Grants data on foreign economic and military aid.

#' @return \code{greenbook_aid()} returns a data frame containing USAID Overseas Loans and Grants data on foreign economic and military aid.
#'
#' @param type The type of aid to return. Values can include economic, military, or all.
#' @param recipient The recipient of the aid. Can include Correlates of War (COW) numerical country codes or ISO3C character country codes.
#' @param startyear The first year for the series
#' @param endyear The last year for the series
#' @param value Indicates whether to return constant or current US dollar values for the observed aid amounts. Default value is NULL and will return both constant and current dollar values. User can specify constant or current character value in function argument to return only one of these values.
#' @param format Gives the user the option to return the data in long or wide format.
#'
#'
#' @importFrom rlang warn
#' @export
#'
#' @author Michael E. Flynn
#'
#' @references United States Government. 2021. US Overseas Loans and Grants (Greenbook). United States Department of State.
#'
#'
#'@examples
#'
#'\dontrun{
#'library(greenbook)
#'
#'example <- greenbook_aid(recipient = NA, startyear = 1980, endyear = 2015)
#'
#'head(example)
#'
#'}
#'


greenbook_aid <- function(type = NA, recipient = NA, startyear, endyear, value = NULL, format = "long") {

  tempdata <- greenbook::greenbook.aid

  rlang::warn("Data currently cover 1946-2020. User must specify a startyear and and endyear that fall within this range.")
  rlang::warn("value argument must take on 'current', 'constant', or 'both'.")
  rlang::warn("Format options are 'long' and 'wide'.")


  # Filter out type of aid
  if (type == "all") {

    tempdata <- tempdata

  } else if (type == "economic") {

    tempdata <- tempdata[
      category == "Economic"
    ]

    tempdata <- tempdata

  } else if (type == "military") {

  tempdata <- tempdata[
    category == "Military"
  ]

  tempdata <- tempdata

  }


  # Filter out years
  tempdata <- tempdata[
    year >= startyear & year <= endyear ,
  ]

  # Filter recipient

   if (is.na(recipient)) {

    tempdata <- tempdata

  } else if (is.numeric(recipient)) {

    tempdata <- tempdata[
      ccode %in% recipient
    ]

  } else if (is.character(recipient)) {

    tempdata <- tempdata[
      iso3c %in% recipient
    ]
  }


  # Filter inflation adjusted or constant

  if (is.null(value)) {

    tempdata <- tempdata

  } else if (value == "constant") {

    tempdata <- tempdata[
      , current := NULL
    ]

  } else {

    tempdata <- tempdata[
      , constant := NULL
    ]
  }


  # Adjust format to user preference

  if (format == "long") {

    tempdata <- data.table::melt(tempdata, id.vars = c("country", "ccode", "iso3c", "year", "region", "category", "pubrow", "agency", "account"),
                                 value.name = "aid_value",
                                 variable.name = "value")


  } else if (format == "wide") {

    tempdata <- tempdata
  }

  return(tempdata)

}



