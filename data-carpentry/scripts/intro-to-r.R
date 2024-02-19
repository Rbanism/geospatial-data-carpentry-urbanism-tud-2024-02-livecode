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
