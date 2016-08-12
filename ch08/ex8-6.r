## 8.6 R에서 시뮬레이션 프로그래밍하기

## 8.6.1 내장 랜덤 변수 생성기

x <- rbinom(100000,5,0.5)
mean(x >= 4)

sum <- 0
nreps <- 100000
for (i in 1:nreps) {
    xy <- rnorm(2) # generate 2 N(0,1)s
    sum <- sum + max(xy)
}
print(sum/nreps)

emax <- function(nreps) {
    x <- rnorm(2*nreps)
    maxxy <- pmax(x[1:nreps],x[(nreps+1):(2*nreps)])
    return(mean(maxxy))
}


## 8.6.2 반복 수행 시에 동일한 랜덤 연속값 얻기

set.seed(8888) # 인수로는 원하는 수를 넣을 수 있다.


## 8.6.3 확장 예제: 조합 시뮬레이션

sim <- function(nreps) {
    commdata <- list() # 세 위원회에 대한 정보를 입력할 곳
    commdata$countabsamecomm <- 0
    for (rep in 1:nreps) {
        commdata$whosleft <- 1:20 # 위원회를 뾰보을 대상
        commdata$numabchosen <- 0 # A, B 중 이미 뽑힌 대상
        ## 외원을 1명 뽑은 후 이 중 A나 B가 속해 있는지 확인한다.
        commdata <- choosecomm(commdata,5)
        ## A나 B가 이미 뽑혔다면 더 이상 확인할 필요가 없다.
        if (commdata$numabchosen > 0) next
        ## 두 번째 위원을 뽑은 후 확인한다.
        commdata <- choosecomm(commdata,4)
        if (commdata$numabchosen > 0) next
        ## 세 번째 위원을 뽑은 후 확인한다.
        commdata <- choosecomm(commdata,3)
    }
    print(commdata$countabsamecomm/nreps)
}

choosecomm <- function(comdat,comsize) {
    ## 위원을 선택한다.
    committee <- sample(comdat$whosleft,comsize)
    ## A나 B 중 얼마나 뽑혔는지 확인한다.
    comdat$numabchosen <- length(intersect(1:2,committee))
    if (comdat$numabchosen == 2)
        comdat$countabsamecomm <- comdat$countabsamecomm + 1
    ## 전체 대상에서 이미 위원으로 뽑힌 사람은 제거한다.
    comdat$whosleft <- setdiff(comdat$whosleft,committee)
    return(comdat)
}
