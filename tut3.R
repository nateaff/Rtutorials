

# review : vectors and types
a <- 1:5
letters[1:5]
b <- factor(letters[1:5])
c <- c("hey", "hi", "yo", "sup", "g'day")

# create a list
alist <- list(a,b,c)
# returns a list
alist[3]
# returns the item
alist[[3]][5]


# create a data frame
df <- data.frame(a,b,c)
df
rm(df)

# indexing and subsetting
dim(df)
df[1,]
df[,2]
df[1,2]
# byl column name
df$a
# other methods
df[, -2]
df[-1, ]
df[c(TRUE, FALSE, TRUE), ]
df[c(1,3), 2:3]

# summary
head(df)
summary(df)
names(df)

# from a set of vectors
name <- c("Bob", "Saghi", "Alice", "Elise", "Ciera", "Elijah")
age <- c(65, 23, 54, 10, 25, 32)
bloodtype <- factor(c("O", "AB", "A", NA, "A", "B"))
last_appt <- c(rep(Sys.Date(), length(age))- floor(rnorm(length(age),365, 100)))
patients <- data.frame(name, age, bloodtype, last_appt)

# checking for na
sum(is.na(patients))
na.omit(patients)
# identify the observation that's a problem 
complete.cases(patients)
patients[!complete.cases(patients), ]


# review lapply(list, FUN )
nas <- lapply(patients, is.na)
lapply(list(df, patients), summary)

# add a column (check err)
random_nums <- floor(rnorm(6, 20, 5))
patients$nums <- random_nums

old_names <- names(patients)
names(patients) <- c("Names", "Age", "Bloodtype", "Last_appt", "ATP_level")
patients

# replace old names 
# names(patients) <- old_names

# write file
getwd()
dir()
setwd()
curr_dir <- getwd()
filename <- "patients.txt"
# check slash direction
file_dir <- paste0(curr_dir, "/",  filename)
write.table(patients, file_dir)

df1 <- read.table(file_dir)
df2 <- read.table(file_dir, stringsAsFactors = FALSE)


library(readr, dplyr)
# manipulation in dplyr
select(df2, -ATP_level)


library(nycflights13)

head(flights)
# filter() 
# arrange()
# select() 
# distinct()
# mutate() 
# summarise()

# January flights
filter(flights, month == 1)
filter(flights, month == 1 | month == 2)

distinct(flights, carrier)
arrange(flights, year, month, day)

arrange(flights, dep_delay)
group_by(flights, carrier)

mutate(flights, speed = distance/air_time * 60)

summarise(group_by(flights, carrier), 
          arr_delay = mean(arr_delay))


summarise(group_by(flights, carrier), 
          arr_delay = mean(arr_delay, na.rm = TRUE))



# plotting data

by_tailnum <- group_by(flights, tailnum)
delay <- summarise(by_tailnum,
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  arr_delay = mean(arr_delay, na.rm = TRUE))
delay <- filter(delay, count > 20, dist < 2000)

with(delay, plot(dist, arr_delay, pch = 16, 
    cex = 0.5 + 5*count/max(count),  
    col = rgb(.1,.1,.1,0.4) ))
lines(with(delay, loess.smooth(dist, arr_delay)), 
  col = "blue", lwd = 3, lty = 3)

## This example has duplicate points, so avoid cv = TRUE

library(ggplot2)
# Interestingly, the average delay is only slightly related to the
# average distance flown by a plane.
ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size = count), alpha = 1/2) +
  geom_smooth() +
  scale_size_area()











