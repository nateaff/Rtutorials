 
 

# Control structures and Functions

This tutorial will cover basic control structures in R, writing functions and some the `apply` family of functions.
I assume some basic familiarity with programming such as a first class in programming.


## A simple function

We'll start off with the structure of a basic function and then build on that once we've gone over some control structures. 

Here is the basic syntax of a function: 

```
fname <- function(arg1, arg2, arg3 = default.value, etc.){
  function.body
}

```

The function defined in the function body will be assigned to the variable `fname`. The arguments : `arg1, arg2, arg3` are the values passed to the function and available to operations in the function body.


Here's a simple example:

```
echo <- function(arg ){ 
  cat(arg, "\n")
}

echo("arrrrrrrg")

```

You can define a function on a single line without brackets, but for now I'd recommend using brackets to define the function body. 

The `cat` function writes its argument to the console and it can take a combination of strings and variables. (The `"\n"` is equivalent to hitting return after writing a sentence).

Here's another simple example: 
```{r}
add <- function(a,b){
  a + b
}

add(3,3)

# with an explicit return function

add2 <- function(a,b){
  res <- a + b
  return(res)
}

add2(2,3)

```


## Control structures

Control structures determine the flow of execution in a program. The most basic example of controlling program flow is branch on some condition. 

```{r}
  x = 5

  if(x == 4) {
    cat("its a four")
  } else {
    cat("its not a four")
  }

```
The "==" is a relational operator that checks for equality. The relational operators are

```
  == 
  !=     
  <= 
  >=

```
and the logical operators are
```
  !
  & 
  &&
  | 
  ||
```
  
The "&" is the logical and operator and checks if both sides of an inequality are true and the "|" is the "or" operator. These act element wise and will return a logical vector if multiple values are becking checked. 

```
x <- 1:10
x[(x > 3) & (x<2)]
```

The double operators _only check the first element_. In control flow statements (`if, while`) where only one element is being compared either can be used. See documentation or the answers to [this stackoverflow](http://stackoverflow.com/questions/6558921/r-boolean-operators-and) question for more information (be sure to read more than the first response). 

There is a ternary operator in `R`. Here's a comparison of using the ternary operator and one using `if ... else` syntax. 

```
a = 2
ifelse( a==2, "two", "not two")
a = 3
if(a==2) "two" else "not two"

```

In the last statement no brackets were needed if the following statement is completed on the same line. I would recommend using brackets unless you have a strong preference or until you have more experience programming.


## for, while, switch statements

All for loops can be written as while loops and all while loops as for loops. 

For loops are usually used to iterate over an index or some number of elements in an array or vector. 

```
for(k in 1:10){
  a = 5
  cat( paste("iteration:", k, sep = " "), "\n")
}

k = 1
while(k <= 1024){
  cat( paste("product:", k, sep = " "), "\n")
  k = k*2
}

```

There is another way to create for loops that can be safer then the `for` syntax mentioned above. 


```
# seq_along

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

```
The `seq_along()` function can be used to iterate over structures that have some length or dimension.


## `apply` type functions

First we'll introduce the replicate function. 

Here's the usage from the documentation:

```
replicate(n, expr, simplify = "array")

``` 
The `expr` is some expression that is evaluated `n` times. Here I use it to create a data frame.

```
expr1 <- rnorm(10, 0, 1)

df <- data.frame(replicate(5, expr1))
df
# we can't do this
mean(df)

# we can do this
apply(df, 2, mean)
apply(df, 1, mean, trim = 0.1)

# using a matrix
M <- as.matrix(df)
apply(M, 2, sd)
```

Here is the function usage 
`apply(X, MARGIN, FUN, ...)` 

`X` is an array structure, a data frame or a matrix, for example.  The margin is the (1 for rows and 2 for columns), and FUN is the function you want to apply to the columns.

The `...` means additional arguments can be passed the function. In the above example `trim = 0.1` is an argument to the mean function. 

There is a family of apply style functions. The `lapply` function operates on lists, `tapply` can operate on a vector where operations are grouped based on second index argument.


Here's a R version of `lapply` from [Advanced R](http://adv-r.had.co.nz/Functionals.html) which gives the idea of what the function does under the hood.

```
lapply2 <- function(x, f, ...) {
  out <- vector("list", length(x))
  for (i in seq_along(x)) {
    out[[i]] <- f(x[[i]], ...)
  }
  out
}

```

Here's an example of operating on a list: 

```
# A list of vectors of different size
vec_list <- list(a = c(1:10, NA), b = 2:20, c = 3:40, d = 5:50)

lapply(vec_list, sum)
lapply(vec_list, mean)

# remove NA's before computing means
lapply(vec_list, mean, na.rm = TRUE)
lapply(vec_list, sd, na.rm = TRUE )

res <- lapply(vec_list, sd, na.rm = TRUE )
unlist(res)
```

The `lapply` function returns a list of the length of the list passed to the function. The `unlist` function can be used to create a vector of the results. 

User defined functions can also be used. In addition, you can define _anonymous functions_ that are defined with the lapply argument. Here is the syntax:

```
# anonymous functions
(function(x) x*2)(2)
lapply(vec_list, function(x) x*2)


``` 



```
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

There are also 

## Functions

We've already seen the basic form of a function. Here we add a few more details and create some more complex functions. 

Many of the base R functions have arguments with default values. You can also add default values to your functions.

```
# default arguments
def0 <- function(a, b = 1){
  a^b
}

def0(1,2)
def0(2)

# can change order if you name the argument
def(b=1, 2)

```
The arguments will be evaluated based on their position unless they are named. 

If a variable isn't defined in a function R will look the next level up based on the environment in which the function was created.

```
  x <- 100
  f <- function( ) {
    y <- 2
    c(x, y)
  }
  f()
  rm(f)

```

For loops are known for being slow in R and you can often rewrite a for loop using a vectorized function using a `apply` type function. 

```

  fill_NAs <- function(v){
    
    ind <- is.na(v)
    mu <- mean(v, na.rm = TRUE, trim = 0.1)
    v[ind] <- mu
    return(v)
  }

  vec <- c(1:5, rep(NA, 5), 3:10)
  fill_NAS(vec)

```


We'll take an example 
[from here](https://www.countbayesie.com/blog/2015/3/3/6-amazing-trick-with-monte-carlo-simulations) of running a simple simulation to test of the difference of two observations are significant. 

Here's the setup : 
> Let's suppose we're comparing two webpages to see which one converts our customers to "sign up" at a higher rate (This is commonly referred to as an A/B Test). For page A we have seen 20 convert and 100 not convert, for page B we have 38 converting and 110 not converting. We'll model this as two Beta distributions as we can see below:

```
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
system.time(pval1 <- sig.test(1000))
system.time(pval2 <- sig.test(100000))

```

## Closures

You can also create functions that return functions based on input. 

```
make_pow <- function(n){
  function(a){
    a^n
  }
}

pow3 <- make_pow(3)
pow4 <- make_pow(4)
is.function(pow3)

pow3(2)
pow4(3)

# create a list of functions
pows <- lapply(5:10, make_pow)
# pass the functions to the anonymous function to evaluate
lapply(pows, function(x) x(2:4))

``` 
