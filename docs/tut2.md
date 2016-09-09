

# Control structures and Functions

This tutorial will cover basic control structures in R, writing functions and some the `apply` family of functions.
I assume some basic familiarity with programming such as a first class in programming.

## Control structures

Control structures determine the flow of execution in a program. The most basic example of controlling program flow is branch on some condition. 

```
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

## Vectorized function

## Functions

## apply functions


Dataframe

