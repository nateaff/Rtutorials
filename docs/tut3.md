# Data Frames


## Aside from last sesson

A couple things that came up in the last session that I said I'd post answers to so here they are. 

** What functions are available at start-up** 

There are a number of default settings in R that can be adjusted. I'd recommend leaving them as or reading up on how the options function before making changes. Settings can be changed in an .Rprofile. 

To view default options you can use the `options()` command. 

```
# check which packages are loaded at start-up
options()$defaultPackages

# look at functions available in a package
  library(help = base)
  library(help = stats)

``` 

Here's [a list from Hadley Wickham](http://adv-r.had.co.nz/Vocabulary.html) if you are interested in expanding your function vocabulary

The first two on that list are, `?` and `str`. 

### Getting packages

So far we haven't been using any package. If you're searching for a topic Google is a good choice. There is also the [CRAN taskview](https://cran.r-project.org/web/views/), or Microsoft's version, the [MRAN taskview](https://mran.microsoft.com/taskview/).

Rstudio also has a built in panel for searching for and installing libraries. 

We'll start off with three packages that make data manipulation easier. These come from the so-called tidyverse:

```
  # install packages
  install.packages("dplyr", "readr", "stringr")

  # look at functions in dplyr
  library(help = dplyr)

```
# Review 

A quick review on creating vectors and lists
```

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

```


## Data frames

A data frame is basically a list with equal vectors of items of a single type (the columns). 

Here's a very simple data frame which we make from the vectors we created above

```

  # create the vectors if you haven't already
  a <- 1:5
  letters[1:5]
  b <- factor(letters[1:5])
  c <- c("hey", "hi", "yo", "sup", "g'day")


  # create a data frame
  df <- data.frame(a,b,c)
  df

```
  The names of the columns default to the variable names of the vectors the data frame was created

### Simple indexing and subsetting

Subsetting follows similar rules to what we've seen with matrices. Note that if you subset a single column of a data frame you still have a data frame. 

```
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
  #logical subsetting
  df[c(TRUE, FALSE, TRUE), ]
  
  # subset with vectors
  df[c(1,3), 2:3]


```

We'll make a slightly larger data frame to demonstrate som

```
  # from a set of vectors
  name <- c("Bob", "Saghi", "Alice", "Elise", "Ciera", "Elijah")
  age <- c(65, 23, 54, 10, 25, 32)
  bloodtype <- factor(c("O", "AB", "A", NA, "A", "B"))
  last_appt <- c(rep(Sys.Date(), length(age))- floor(rnorm(length(age),365, 100)))
  
  patients <- data.frame(name, age, bloodtype, last_appt)

  # summary
  head(patients)
  summary(patients)
  names(patients)
```
### Looking at NA values
There are many ways of dealing with NA values. The simplest is just to remove columns. Here we look at a few basic ways of checking for missing values.

```
  sum(is.na(patients))
  na.omit(patients)
  # identify the observation that's a problem 
  complete.cases(patients)
  patients[!complete.cases(patients), ]

```
The `complete.cases` function is useful for looking at observations (rows) that have no NA values. 

The `lapply` function can also be used on lists of data frames. This can be a pretty powerful method for applying functions to multiple similar data frames. You need to make sure the operations are valid on the columns they're applied to, of course.

```
  # review lapply(list, FUN )
  nas <- lapply(patients, is.na)
  lapply(list(df, patients), summary)

```
It's easy to add columns to data frames, or to get and change column names. 

```  
  # add a column (check err)
  random_nums <- floor(rnorm(6, 20, 5))
  patients$nums <- random_nums


  old_names <- names(patients)
  names(patients) <- c("Names", "Age", "Bloodtype", "Last_appt", "ATP_level")
  patients

  # replace old names 
  # names(patients) <- old_names
```

## Reading and writing files

Here we go over a simple case of reading and writing files. For most school projects you're likely to be given nice clean data to load. Once you're using data from a wider range of sources, you'll need to be able to check more carefully the formatting of the file before loading.

First we figure out where R has been loaded. In this example I'm just saying to the current directory R is in. In other cases you mean need to load or save to a directory using relative or absolute file paths.

```

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

```

# Dplyr Vignette
It's good to be familiar with all the ways of manipulating data frames in base R and if you are minimizing dependencies of you code you might want to stick to base R functions for common tasks. 

`dplyr` is a package written by Hadley Wickham that has a number of convenient tools for manipulating data frames. 

Out of laziness and to demonstrate where to find good examples, this example is taken from the very good vignette provided for the dplyr package. Find the [whole thing here](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)

```
library(readr, dplyr)
# manipulation in dplyr
select(df2, -ATP_level)

```


```
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
mutate(flights, speed = distance/air_time * 60)
```



```
group_by(flights, carrier)


summarise(group_by(flights, carrier), 
          arr_delay = mean(arr_delay))


summarise(group_by(flights, carrier), 
          arr_delay = mean(arr_delay, na.rm = TRUE))

```

In the next example, these operations are combined. We group data by the plane tail_num and then create a summary data frame using `summarise`. The `n()` is a dplyr utility function that counts the number of observations for a given factor. 

```
# plotting data

  by_tailnum <- group_by(flights, tailnum)
  delay <- summarise(by_tailnum,
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    arr_delay = mean(arr_delay, na.rm = TRUE))
  delay <- filter(delay, count > 20, dist < 2000)

  head(delay)

  with(delay, plot(dist, arr_delay, pch = 16, 
      cex = 0.5 + 5*count/max(count),  
      col = rgb(.1,.1,.1,0.4) ))
  lines(with(delay, loess.smooth(dist, arr_delay)), 
    col = "blue", lwd = 3, lty = 3)

```

My previous plot was a partial attempt to mimic the ggplot that is demonstrated in the ddplyr vignette.


```
  ## This example has duplicate points, so avoid cv = TRUE
  library(ggplot2)

  # Interestingly, the average delay is only slightly related to the
  # average distance flown by a plane.
  ggplot(delay, aes(dist, delay)) +
    geom_point(aes(size = count), alpha = 1/2) +
    geom_smooth() +
    scale_size_area()

```