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

imin <- function(x) {
    n <- length(x)
    i <- x[n]
    j <- which.min(x[(i+1):(n-1)])
    k <- i + j
    return(c(k,x[k]))
}

mind <- function(d) {
    n <- nrow(d)
    ## apply()에 사용할 행 번호를 정의해주는 열 추가
    dd <- cbind(d,1:n)
    wmins <- apply(dd[-n,],1,imin)
    ## wmins는 1번 행에는 인덱스가 들어가고 2번 행에는 그 값이 들어간 2-n 행렬 형태가 된다.
    i <- which.min(wmins[2,])
    j <- wmins[1,i]
    return(c(d[i,j],i,j))
}
