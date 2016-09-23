


# 

rm(f)

f <- function(x){

  # make a vector of length(x)
  out <- double(length(x))

  for(i in 1:length(x)){
    out[i] <- x[i] + 4
  }
  out
}

f(3)
f(1:4)


echo <- function(x){
  cat("this is the argument:", x, "\n")
}

x 
f2 <- function(x,y){
  x + y
}

y <- 3
f3 <- function(x){
  x + y
}

f4 <- function(x,y = 5){
  x + 2*y
}

cute <- function(x,a){
  sin(2*x) + 3*x^2 + a*cos(x) + 1/3 *a^3
}

ys <- cute(1:5, 5)
plot(cute(1:5, .02), type ='l')

xs <- seq(0,3, by = 0.01)
xs

ys <- cute(xs, 5)
plot(ys, type ='l')

cute <- function(x){
  sin(2*x) + 3*x^2 + 2*cos(x) + 1/3 *2^3
}

curve(cute)

f5 <- function(x){
  if(x == 4) {
    cat("its a four", "\n")
  } else {
    cat("its not a four", "\n")
  }

}

f5(1:20)

x <- c(4,4,4,4)
if(all(x == 4)){
    cat("its a four", "\n")
  } else {
    cat("its not a four", "\n")
  }


v <- 2:20


for(k in seq_along(v)){
  cat(k, "\n")
}


lapply(list, FUN)



somelist <- list(a= 1:3, b = 4:10, c= 1:10)

lapply(somelist, mean)
output <- lapply(somelist, summary)
output[[1]]

lapply(somelist, function(x) x+500)2

ext <- ".txt"
paste0("filename", ".txt")

lapply(1:5, function(x) paste0("filename", x, ".txt"))

apply(M, 1, avg)


# tapply 
rep(c("m", "f"), )




















































