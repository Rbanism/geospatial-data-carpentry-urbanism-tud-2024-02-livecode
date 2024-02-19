print('hello world')
#install.packages('here')

library(here)
library(tidyverse)
here()


download.file('https://bit.ly/geospatial_data', 
              here('data', 'gapminder_data.csv'))

1+100
1*100
1/100

x <- 1/40
x
sqrt(x)
y <- sqrt(x)

numeric_vector <- c(2, 6, 3)
str(numeric_vector)

character_vector <- c('Amsterdam', 'Rotterdam', "'s-Gravenhage" )
str(character_vector)

logical_vector <- c(TRUE, FALSE, TRUE)
logical_vector


ab_vector <- c('a', 'b')
ab_vector

abcd_vector <- c(ab_vector, 'c', 'd')
combined_vector <- c(abcd_vector, numeric_vector)

#missing values

with_na <- c(1, 2, 1, 1, NA, 3, NA)
mean(with_na)

mean(with_na, na.rm=TRUE)

is.na(with_na)
!is.na(with_na)
sum(!is.na(with_na))

#factors

nordic_str <- c('Norway', 'Sweden', 'Norway', 'Denmark', 'Sweden')
nordic_str

nordic_cat <- factor(nordic_str)
nordic_cat
levels(nordic_cat)
nlevels(nordic_cat)

nordic_cat <- factor(nordic_cat, levels = c('Norway', 'Denmark', 'Sweden'))
nordic_cat

nordic_cat2 <- factor(nordic_str, levels = c('Norway', 'Denmark'))
nordic_cat2
unique(nordic_str)

nordic_str <- c(nordic_str, "Iceland")
nordic_str



######### Coffee break


# Explore Data
library(here)
here
gapminder <- read.csv(here('data', 'gapminder_data.csv'))

str(gapminder)

head(gapminder)

summary(gapminder)

nrow(gapminder)
ncol(gapminder)

country_vec <- gapminder$country
head(country_vec)
str(country_vec)

select(gapminder, )