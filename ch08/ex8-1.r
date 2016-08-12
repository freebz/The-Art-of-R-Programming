## 8장 R에서 수학과 시뮬레이션 하기

## 8.1수학 함수

## 8.1.1 확장 예제: 확률 계산

exactlyone <- function(p) {
    notp <- 1 - p
    tot <- 0.0
    for (i in 1:length(p))
        tot <- tot + p[i] * prod(notp[-i])
    return(tot)
}


## 8.1.2 누적 합과 곱

x <- c(12,5,13)
cumsum(x)
cumprod(x)


## 8.1.3 최소값과 최대값(복수 가능)

z <- matrix(c(1,5,6,2,3,2), 3)
z
min(z[,1],z[,2])
pmin(z[,1],z[,2])

pmin(z[1,],z[2,],z[3,])


## 8.1.4 미적분

D(expression(exp(x^2)),"x") # 도함수
integrate(function(x) x^2,0,1)
