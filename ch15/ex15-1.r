## 15장 타 언어와 R을 인터페이스 하기

## 15.1 R에서 호출하는 C/C++ 함수 작성하기

## 15.1.1 R을 C/C++와 연동할 때 선행지식

## 15.1.2 예제: 정사작행렬에서 부분 대각행렬 추출

## 15.1.3 컴파일하고 코드 실행하기

% R CMD SHLIB sd.c

dyn.load("sd.so")
m <- rbind(1:5, 6:10, 11:15, 16:20, 21:25)
k <- 2
.C("subdiag", as.double(m), as.integer(dim(m)[1]), as.integer(k), result=double(dim(m)[1]-k))


## 15.1.4 R/C 코드 디버깅하기

$ R -d gdb

(gdb) run

> gyn.load("sd.so")

> # hit ctrl-c here

(gdb) b subdiag

(gdb) continue

> m <- rbind(1:5, 6:10, 11:15, 16:20, 21:25)
> k <- 2
> .C("subdiag", as.double(m), as.integer(dim(m)[1]), as.integer(k),
+ result=double(dim(m)[1]-k))


## 15.1.5 확장 예제: 이산 시계열값 예측

## 이산 시계열 예측; 0과 1; k개의 연속값 사용
## 다수의 값으로 다음 관측치 예측;
## 오류율 계산
preda <- function(x,k) {
    n <- length(x)
    k2 <- k/2
    ## pred에 다음 예측값 저장
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
            if (sm >= k2) pred[i] <- 1 else pred[i] <- 0
        }
    }
    return(mean(abs(pred-x[(k+1):n])))
}

y <- sample(0:1,100000,replace=T)
system.time(preda(y,1000))
system.time(predb(y,1000))

predc <- function(x,k) {
    n <- length(x)
    f <- filter(x,rep(1,k),sides=1)[k:(n-1)]
    k2 <- k/2
    pred <- as.integer(f >= k2)
    return(mean(abs(pred-x[(k+1):n])))
}

system.time(predc(y,1000))

dyn.load("predd.so")

system.time(.C("predd", as.integer(y), as.integer(length(y)), as.integer(1000),
               errrate=double(1)))
