## 7.4 반환값

 oddcount <- function(x) {
    k <- 0 # k에 0을 대입
    for (n in x) {
        if (n %% 2 == 1) k <- k + 1 # %%는 나머지 연산자다.
    }
    return(k)
}

oddcount

oddcount <- function(x) {
    k <- 0 # k에 0을 대입
    for (n in x) {
        if (n %% 2 == 1) k <- k + 1 # %%는 나머지 연산자다.
    }
    k
}

## 7.4.1 명시적으로 return()을 호출할지 판단하기

oddcount <- function(x) {
    k <- 0
    for (n in x) {
        if (n %% 2 == 1) k <- k+1
    }
    k
}

## 7.4.2 복잡한 객체 반환하기

g <- function() {
    t <- function(x) return(x^2)
    return(t)
}
g()
