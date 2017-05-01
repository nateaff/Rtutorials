
# Introduction to R : Tutorial 1 (9/)

# where you are
getwd()
?setwd()
dir()


# arithmetic
5 + 12
20 * 3 - 5/2
4^2


# assignment
x <- 13*2
y <- 5
# or 
z = x + y
z 

(x <- 15 )
# modulus
( y <- 20 %% 3)

((20 %% 5)^2 +  1/2) * 2

## Getting help
?sum


# get help
?"%%"

# **Exercise**
# What does the "%/%" operator do? Use the help or experiment. 


## Basic data types

# 1. Double
# 2. Logical
# 3. Character
# 4. Integer
# 5. Complex

5.5             # double
TRUE == FALSE   # logical
5 == 2          # returns a logical
"a"             # character
"hello"         
2L              # integer


## Vectors

x <- 4.4
is.vector(x)

# double
(vec <- c(0, 1, 2, 3, 4))
vec <- c(0, 1, 2); vec

length(vec)
mode(vec)
is.numeric(vec)
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

# concatenation
vec2 <- c(1, 2, 3, int_vec)

# create a vectors of length 10 with default values
character(10)
logical(10)
double(10)

# an alternative method 
x <- vector(mode = "double", length = 10)

# this works the same as the previous command
x <- vector("double", 10)

## Factors

# create factors from characters
factor_vec <- factor(c("a", "b", "c"))
levels(factor_vec)

# coerce a character vector to a factor
name_vec <- c("Sue", "Saghi", "Eileen", "Fred", "Fred", "Sue")

# show unique names: 
unique(name_vec)
(name_factors <- as.factor(name_vec))

#access levels
levels(name_factors)
levels(name_factors)[2]

# a common way to create a factor vector
rep(c("Sue", "Saghi", "Eileen"), 3)
rep(c("Sue", "Saghi", "Eileen"), each = 3)

# combining the operations
factor(rep(c("Sue", "Saghi", "Eileen"), 3))



# Special values 
na_vec <- c(1, 2, 3, 4, NA)
is.na(na_vec)

sum(na_vec)
# sum after omitting na values
sum(omit.na(na_vec))

# sum a subset
sum(na_vec[1:4])


## Operations with `NA`'s will return `NA`.

1 + NA 
2 * NA

2 + Inf
2 / Inf 
Inf - Inf

is.null(NULL)

### Subset an atomic vector

# letters is a built-in R variable
letters[1:20]
abcs <- LETTERS[1:5]
abcs[1:2]
# omit the third element
abcs[-3]
# select based on a vector
abcs[c(1, 3, 5)]

## logical vector subsetting

# set a seed for reproducible random number generation
set.seed(1)

numbers <- rnorm(10, mean = 0, sd = 10)
# returns logical vector
numbers > 10
# using the logical vector to subset
numbers[numbers > 10]

names(numbers)
names(numbers) <- letters[1:length(numbers)]
numbers["a"]

# A few examples of useful functions:

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


# --- Lists

# create list
mylist <- list(numbers  = rnorm(10, 4, 3), letters[1:20])
names(mylist)

# change name of second element
names(mylist)[2] <- "letters"
names(mylist)

# list subsetting

mylist$numbers
list1 <- mylist[1]
is.vector(list1)

vec1 <- mylist[[2]]
is.vector(vec1)



# Matrices 

matrix(c(1, 2, 3, 4))

matrix(1:4, nrow = 2, ncol = 2)
matrix(1:4, nrow = 2, ncol = 2, byrow = TRUE)

M <- matrix(rnorm(16), ncol= 4, nrow = 4, byrow = TRUE)
M
# Operations
M %*% M

M * M
M ^ 2

solve(M)

dim(M)

# access an element
M[1, 2]

# access a row
M[, 1]


# Retrieving a column of a matrix returns a vector, not a matrix.

is.matrix(M[, 1])
is.vector(M[, 1])



# --- data frame basics
# some vectors of the same length
abc <- LETTERS[1:3]
nums <- rpois(3, 10)
facs <- factor(c("red", "green", "blue"))

# create a data frame
df <- data.frame(abc, nums, facs)

# add a column 
df$ints <-  3:5

# summaries of data 
summary(df)
head(df)
names(df)

#replace names
names(df) <- c("letters", "numbers", "factors", "integers")
df
row.names(df)

# subsetting
df[1,2]

df[1]
is.vector(df[1])
is.vector(df[[1]])

is.list(df)
is.data.frame(df)
mean(df[, 2])
sum(df[, 2])

# add a column 
df$ints <-  3:5



# --- simulate a die role
set.seed(1)
die <- 1:6
# this does not work
sample1 <- sample(die, 1)


# --- plot example
plot(sample1)


# save defaults
oldpar <- par 

# set number of rows, columns with mfrow
par(mfrow = c(1, 3))

hist(rolls)
hist(sample1)
hist(sample1)
# restore defaults
par <- oldpar

n1 <- rnorm(10000, mean = 3, sd = 1.5)
n2 <- rnorm(10000, mean = -4, sd = 2)
n3 <- rnorm(10000, mean = 2, sd = 5)

hist(c(n1, n2, n3), col = "gray30", border = "white")

p1 <- hist(n1)
p2 <- hist(n2)
p3 <- hist(n3)

d1 <- density(rnorm(10000, mean = 3, sd = 1.5))
d2 <- density(rnorm(10000, mean = -4, sd = 2))
d3 <- density(rnorm(10000, mean = 2, sd = 5))

plot( p1, col="green", xlim=c(-20, 20), xlab = "",
main = "Mixture of Gaussians" )
plot( p2, col=rgb(1, 0, 0, 1/8), xlim=c(-20,20), xlab = "", add=TRUE) 
plot( p3, col=rgb(0, .7, 0, 1/8), xlim=c(-20,20), xlab ="", add=TRUE)  

# a simple plot function

add_density <- function(dens, color){
  par(new = TRUE)
  plot(dens, col = color, xlim = c(-20, 20), ylab ="", xlab="",main="", yaxt = "n", xaxt= "n")  
}

add_density(d1, "blue")
add_density(d2, "red")
add_density(d3, "green")


