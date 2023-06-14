#######################################################################
### Load required libraries ###########################################
#######################################################################

## if you don't already have readxl downloaded, start by running:
## install.packages("ggplot2")
## install.packages("dplyr")

library(ggplot2)
library(dplyr)

#######################################################################
### Read in your raw dataset ##########################################
#######################################################################

countries <- read.delim("https://raw.githubusercontent.com/seaneff/data-science-basics-2023/main/day3/demo/datasets/countries.tsv")
breeds <- read.delim("https://raw.githubusercontent.com/seaneff/data-science-basics-2023/main/day3/demo/datasets/local_breeds_at_risk.tsv")
sanctions <- read.delim("https://raw.githubusercontent.com/seaneff/data-science-basics-2023/main/day3/demo/datasets/sanctions.tsv")

#######################################################################
### Explore dataset generally #########################################
#######################################################################

## What are the columns/fields?
names(countries)
names(breeds)
names(sanctions)

#############################################################################################
### Descriptive statistics: #################################################################
### Measures of centrality (average, median) ################################################
#############################################################################################

## average, across countries reporting data, of proportion of total population who feel safe walking alone after dark
mean(countries$safe_after_dark_overall) ## what happened here? missing values
mean(countries$safe_after_dark_overall, na.rm = TRUE) 

## median, across countries reporting data, of proportion of total population who feel safe walking alone after dark
median(countries$safe_after_dark_overall) ## what happened here? missing values
median(countries$safe_after_dark_overall, na.rm = TRUE) 

#############################################################################################
### Descriptive statistics: #################################################################
### Measures of spread (standard deviation, interquartile range) ############################
#############################################################################################

## standard deviation, across countries reporting data, of proportion of total population who feel safe walking alone after dark
sd(countries$safe_after_dark_overall) ## what happened here? missing values
sd(countries$safe_after_dark_overall, na.rm = TRUE) 

## interquartile range (IQR), across countries reporting data, of proportion of total population who feel safe walking alone after dark
quantile(countries$safe_after_dark_overall) ## what happened here? missing values
quantile(countries$safe_after_dark_overall, na.rm = TRUE) 

#############################################################################################
### Descriptive statistics: #################################################################
### Counts and rates ########################################################################
#############################################################################################

## number of countries where over 50% of respondents reported feeling safe walking alone after dark
table(countries$safe_after_dark_overall >= 50) 

## proportion of countries where over 50% of respondents reported feeling safe walking alone after dark
prop.table(table(countries$safe_after_dark_overall >= 50))

########################################################################################################
### Data visualization: ################################################################################
### Histogram (base R) #################################################################################
########################################################################################################

## most basic possible histogram
hist(countries$safe_after_dark_overall)

## add axis labels and a title
hist(countries$safe_after_dark_overall,
     ## xlab specifies the x axis label
     xlab = "Percent of population",
     ## ylab specifies the y axis label
     ylab = "Count",
     ## main specifies the primary title, the \n here tells R to make a line break
     main = "Proportion of population, per country\nwho feel safe walking alone after dark")

## add a color
hist(countries$safe_after_dark_overall,
     xlab = "Percent of population",
     ylab = "Count",
     main = "Proportion of population, per country\nwho feel safe walking alone after dark",
     ## col specifies the color that we should fill the bars with
     col = "light blue")

## specify the number of separate bars we want in the plot
hist(countries$safe_after_dark_overall,
     xlab = "Percent of population",
     ylab = "Count",
     main = "Proportion of population, per country\nwho feel safe walking alone after dark",
     col = "light blue",
     ## breaks specifies how many bins we want in our final plot
     breaks = 10)

########################################################################################################
### Data visualization: ################################################################################
### Scatterplot (base R) ###############################################################################
########################################################################################################

## most basic possible scatterplot
plot(countries$safe_after_dark_male,
     countries$safe_after_dark_female)

## add labels and color
plot(x = countries$safe_after_dark_male,
     y = countries$safe_after_dark_female,
     xlab = "Percent of males",
     ylab = "Percent of females",
     main = "Proportion of population, per country\nwho feel safe walking alone after dark\nby gender",
     col = "salmon")

########################################################################################################
### Data visualization: ################################################################################
### Histogram (ggplot2) ################################################################################
########################################################################################################

## most basic possible histogram in ggplot2
ggplot(countries, aes(safe_after_dark_overall)) +
  geom_histogram()

## add axis labels and a title
ggplot(countries, aes(safe_after_dark_overall)) +
  geom_histogram() +
  ## xlab specifies the x axis label
  xlab("Percent of population") +
  ## ylab specifies the x axis label
  ylab("Count") +
  ## ggtitle specifies the x axis label
  ggtitle("Proportion of population, per country\nwho feel safe walking alone after dark")
  
## add colors
ggplot(countries, aes(safe_after_dark_overall)) +
  ## fill specifies how the histogram bins are filled, color specifies their outline color
  geom_histogram(fill = "light blue", color = "black") +
  xlab("Percent of population") +
  ylab("Count") +
  ggtitle("Proportion of population, per country\nwho feel safe walking alone after dark")

########################################################################################################
### Data visualization: ################################################################################
### Scatterplot (ggplot2) ##############################################################################
########################################################################################################

## most basic possible scatterplot in ggplot2
ggplot(countries, aes(x = mds_per_10000capita, y = nurses_midwives_per_10000capita)) +
  geom_point()

## add axis labels and a title
ggplot(countries, aes(x = mds_per_10000capita, y = nurses_midwives_per_10000capita)) +
  geom_point() +
  xlab("Number of MDs\nper 10,000 capita") +
  ylab("Number of nurses and midwives\nper 10,000 capita") +
  ggtitle("Health workforce per capita, by country\nMDs and nurses/midwives")

## color points by WHO region
ggplot(countries, 
       aes(x = mds_per_10000capita, 
           y = nurses_midwives_per_10000capita,
           ## the line below colors the plots by WHO region
           col = who_region)) +
  geom_point() +
  xlab("Number of MDs\nper 10,000 capita") +
  ylab("Number of nurses and midwives\nper 10,000 capita") +
  ggtitle("Health workforce per capita, by country\nMDs and nurses/midwives") +
  labs(col = "WHO region") ## this line gives the legend a nice title

########################################################################################################
### Data visualization: ################################################################################
### Barplot (ggplot2) ##################################################################################
########################################################################################################

## most basic possible scatterplot in ggplot2
ggplot(countries, aes(who_region)) +
  geom_bar()

## labels are hard to see, try flipping plot
ggplot(countries, aes(who_region)) +
  geom_bar() +
  ## reverse the X and Y coordinates (flip barplot horizontally)
  coord_flip()

## add colors and titles
ggplot(countries, aes(who_region)) +
  ## fill is the color used to fill the barplot, black is the color that surrounds the bars
  geom_bar(fill = "dark blue", color = "black") +
  ylab("Count") +
  xlab("") +
  ggtitle("Number of WHO member states\nper WHO region") +
  coord_flip() 

########################################################################################################
### Data visualization: ################################################################################
### Line chart (ggplot2) ###############################################################################
########################################################################################################


world <- map_data("world")
world_data <- inner_join(world, countries, by = join_by(region == country_name))

ggplot(data = world_data, mapping = aes(x = long, y = lat, group = group)) + 
  coord_fixed(1.3) +
  geom_polygon(aes(fill = mds_per_10000capita)) +
  scale_fill_distiller(palette ="RdBu", direction = -1) + # or direction=1
  ggtitle("Global Human Development Index (HDI)") 
