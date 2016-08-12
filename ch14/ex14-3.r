## 14.3 함수형 프로그래밍과 메모리 문제

## 14.3.1 벡터 할당 문제

z[3] <- 8

z <- "[<-"(z,3,value=8)


## 14.3.2 복사 후 변경 문제

y <- z

z <- runif(10)
tracemem(z)
z[3] <- 8
tracemem(z)

z <- 1:10000000
system.time(z[3] <- 8)
system.time(z[33] <- 88)


## 14.3.3 확장 예제: 메모리 복사 피하기

m <- 5000
n <- 1000
z <- list()
for (i in 1:m) z[[i]] <- sample(1:10,n,replace=T)
system.time(for (i in 1:m) z[[i]][3] <- 8)
z <- matrix(sample(1:10,m*n,replace=T),nrow=m)
system.time(z[,3] <- 8)

set3 <- function(lv) {
    lv[3] <- 8
    return(lv)
}
z <- list()
for (i in 1:m) z[[i]] <- sample(1:10,n,replace=T)
system.time(lapply(z,set3))
