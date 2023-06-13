#######################################################################
### Read in the countries dataset we discussed today ##################
#######################################################################

## write your code here
countries <- read.delim("https://raw.githubusercontent.com/seaneff/data-science-basics-2023/main/reference-dataset/countries.tsv")

#######################################################################
### What are the names of all the fields? #############################
#######################################################################

## write your code here
names(countries)

#######################################################################
### Can you identify a numeric vector? ################################
#######################################################################

## write your code here
is.numeric(countries$safe_after_dark_overall)
is(countries$safe_after_dark_overall)

#######################################################################
### Can you identify a logical vector? ################################
#######################################################################

## write your code here
is.logical(countries$who_member_state)
is(countries$who_member_state)

#######################################################################
### Can you identify a character vector? ##############################
#######################################################################

## write your code here
is.character(countries$who_region)
is(countries$who_region)
