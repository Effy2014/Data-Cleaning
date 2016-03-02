library(readr)

x <- read_fwf(file="https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for",skip=4,
              fwf_widths(c(12, 7, 4, 9, 4, 9, 4, 9, 4)))
