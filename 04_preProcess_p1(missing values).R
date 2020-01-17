######################################################################
#             Data Preprocessing (PART 1)
######################################################################

# necessary to 'clean' the data before perfoming machine learning algorithms


################# DEALING WITH MISSING VALUES #####################


#install.packages("mice")
#install.packages("VIM")
library(mice)
library(VIM) 

## Create data set with missing values
a=set.seed(2) 
View(mtcars)
miss_mtcars <- mtcars 

some_rows <- sample(1:nrow(miss_mtcars), 7) 
miss_mtcars$drat[some_rows] <- NA

some_rows <- sample(1:nrow(miss_mtcars), 5) 
miss_mtcars$mpg[some_rows] <- NA

some_rows <- sample(1:nrow(miss_mtcars), 5)
miss_mtcars$cyl[some_rows] <- NA

some_rows <- sample(1:nrow(miss_mtcars), 3) 
miss_mtcars$wt[some_rows] <- NA

some_rows <- sample(1:nrow(miss_mtcars), 3) 
miss_mtcars$vs[some_rows] <- NA 

only_automatic <- which(miss_mtcars$am==0) 
some_rows <- sample(only_automatic, 4) 
miss_mtcars$qsec[some_rows] <- NA

nrow(miss_mtcars)
View(miss_mtcars)
summary(miss_mtcars)
## Visualization of the missing pattern
md.pattern(miss_mtcars) #  Cells with a 1 represent nonmissing data; 0s represent missing data.
mpattern <- md.pattern(miss_mtcars)
sum(as.numeric(row.names(mpattern)), na.rm = TRUE)

aggr(miss_mtcars, numbers=TRUE) # visualize the missing data pattern graphically 


######### Challenge #########

#visualize the weather dataset for NA values

## Dealing with missing data
### Complete case analysis
mean(miss_mtcars$mpg)
mean(miss_mtcars$mpg, na.rm = TRUE)

m1 <- lm(mpg ~ am + wt + qsec, data = miss_mtcars, na.action = na.omit)


### Missing Data Imputation
#### Mean Substitution
mean_sub <- miss_mtcars
mean_sub$qsec
mean_sub$qsec[is.na(mean_sub$qsec)] <- mean(mean_sub$qsec, na.rm = TRUE)
mean_sub$qsec
