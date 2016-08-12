u <- c(5,2,8)
v <- c(1,3,9)
u > v


w <- function(x) return(x+1)
w(u)


sqrt(1:9)


y <- c(1.2,3.9,0.4)
z <- round(y)
z


round(1.2)


y <- c(12,5,13)
y+4
'+'(y,4)


f <- function(x,c) return((x+c)^2)
f(1:3,0)
f(1:3,1)
f(1:3,1:3)


f <- function(x,c) {
    if (length(c) != 1) stop("vector c not allowed")
    return((x+c)^2)
}


z12 <- function(z) return(c(z,z^2))
x <- 1:8
z12(x)

matrix(z12(x),ncol=2)
sapply(1:8,z12)
