## 16.2 snow 패키지 소개

## 상호 링크 문제의 snow 버전

mtl <- function(ichunk,m) {
    n <- ncol(m)
    matches <- 0
    for (i in ichunk) {
        if (i < n) {
            rowi <- m[i,]
            matches <- matches +
                sum(m[(i+1):n,] %*% rowi)
        }
    }
    matches
}

mutlinks <- function(cls,m) {
    n <- nrow(m)
    nc <- length(cls)
    ## 어떤 일꾼이 i의 어떤 청크를 다룰지 결정함
    options(warn=-1)
    ichunks <- split(1:n,1:nc)
    options(warn=0)
    counts <- clusterApply(cls,ichunks,mtl,m)
    do.call(sum,counts) / (n*(n-1)/2)
}


## 16.2.1 snow 코드 실행하기

install.packages('snow')

source("SnowMutLinks.R")
library(snow)
cl <- makeCluster(type="SOCK",c("localhost","localhost"))
testm <- matrix(sample(0:1,16,replace=T),nrow=4)
mutlinks(cl,testm)

testm

c16 <- makeCluster(type="SOCK",c("pc28","pc28","pc29","pc29","pc30","pc30"))


## 16.2.2 snow 코드 분석하기

split(1:4,1:2)

sum(1:2,c(4,10))


## 16.2.3 어느 정도의 속도 향상이 가능할까

## 16.2.4 확장 예제: K-평균 클러스터링

for iter = 1,2,...,niters
  set vector and count totals to 0
  for i = 1,...,nrow(m)
    set j = index of the closest group center to m[i,]
    add m[i] to the vector total for group j, v[j]
    add 1 to the count total for group j, c[j]
  for j = 1,...,ngrps
    set new center of group j = v[j] / c[j]

## K-평균 클러스터 문제의 snow 버전

library(snow)

## x부터 y의 각 벡터까지의 거리 반환;
## x는 단일 벡터이고 y는 단일 벡터의 묶음임;
## 두 점 간의 거리는 각 원소 간 차이의 절대값의 합으로 정의함
## 예) (5,4.2) (3,5.6) 간의 거리는
## 2 + 1.4 = 3.4
dst <- function(x,y) {
    tmpmat <- matrix(abs(x-y),byrow=T,ncol=length(x))
    ## rowSum(tmpmat)을 재활용한다는 것을 명시할 것
}

## 각 일꾼의 currctrs(현재 그룹의 중심점)에 대해 mchunk 행렬을 확인하고
## 다음 행렬을 반환함
## 행렬의 j행은 현재 j번째 중심점과 가장 가까운 mchunk 내의 점의 벡터 합과
## 각 점의 수로 이뤄져 있음
findnewgrps <- function(currctrs) {
    ngrps <- nrow(currctrs)
    spacedim <- ncol(currctrs) # 현재 차원 공간
    ## 결과 행렬 설정
    sumcounts <- matrix(rep(0,ngrps*(spacedim+1)),nrow=ngrps)
    for (i in 1:nrow(mchunk)) {
        dsts <- dst(mchunk[i,],t(currctrs))
        j <- which.min(dsts)
        sumcounts[j,] <- sumcounts[j,] + c(mchunk[i,],1)
    }
    sumcounts
}

parkm <- function(cls,m,niters,initcenters) {
    n <- nrow(m)
    spacedim <- ncol(m) # 현재 차원 공간
    ## 어떤 일꾼이 m의 어떤 행들을 사용하는지 파악하기
    options(warn=-1)
    ichunks <- split(1:n,1:length(cls))
    options(warn=0)
    ## 행 청크 만들기
    mchunks <- lapply(ichunks,function(ichunk) m[ichunk,])
    mcf <- function(mchunk) mchunk <<- mchunk
    ## 행 청크를 일꾼에게 전송;
    ## 각 청크는 일꾼이 사용하도록 mchunk라는 전역변수로 만듦
    invisible(clusterApply(cls,mchunks,mcf))
    ## dst()를 일꾼에게 전송
    clusterExport(cls,"dst")
    ## 반복 시작
    centers <- initcenters
    for (i in 1:niters) {
        sumcounts <- clusterCall(cls,findnewgrps,centers)
        tmp <- Reduce("+",sumcounts)
        centers <- tmp[,1:spacedim] / tmp[,spacedim+1]
        ## 그룹이 비었을 경우 중심점을 0으로 설정
        centers[is.nan(centers)] <- 0
    }
    centers
}
