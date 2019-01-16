# load the dplyr package
library("dplyr")

# rad in the gapminder data
dat <- read.csv("data/gapminder_data.csv")

dat$gdpPercap

dat[1:5, "gdpPercap"]
mean(dat$gdpPercap)
mean(dat[1:5, "gdpPercap"])
mean(dat[dat$continent == "Americas", "gdpPercap"]) # choose all rows with continent equal to "Americas"

#### using dplyr for data subsetting ----
# 'filter' chooses the rows
filter(dat, continent == "Americas")
filter(dat, year > 2000)
dat_2 <- filter(dat, continent == "Americas", year > 2000)

# 'select' chooses the columns
select(dat, continent)
select(dat_2, country, year, gdpPercap)

# %>% is the pipe that works the same as in the unix shell
dat %>% 
  filter(continent == "Americas", year > 2000) %>%
  select(country, year, gdpPercap)

#### group_by() and summarize() ----
summary_1 <- dat %>%
  group_by(country) %>%
  summarize(avg_life_exp = mean(lifeExp))

# compute the average gdpPercap for each country
mean_gdpPercap <- dat %>%
  group_by(country) %>%
  summarize(avg_gdppercap = mean(gdpPercap))

mean_gdpPercap

# compute the average gdpPerap for each continent in year 1957
mean_gdpPercap_continent_1957 <- dat %>%
  group_by(continent) %>%
  filter(year==1957) %>%
  summarize(avg_gdppercap_continent = mean(gdpPercap))

dat %>%
  group_by(continent,year)
mean_gdpPercap_continent_1957
str(dat)

#### multiple summary outputs ----
dat %>% 
  group_by(continent) %>%
  summarize(avg_gdp = mean(gdpPercap), 
            min_gdp = min(gdpPercap),
            max_gdp = max(gdpPercap),
            median_gdp = median(gdpPercap),
            sd_gdp = sd(gdpPercap),
            num_values = n())

#### making new column variables ----
#
dat %>%
  mutate(gdp_billion = gdpPercap* 10^9)

#### wide vs long in gapminder data ----
dat2 <- dat %>%
  select(country, year, gdpPercap)

library(tidyr)
dat2_wide <- dat2 %>% spread(year, gdpPercap)

dat2_long <- dat2_wide %>%
  gather(year, gdp, "1952":"2007") # the columns with the name of 1952 and 2007

