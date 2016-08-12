## 14.2 반복문에 대한 두려움

## 14.2.1 속도 향상을 위한 벡터화

z <- x + y

for (i in 1:length(x)) z[i] <- x[i] + y[i]

x <- runif(1000000)
y <- runif(1000000)
z <- vector(length=1000000)
system.time(z <- x + y)
system.time(for (i in 1:length(x)) z[i] <- x[i] + y[i])

":"(1,10)

oddcount <- function(x) return(sum(x%%2==1))

x <- sample(1:1000000,100000,replace=T)
system.time(oddcount(x))
system.time({
    c <- 0
    for (i in 1:length(x))
        if (x[i] %% 2 == 1) c <- c+1
    return(c)
})


## 14.2.2 확장 예제: 몬테카를로 시뮬레이션의 속도 향상시키기

sum <- 0
nreps <- 100000
for (i in 1:nreps) {
    xy <- rnorm(2) # generate 2 N(0,1)s
    sum <- sum + max(xy)
}
print(sum/nreps)

nreps <- 100000
xymat <- matrix(rnorm(2*nreps),ncol=2)
maxs <- pmax(xymat[,1],xymat[,2])
print(mean(maxs))

system.time(source("MaxNorm.R"))
system.time(source("MaxNorm2.R"))

## 1번 항아리에는 파란 돌 10개와 노란 돌 8개가 있다.
## 2번 항아리에는 6개의 파란 돌과 6개의 노란 돌이 있다.
## 항아리 1번에서 돌 하나를 아무거나 꺼낸 뒤 2번 항아리에 넣고,
## 2번 항아리에서 돌 하나를 꺼낸다.
## 이때 두 번째 돌이 파란색일 확률은 얼마일까?

## P(2번 항아리에서 파란색 돌을 꺼냄)을 추정하기 위해
## n번의 돌을 꺼내는 실험을 반복한다.
sim1 <- function(nreps) {
    nb1 <- 10 # 1번 항아리에는 10개의 파란 돌이 있다.
    n1 <- 18 # 첫 번째에 1번 항아리에서 꺼낼 수 있는 돌의 수
    n2 <- 13 # 두 번째에 2번 항아리에서 꺼낼 수 있는 돌의 수
    count <- 0 # 2번 항아리에서 파란 돌을 꺼내기 위해 반복해야 하는 횟수
    for (i in 1:nreps) {
        nb2 <- 6 # 원래 항아리 2번에는 6개의 파란 돌이 있다.
        ## 1번 항아리에서 돌을 하나 꺼내어 2번 항아리에 넣을 때, 그 돌이 파란색인가?
        if (runif(1) < nb1/n1) nb2 <- nb2 + 1
        ## 2번 항아리에서 꺼낸 돌이 파란색인가?
        if (runif(1) < nb2/n2) count <- count + 1
    }
    return(count/nreps)  # (2번 항아리에서 파란색 돌을 꺼냄)을 추정
}

sim2 <- function(nreps) {
    nb1 <- 10
    nb2 <- 6
    n1 <- 18
    n2 <- 13
    ## 한 행에 한 번 반복할 때 쓰이는 만큼 미리 랜덤 숫자를 모두 생성해 놓는다.
    u <- matrix(c(runif(2*nreps)),nrow=nreps,ncol=2)
    ## apply()를 사용해 실험을 반복하는 simfun()을 정의한다.
    simfun <- function(rw) {
        ## rw ("row")는 랜덤 숫자의 쌍이다.
        ## 1번 항아리에서 선택
        if (rw[1] < nb1/n1) nb2 <- nb2 + 1
        ## 2번 항아리에서 돌을 선택한 후, 파란색 여부에 대해 불리언값의 결과를 반환한다.
        return (rw[2] < nb2/n2)
    }
    z <- apply(u,1,simfun)
    ## z는 불리언 벡터로 값은 1과 0으로 처리한다.
    return(mean(z))
}

system.time(print(sim1(100000)))
system.time(print(sim2(100000)))

sim3 <- function(nreps) {
    nb1 <- 10
    nb2 <- 6
    n1 <- 18
    n2 <- 13
    u <- matrix(c(runif(2*nreps)),nrow=nreps,ncol=2)
    ## 상태 벡터를 설정한다.
    cndtn <- u[,1] <= nb1/n1 & u[,2] <=(nb2+1)/n2 |
        u[,1] > nb1/n1 & u[,2] <= nb2/n2
    return(mean(cndtn))
}

system.time(print(sim3(100000)))


## 14.2.3 확장 예제: 멱행렬 생성하기

## 차수일 때의 벡터 x의 멱행렬 생성
powers1 <- function(x,dg) {
    pw <- matrix(x,nrow=length(x))
    prod <- x # 현재 값
    for (i in 2:dg) {
        prod <- prod * x
        pw <- cbind(pw,prod)
    }
    return(pw)
}

## 차수일 때의 벡터 x의 멱행렬 생성
powers2 <- function(x,dg) {
    pw <- matrix(nrow=length(x),ncol=dg)
    prod <- x # 현재 값
    pw[,1] <- prod
    for (i in 2:dg) {
        prod <- prod * x
        pw[,i] <- prod
    }
    return(pw)
}

x <- runif(1000000)
system.time(powers1(x,8))
system.time(powers2(x,8))

powers3 <- function(x,dg) return(outer(x,1:dg,"^"))

system.time(powers3(x,8))

powers4 <- function(x,dg) {
    repx <- matrix(rep(x,dg),nrow=length(x))
    return(t(apply(repx,1,cumprod)))
}
system.time(powers4(x,8))
