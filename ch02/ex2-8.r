z <- c(5,2,-3,8)
w <- z[z*z > 8]
w

z*z > 8

">"(2,1)
">"(2,5)

z[c(TRUE,FALSE,TRUE,TRUE)]


z <- c(5,2,-3,8)
j <- z*z > 8
y <- c(1,2,30,5)
y[j]


z <- c(5,2,-3,8)
y <- c(1,2,30,5)
y[z*z > 8]


x <- c(1,3,8,2,20)
x[x > 3] <- 0
x


x <- c(6,1:3,NA,12)
x
x[x > 5]
subset(x,x > 5)


z <- c(5,2,-3,8)
which(z*z > 8)


first1 <- function(x) {
    for (i in 1:length(x)) {
        if (x[i] == 1) break  # break out of loop
    }
    return(i)
}

first1a <- function(x) return(which(x == 1)[1])
