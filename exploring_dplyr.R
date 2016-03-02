library(dplyr)
mydf <- read.csv(path2csv, stringsAsFactors = FALSE)
cran <- tbl_df(mydf)
rm("mydf")
select(cran, ip_id, package, country)
select(cran, r_arch:country)
select(cran, country:r_arch)
select(cran, -time)
select(cran, -(X:size))
filter(cran, package == "swirl")
filter(cran, size > 100500, r_os == "linux-gnu")
filter(cran, !is.na(r_version))
cran2 <- select(cran, size:ip_id)
arrange(cran2, ip_id)
arrange(cran2, desc(ip_id))
arrange(cran2, package, ip_id)
arrange(cran2, country, desc(r_version), ip_id)
cran3 <- select(cran, ip_id, package, size)
#adding a new column
mutate(cran3, size_mb = size/2^20)
mutate(cran3, size_mb = size/2^20, size_gb = size_mb/2^10)
mutate(cran3, correct_size = size+1000)
summarize(cran, avg_bytes=mean(size))
by_package <- group_by(cran, package)
summarize(by_package, mean(size))
pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size))
quantile(pack_sum$count, probs = 0.99)
top_counts <- filter(pack_sum, count>679)
View(top_counts)
top_counts_sorted <- arrange(top_counts, desc(count))
quantile(pack_sum$unique, probs = 0.99)
top_unique <- filter(pack_sum, unique > 465)
top_unique_sorted <- arrange(top_unique, desc(unique))
#pipeline operator
cran %>%
    select(ip_id, country, package, size) %>%
    mutate(size_mb = size / 2^20) %>%
    filter(size_mb <= 0.5) %>%
    # Your call to arrange() goes here
    arrange(desc(size_mb))