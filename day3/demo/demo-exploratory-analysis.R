#######################################################################
### Load required libraries ###########################################
#######################################################################

## if you don't already have readxl downloaded, start by running:
## install.packages("ggplot2")
## install.packages("sqldf")
## install.packages("readr")

library(ggplot2)

#######################################################################
### Read in your raw dataset ##########################################
#######################################################################

countries <- read.delim("countries.tsv")
breeds <- read.delim("local_breeds_at_risk.tsv")

#######################################################################
### See datasets in R Studio Viewer ###################################
#######################################################################

View(countries)

#######################################################################
### Explore dataset generally #########################################
#######################################################################

## What are the columns/fields?
names(countries)

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
ggplot(countries, aes(x = safe_after_dark_female, y = safe_after_dark_male)) +
  geom_point()

## add axis labels and a title
ggplot(countries, aes(x = safe_after_dark_female, y = safe_after_dark_male)) +
  geom_point() +
  xlab("Percent of females") +
  ylab("Percent of males") +
  ggtitle("Proportion of population, per country\nwho feel safe walking alone after dark")

## color points by WHO region
ggplot(countries, 
       aes(x = safe_after_dark_female, 
           y = safe_after_dark_male,
           ## col here tells R that the points should be colored based on the WHO region
           col = who_region)) +
  geom_point() +
  xlab("Percent of females") +
  ylab("Percent of males") +
  ggtitle("Proportion of population, per country\nwho feel safe walking alone after dark")


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


