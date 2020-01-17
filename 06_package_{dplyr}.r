
## install.packAges(tidyverse)

library(tidyverse)  # using the dplyr packAge

# use the heartDT dataset

########################## Data structure ################################

glimpse(heartDT)
lst(heartDT)
tbl_sum(heartDT)

na_if(x)   # converts unwanted values to NA


############################# Select() ###################################
heartDT=read.csv(file.choose())

View(heartDT)
heartDTNUM=select(heartDT,Age,RestBP,Chol,MaxHR)
# can be used to rearrange columns if you want >> sequence you specify
heartDTNUM2=select(heartDT,RestBP,MaxHR,Chol,Age)
heartDTNUM2=select(heartDT,Chol:ExAng)  # those from Chol till AHD selected

# can be used to drop variable from dataset
heartDTNUM2=select(heartDTNUM2,RestBP,MaxHR, -Chol,-Age)
heartDTNUM2=select(heartDTNUM2,RestBP,-c(MaxHR,Chol,Age))

# sometimes can use column index instead of column name
heartDTNUM=select(heartDT, 1,2,3,4,5,6)
heartDTNUM=select(heartDT, 1:6)
heartDTNUM=select(heartDT, c(2,4,7))
heartDTNUM=select(heartDT, -2,-3) # delete columns

# use to rename columns
heartDTNUM=select(heartDT, "gender"=Sex, RestBP, Chol) # change Sex into gender



############################## Filter()####################################

# filter() >> select rows >> something like subset (by rows)

heartDTNEW3=filter(heartDT, ChestPain != "asymptomatic")   # not equal
heartDTNEW3=filter(heartDT, ChestPain =="asymptomatic"| Sex=="1") # or operator
heartDTNEW3=filter(heartDT, ChestPain %in% c("asymptomatic","nonanginal"))   # in a group

############################### Slice()#####################################

# slice() >> see first 20 rows or from 20:40 rows and so on
slice(heartDT, 1:20)
slice(heartDT, 20:40)
slice(heartDT, 10:nrow(heartDT))  # from 10th row to end of dataset

############################# add_rownames() ###############################

#check it there are rownames or not
rownames(heartDT)

# create a new variable called dwightNum
heartDTNEW4=add_rownames(heartDT, "dwightNum") # deprecated but still works

############################## mutate() and transmute()######################

# mutate() >> when you want to create new variable which are function of exisiting variables
heartDTNEW5= mutate(heartDT, old = Age>50) # this will give TRUE or FALSE
heartDTNEW5= mutate(heartDT, Chol_class=Chol/20)
heartDTNEW5= mutate(heartDT, Chol_class=Chol/20, RestBP_class=RestBP/5)

# add multiple and overlapping functions
heartDTNEW6=mutate(heartDT, Chol_class=Chol/20, RestBP_class=RestBP/5, ratio=Chol_class-RestBP_class)

# using if_else function in mutate
heartDTNEW7=mutate(heartDT, CholLevel=if_else(Chol>250,"highrisk","normal"), Chol_class=Chol/20)
heartDTNEW7=mutate(heartDT, CholLevel=if_else(Chol>250,"highrisk",(if_else(Chol>200, "normal","healthy"))), Chol_class=Chol/20)

heartDTNEW7=mutate(heartDT, CholLevel=if_else(Chol>250,"highrisk",(if_else(Chol>200, "normal",(if_else(Chol>175,"healthy","poor"))))))

heartDTNEW8=mutate(heartDT, CholLevel=if_else(Chol>250 & Age >50,"highrisk",
                                          if_else(Chol>200 & Age >40, "normal","healthy")))


# multiple layers of if_else (like in functions)

# transmute works exactly like mutate() except only show the mutated columns
heartDTNEW8=transmute(heartDT,Chol_class = Chol/20, RestBP_class =RestBP/5, ratio=Chol_class-RestBP_class)

################################## data_frame #################################

mydataframe = data_frame(line= 1:4,
                        text=c(123,123,123,123),
                        data=c(456,456,456,456))

################################### count() ####################################

count(heartDT, ChestPain, sort = TRUE)
count(heartDT, AHD, sort=TRUE)
count(heartDT, ChestPain, AHD)

################################### if_else()###################################

# shown above some examples

# if_else can be used replace factors or modify values or replace NA values
# if "Yes" is found will replace with "Sick", "No" replace with "Not Sick", 
# finally NAs values replace with "missing" 

heartDT$ExAng=if_else(heartDT$ExAng=="2", "1","0")
# this is very useful for ETL when we replace "M" with "Male" and so on to standardize data

heartDT$Sex=if_else(heartDT$Sex=="0","F", "M")
heartDT$Sex=if_else(heartDT$Sex %in% c("1","gay"), "reject", "0")


##################################### case_when() ##############################

