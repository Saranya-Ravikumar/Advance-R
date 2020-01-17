library(readr)


#### read columns

names2=read_csv(file.choose())






####### writing files

write_csv(file,"filepath.csv")


# parse as factors
names2$disease=parse_factor(names2$ChestPain, levels=c("asymptomatic", "nontypical", "nonanginal","typical"))


