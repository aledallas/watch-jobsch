# scraping jobs.ch
library(tidyverse)
library(rvest)
library(writexl)

# function to retrieve info on number of jobs
get_job_number <- function(x){
    read_html(x) %>% 
    html_element(".drjDnt") %>% 
    html_text2() %>% 
    str_remove("[^0-9\\.]") %>% 
    parse_number()
}


# Get data ----------------------------------------------------------------

# tot jobs
tot <- get_job_number("https://www.jobs.ch/de/stellenangebote/?term=")

# deutschschweiz
chde <- get_job_number("https://www.jobs.ch/de/stellenangebote/?region=2&term=")

# banking / financial services
bank <- get_job_number("https://www.jobs.ch/de/stellenangebote/?industry=1&term=")

# strategy
strat <- get_job_number("https://www.jobs.ch/de/stellenangebote/?term=strategy")

# strategy in deutschschweiz
strat_de <- get_job_number("https://www.jobs.ch/de/stellenangebote/?region=2&term=strategy")

# zurich
zh <- get_job_number("https://www.jobs.ch/de/stellenangebote/?location=Z%C3%BCrich&term=")

# banking in zurich
bank_zh <- get_job_number("https://www.jobs.ch/de/stellenangebote/?industry=1&location=Z%C3%BCrich&term=")

# strategy in zurich
strat_zh <- get_job_number("https://www.jobs.ch/de/stellenangebote/?location=Z%C3%BCrich&term=strategy")

# strategy in banking in zurich
strat_bank_zh <- get_job_number("https://www.jobs.ch/de/stellenangebote/?industry=1&location=Z%C3%BCrich&term=strategy")



# Consolidate and save ----------------------------------------------------

# put things together
df <- tibble(date = Sys.Date(), tot, chde, bank, strat, strat_de, zh, bank_zh, strat_zh, strat_bank_zh)

# write to xlsx
writexl::write_xlsx(obs, "ecb_eurchf.xlsx")


