# 3.4 행렬에 행과 열 추가 및 제거하기

# 3.4.1 행렬 크기 바꾸기

x <- c(12,5,13,16,8)
x <- c(x,20) # 20 추가하기
x <- c(x[1:3],20,x[4:6]) # 중간에 20 끼워 넣기
x <- x[-2:-4] # 2~4번째 원소 제거하기
x


one <- rep(1,4)
z <- matrix(c(1:4,1,1,0,0,1,0,1,0),4)
cbind(one,z)
z <- cbind(one,z)
cbind(1,z)

q <- cbind(c(1,2),c(3,4))
q

m <- matrix(1:6,nrow=3)
m
m <- m[c(1,3),]
m



# 3.4.2 확장 예제: 그래프에서 서로 거리가 가장 가까운 두 점 찾기

# 정사각 대칭행렬 d에 대해 d[i,j] 중 i != j인 값에서 최소값과
# 최소값이 위치한 행과 열을 반환함. 같은 경우 특별한 규칙 없음
mind <- function(d) {
    n <- nrow(d)
    #apply()에 사용할 열 번호를 정의해주는 행 추가
    dd <- cbind(d,1:n)
    wmins <- apply(dd[-n,],1,imin)
    # wmins 는 1번 열에는 인덱스가 들어가고
    # 2번 열에는 그 값이 들어간 2-n 행렬 형태가 된다.
    i <- which.min(wmins[2,])
    j <- wmins[1,i]
    return(c(d[i,j],i,j))
}

# 열 x 중 최소값의 인덱스와 최소값을 찾아줌
imin <- function(x) {
    lx <- length(x)
    i <- x[lx] # original row number
    j <- which.min(x[(i+1):(lx-1)])
    k <- i+j
    return(c(k,x[k]))
}

q <- matrix(c(0,12,13,8,20,
              12,0,15,28,88,
              13,15,0,6,9,
              8,28,6,0,33,
              20,88,9,33,0),5)


minda <- function(d) {
    smallest <- min(d)
    ij <- which(d == smallest,arr.ind=TRUE)
    return(c(smallest,ij))
}
