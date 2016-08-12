## 7.8 위층에 쓰기

## 7.8.1 고급 할당 연산자를 이용한 지역 외 변수 사용하기

two <- function(u) {
    u <<- 2*u
    z <- 2*z
}
x <- 1
z <- 3
u
two(x)
x
z
u

f <- function() {
    inc <- function() { x <<- x + 1 }
    x <- 3
    inc()
    return(x)
}
f()
x


## 7.8.2 assign()을 이용해 지역 외 변수 사용하기

two <- function(u) {
    assign("u",2*u,pos=.GlobalEnv)
    z <- 2*z
}
two(x)
x
u


makecorpdfs <- function(corplist) {
    for (i in 1:(length(corplist)/2)) {
        corp <- corplist[2*i-1]
        newdtf <- paste(corplist[2*i],"2006",sep="")
        assign(newdtf,makecorp(corp),pos=.GlobalEnv)
    }
}

makecorpdfs(c("MICROSOFT CORPORATION", "ms", "INTEL CORPORATION", "intel",
              "SUN MICROSYSTEMS, INC", "sun", "GOOGLE INC.", "google"))


## 7.8.3 확장 예제: R에서의 이산  사건 시뮬레이션

## DES.R DES_APP.R 참조

## 7.8.4 광역 변수는 언제 사용해야 하나?

## 7.8.5 클로저(Closure)

counter <- function() {
    ctr <- 0
    f <- function() {
        ctr <<- ctr + 1
        cat("this count currently has value",ctr,"\n")
    }
    return(f)
}

c1 <- counter()
c2 <- counter()
c1
c2
c1()
c1()
c2()
c2()
c2()
c1()
