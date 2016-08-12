# 3.2 일반 행렬 연산

y <- matrix(c(1,2,3,4),2)

# 3.2.1 행렬에서 선형대수 연산 처리
y %*% y # 행렬 간 곱
3*y # 행렬-상수 간 곱
y+y # 행렬 간 합


# 3.2.2. 행렬 인덱싱
z <- matrix(c(1,2,3,4,1,1,0,0,1,0,1,0),4)
z
z[,2:3]

y <- matrix(c(11,21,31,12,22,32),3)
y
y[2:3,]
y[2:3,2]

y <- matrix(1:6,3)
y
y[c(1,3),] <- matrix(c(1,1,8,12),nrow=2)
y

x <- matrix(nrow=3,ncol=3)
y <- matrix(c(4,5,2,3),nrow=2)
y
x[2:3,2:3] <- y
x

y <- matrix(1:6,3)
y[-2]



# 3.2.3 확장 예제: 이미지 다루기
library(pixmap)
mtrush1 <- read.pnm("mtrush1.pgm")
mtrush1
plot(mtrush1)
str(mtrush1)
mtrush1@grey[28,88]
#locator()

mtrush2 <- mtrush1
mtrush2@grey[84:163,135:177] <- 1
plot(mtrush2)


# img의 행과 열의 범위 내에 무작위로 노이즈를 넣는다.
# 반환되는 값은 pixmap 클래스 객체다.
# q로 노이즈의 정도를 조절한다.
# 원래 이미지에 1-q를 곱하고 q만큼의 노이즈를 추가한 결과를 반환한다.
blurpart <- function(img,rows,cols,q) {
    lrows <- length(rows)
    lcols <- length(cols)
    newimg <- img
    randomnoise <- matrix(nrow=lrows, ncol=lcols, runif(lrows*lcols))
    newimg@grey[rows,cols] <- (1-q) * img@grey[rows,cols] + q * randomnoise
    return(newimg)
}

mtrush3 <- blurpart(mtrush1,84:163,135:177,0.65)
plot(mtrush3)



# 3.2.4 행렬 필터링
x <- matrix(c(1,2,3,2,3,4),3)
x
x[x[,2] >= 3,]

j <- x[,2] >= 3
j
x[j,]


z <- c(5,12,13)
x[z %% 2 == 1,]


m <- matrix(1:6,3)
m[m[,1] > 1 & m[,2] > 5,]


m <- matrix(c(5,2,9,-1,10,11),3)
m
which(m > 2)



# 3.2.5 확장 예제: 공분산 행렬 생성하기
makecov <- function(rho,n) {
    m <- matrix(nrow=n,ncol=n)
    m <- ifelse(row(m) == col(m),1,rho)
    return(m)
}

z <- matrix(3:8,3)
z
row(z)
col(z)
