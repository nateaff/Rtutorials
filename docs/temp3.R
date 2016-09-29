
a <- 1:5
a = 1:5 

a <- 1:5
b <- factor(letters[1:5])
c <- c("hey", "yo", "hi", "bye", "there")

alist <- list(a,b,c)
alist[[1]]
alist[[3]][3]

# make a data frame 
df <- data.frame(a,b,c)
df

df[1,2]
names(df)

df$a
rm(a)
attach(df)
detach(df)

with(df, plot(a))

df$a

df[,-2]

cols <- c(1,3)
df[,cols]

vec <- rnorm(20)
vec

samp1 <- sample(1:20, 10)
vec[samp1]
vec[-samp1]
mean(vec[samp1])
mean(vec[-samp1])

df[c(TRUE, FALSE, TRUE, TRUE, TRUE), ]




# from a set of vectors
name <- c("Bob", "Saghi", "Alice", "Elise", "Ciera", "Elijah")
age <- c(65, 23, 54, 10, 25, 32)
bloodtype <- factor(c("O", "AB", "A", NA, "A", "B"))
last_appt <- c(rep(Sys.Date(), 
          length(age))- floor(rnorm(length(age),365, 100)))

patients <- data.frame(name, age, bloodtype, last_appt)


# checking for na
sum(is.na(patients))
is.na(patients)
na.omit(patients)
# identify the observation that's a problem 
complete.cases(patients)

patients[!complete.cases(patients), ]

summary(patients)

lapply(list(df,patients), summary)


install.packages("readr", "dplyr")

#library(devtools)
library(readr, dplyr)
?dplyr::select

getwd()
setdir <- "/home/nathanael/data"
setwd()
dir()

curr_dir <- getwd()
curr_dir
filename <- "patients.txt"
filedir <- paste0(curr_dir, "/", filename)
filedir 

write.table(patients, filedir)

read.table(filedir)

library(readr)
read_table(filedir)

df2 <- read.table(filedir, stringsAsFactors = FALSE)

df2
summary(patients)

library(dplyr)
library(nycflights13)

summary(flights)

head(flights)

filter(flights, month == 2)
filter(flights, month == 2 & day == 1)

arrange(flights, year, month, day)
select(flights, year, month)

group_by(flights, dep_delay)



































