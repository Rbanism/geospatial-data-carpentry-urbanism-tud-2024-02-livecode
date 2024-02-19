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

with_na <-
