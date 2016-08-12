# 3.3 행렬의 행과 열에 함수 적용하기

# 3.3.1 apply() 함수 사용하기

# apply(m,dimcode,f,fargs)
#
# m 행렬
# dimcode 차원수, 1: 함수를 행에 적용, 2: 열에적용
# f 적용할 함수
# fargs f에 필요한 인수의 집합(옵션)

z <- matrix(1:6,3)
apply(z,2,mean)
colMeans(z)

f <- function(x) x/c(2,8)
y <- apply(z,1,f)
y
t(apply(z,1,f))


copymaj <- function(rw,d) {
    maj <- sum(rw[1:d]) / d
    return(if(maj > 0.5) 1 else 0)
}

x <- matrix(c(1,1,1,0,0,1,0,1,1,1,0,1,1,1,1,1,0,0,1,0),4)
x
apply(x,1,copymaj,3)
apply(x,1,copymaj,2)



# 3.3.2 확장 예제: 아웃라이어 탐색
findols <- function(x) {
    findol <- function(xrow) {
        mdn <- median(xrow)
        devs <- abs(xrow-mdn)
        return(which.max(devs))
    }
    return(apply(x,1,findol))
}
