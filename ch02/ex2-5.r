x <- 1:10
any(x > 8)
any(x > 88)
all(x > 88)
all(x > 0)


findruns <- function(x,k) {
    n <- length(x)
    runs <- NULL
    for (i in 1:(n-k+1)) {
        if (all(x[i:(i+k-1)]==1)) runs <- c(runs,i)
    }
    return(runs)
}

y <- c(1,0,0,1,1,1,0,1,1)
findruns(y,3)


findruns1 <- function(x,k) {
    n <- length(x)
    runs <- vector(length=n)
    count <- 0
    for (i in 1:(n-k+1)) {
        if (all(x[i:(i+k-1)]==1)) {
            count <- count + 1
            runs[count] <- i
        }
    }
    if (count > 0) {
        runs <- runs[1:count]
    } else runs <- NULL
    return(runs)
}


preda <- function(x,k) {
    n <- length(x)
    k2 <- k/2
    # pred 백터에 예측값이 들어 있다.
    pred <- vector(length=n-k)
    for (i in 1:(n-k)) {
        if (sum(x[i:(i+(k-1))]) >= k2) pred[i] <- 1 else pred[i] <- 0
    }
    return(mean(abs(pred-x[(k+1):n])))
}

predb <- function(x,k) {
    n <- length(x)
    k2 <- k/2
    pred <- vector(length=n-k)
    sm <- sum(x[1:k])
    if (sm >= k2) pred[1] <- 1 else pred[1] <- 0
    if (n-k >= 2) {
        for (i in 2:(n-k)) {
            sm <- sm + x[i+k-1] - x[i-1]
            if (xm >= k2) pred[i] <- 1 else pred[i] <- 0
        }
    }
    return(mean(abs(pred-x[(k+1):n])))
}

Y <- c(5,2,-3,8)
cumsum(y)

predc <- function(x,k) {
    n <- length(x)
    k2 <- k/2
    # the vector red will contain our predicted values
    pred <- vector(length=n-k)
    csx <- c(0,cumsum(x))
    for (i in 1:(n-k)) {
        if (csx[i+k] - csx[i] >= k2) pred[i] <- 1 else pred[i] <- 0
    }
    return(mean(abs(pred-x[(k+1):n])))
}
