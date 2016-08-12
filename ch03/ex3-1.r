# 3.1 행렬 만들기

y <- matrix(c(1,2,3,4),nrow=2,ncol=2)
y

y <- matrix(c(1,2,3,4),nrow=2)
y
y[,2]

y <- matrix(nrow=2,ncol=2)
y[1,1] <- 1
y[2,1] <- 2
y[1,2] <- 3
y[2,2] <- 4
y

m <- matrix(c(1,2,3,4,5,6),nrow=2,byrow=T)
m
