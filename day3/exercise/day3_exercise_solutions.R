#######################################################################
### Install and load ggplot2 ##########################################
#######################################################################

## write code here
## install.packages("ggplot2)
library(ggplot2)

#######################################################################
### Read in countries dataset #########################################
#######################################################################

## write code here
countries <- read.delim("countries.tsv")

#######################################################################
### Print out the first five rows of the dataset ######################
#######################################################################

## write code here
head(countries)

#######################################################################
### Summary statistics the number of MDs per 100,000 capita ##########
#######################################################################

## write code here
summary(countries$mds_per_10000capita)

#######################################################################
### Make a (base R) histogram of the number of MDs per capita #########
#######################################################################

## write code here
hist(countries$mds_per_10000capita,
     xlab = "MDs per 10,000 capita",
     ylab = "Frequency",
     main = "Distribution of MDs per 100,000 capita\nper WHO Member State",
     col = "light blue")

#######################################################################
### Make a scatterplot in ggplot ######################################
### hint: use geom_point() ############################################
#######################################################################

ggplot(countries, 
       aes(x = mds_per_10000capita, 
           y = nurses_midwives_per_10000capita, 
           color = who_region)) +
  geom_point() +
  xlab("MDs per\n10,000 capita") +
  ylab("Nurses and midwives\nper 10,000 capita") +
  ggtitle("Healthcare worker density\n(doctors, nurses, and midwives)\nby WHO region") +
  labs(color = "WHO Region")

