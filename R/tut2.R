# Run this as a reminder to use "TRUE"
T <- FALSE
# You can't do this: 
TRUE <- FALSE
# Check reserved words: 
?Reserved


# fname <- function(arg1, arg2, arg3 = default.value, etc.){
#   function.body
# }

# example 1
echo <- function(arg) { 
  cat(arg, "\n")
}

echo("arrrrrrrg")


# example 2 
add <- function(a, b) {
  cat("a: ", a, ", b:" b, "\n")
  a + b  
}

add(3,3)

# with an explicit return function

add2 <- function(a,b){
  res <- a + b
  return(res)
}

add2(2,3)

# ---- Control structures

# if()
# example 1
x = 5

(x==4)


if(x == 4) {
  cat("its a four", "\n")
} else {
  cat("its not a four", "\n")
}


#----- Relational operators
== 
!=     
<= 
>=

# example 2
(20 < 10)

#
if(20 < x) cat(x, " is greater than 20") 

# ---- Logical operators
!
& 
&&
| 
||


if(!(20 < x))

# & operator  
x <- 1:10
x[(x > 3) & (x<2)]

# vector equality 

x <- 1:10
y <- 1:10
all(x == y)


# Ternary operator
a = 2
ifelse( a==2, "two", "not two")
a = 3
if(a==2) "two" else "not two"


# for loops

for(k in 1:10){
  a = 5
  cat( paste("iteration:", k, sep = " "), "\n")
}


k = 1
while(k <= 1024){
  cat( paste("product:", k, sep = " "), "\n")
  k = k*2
}

# Using seq_along

# this behavior is unexpected for a zero length vector
xx <- NULL
for(k in 1:(length(xx))){
cat("k: ", k, "\n")
}

for(k in seq_along(xx)){
cat("k: ", k, "\n")
}

xx <- 3:20
length(xx)
new_vec <- double(length(xx))
for(k in seq_along(xx)){
cat("k: ", k, "\n")
new_vec[k] <- k + 5
}
new_vec



# ------- applying functions to vectors

f <- function(x){
sin(x) + cos(2*x)
}
x <- 3
f(3)
x <- seq(0,2, by = 0.1)
f(x)

# simple plot 
plot(f(x), type = 'l', col = "blue", lwd = 2)

# ----- default values

pow1 <- function(a, b = 1){
a^b
}

pow1(1,2)
pow1(2)

# can change order if you name the argument
pow1(b=1, 2)


# R searches environment hierarchy in which 
# a variable was created

x <- 100
f <- function( ) {
y <- 2
c(x, y)
}
f()
rm(f)


# Another vector example

fill_NAs <- function(v){

ind <- is.na(v)
mu <- mean(v, na.rm = TRUE, trim = 0.1)
v[ind] <- mu
return(v)
}

vec <- c(1:5, rep(NA, 5), 3:10)
fill_NAS(vec)


# Functionals

# replicate
replicate(n, expr, simplify = "array")


expr1 <- rnorm(10, 0, 1)

df <- data.frame(replicate(5, expr1))
df
# we can't do this
mean(df)

# ------ apply, lapply, tapply

# we can do this
apply(df, 2, mean)
apply(df, 1, mean, trim = 0.1)

# using a matrix
M <- as.matrix(df)
apply(M, 2, sd)

# tapply

# tapply example
# generate two vectors of equal length (tapply will recycle if not)
countries <- c( rep("US", 13), rep("UK", 17), rep("FR", 10))
len <- length(countries)
medals <- sample(c(0,1), len, replace = TRUE)
ages <- rpois(len, 26)

len; medals; population

# apply sum 
tapply(medals, factor(countries), sum)
tapply(ages, factor(countries), mean)
tapply(ages, factor(countries), summary)

# ---- lapply

# lapply if it were a function (from "Advanced R")
lapply2 <- function(x, f, ...) {
out <- vector("list", length(x))
for (i in seq_along(x)) {
  out[[i]] <- f(x[[i]], ...)
}
return(out)
} 



# A list of vectors of different size
vec_list <- list(a = c(1:10, NA), b = 2:20, c = 3:40, d = 5:50)

lapply(vec_list, sum)
lapply(vec_list, mean)

# remove NA's before computing means
lapply(vec_list, mean, na.rm = TRUE)
lapply(vec_list, sd, na.rm = TRUE )

res <- lapply(vec_list, sd, na.rm = TRUE )
unlist(res)



# ------ anonymous functions
(function(x) x*2)(2)
lapply(vec_list, function(x) x*2)



# paste/paste0 functions
paste0("filename", 1, ".csv")

# create a list of file names
dflist <- lapply(2:10, function(x) paste0("filename", x, ".csv"))
dflist

# seq
seq(2, 20, by = 4)
nums <- seq(2, 20, by = 4)

# repeating above with a different sequence
dflist <- lapply(nums , function(x) paste0("filename", x, ".csv"))
dflist


```

# We'll take an example 
# [from here](https://www.countbayesie.com/blog/2015/3/3/6-amazing-trick-with-monte-carlo-simulations) of running a simple simulation to test of the difference of two observations are significant. 


# generate samples from the distributions
runs <- 100
rbeta(runs, 38, 110)
rbeta(runs, 20, 100)

# vary the number of runs and compute the percent of winners

sig_test <- function(runs){
a <- rbeta(runs, 38, 110)
b <- rbeta(runs, 20, 100)
p_val <- 1- sum(a > b)/runs
return(p_val)
}

# check time
system.time(pval1 <- sig_test(1000))
system.time(pval2 <- sig_test(100000))

make_pow <- function(n){
function(a){
  a^n
}
}


# ----- closure example

pow3 <- make_pow(3)
pow4 <- make_pow(4)
is.function(pow3)

pow3(2)
pow4(3)

# create a list of functions
pows <- lapply(5:10, make_pow)
# pass the functions to the anonymous function to evaluate
lapply(pows, function(x) x(2:4))
