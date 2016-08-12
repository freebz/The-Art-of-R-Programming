# x 중 홀수의 개수 세기
oddcount <- function(x) {
    k <- 0 # assign 0 to k
    for (n in x) {
        if (n %% 2 == 1) k <- k+1 # %%는 모듈로 연산자임
    }
    return(k)
}

oddcount(c(1,3,5))

oddcount(c(1,2,3,7,9))


z <- c(2,6,7)
oddcount(z)


f <- function(x) return(x+y)
y <- 3
f(5)
