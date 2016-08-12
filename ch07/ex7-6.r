## 7.6 환경 설정 및 범위 문제

## 7.6.1 최상위 레벨 환경변수

w <- 12
f <- function(y) {
    d <- 8
    h <- function() {
        return(d*(w+y))
    }
    return(h())
}
environment(f)

ls()

ls.str()


## 7.6.2 범위 계층 구조

h <- function() {
    return(d*(w+y))
}

f(2)

f <- function(y) {
    d <- 8
    h <- function() {
        return(d*(w+y))
    }
    print(environment(h))
    return(h())
}
f
f(2)

f <- function(y) {
    d <- 8
    return(h())
}

f(5)


f <- function(y) {
    d <- 8
    return(h(d,y))
}
h <- function(dee,yyy) {
    return(dee*(w+yyy))
}
f(2)


f <- function(y,ftn) {
    d <- 8
    print(environment(ftn))
    return(ftn(d,y))
}
h <- function(dee,yyy) {
    return(dee*(w+yyy))
}

w <- 12
f(3,h)


## 7.6.3 ls()좀더 살펴보기

f <- function(y) {
    d <- 8
    return(h(d,y))
}
h <- function(dee,yyy) {
    print(ls())
    print(ls(envir=parent.frame(n=1)))
    return(dee*(w+yyy))
}

f(2)


## 7.6.4 함수는 거의 부작용이 없다

w <- 12
f <- function(y) {
    d <- 8
    w <- w + 1
    y <- y - 2
    print(w)
    h <- function() {
        return(d*(w+y))
    }
    return(h())
}
t <- 4
f(t)
w
t


## 7.6.5 확장 예제: 호출 프레임의 내용을 보여주는 함수

f <- function() {
    a <- 1
    return(g(a)+a)
}
g <- function(aa) {
    b <- 2
    aab <- h(aa+b)
    return(aab)
}
h <- function(aaa) {
    c <- 3
    return(aaa+c)
}


## showframe()이 호출된 이후 upn만큼의 상위값의 프레임에서
## 인수를 포함한 지역변수의 값을 보여준다.
## upn < 0일 경우에는 전역변수만 보여주고 함수 객체는 보여주지 않는다.
showframe <- function(upn) {
    ## 필요한 환경변수를 찾는다.
    if (upn < 0) {
        env <- .GlobalEnv
    } else {
        env <- parent.frame(n=upn+1)
    }
    ## 변수명의 리스트를 얻는다.
    vars <- ls(envir=env)
    ## 각 변수명별로 값을 출력한다.
    for (vr in vars) {
        vrg <- get(vr,envir=env)
        if (!is.function(vrg)) {
            cat(vr,":\n",sep="")
            print(vrg)
        }
    }
}

g <- function(aa) {
    b <- 2
    showframe(0)
    showframe(1)
    aab <- h(aa+h)
    return(aab)
}

f()

m <- rbind(1:3,20:22)
m
get("m")
