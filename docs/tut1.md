

# Introduction to R: Basic data types and operations

This tutorial covers the basic data types and structures in R along with an introduction to common functions and operators. This should be suitable to someone just starting out in R but I try to go into a little more detail than the common introductory tutorial. 

For this tutorial you'll need R installed. During the class I won't be going over installation of R or Rstudio but I've included some notes below on installing and using Rstudio for reference.

## Installing R and Rstudio

 I would also recommend using Rstudio as your programming environment or IDE (integrated development environment). 

1. Install R : [Berkeley CRAN mirror](http://cran.cnr.berkeley.edu/) 
2. Install Rstudio following the instructions [here](https://www.rstudio.com/products/rstudio/download2/).

### RStudio layout

There is a visual introduction to the four default panes in Rstudio [here](https://wiki.mobilizingcs.org/rstudio/panes). 

To begin with we will mostly be using the editor (top left panel) and the console, which is below the editor. 

### Some recommended Rstudio settings:

Under *Tools*->*Global Options* unselect the options: "Always save history", and "Restore .RData into workplace at startup". 

These settings will let you start a new R session without data and variables saved from a previoussession loaded into the global environment. 

*Useful shortcuts*

* Ctrl + Enter : (in editor) run highlighted lines in console
* Ctrl + uparrow : (in editor) See previous commands run in console

*Saving your session*

I'd recommend using the editor for running most commands. Particularly when starting, saving commands from a session is a useful way to review what you've learned. 

*** 

# Basic data types 

Most data types in `R` can be though of has

1. Vectors or arrays of a single data type
2. Lists which contain multiple data types

For more on data types try Hadley Wickham's [Advanced R](https://adv-R.had.co.nz). (Many of the examples and notes below are taken from this book.)

## `R` as a calculator

Here are some basic arithemetic operations in `R`. 

```
  5 + 12
  20 * 3 - 5/2
  4^2
```

You can assign values to a variable in two ways

```
  x <- 13*2
  y <- 5
  x + y
```
The value of the computation is not displayed if when assigned to a 
variable. You can display it by using parentheses:

```
  (x <- 15 )
  ( y <- 20 %% 3)
```

`%%` is the modulus operator, it returns the remainder after division. 

The order of operation determines which operator is evaluated first in a compound operation. To be safe, you can use parentheses to group operations: 

```
  ((20 %% 5)^2 +  1/2) * 2
```

## Getting help
A fast way to look up help for a function in the R console. Type a question mark followed by the function:

```
  ?sum
```

The arithmetic operators are also function, and you can look up the documentation for them by putting the operator in quotes.
```
  ?"%%"

```


**Exercise**
What does the "%/%" operator do? Use the help or experiment. 

## Getting help part 2

The help documentation can be found using the console (which is fast), using the help panel in Rstudio, and is also online. Googling specific questions can also lead to good answers. [http://stackoverflow.com] has a large group of users and you can find some questions answered by expert users. 



## Primitive types

A vector is an array or ordered sequence of elements. In R, vectors are ordered arrays that contain a single type. 

There are five _atomic_ types in R. Many operations on vectors of atomic types are implemented in C(a fast, lower level programming language). 

1. Double
2. Logical
3. Character
4. Integer
5. Complex

Below the "==" operator check for equality between elements.

```
  5.5             # double
  TRUE == FALSE   # logical
  5 == 2          # returns a logical
  "a"             # character
  "hello"         
  2L              # integer
```
 

## Vectors

In `R` all atomic types can be thought of as vectors. A single element is a single length vector. 

```
  x <- 4.4
  is.vector(x)
```

This means that most functions that operate on atomic elements also operate on vectors.  

The most common way of creating vector can be created using the `c( )` function. Vectors by default have a _mode_ and a _length_. The mode describes the atomic type of the vector and allows you to check vector types. 

For many base types there are functions to check the type "is.[type]".


```
  # double
  (vec <- c(0,1,2,3,4))
  length(vec)
  mode(vec)
  is.numeric(vec)s
  is.double(vec)

  # generate seqeunce
  1:6

  # character
  char_vec <- c("a", "b", "c")
  mode(char_vec)
  length(char_vec)
  is.character(char_vec)

  # integer type
  int_vec <- c(1L, 2L, 3L)
  is.numeric(int_vec)
  levels(int_vec)

  # boolean or logical 
  bool_vec <- c(TRUE, FALSE, TRUE, FALSE)
  is.logical(bool_vec)

```

Vectors of the same primitive type can be concatenated.

```
vec2 <- c(1,2,3, int_vec)

```

Repeatedly concatenating vectors is computationally inefficient since `R` will need to allocate new space each time you increase the size of the vector. 

If you know how many elements will be added to a vector you can preallocate space in a few ways.

```
# create a vectors of length 10 with default values
  character(10)
  logical(10)

  double(10)

  # an alternative method 
  x <- vector(mode = "double", length = 10)

  # this works the same as the previous command
  x <- vector("double", 10)

```


### Factors

Factors are the other most commonly used class of objects in R.
In addition the mode and length, factors have a levels attribute which records the unique values of the factor. All types of vectors can be coerced to factor vectors. 

**Coercion** means altering the type of the vector. The common syntax for chaning types in `R` is `as.atomictype`. For example: `as.double`, `as.character`, etc.


```
  # create factors from characters
  factor_vec <- factor(c("a", "b", "c"))
  levels(factor_vec)
```
### stringsAsFactors

One of the common ways of loading data in R, the `read.table` and `read.csv` functions, has a default setting that coerces all characters columns as factors, the infamous `stringsAsFactors == TRUE` setting. We'll return to this later but it's something to watch out for. 


### Special values 

Several special values in R are worth kowing: 
_NA, Inf, NaN, NULL_. 

`NA` is R's type for missing values. Some built-in functions handle `NA`s silently but most arithemtic functions are undefined on `NA`s

```
  na_vec <- c(1,2,3,4, NA)
  is.na(na_vec)

  sum(na_vec)
  # sum after omitting na values
  sum(omit.na(na_vec))

  # sum a subset
  sum(na_vec[1:4])

```

### Subset an atomic vector

In the last example we used brackets to access a subset of the vector, elements (1,2,3,4). In R, vector indexing begins with 1, and elements can be accessed using the bracket operator "[]". 


```
  # letters is a built-in R variable
  letters[1:20]
  abcs <- Letters[1:5]
  abcs[1:2]
  # omit the third element
  abcs[-3]
  # select based on a vector
  abcs[c(1,3,5)]

```
A very common way of subsetting vectors is through logical vectors based on some condition. 

```
  # set a seed for reproducible random number generation
  seed(1)

  numbers <- rnorm(10, mean=0, sd =10)
  # returns logical vector
  numbers > 10
  # using the logical vector to subset
numbers[numbers > 10]
```

Less commonly used, you can also assign names to a vector
```
  names(numbers)
  names(numbers) <- letters[1:length(numbers)]
  numbers["a"]
```

### Exercise 
Find the letters of the `numbers` vectors corresponding to positions that are less than -10.  



## Operations on vectors

Many base functions in `R` act on vectors  by default. 

A few examples of useful functions:

```
  median(vec)
  mean(vec)
  sum(vec)
  var(vec)
  sd(vec)
  max(3:10)
  min(5:10)
  range(1:20)
  quantile(1:20)
  summary(1:20)
```
## Exercises

How do you select a specific quantile with the `quantile` function?

Run the examples from the `quantile function` documentation.


## Lists

Along with vectors, lists are the most common data structure in R. Unlike vectors, they can hold multiple types. 

```
  # create list
  mylist <- list(numbers  = rnorm(10, 4, 3), letters[1:20])
  names(mylist)

  # change name of second element
  names(mylist)[2] <- "letters"
  names(mylist)

```
You can access elements by name or by brackets. You need to use a double bracket "[[.]]" to access the element. A single bracket returns a list that contains that item.

```
  mylist$numbers
  list1 <- mylist[1]
  is.vector(list1)

  vec1 <- mylist[[2]]
  is.vector(vec1)

```

*** 

# Simulation exercise

In this exercise we use what you've learned so far to simulate 10, 100 and 1000 roles of a die

Steps:

1. Create a vector that represents the roles of a single die
2. Use the `sample()` function to make three vectors that simulate 10, 100 and 1000 rolls of the die.
3. Compare the mean of each simulation to the analytic mean
4. Plot them next to each other using the `barplot()` function.


```
  seed(1)
  die <- 1:6
  # this does not work
  sample1 <- sample(die, 10)
```

Read function docs or follow examples to enable repeated sampling. 

### Plotting

Base plot with one vector will use the index as the _x_ value:
```
plot(sample1)

```

We can use `barplot()` to plot the three simulations. The `par` variable holds some graphic parameters for plotting in base R (the default plotting functions). We can create multiple plots by changing the `mfrom` setting. 


```
  # save defaults
  oldpar <- par  
  # set number of rows, columns with mfrow
  par(mfrow = c(1,3))
  barplot(sample1)
  barplot(sample1)
  barplot(sample1)
  # restore defaults
  par <- oldpar

```

