## 8.4 벡터와 행렬의 선형 대수 연산

y <- c(1, 3, 4, 10)
y
2*y

## 내적
crossprod(1:3,c(5,12,13))

a <- matrix(1:4,2,byrow=T)
b <- matrix(c(1,0,-1,1),2)
a
b
a %*% b

a <- matrix(c(1,1,-1,1),nrow=2,ncol=2)
b <- c(2,4)
solve(a,b)
solve(a)


## 8.4.1 확장 예제: 벡터 외적

xprod <- function(x,y) {
    m <- rbind(rep(NA,3),x,y)
    xp <- vector(length=3)
    for (i in 1:3)
        xp[i] <- -(-1)^i * det(m[2:3,-i])
    return(xp)
}


## 8.4.2 확장 예제: 마코드 체인(Markov Chain)의 고정 분포 찾기

findpi1 <- function(p) {
    n <- nrow(p)
    imp <- diag(n) - t(p)
    imp[n,] <- rep(1,n)
    rhs <- c(rep(0,n-1),1)
    pivec <- solve(imp,rhs)
    return(pivec)
}

findpi2 <- function(p) {
    n <- nrow(p)
    ## P 전치 행렬의 첫 번째 아이겐벡터를 찾는다.
    pivec <- eigen(t(p))$vectors[,1]
    ## 실수임은 확실하지만 음수일 수 있다.
    if (pivec[1] < 0) pivec <- -pivec
    ## 합이 1이 되도록 표준화한다
    pivec <- pivec / sum(pivec)
    return(pivec)
}
