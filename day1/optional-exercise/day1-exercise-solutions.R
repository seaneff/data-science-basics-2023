#######################################################################
### Create an object titled "name" ####################################
## and assign it the value of your name ###############################
#######################################################################

## write your code here
name <- "Steph"

#######################################################################
### What data type is the object name? ################################
## Print it out in the R console ######################################
#######################################################################

## write your code here
is(name)

#######################################################################
### Do some math that involves addition ###############################
#######################################################################

## write your code here
3+7

#######################################################################
### Do some math that involves multiplication #########################
#######################################################################

## write your code here
2*4*9

#######################################################################
### Create a vector called "foods" that lists three of your favorite ##
## foods ##############################################################
#######################################################################

## write your code here
foods <- c("fresh bread", "artichokes", "strawberries")

#######################################################################
### Create a logical vector and assign it to an object called #########
### logical_vector ####################################################
#######################################################################

logical_vector <- c(TRUE, TRUE, TRUE, TRUE, FALSE, TRUE, FALSE)

#############################################################################
### Use is() to confirm that the object logical_vector has type logical #####
#############################################################################

is(logical_vector)

##############################################################################
### Create a numeric vector with five values and assign it to an object ######
## called numeric_vector #####################################################
##############################################################################

numeric_vector <- c(-1, 0, 1, 2, 3)

#######################################################################
### Add one to each element of numeric_vector #########################
#######################################################################

numeric_vector + 1

#######################################################################
### Multiply each element of numeric_vector by three ##################
#######################################################################

numeric_vector*3

#######################################################################
### Divide each element of numeric_vector by negative five ############
#######################################################################

numeric_vector/-5

#######################################################################
### Calculate the average and standard deviation of the numbers in ####
## numeric_vector, then and add a comment to describe what you did ####
#######################################################################

## calculate the mean and standard deviation of the object numeric_vector
## then also print out some additional summary statistics
mean(numeric_vector)
sd(numeric_vector)
summary(numeric_vector)

#######################################################################
### Use the ? functionality to learn more about the function summary ##
#######################################################################

?summary
