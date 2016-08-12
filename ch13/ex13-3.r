## 13.3 R 디버그 기능 사용하기

## 13.3.1 debug()와 browser() 함수를 사용한 개별 단계 살펴보기

debug(f)
undebug(f)
debugonce(f)


## 13.3.2 브라우저 명령어 사용하기

## 13.3.3 중단점 설정하기

##13.3.3.1 browser() 직접 호출하기

browser(s > 1)

if (s > 1) browser()

if (i > 49) browser()


## 13.3.3.2 setBreakpoint() 함수 사용하기

setBreakpoint(filename, linenumber)

setBreakpoint("x.R",28)

untrace(g)


## 13.3.4 trace() 함수로 추적하기

trace(f,t)

trace(gy,browser)

untrace(gy)


## 13.3.5 충돌 발생 후 traceback()과 debugger() 함수를 사용해 확인하기

options(error=dump.frames)

debugger()

options(error=recover)

options(error=NULL)


## 13.3.6 확장 예제: 두가지의 전체 디버깅 과정

## 13.3.6.1 연속된 1 찾는 예제의 디버깅

findruns <- function(x,k) {
    n <- length(x)
    runs <- NULL
    for (i in 1:(n-k)) {
        if (all(x[i:i+k-1]==1)) runs <- c(runs,i)
    }
    return(runs)
}

source("findruns.R")
findruns(c(1,0,0,1,1,0,1,1,1),2)

debug(findruns)
findruns(c(1,0,0,1,1,0,1,1,1),2)

source("findruns.R")
findruns(c(1,0,0,1,1,0,1,1,1),2)

setBreakpoint("findruns.R",5)
findruns(c(1,0,0,1,1,0,1,1,1),2)

source("findruns.R")
findruns(c(1,0,0,1,1,0,1,1,1),2)


## 13.3.6.2 도시 쌍 찾기 문제 디버깅

## 정사각 대칭행렬 d에 대해 d[i,j] 중 i != j인 값에서 최소값과
## 최소값이 위치한 행과 열을 반환함.
## 같은 경우 특별한 규칙 없음
## 거리 행렬 사용
mind <- function(d) {
    n <- nrow(d)
    ## apply()에 사용할 행 번호를 정의해주는 열 추가
    dd <- cbind(d,1:n)
    wmins <- apply(dd[-n,],1,imin)
    ## wmins는 1번 행에는 인덱스가 들어가고 2번 행에는 그 값이 들어간 2-n 행렬 형태가 된다.
    i <- which.min(wmins[1,])
    j <- wmins[2,i]
    return(c(d[i,j],i,j))
}

## 행 x 중 최소값의 인덱스와 최소값을 찾아줌
imin <- function(x) {
    n <- length(x)
    i <- x[n]
    j <- which.min(x[(i+1):(n-1)])
    return(c(j,x[j]))
}

source("cities.R")
m <- rbind(c(0,12,5),c(12,0,8),c(5,8,0))
m
mind(m)

options(error=recover)
mind(m)

debug(imin)
mind(m)
