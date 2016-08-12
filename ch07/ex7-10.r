## 7.10 교체 함수

x <- c(1,2,3)
names(x)
names(x) <- c("a","b","ab")
names(x)
x

x <- "names<-"(x, value=c("a","b","ab"))


## 7.10.1 교체 함수를 사용할 때 고려해야 하는 사항

g(u) <- v

u <- "g<-"(u,value=v)

x[3] <- 8

x <- c(8,88,5,12,13)
x
x[3]

"["(x,3)
x <- "[<-"(x,2:3,value=99:100)
x

x[2:3] <- 99:100

x <- c(8,88,5,12,13)
x[2:3] <- 99:100
x


## 7.10.2 확장 예제: 자동 부기 벡터 클래스

x[2] <- 8

## "bookvec" 클래스 벡터는 해당 벡터의 원소들이 쓰인 숫자를 센다.

## 클래스의 각 인스턴스는
## 값으로 이루어진 벡터와 횟수로 이루어진 벡터를 구성요소로 갖고 있다.

## bookvec 클래스의 새 책체를 생성한다.
newbookvec <- function(x) {
    tmp <- list()
    tmp$vec <- x # 벡터 자체
    tmp$wrts <- rep(0, length(x)) # 각 원소 하나마다 값이 쓰인 횟수를 셈
    class(tmp) <- "bookvec"
    return(tmp)
}

## 읽는 함수
"[.bookvec" <- function(bv,subs) {
    return(bv$vec[subs])
}

## 쓰는 함수
"[<-.bookvec" <- function(bv,subs,value) {
    bv$wrts[subs] <- bv$wrts[subs] + 1 # note the recycling
    bv$vec[subs] <- value
    return(bv)
}


b <- newbookvec(c(3,4,5,5,12,13))
b
b[2]
b[2] <- 88 # 값을 쓴다.
b[2] # 작동하는가?
b$wrts # 횟수가 증가했는가?
