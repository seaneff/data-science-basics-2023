#######################################################################
### Find an Excel or .csv file with data you find interesting, #########
### or that you've used for work/school, and read it in R #############
#######################################################################

## your specific code will depend on the file type, but it may look something like this
## you can either do this via code or via the import dataset functionality in R Studio
my_data <- read_excel("~/Desktop/my_dataset.xlsx")


#######################################################################
### Use View() to inspect your data within R Studio ###################
#######################################################################

View(my_data)

#######################################################################
### Use is() to identify what type of object the data are loaded as ###
#######################################################################

is(my_data)

#######################################################################
### Print out the dimensions of your dataset ##########################
#######################################################################

dim(my_data)

#######################################################################
### Print out the names of all the columns of your dataset ############
#######################################################################

names(my_data)

#######################################################################
### Use head() to print the first five rows of your dataset ###########
#######################################################################

head(my_data)

#######################################################################
### Bonus: use tail() to print the last five rows of your dataset #####
#######################################################################

tail(my_data)

#######################################################################
### Explore your dataset! See some examples in today's course slides ##
#######################################################################

summary(my_data$value)
table(my_data$country_name)


