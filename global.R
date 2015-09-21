library(dplyr)
library(lubridate)
library(rgdal)


#Preprocess the data
bc <- wbill %>%
    mutate(billing_frequency = toupper(billing_frequency),
           loc_in_city = toupper(loc_in_city)) %>%
    mutate(bill_post_date = mdy(bill_date_posting_date),
           meter_read_date = mdy(meter_read_date)) %>%
    # Remove rows that are not bi-monthly since that will skew the data:
    filter(billing_frequency == 'B') %>%
   # Remove rows that are not in a city
    filter(loc_in_city == 'IN') %>%
    select(
        id,
        cpcode,
        cpname,
        water_cons = water_consumption,
        sewer_cons = sewer_consumption,
        water_base_chg = water_service_charge_base_fee,
        water_commodity_chg = water_commodity_charge,
        sewer_base_chg = sewer_service_charge_base_fee,
        sewer_commodity_chg = sewer_commodity_charge
    )

getCPDList <- function(inputList = TRUE) {
  cpds <- select(bc, cpname, cpcode) %>%
      arrange(cpname)
  #TODO -- because of the duplication here, need to double check bill processing.
  unique(cpds)

  if (inputList == TRUE)
     setNames(cpds$cpcode, cpds$cpname)

}