heartDT$cats <- case_when(
  heartDT$Age >  30 & heartDT$Age <= 40  ~ "Middle",
  heartDT$Age >  40 & heartDT$Age <=50   ~ "older",
  heartDT$Age >  50 & heartDT$Age <=65   ~ "senior", 
  heartDT$Age >  65 & heartDT$Age <= 90  ~ "Super senior",
  heartDT$Age >  90 & heartDT$Age <= 125 ~ "Super Hero"
)

View(heartDT)

heartDT=select(heartDT, -11)


################################### distinct() and arrange() #####################

# distict() gives unique values or levels

distinct(heartDT, ExAng) # gives only 2 levels >> can also be seen in str()
distinct(heartDT, ExAng, AHD) # look at 2 variables at same time 
distinct(heartDT,ChestPain, AHD)
#like a table, but doesn't give the count

n_distinct(heartDT$Age) # gives the number of distinct Ages
n_distinct(heartDT$ExAng) # will give 2 for there are only 2 factors
n_distinct(heartDT$ChestPain)

# arrange() >> reshuffling of data

heartDTNEW9=arrange(heartDT, Age) # arrange all the rows by the Age var number
heartDTNEW9=arrange(heartDT, Age, MaxHR) # arrange by Age first then MaxHR
heartDTNEW9=arrange(heartDT, desc(Age)) # descending order

############################### chaining ###########################################
library(dplyr)
library(ggplot2)

heartDT %>% select(1:5) %>%
  mutate(Chol_class=Chol/20, RestBP_class=RestBP/5) %>%
  ggplot(aes(RestBP_class,Chol_class)) + geom_point()


heartDT %>% select(MaxHR) %>% 
  mutate(MaxHR_class=MaxHR/15) %>%
  ggplot(aes(MaxHR)) + geom_histogram(binwidth = 3, color = "black", fill = "red")


heartDT33=heartDT %>% select(1:5) %>%
  mutate(Chol_class=Chol/20, RestBP_class=RestBP/5)

################################### joins()#########################################

# just like in SQL >> look at infographic

A=data.frame(col1=c("A","B","C"), col2=c(seq(1:3)));
B=data.frame(col1=c("A","B","D"), col3=c("T","E","F"));


# Mutating Joins
left_join(A,B, by="col1")  #join matching rows from B to A
right_join(A,B, by="col1") # join matching rows from B to A
inner_join(A,B, by="col1") # join data, retain only rows in both sets)
full_join(A,B, by="col1") # join data, retain all values, all rows)

# Filtering Joins
semi_join(A,B, by="col1")  # all rows in A that have a match in B
anti_join(A,B, by="col1")  # all rows in A that do not have a match in B

################################### sample_n() and sample_frac() #################

sample_n(heartDT,10) # randomly choose 10 rows from heartDT dataset
sample_frac(heartDT, 0.30)  # randomly choose 30% of dataset

# split into test and train data for datascience
train=sample_frac(heartDT, 0.7)
sid=as.numeric(rownames(train)) # because rownames() returns character
test=heartDT[-sid,]

################################## top_n() #########################################

heartDT %>% select(Age) %>% top_n(20)

heartDT %>% select(Age) %>% 
  arrange(desc(Age)) %>%top_n(20)



# you can choose your own summary statistics

              summarize(heartDT,
                       count=n(),
                       avgAge=mean(Age, na.rm=TRUE),
                       sdAge=sd(Age, na.rm=TRUE),
                       medAge=median(Age, na.rm=TRUE),
                       Q3rdAge=quantile(Age, .75)
                        )


# AHD is the variable which we want to create groups ["positive", "negative"]
groupheartDTAHD=group_by(heartDT, AHD)
groupheartDTAHD2=group_by(heartDT, AHD, Fbs)
# can combine with  other function in R , dplyr

slice(groupheartDTAHD2, 1:5)  # gives top 5 rows in each group


# for demonstration we pass into summary statistics >> we get 4 groups
            summarize(groupheartDTAHD2,
                       count=n(),
                       avgAge=mean(Age, na.rm=TRUE),
                       sdAge=sd(Age, na.rm=TRUE),
                       medAge=median(Age, na.rm=TRUE),
                       Q3rdAge=quantile(Age, .75)
                        )

            
groupheartDTAHD3=group_by(heartDT, AHD, ChestPain)            
            
  summarize(groupheartDTAHD3,
          count=n(),
          avgAge=mean(Age, na.rm=TRUE),
          sdAge=sd(Age, na.rm=TRUE),
          medAge=median(Age, na.rm=TRUE),
          Q3rdAge=quantile(Age, .75)
)

                        
            
# we can modify our summary statsitics to filter off data
            summarize(groupheartDTAHD2,
                      avgAge35=mean(Age>35, na.rm=TRUE),
                      nobsAge35=sum(Age>35, na.rm=TRUE)
                      )
            

heartDT %>% group_by(AHD, ChestPain) %>% 
  summarize(count=n(),
            avgAge=mean(Age, na.rm=TRUE),
            sdAge=sd(Age, na.rm=TRUE),
            medAge=median(Age, na.rm=TRUE),
            Q3rdAge=quantile(Age, .75)
  )
            



